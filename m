Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262941AbVEHT7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262941AbVEHT7W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 15:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbVEHT5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 15:57:37 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:5783 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262942AbVEHTKY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:10:24 -0400
Message-Id: <20050508184348.329919000@abc>
References: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:42:53 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
Content-Disposition: inline; filename=dvb-cleanup-make-static-drop-ununsed.patch
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 24/37] make needlessly global code static or drop it
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- make needlessly global code static
- #if 0 the following unused global functions:
  - ttpci/av7110_hw.c: av7110_reset_arm
  - ttpci/av7110_hw.c: av7110_send_ci_cmd
- frontends/mt352.[ch]: drop mt352_read

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/frontends/mt352.c               |   12 ------------
 drivers/media/dvb/frontends/mt352.h               |    1 -
 drivers/media/dvb/ttpci/av7110.h                  |    1 -
 drivers/media/dvb/ttpci/av7110_hw.c               |   12 +++++++-----
 drivers/media/dvb/ttpci/av7110_hw.h               |    5 -----
 drivers/media/dvb/ttpci/av7110_v4l.c              |    2 +-
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |    2 +-
 drivers/media/dvb/ttusb-dec/ttusb_dec.c           |    8 ++++----
 8 files changed, 13 insertions(+), 30 deletions(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/mt352.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/mt352.c	2005-05-08 16:26:30.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/mt352.c	2005-05-08 16:32:39.000000000 +0200
@@ -102,11 +102,6 @@ static int mt352_read_register(struct mt
 	return b1[0];
 }
 
-int mt352_read(struct dvb_frontend *fe, u8 reg)
-{
-	return mt352_read_register(fe->demodulator_priv,reg);
-}
-
 static int mt352_sleep(struct dvb_frontend* fe)
 {
 	static u8 mt352_softdown[] = { CLOCK_CTL, 0x20, 0x08 };
@@ -601,10 +596,3 @@ MODULE_LICENSE("GPL");
 
 EXPORT_SYMBOL(mt352_attach);
 EXPORT_SYMBOL(mt352_write);
-EXPORT_SYMBOL(mt352_read);
-/*
- * Local variables:
- * c-basic-offset: 8
- * compile-command: "make DVB=1"
- * End:
- */
Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/mt352.h
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/mt352.h	2005-05-08 15:55:37.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/mt352.h	2005-05-08 16:32:39.000000000 +0200
@@ -61,7 +61,6 @@ extern struct dvb_frontend* mt352_attach
 					 struct i2c_adapter* i2c);
 
 extern int mt352_write(struct dvb_frontend* fe, u8* ibuf, int ilen);
-extern int mt352_read(struct dvb_frontend *fe, u8 reg);
 
 #endif // MT352_H
 
Index: linux-2.6.12-rc4/drivers/media/dvb/ttpci/av7110.h
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/ttpci/av7110.h	2005-05-08 15:55:37.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/ttpci/av7110.h	2005-05-08 16:32:39.000000000 +0200
@@ -274,7 +274,6 @@ extern void av7110_ir_exit (void);
 extern int i2c_writereg(struct av7110 *av7110, u8 id, u8 reg, u8 val);
 extern u8 i2c_readreg(struct av7110 *av7110, u8 id, u8 reg);
 extern int msp_writereg(struct av7110 *av7110, u8 dev, u16 reg, u16 val);
-extern int msp_readreg(struct av7110 *av7110, u8 dev, u16 reg, u16 *val);
 
 
 extern int av7110_init_analog_module(struct av7110 *av7110);
Index: linux-2.6.12-rc4/drivers/media/dvb/ttpci/av7110_hw.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/ttpci/av7110_hw.c	2005-05-08 15:55:37.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/ttpci/av7110_hw.c	2005-05-08 16:32:39.000000000 +0200
@@ -104,7 +104,7 @@ u32 av7110_debiread(struct av7110 *av711
 
 
 /* av7110 ARM core boot stuff */
-
+#if 0
 void av7110_reset_arm(struct av7110 *av7110)
 {
 	saa7146_setgpio(av7110->dev, RESET_LINE, SAA7146_GPIO_OUTLO);
@@ -124,7 +124,7 @@ void av7110_reset_arm(struct av7110 *av7
 	av7110->arm_ready = 1;
 	dprintk(1, "reset ARM\n");
 }
-
+#endif  /*  0  */
 
 static int waitdebi(struct av7110 *av7110, int adr, int state)
 {
@@ -335,7 +335,7 @@ int av7110_wait_msgstate(struct av7110 *
 	return 0;
 }
 
-int __av7110_send_fw_cmd(struct av7110 *av7110, u16* buf, int length)
+static int __av7110_send_fw_cmd(struct av7110 *av7110, u16* buf, int length)
 {
 	int i;
 	unsigned long start;
@@ -455,7 +455,7 @@ int __av7110_send_fw_cmd(struct av7110 *
 	return 0;
 }
 
-int av7110_send_fw_cmd(struct av7110 *av7110, u16* buf, int length)
+static int av7110_send_fw_cmd(struct av7110 *av7110, u16* buf, int length)
 {
 	int ret;
 
@@ -500,6 +500,7 @@ int av7110_fw_cmd(struct av7110 *av7110,
 	return ret;
 }
 
+#if 0
 int av7110_send_ci_cmd(struct av7110 *av7110, u8 subcom, u8 *buf, u8 len)
 {
 	int i, ret;
@@ -521,6 +522,7 @@ int av7110_send_ci_cmd(struct av7110 *av
 		printk(KERN_ERR "dvb-ttpci: av7110_send_ci_cmd error %d\n", ret);
 	return ret;
 }
+#endif  /*  0  */
 
 int av7110_fw_request(struct av7110 *av7110, u16 *request_buf,
 		      int request_buf_len, u16 *reply_buf, int reply_buf_len)
@@ -593,7 +595,7 @@ int av7110_fw_request(struct av7110 *av7
 	return 0;
 }
 
-int av7110_fw_query(struct av7110 *av7110, u16 tag, u16* buf, s16 length)
+static int av7110_fw_query(struct av7110 *av7110, u16 tag, u16* buf, s16 length)
 {
 	int ret;
 	ret = av7110_fw_request(av7110, &tag, 0, buf, length);
Index: linux-2.6.12-rc4/drivers/media/dvb/ttpci/av7110_hw.h
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/ttpci/av7110_hw.h	2005-05-08 15:55:37.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/ttpci/av7110_hw.h	2005-05-08 16:32:39.000000000 +0200
@@ -364,7 +364,6 @@ enum av7110_command_type {
 
 
 
-extern void av7110_reset_arm(struct av7110 *av7110);
 extern int av7110_bootarm(struct av7110 *av7110);
 extern int av7110_firmversion(struct av7110 *av7110);
 #define FW_CI_LL_SUPPORT(arm_app) ((arm_app) & 0x80000000)
@@ -373,12 +372,8 @@ extern int av7110_firmversion(struct av7
 
 extern int av7110_wait_msgstate(struct av7110 *av7110, u16 flags);
 extern int av7110_fw_cmd(struct av7110 *av7110, int type, int com, int num, ...);
-extern int __av7110_send_fw_cmd(struct av7110 *av7110, u16* buf, int length);
-extern int av7110_send_fw_cmd(struct av7110 *av7110, u16* buf, int length);
-extern int av7110_send_ci_cmd(struct av7110 *av7110, u8 subcom, u8 *buf, u8 len);
 extern int av7110_fw_request(struct av7110 *av7110, u16 *request_buf,
 			     int request_buf_len, u16 *reply_buf, int reply_buf_len);
-extern int av7110_fw_query(struct av7110 *av7110, u16 tag, u16* Buff, s16 length);
 
 
 /* DEBI (saa7146 data extension bus interface) access */
Index: linux-2.6.12-rc4/drivers/media/dvb/ttpci/av7110_v4l.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/ttpci/av7110_v4l.c	2005-05-08 16:14:09.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/ttpci/av7110_v4l.c	2005-05-08 16:32:39.000000000 +0200
@@ -52,7 +52,7 @@ int msp_writereg(struct av7110 *av7110, 
 	return 0;
 }
 
-int msp_readreg(struct av7110 *av7110, u8 dev, u16 reg, u16 *val)
+static int msp_readreg(struct av7110 *av7110, u8 dev, u16 reg, u16 *val)
 {
 	u8 msg1[3] = { dev, reg >> 8, reg & 0xff };
 	u8 msg2[2];
Index: linux-2.6.12-rc4/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2005-05-08 15:55:37.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2005-05-08 16:32:39.000000000 +0200
@@ -1065,7 +1065,7 @@ static int alps_tdmb7_pll_set(struct dvb
 	return 0;
 }
 
-struct cx22700_config alps_tdmb7_config = {
+static struct cx22700_config alps_tdmb7_config = {
 	.demod_address = 0x43,
 	.pll_set = alps_tdmb7_pll_set,
 };
Index: linux-2.6.12-rc4/drivers/media/dvb/ttusb-dec/ttusb_dec.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2005-05-08 15:55:37.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2005-05-08 16:32:39.000000000 +0200
@@ -1565,15 +1565,15 @@ static void ttusb_dec_exit_filters(struc
 	}
 }
 
-int fe_send_command(struct dvb_frontend* fe, const u8 command,
-		    int param_length, const u8 params[],
-		    int *result_length, u8 cmd_result[])
+static int fe_send_command(struct dvb_frontend* fe, const u8 command,
+			   int param_length, const u8 params[],
+			   int *result_length, u8 cmd_result[])
 {
 	struct ttusb_dec* dec = (struct ttusb_dec*) fe->dvb->priv;
 	return ttusb_dec_send_command(dec, command, param_length, params, result_length, cmd_result);
 }
 
-struct ttusbdecfe_config fe_config = {
+static struct ttusbdecfe_config fe_config = {
 	.send_command = fe_send_command
 };
 

--

