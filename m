Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753056AbWKCEEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753056AbWKCEEN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 23:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753063AbWKCEEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 23:04:11 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:3483 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1753056AbWKCEEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 23:04:08 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Trent Piepho <xyzzy@speakeasy.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 7/7] V4L/DVB (4751): Fix DBV_FE_CUSTOMISE for card drivers
	compiled into kernel
Date: Fri, 03 Nov 2006 01:02:14 -0300
Message-id: <20061103040214.PS2979150007@infradead.org>
In-Reply-To: <20061103035925.PS9047100000@infradead.org>
References: <20061103035925.PS9047100000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Trent Piepho <xyzzy@speakeasy.org>

When a front-end is disabled, card drivers that use it are compiled with
a stub version of the front-end's attach function.  This way they have no
references to the front-end's code and don't need it to be loaded.
If a card driver is compiled into the kernel, and a front-end is a
module, then that front-end is effectively disabled wrt the card driver. 
In this case, the card driver should get the stub version.  This was not
happening.
The stub vs real attach function selection is changed so that when the
front-end is a module the real attach function is only used if the card
driver is a module as well.  This means a module front-end will be
supported by card drivers that are modules and not supported by card
drivers compiled into the kernel.

Signed-off-by: Trent Piepho <xyzzy@speakeasy.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/frontends/bcm3510.h   |    2 +-
 drivers/media/dvb/frontends/cx22700.h   |    2 +-
 drivers/media/dvb/frontends/cx22702.h   |    2 +-
 drivers/media/dvb/frontends/cx24110.h   |    2 +-
 drivers/media/dvb/frontends/cx24123.h   |    2 +-
 drivers/media/dvb/frontends/dib3000.h   |    2 +-
 drivers/media/dvb/frontends/dib3000mc.h |    2 +-
 drivers/media/dvb/frontends/isl6421.h   |    2 +-
 drivers/media/dvb/frontends/l64781.h    |    2 +-
 drivers/media/dvb/frontends/lgdt330x.h  |    2 +-
 drivers/media/dvb/frontends/lnbp21.h    |    2 +-
 drivers/media/dvb/frontends/mt312.h     |    2 +-
 drivers/media/dvb/frontends/mt352.h     |    2 +-
 drivers/media/dvb/frontends/nxt200x.h   |    2 +-
 drivers/media/dvb/frontends/nxt6000.h   |    2 +-
 drivers/media/dvb/frontends/or51132.h   |    2 +-
 drivers/media/dvb/frontends/or51211.h   |    2 +-
 drivers/media/dvb/frontends/s5h1420.h   |    2 +-
 drivers/media/dvb/frontends/sp8870.h    |    2 +-
 drivers/media/dvb/frontends/sp887x.h    |    2 +-
 drivers/media/dvb/frontends/stv0297.h   |    2 +-
 drivers/media/dvb/frontends/stv0299.h   |    2 +-
 drivers/media/dvb/frontends/tda10021.h  |    2 +-
 drivers/media/dvb/frontends/tda1004x.h  |    2 +-
 drivers/media/dvb/frontends/tda10086.h  |    2 +-
 drivers/media/dvb/frontends/tda8083.h   |    2 +-
 drivers/media/dvb/frontends/tda826x.h   |    2 +-
 drivers/media/dvb/frontends/tua6100.h   |    2 +-
 drivers/media/dvb/frontends/ves1820.h   |    2 +-
 drivers/media/dvb/frontends/ves1x93.h   |    2 +-
 drivers/media/dvb/frontends/zl10353.h   |    2 +-
 31 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/media/dvb/frontends/bcm3510.h b/drivers/media/dvb/frontends/bcm3510.h
index 6dfa839..7e4f95e 100644
--- a/drivers/media/dvb/frontends/bcm3510.h
+++ b/drivers/media/dvb/frontends/bcm3510.h
@@ -34,7 +34,7 @@ struct bcm3510_config
 	int (*request_firmware)(struct dvb_frontend* fe, const struct firmware **fw, char* name);
 };
 
-#if defined(CONFIG_DVB_BCM3510) || defined(CONFIG_DVB_BCM3510_MODULE)
+#if defined(CONFIG_DVB_BCM3510) || (defined(CONFIG_DVB_BCM3510_MODULE) && defined(MODULE))
 extern struct dvb_frontend* bcm3510_attach(const struct bcm3510_config* config,
 					   struct i2c_adapter* i2c);
 #else
diff --git a/drivers/media/dvb/frontends/cx22700.h b/drivers/media/dvb/frontends/cx22700.h
index 10286cc..7ac3369 100644
--- a/drivers/media/dvb/frontends/cx22700.h
+++ b/drivers/media/dvb/frontends/cx22700.h
@@ -31,7 +31,7 @@ struct cx22700_config
 	u8 demod_address;
 };
 
-#if defined(CONFIG_DVB_CX22700) || defined(CONFIG_DVB_CX22700_MODULE)
+#if defined(CONFIG_DVB_CX22700) || (defined(CONFIG_DVB_CX22700_MODULE) && defined(MODULE))
 extern struct dvb_frontend* cx22700_attach(const struct cx22700_config* config,
 					   struct i2c_adapter* i2c);
 #else
diff --git a/drivers/media/dvb/frontends/cx22702.h b/drivers/media/dvb/frontends/cx22702.h
index bc217dd..9cd64da 100644
--- a/drivers/media/dvb/frontends/cx22702.h
+++ b/drivers/media/dvb/frontends/cx22702.h
@@ -41,7 +41,7 @@ #define CX22702_SERIAL_OUTPUT   1
 	u8 output_mode;
 };
 
-#if defined(CONFIG_DVB_CX22702) || defined(CONFIG_DVB_CX22702_MODULE)
+#if defined(CONFIG_DVB_CX22702) || (defined(CONFIG_DVB_CX22702_MODULE) && defined(MODULE))
 extern struct dvb_frontend* cx22702_attach(const struct cx22702_config* config,
 					   struct i2c_adapter* i2c);
 #else
diff --git a/drivers/media/dvb/frontends/cx24110.h b/drivers/media/dvb/frontends/cx24110.h
index c9d5ae2..0ca3af4 100644
--- a/drivers/media/dvb/frontends/cx24110.h
+++ b/drivers/media/dvb/frontends/cx24110.h
@@ -41,7 +41,7 @@ static inline int cx24110_pll_write(stru
 	return r;
 }
 
-#if defined(CONFIG_DVB_CX24110) || defined(CONFIG_DVB_CX24110_MODULE)
+#if defined(CONFIG_DVB_CX24110) || (defined(CONFIG_DVB_CX24110_MODULE) && defined(MODULE))
 extern struct dvb_frontend* cx24110_attach(const struct cx24110_config* config,
 					   struct i2c_adapter* i2c);
 #else
diff --git a/drivers/media/dvb/frontends/cx24123.h b/drivers/media/dvb/frontends/cx24123.h
index 57a1dae..84f9e4f 100644
--- a/drivers/media/dvb/frontends/cx24123.h
+++ b/drivers/media/dvb/frontends/cx24123.h
@@ -35,7 +35,7 @@ struct cx24123_config
 	int lnb_polarity;
 };
 
-#if defined(CONFIG_DVB_CX24123) || defined(CONFIG_DVB_CX24123_MODULE)
+#if defined(CONFIG_DVB_CX24123) || (defined(CONFIG_DVB_CX24123_MODULE) && defined(MODULE))
 extern struct dvb_frontend* cx24123_attach(const struct cx24123_config* config,
 					   struct i2c_adapter* i2c);
 #else
diff --git a/drivers/media/dvb/frontends/dib3000.h b/drivers/media/dvb/frontends/dib3000.h
index 0caac3f..a6d3854 100644
--- a/drivers/media/dvb/frontends/dib3000.h
+++ b/drivers/media/dvb/frontends/dib3000.h
@@ -41,7 +41,7 @@ struct dib_fe_xfer_ops
 	int (*tuner_pass_ctrl)(struct dvb_frontend *fe, int onoff, u8 pll_ctrl);
 };
 
-#if defined(CONFIG_DVB_DIB3000MB) || defined(CONFIG_DVB_DIB3000MB_MODULE)
+#if defined(CONFIG_DVB_DIB3000MB) || (defined(CONFIG_DVB_DIB3000MB_MODULE) && defined(MODULE))
 extern struct dvb_frontend* dib3000mb_attach(const struct dib3000_config* config,
 					     struct i2c_adapter* i2c, struct dib_fe_xfer_ops *xfer_ops);
 #else
diff --git a/drivers/media/dvb/frontends/dib3000mc.h b/drivers/media/dvb/frontends/dib3000mc.h
index 0d6fdef..72d4757 100644
--- a/drivers/media/dvb/frontends/dib3000mc.h
+++ b/drivers/media/dvb/frontends/dib3000mc.h
@@ -39,7 +39,7 @@ struct dib3000mc_config {
 #define DEFAULT_DIB3000MC_I2C_ADDRESS 16
 #define DEFAULT_DIB3000P_I2C_ADDRESS  24
 
-#if defined(CONFIG_DVB_DIB3000MC) || defined(CONFIG_DVB_DIB3000MC_MODULE)
+#if defined(CONFIG_DVB_DIB3000MC) || (defined(CONFIG_DVB_DIB3000MC_MODULE) && defined(MODULE))
 extern struct dvb_frontend * dib3000mc_attach(struct i2c_adapter *i2c_adap, u8 i2c_addr, struct dib3000mc_config *cfg);
 #else
 static inline struct dvb_frontend * dib3000mc_attach(struct i2c_adapter *i2c_adap, u8 i2c_addr, struct dib3000mc_config *cfg)
diff --git a/drivers/media/dvb/frontends/isl6421.h b/drivers/media/dvb/frontends/isl6421.h
index 1916e3e..ea7f78a 100644
--- a/drivers/media/dvb/frontends/isl6421.h
+++ b/drivers/media/dvb/frontends/isl6421.h
@@ -39,7 +39,7 @@ #define ISL6421_ENT1	0x10
 #define ISL6421_ISEL1	0x20
 #define ISL6421_DCL	0x40
 
-#if defined(CONFIG_DVB_ISL6421) || defined(CONFIG_DVB_ISL6421_MODULE)
+#if defined(CONFIG_DVB_ISL6421) || (defined(CONFIG_DVB_ISL6421_MODULE) && defined(MODULE))
 /* override_set and override_clear control which system register bits (above) to always set & clear */
 extern struct dvb_frontend *isl6421_attach(struct dvb_frontend *fe, struct i2c_adapter *i2c, u8 i2c_addr,
 			  u8 override_set, u8 override_clear);
diff --git a/drivers/media/dvb/frontends/l64781.h b/drivers/media/dvb/frontends/l64781.h
index 21ba4a2..cd15f76 100644
--- a/drivers/media/dvb/frontends/l64781.h
+++ b/drivers/media/dvb/frontends/l64781.h
@@ -31,7 +31,7 @@ struct l64781_config
 	u8 demod_address;
 };
 
-#if defined(CONFIG_DVB_L64781) || defined(CONFIG_DVB_L64781_MODULE)
+#if defined(CONFIG_DVB_L64781) || (defined(CONFIG_DVB_L64781_MODULE) && defined(MODULE))
 extern struct dvb_frontend* l64781_attach(const struct l64781_config* config,
 					  struct i2c_adapter* i2c);
 #else
diff --git a/drivers/media/dvb/frontends/lgdt330x.h b/drivers/media/dvb/frontends/lgdt330x.h
index 3f96b48..9950590 100644
--- a/drivers/media/dvb/frontends/lgdt330x.h
+++ b/drivers/media/dvb/frontends/lgdt330x.h
@@ -52,7 +52,7 @@ struct lgdt330x_config
 	int clock_polarity_flip;
 };
 
-#if defined(CONFIG_DVB_LGDT330X) || defined(CONFIG_DVB_LGDT330X_MODULE)
+#if defined(CONFIG_DVB_LGDT330X) || (defined(CONFIG_DVB_LGDT330X_MODULE) && defined(MODULE))
 extern struct dvb_frontend* lgdt330x_attach(const struct lgdt330x_config* config,
 					    struct i2c_adapter* i2c);
 #else
diff --git a/drivers/media/dvb/frontends/lnbp21.h b/drivers/media/dvb/frontends/lnbp21.h
index 1fe1dd1..68906ac 100644
--- a/drivers/media/dvb/frontends/lnbp21.h
+++ b/drivers/media/dvb/frontends/lnbp21.h
@@ -39,7 +39,7 @@ #define LNBP21_PCL	0x80
 
 #include <linux/dvb/frontend.h>
 
-#if defined(CONFIG_DVB_LNBP21) || defined(CONFIG_DVB_LNBP21_MODULE)
+#if defined(CONFIG_DVB_LNBP21) || (defined(CONFIG_DVB_LNBP21_MODULE) && defined(MODULE))
 /* override_set and override_clear control which system register bits (above) to always set & clear */
 extern struct dvb_frontend *lnbp21_attach(struct dvb_frontend *fe, struct i2c_adapter *i2c, u8 override_set, u8 override_clear);
 #else
diff --git a/drivers/media/dvb/frontends/mt312.h b/drivers/media/dvb/frontends/mt312.h
index 7112fb4..cf9a150 100644
--- a/drivers/media/dvb/frontends/mt312.h
+++ b/drivers/media/dvb/frontends/mt312.h
@@ -34,7 +34,7 @@ struct mt312_config
 	u8 demod_address;
 };
 
-#if defined(CONFIG_DVB_MT312) || defined(CONFIG_DVB_MT312_MODULE)
+#if defined(CONFIG_DVB_MT312) || (defined(CONFIG_DVB_MT312_MODULE) && defined(MODULE))
 struct dvb_frontend* vp310_mt312_attach(const struct mt312_config* config,
 					struct i2c_adapter* i2c);
 #else
diff --git a/drivers/media/dvb/frontends/mt352.h b/drivers/media/dvb/frontends/mt352.h
index 0035c2e..e996408 100644
--- a/drivers/media/dvb/frontends/mt352.h
+++ b/drivers/media/dvb/frontends/mt352.h
@@ -51,7 +51,7 @@ struct mt352_config
 	int (*demod_init)(struct dvb_frontend* fe);
 };
 
-#if defined(CONFIG_DVB_MT352) || defined(CONFIG_DVB_MT352_MODULE)
+#if defined(CONFIG_DVB_MT352) || (defined(CONFIG_DVB_MT352_MODULE) && defined(MODULE))
 extern struct dvb_frontend* mt352_attach(const struct mt352_config* config,
 					 struct i2c_adapter* i2c);
 #else
diff --git a/drivers/media/dvb/frontends/nxt200x.h b/drivers/media/dvb/frontends/nxt200x.h
index 2eb220e..28bc559 100644
--- a/drivers/media/dvb/frontends/nxt200x.h
+++ b/drivers/media/dvb/frontends/nxt200x.h
@@ -45,7 +45,7 @@ struct nxt200x_config
 	int (*set_ts_params)(struct dvb_frontend* fe, int is_punctured);
 };
 
-#if defined(CONFIG_DVB_NXT200X) || defined(CONFIG_DVB_NXT200X_MODULE)
+#if defined(CONFIG_DVB_NXT200X) || (defined(CONFIG_DVB_NXT200X_MODULE) && defined(MODULE))
 extern struct dvb_frontend* nxt200x_attach(const struct nxt200x_config* config,
 					   struct i2c_adapter* i2c);
 #else
diff --git a/drivers/media/dvb/frontends/nxt6000.h b/drivers/media/dvb/frontends/nxt6000.h
index 9397393..13d2251 100644
--- a/drivers/media/dvb/frontends/nxt6000.h
+++ b/drivers/media/dvb/frontends/nxt6000.h
@@ -33,7 +33,7 @@ struct nxt6000_config
 	u8 clock_inversion:1;
 };
 
-#if defined(CONFIG_DVB_NXT6000) || defined(CONFIG_DVB_NXT6000_MODULE)
+#if defined(CONFIG_DVB_NXT6000) || (defined(CONFIG_DVB_NXT6000_MODULE) && defined(MODULE))
 extern struct dvb_frontend* nxt6000_attach(const struct nxt6000_config* config,
 					   struct i2c_adapter* i2c);
 #else
diff --git a/drivers/media/dvb/frontends/or51132.h b/drivers/media/dvb/frontends/or51132.h
index 9718be4..add24f0 100644
--- a/drivers/media/dvb/frontends/or51132.h
+++ b/drivers/media/dvb/frontends/or51132.h
@@ -34,7 +34,7 @@ struct or51132_config
 	int (*set_ts_params)(struct dvb_frontend* fe, int is_punctured);
 };
 
-#if defined(CONFIG_DVB_OR51132) || defined(CONFIG_DVB_OR51132_MODULE)
+#if defined(CONFIG_DVB_OR51132) || (defined(CONFIG_DVB_OR51132_MODULE) && defined(MODULE))
 extern struct dvb_frontend* or51132_attach(const struct or51132_config* config,
 					   struct i2c_adapter* i2c);
 #else
diff --git a/drivers/media/dvb/frontends/or51211.h b/drivers/media/dvb/frontends/or51211.h
index 10a5419..8aad840 100644
--- a/drivers/media/dvb/frontends/or51211.h
+++ b/drivers/media/dvb/frontends/or51211.h
@@ -37,7 +37,7 @@ struct or51211_config
 	void (*sleep)(struct dvb_frontend * fe);
 };
 
-#if defined(CONFIG_DVB_OR51211) || defined(CONFIG_DVB_OR51211_MODULE)
+#if defined(CONFIG_DVB_OR51211) || (defined(CONFIG_DVB_OR51211_MODULE) && defined(MODULE))
 extern struct dvb_frontend* or51211_attach(const struct or51211_config* config,
 					   struct i2c_adapter* i2c);
 #else
diff --git a/drivers/media/dvb/frontends/s5h1420.h b/drivers/media/dvb/frontends/s5h1420.h
index efc54d7..1555870 100644
--- a/drivers/media/dvb/frontends/s5h1420.h
+++ b/drivers/media/dvb/frontends/s5h1420.h
@@ -34,7 +34,7 @@ struct s5h1420_config
 	u8 invert:1;
 };
 
-#if defined(CONFIG_DVB_S5H1420) || defined(CONFIG_DVB_S5H1420_MODULE)
+#if defined(CONFIG_DVB_S5H1420) || (defined(CONFIG_DVB_S5H1420_MODULE) && defined(MODULE))
 extern struct dvb_frontend* s5h1420_attach(const struct s5h1420_config* config,
 	     struct i2c_adapter* i2c);
 #else
diff --git a/drivers/media/dvb/frontends/sp8870.h b/drivers/media/dvb/frontends/sp8870.h
index 4cf27d3..909cefe 100644
--- a/drivers/media/dvb/frontends/sp8870.h
+++ b/drivers/media/dvb/frontends/sp8870.h
@@ -35,7 +35,7 @@ struct sp8870_config
 	int (*request_firmware)(struct dvb_frontend* fe, const struct firmware **fw, char* name);
 };
 
-#if defined(CONFIG_DVB_SP8870) || defined(CONFIG_DVB_SP8870_MODULE)
+#if defined(CONFIG_DVB_SP8870) || (defined(CONFIG_DVB_SP8870_MODULE) && defined(MODULE))
 extern struct dvb_frontend* sp8870_attach(const struct sp8870_config* config,
 					  struct i2c_adapter* i2c);
 #else
diff --git a/drivers/media/dvb/frontends/sp887x.h b/drivers/media/dvb/frontends/sp887x.h
index cab7ea6..7ee78d7 100644
--- a/drivers/media/dvb/frontends/sp887x.h
+++ b/drivers/media/dvb/frontends/sp887x.h
@@ -17,7 +17,7 @@ struct sp887x_config
 	int (*request_firmware)(struct dvb_frontend* fe, const struct firmware **fw, char* name);
 };
 
-#if defined(CONFIG_DVB_SP887X) || defined(CONFIG_DVB_SP887X_MODULE)
+#if defined(CONFIG_DVB_SP887X) || (defined(CONFIG_DVB_SP887X_MODULE) && defined(MODULE))
 extern struct dvb_frontend* sp887x_attach(const struct sp887x_config* config,
 					  struct i2c_adapter* i2c);
 #else
diff --git a/drivers/media/dvb/frontends/stv0297.h b/drivers/media/dvb/frontends/stv0297.h
index 760b80d..69f4515 100644
--- a/drivers/media/dvb/frontends/stv0297.h
+++ b/drivers/media/dvb/frontends/stv0297.h
@@ -42,7 +42,7 @@ struct stv0297_config
 	u8 stop_during_read:1;
 };
 
-#if defined(CONFIG_DVB_STV0297) || defined(CONFIG_DVB_STV0297_MODULE)
+#if defined(CONFIG_DVB_STV0297) || (defined(CONFIG_DVB_STV0297_MODULE) && defined(MODULE))
 extern struct dvb_frontend* stv0297_attach(const struct stv0297_config* config,
 					   struct i2c_adapter* i2c);
 #else
diff --git a/drivers/media/dvb/frontends/stv0299.h b/drivers/media/dvb/frontends/stv0299.h
index 7ef2520..33df949 100644
--- a/drivers/media/dvb/frontends/stv0299.h
+++ b/drivers/media/dvb/frontends/stv0299.h
@@ -89,7 +89,7 @@ struct stv0299_config
 	int (*set_symbol_rate)(struct dvb_frontend* fe, u32 srate, u32 ratio);
 };
 
-#if defined(CONFIG_DVB_STV0299) || defined(CONFIG_DVB_STV0299_MODULE)
+#if defined(CONFIG_DVB_STV0299) || (defined(CONFIG_DVB_STV0299_MODULE) && defined(MODULE))
 extern struct dvb_frontend* stv0299_attach(const struct stv0299_config* config,
 					   struct i2c_adapter* i2c);
 #else
diff --git a/drivers/media/dvb/frontends/tda10021.h b/drivers/media/dvb/frontends/tda10021.h
index d68ae20..e3da780 100644
--- a/drivers/media/dvb/frontends/tda10021.h
+++ b/drivers/media/dvb/frontends/tda10021.h
@@ -32,7 +32,7 @@ struct tda10021_config
 	u8 demod_address;
 };
 
-#if defined(CONFIG_DVB_TDA10021) || defined(CONFIG_DVB_TDA10021_MODULE)
+#if defined(CONFIG_DVB_TDA10021) || (defined(CONFIG_DVB_TDA10021_MODULE) && defined(MODULE))
 extern struct dvb_frontend* tda10021_attach(const struct tda10021_config* config,
 					    struct i2c_adapter* i2c, u8 pwm);
 #else
diff --git a/drivers/media/dvb/frontends/tda1004x.h b/drivers/media/dvb/frontends/tda1004x.h
index e28fca0..605ad2d 100644
--- a/drivers/media/dvb/frontends/tda1004x.h
+++ b/drivers/media/dvb/frontends/tda1004x.h
@@ -71,7 +71,7 @@ struct tda1004x_config
 	int (*request_firmware)(struct dvb_frontend* fe, const struct firmware **fw, char* name);
 };
 
-#if defined(CONFIG_DVB_TDA1004X) || defined(CONFIG_DVB_TDA1004X_MODULE)
+#if defined(CONFIG_DVB_TDA1004X) || (defined(CONFIG_DVB_TDA1004X_MODULE) && defined(MODULE))
 extern struct dvb_frontend* tda10045_attach(const struct tda1004x_config* config,
 					    struct i2c_adapter* i2c);
 
diff --git a/drivers/media/dvb/frontends/tda10086.h b/drivers/media/dvb/frontends/tda10086.h
index 18457ad..ed584a8 100644
--- a/drivers/media/dvb/frontends/tda10086.h
+++ b/drivers/media/dvb/frontends/tda10086.h
@@ -35,7 +35,7 @@ struct tda10086_config
 	u8 invert;
 };
 
-#if defined(CONFIG_DVB_TDA10086) || defined(CONFIG_DVB_TDA10086_MODULE)
+#if defined(CONFIG_DVB_TDA10086) || (defined(CONFIG_DVB_TDA10086_MODULE) && defined(MODULE))
 extern struct dvb_frontend* tda10086_attach(const struct tda10086_config* config,
 					    struct i2c_adapter* i2c);
 #else
diff --git a/drivers/media/dvb/frontends/tda8083.h b/drivers/media/dvb/frontends/tda8083.h
index aae15bd..2d33079 100644
--- a/drivers/media/dvb/frontends/tda8083.h
+++ b/drivers/media/dvb/frontends/tda8083.h
@@ -35,7 +35,7 @@ struct tda8083_config
 	u8 demod_address;
 };
 
-#if defined(CONFIG_DVB_TDA8083) || defined(CONFIG_DVB_TDA8083_MODULE)
+#if defined(CONFIG_DVB_TDA8083) || (defined(CONFIG_DVB_TDA8083_MODULE) && defined(MODULE))
 extern struct dvb_frontend* tda8083_attach(const struct tda8083_config* config,
 					   struct i2c_adapter* i2c);
 #else
diff --git a/drivers/media/dvb/frontends/tda826x.h b/drivers/media/dvb/frontends/tda826x.h
index 83998c0..ad99811 100644
--- a/drivers/media/dvb/frontends/tda826x.h
+++ b/drivers/media/dvb/frontends/tda826x.h
@@ -35,7 +35,7 @@ #include "dvb_frontend.h"
  * @param has_loopthrough Set to 1 if the card has a loopthrough RF connector.
  * @return FE pointer on success, NULL on failure.
  */
-#if defined(CONFIG_DVB_TDA826X) || defined(CONFIG_DVB_TDA826X_MODULE)
+#if defined(CONFIG_DVB_TDA826X) || (defined(CONFIG_DVB_TDA826X_MODULE) && defined(MODULE))
 extern struct dvb_frontend* tda826x_attach(struct dvb_frontend *fe, int addr,
 					   struct i2c_adapter *i2c,
 					   int has_loopthrough);
diff --git a/drivers/media/dvb/frontends/tua6100.h b/drivers/media/dvb/frontends/tua6100.h
index 8f98033..03a665e 100644
--- a/drivers/media/dvb/frontends/tua6100.h
+++ b/drivers/media/dvb/frontends/tua6100.h
@@ -34,7 +34,7 @@ #define __DVB_TUA6100_H__
 #include <linux/i2c.h>
 #include "dvb_frontend.h"
 
-#if defined(CONFIG_DVB_TUA6100) || defined(CONFIG_DVB_TUA6100_MODULE)
+#if defined(CONFIG_DVB_TUA6100) || (defined(CONFIG_DVB_TUA6100_MODULE) && defined(MODULE))
 extern struct dvb_frontend *tua6100_attach(struct dvb_frontend *fe, int addr, struct i2c_adapter *i2c);
 #else
 static inline struct dvb_frontend* tua6100_attach(struct dvb_frontend *fe, int addr, struct i2c_adapter *i2c)
diff --git a/drivers/media/dvb/frontends/ves1820.h b/drivers/media/dvb/frontends/ves1820.h
index f0c9dde..e4a2a32 100644
--- a/drivers/media/dvb/frontends/ves1820.h
+++ b/drivers/media/dvb/frontends/ves1820.h
@@ -41,7 +41,7 @@ struct ves1820_config
 	u8 selagc:1;
 };
 
-#if defined(CONFIG_DVB_VES1820) || defined(CONFIG_DVB_VES1820_MODULE)
+#if defined(CONFIG_DVB_VES1820) || (defined(CONFIG_DVB_VES1820_MODULE) && defined(MODULE))
 extern struct dvb_frontend* ves1820_attach(const struct ves1820_config* config,
 					   struct i2c_adapter* i2c, u8 pwm);
 #else
diff --git a/drivers/media/dvb/frontends/ves1x93.h b/drivers/media/dvb/frontends/ves1x93.h
index 395fed3..d507f89 100644
--- a/drivers/media/dvb/frontends/ves1x93.h
+++ b/drivers/media/dvb/frontends/ves1x93.h
@@ -40,7 +40,7 @@ struct ves1x93_config
 	u8 invert_pwm:1;
 };
 
-#if defined(CONFIG_DVB_VES1X93) || defined(CONFIG_DVB_VES1X93_MODULE)
+#if defined(CONFIG_DVB_VES1X93) || (defined(CONFIG_DVB_VES1X93_MODULE) && defined(MODULE))
 extern struct dvb_frontend* ves1x93_attach(const struct ves1x93_config* config,
 					   struct i2c_adapter* i2c);
 #else
diff --git a/drivers/media/dvb/frontends/zl10353.h b/drivers/media/dvb/frontends/zl10353.h
index 79a9472..0bc0109 100644
--- a/drivers/media/dvb/frontends/zl10353.h
+++ b/drivers/media/dvb/frontends/zl10353.h
@@ -36,7 +36,7 @@ struct zl10353_config
 	int parallel_ts;
 };
 
-#if defined(CONFIG_DVB_ZL10353) || defined(CONFIG_DVB_ZL10353_MODULE)
+#if defined(CONFIG_DVB_ZL10353) || (defined(CONFIG_DVB_ZL10353_MODULE) && defined(MODULE))
 extern struct dvb_frontend* zl10353_attach(const struct zl10353_config *config,
 					   struct i2c_adapter *i2c);
 #else

