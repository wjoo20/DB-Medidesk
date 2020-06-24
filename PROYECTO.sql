CREATE TABLE administrador (
    adm_idadministrador    NUMBER(2) NOT NULL,
    adm_dni                NUMBER(8) NOT NULL,
    adm_nombres            VARCHAR2(50 CHAR) NOT NULL,
    adm_apellidos          VARCHAR2(50 CHAR) NOT NULL,
    adm_genero             CHAR(1 CHAR) NOT NULL,
    adm_edad               NUMBER(3) NOT NULL,
    usuario_us_idusuario   NUMBER(8) NOT NULL
);

CREATE UNIQUE INDEX administrador__idx ON
    administrador (
        usuario_us_idusuario
    ASC );

ALTER TABLE administrador ADD CONSTRAINT administrador_pk PRIMARY KEY ( adm_idadministrador );

CREATE TABLE cita (
    cita_idcita           NUMBER(10) NOT NULL,
    cita_tipo             CHAR(1 CHAR) NOT NULL,
    cita_estado           CHAR(1 CHAR) NOT NULL,
    cita_fecha            DATE NOT NULL,
    medico_med_idmedico   NUMBER(4) NOT NULL,
    triaje_tri_idtriaje   NUMBER(8) NOT NULL,
    paciente_pac_dni      NUMBER(8) NOT NULL
);

ALTER TABLE cita ADD CONSTRAINT cita_pk PRIMARY KEY ( cita_idcita );

CREATE TABLE enfermera (
    enf_idenfermera        NUMBER(4) NOT NULL,
    enf_dni                NUMBER(8) NOT NULL,
    enf_nombres            VARCHAR2(50 CHAR) NOT NULL,
    enf_apellidos          VARCHAR2(50 CHAR) NOT NULL,
    enf_genero             CHAR(1 CHAR) NOT NULL,
    enf_edad               NUMBER(3) NOT NULL,
    usuario_us_idusuario   NUMBER(8) NOT NULL
);

CREATE UNIQUE INDEX enfermera__idx ON
    enfermera (
        usuario_us_idusuario
    ASC );

ALTER TABLE enfermera ADD CONSTRAINT enfermera_pk PRIMARY KEY ( enf_idenfermera );

CREATE TABLE especialidad (
    espe_idespecialidad   NUMBER(4) NOT NULL,
    espe_nombre           VARCHAR2(50 CHAR) NOT NULL
);

ALTER TABLE especialidad ADD CONSTRAINT especialidad_pk PRIMARY KEY ( espe_idespecialidad );

CREATE TABLE farmaceutico (
    farm_idfarmaceutico    NUMBER(4) NOT NULL,
    farm_dni               NUMBER(8) NOT NULL,
    farm_nombres           VARCHAR2(50 CHAR) NOT NULL,
    farm_apellidos         VARCHAR2(50 CHAR) NOT NULL,
    farm_genero            CHAR(1 CHAR) NOT NULL,
    farm_edad              NUMBER(3) NOT NULL,
    usuario_us_idusuario   NUMBER(8) NOT NULL
);

CREATE UNIQUE INDEX farmaceutico__idx ON
    farmaceutico (
        usuario_us_idusuario
    ASC );

ALTER TABLE farmaceutico ADD CONSTRAINT farmaceutico_pk PRIMARY KEY ( farm_idfarmaceutico );

CREATE TABLE historia (
    hist_idhistoria      NUMBER(10) NOT NULL,
    hist_fechaapertura   DATE NOT NULL
);

ALTER TABLE historia ADD CONSTRAINT historia_pk PRIMARY KEY ( hist_idhistoria );

CREATE TABLE historia_patologia (
    historia_hist_idhistoria    NUMBER(10) NOT NULL,
    patologia_pat_idpatologia   NUMBER(10) NOT NULL
);

ALTER TABLE historia_patologia ADD CONSTRAINT historia_patologia_pk PRIMARY KEY ( historia_hist_idhistoria,
                                                                                  patologia_pat_idpatologia );

CREATE TABLE medicamento (
    me_idmedicamento   NUMBER(10) NOT NULL,
    me_nombre          VARCHAR2(30 CHAR) NOT NULL,
    me_cantidad        NUMBER(5) NOT NULL
);

ALTER TABLE medicamento ADD CONSTRAINT medicamento_pk PRIMARY KEY ( me_idmedicamento );

CREATE TABLE medico (
    med_idmedico                       NUMBER(4) NOT NULL,
    med_dni                            NUMBER(8) NOT NULL,
    med_nombres                        VARCHAR2(50 CHAR) NOT NULL,
    med_apellidos                      VARCHAR2(50 CHAR) NOT NULL,
    med_genero                         CHAR(1 CHAR) NOT NULL,
    med_edad                           NUMBER(3) NOT NULL,
    med_cmp                            NUMBER(6) NOT NULL,
    usuario_us_idusuario               NUMBER(8) NOT NULL, 
    espe_espe_idespe   NUMBER(4) NOT NULL
);

CREATE UNIQUE INDEX medico__idx ON
    medico (
        usuario_us_idusuario
    ASC );

ALTER TABLE medico ADD CONSTRAINT medico_pk PRIMARY KEY ( med_idmedico );

CREATE TABLE paciente (
    pac_dni                             NUMBER(8) NOT NULL,
    pac_nombres                         VARCHAR2(50 CHAR) NOT NULL,
    pac_apellidos                       VARCHAR2(50 CHAR) NOT NULL,
    pac_correo                          VARCHAR2(50 CHAR) NOT NULL,
    pac_telefono                        NUMBER(9) NOT NULL,
    pac_direccion                       VARCHAR2(50 CHAR) NOT NULL,
    pac_genero                          CHAR(1 CHAR) NOT NULL,
    pac_edad                            NUMBER(3) NOT NULL,
    pac_talla                           NUMBER(3),
    pac_peso                            NUMBER(3, 2),
    pac_temperatura                     NUMBER(2, 1),
    pac_presion                         NUMBER(3, 3),
    pac_triaje                          CHAR(1 CHAR) NOT NULL,
    historia_hist_idhistoria            NUMBER(10) NOT NULL, 
    adm_adm_idadm   NUMBER(2) NOT NULL
);

CREATE UNIQUE INDEX paciente__idx ON
    paciente (
        historia_hist_idhistoria
    ASC );

ALTER TABLE paciente ADD CONSTRAINT paciente_pk PRIMARY KEY ( pac_dni );

CREATE TABLE patologia (
    pat_idpatologia   NUMBER(10) NOT NULL,
    pat_descripcion   VARCHAR2(200 CHAR) NOT NULL
);

ALTER TABLE patologia ADD CONSTRAINT patologia_pk PRIMARY KEY ( pat_idpatologia );

CREATE TABLE rec_me (
    receta_rec_idreceta            NUMBER(10) NOT NULL,
    medicamento_me_idmedicamento   NUMBER(10) NOT NULL
);

ALTER TABLE rec_me ADD CONSTRAINT rec_me_pk PRIMARY KEY ( receta_rec_idreceta,
                                                          medicamento_me_idmedicamento );

CREATE TABLE receta (
    rec_idreceta       NUMBER(10) NOT NULL,
    rec_indicaciones   VARCHAR2(200 CHAR) NOT NULL,
    cita_cita_idcita   NUMBER(10) NOT NULL
);

CREATE UNIQUE INDEX receta__idx ON
    receta (
        cita_cita_idcita
    ASC );

ALTER TABLE receta ADD CONSTRAINT receta_pk PRIMARY KEY ( rec_idreceta );

CREATE TABLE registro (
    reg_dni                NUMBER(8) NOT NULL,
    reg_nombres            VARCHAR2(50 CHAR) NOT NULL,
    reg_apellidos          VARCHAR2(50 CHAR) NOT NULL,
    reg_genero             CHAR(1 CHAR) NOT NULL,
    reg_edad               NUMBER(3) NOT NULL,
    usuario_us_idusuario   NUMBER(8) NOT NULL
);

CREATE UNIQUE INDEX registro__idx ON
    registro (
        usuario_us_idusuario
    ASC );

ALTER TABLE registro ADD CONSTRAINT registro_pk PRIMARY KEY ( reg_dni );

CREATE TABLE transaccion_receta (
    tr_idtransaccion                   NUMBER(10) NOT NULL,
    receta_rec_idreceta                NUMBER(10) NOT NULL, 
    farm_farm_idfarm   NUMBER(4) NOT NULL
);

CREATE UNIQUE INDEX transaccion_receta__idx ON
    transaccion_receta (
        receta_rec_idreceta
    ASC );

ALTER TABLE transaccion_receta ADD CONSTRAINT transaccion_receta_pk PRIMARY KEY ( tr_idtransaccion );

CREATE TABLE triaje (
    tri_idtriaje                NUMBER(8) NOT NULL,
    enfermera_enf_idenfermera   NUMBER(4) NOT NULL
);

ALTER TABLE triaje ADD CONSTRAINT triaje_pk PRIMARY KEY ( tri_idtriaje );

CREATE TABLE usuario (
    us_idusuario   NUMBER(8) NOT NULL,
    us_correo      VARCHAR2(50 CHAR) NOT NULL,
    us_clave       VARCHAR2(10 CHAR) NOT NULL,
    us_tipo        CHAR(1 CHAR) NOT NULL
);

ALTER TABLE usuario ADD CONSTRAINT usuario_pk PRIMARY KEY ( us_idusuario );

ALTER TABLE administrador
    ADD CONSTRAINT administrador_usuario_fk FOREIGN KEY ( usuario_us_idusuario )
        REFERENCES usuario ( us_idusuario );

ALTER TABLE cita
    ADD CONSTRAINT cita_medico_fk FOREIGN KEY ( medico_med_idmedico )
        REFERENCES medico ( med_idmedico );

ALTER TABLE cita
    ADD CONSTRAINT cita_paciente_fk FOREIGN KEY ( paciente_pac_dni )
        REFERENCES paciente ( pac_dni );

ALTER TABLE cita
    ADD CONSTRAINT cita_triaje_fk FOREIGN KEY ( triaje_tri_idtriaje )
        REFERENCES triaje ( tri_idtriaje );

ALTER TABLE enfermera
    ADD CONSTRAINT enfermera_usuario_fk FOREIGN KEY ( usuario_us_idusuario )
        REFERENCES usuario ( us_idusuario );

ALTER TABLE farmaceutico
    ADD CONSTRAINT farmaceutico_usuario_fk FOREIGN KEY ( usuario_us_idusuario )
        REFERENCES usuario ( us_idusuario );

ALTER TABLE historia_patologia
    ADD CONSTRAINT historia_patologia_historia_fk FOREIGN KEY ( historia_hist_idhistoria )
        REFERENCES historia ( hist_idhistoria );

ALTER TABLE historia_patologia
    ADD CONSTRAINT hist_pato_pato_fk FOREIGN KEY ( patologia_pat_idpatologia )
        REFERENCES patologia ( pat_idpatologia );

ALTER TABLE medico
    ADD CONSTRAINT medico_especialidad_fk FOREIGN KEY ( espe_espe_idespe )
        REFERENCES especialidad ( espe_idespecialidad );

ALTER TABLE medico
    ADD CONSTRAINT medico_usuario_fk FOREIGN KEY ( usuario_us_idusuario )
        REFERENCES usuario ( us_idusuario );

ALTER TABLE paciente
    ADD CONSTRAINT paciente_administrador_fk FOREIGN KEY ( adm_adm_idadm )
        REFERENCES administrador ( adm_idadministrador );

ALTER TABLE paciente
    ADD CONSTRAINT paciente_historia_fk FOREIGN KEY ( historia_hist_idhistoria )
        REFERENCES historia ( hist_idhistoria );

ALTER TABLE rec_me
    ADD CONSTRAINT rec_me_medicamento_fk FOREIGN KEY ( medicamento_me_idmedicamento )
        REFERENCES medicamento ( me_idmedicamento );

ALTER TABLE rec_me
    ADD CONSTRAINT rec_me_receta_fk FOREIGN KEY ( receta_rec_idreceta )
        REFERENCES receta ( rec_idreceta );

ALTER TABLE receta
    ADD CONSTRAINT receta_cita_fk FOREIGN KEY ( cita_cita_idcita )
        REFERENCES cita ( cita_idcita );

ALTER TABLE registro
    ADD CONSTRAINT registro_usuario_fk FOREIGN KEY ( usuario_us_idusuario )
        REFERENCES usuario ( us_idusuario );
 
ALTER TABLE transaccion_receta
    ADD CONSTRAINT tr_rec_farm_fk FOREIGN KEY ( farm_farm_idfarm )
        REFERENCES farmaceutico ( farm_idfarmaceutico );

ALTER TABLE transaccion_receta
    ADD CONSTRAINT transaccion_receta_receta_fk FOREIGN KEY ( receta_rec_idreceta )
        REFERENCES receta ( rec_idreceta );

ALTER TABLE triaje
    ADD CONSTRAINT triaje_enfermera_fk FOREIGN KEY ( enfermera_enf_idenfermera )
        REFERENCES enfermera ( enf_idenfermera );



