Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVDSAob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVDSAob (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 20:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVDSAob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 20:44:31 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:32524 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261222AbVDSAnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 20:43:12 -0400
Date: Tue, 19 Apr 2005 02:43:08 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-dvb-maintainer@linuxtv.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/media/dvb/: possible cleanups
Message-ID: <20050419004308.GJ5489@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global code static
- #if 0 the following unused global functions:
  - dibusb/dvb-dibusb-usb.c: dibusb_set_streaming_mode
  - frontends/mt352.c: mt352_read
  - ttpci/av7110_hw.c: av7110_reset_arm
  - ttpci/av7110_hw.c: av7110_send_ci_cmd
- remove the following unneeded EXPORT_SYMBOL:
  - frontends/mt352.c: mt352_read

Please review which of these changes do make sense.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/media/dvb/dibusb/dvb-dibusb-usb.c         |    2 ++
 drivers/media/dvb/dibusb/dvb-dibusb.h             |    1 -
 drivers/media/dvb/frontends/mt352.c               |    3 ++-
 drivers/media/dvb/frontends/mt352.h               |    1 -
 drivers/media/dvb/ttpci/av7110.h                  |    1 -
 drivers/media/dvb/ttpci/av7110_hw.c               |   12 +++++++-----
 drivers/media/dvb/ttpci/av7110_hw.h               |    5 -----
 drivers/media/dvb/ttpci/av7110_v4l.c              |    2 +-
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |    2 +-
 drivers/media/dvb/ttusb-dec/ttusb_dec.c           |    8 ++++----
 10 files changed, 17 insertions(+), 20 deletions(-)

--- linux-2.6.12-rc2-mm3-full/drivers/media/dvb/dibusb/dvb-dibusb.h.old	2005-04-19 01:23:04.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/media/dvb/dibusb/dvb-dibusb.h	2005-04-19 01:23:09.000000000 +0200
@@ -230,7 +230,6 @@
 
 int dibusb_hw_wakeup(struct dvb_frontend *);
 int dibusb_hw_sleep(struct dvb_frontend *);
-int dibusb_set_streaming_mode(struct usb_dibusb *,u8);
 int dibusb_streaming(struct usb_dibusb *,int);
 
 int dibusb_urb_init(struct usb_dibusb *);
--- linux-2.6.12-rc2-mm3-full/drivers/media/dvb/dibusb/dvb-dibusb-usb.c.old	2005-04-19 01:23:17.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/media/dvb/dibusb/dvb-dibusb-usb.c	2005-04-19 01:23:30.000000000 +0200
@@ -139,11 +139,13 @@
 	return 0;
 }
 
+#if 0
 int dibusb_set_streaming_mode(struct usb_dibusb *dib,u8 mode)
 {
 	u8 b[2] = { DIBUSB_REQ_SET_STREAMING_MODE, mode };
 	return dibusb_readwrite_usb(dib,b,2,NULL,0);
 }
+#endif  /*  0  */
 
 static int dibusb_urb_kill(struct usb_dibusb *dib)
 {
--- linux-2.6.12-rc2-mm3-full/drivers/media/dvb/frontends/mt352.h.old	2005-04-19 01:25:12.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/media/dvb/frontends/mt352.h	2005-04-19 01:25:18.000000000 +0200
@@ -61,7 +61,6 @@
 					 struct i2c_adapter* i2c);
 
 extern int mt352_write(struct dvb_frontend* fe, u8* ibuf, int ilen);
-extern int mt352_read(struct dvb_frontend *fe, u8 reg);
 
 #endif // MT352_H
 
--- linux-2.6.12-rc2-mm3-full/drivers/media/dvb/frontends/mt352.c.old	2005-04-19 01:25:26.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/media/dvb/frontends/mt352.c	2005-04-19 01:44:26.000000000 +0200
@@ -102,10 +102,12 @@
 	return b1[0];
 }
 
+#if 0
 int mt352_read(struct dvb_frontend *fe, u8 reg)
 {
 	return mt352_read_register(fe->demodulator_priv,reg);
 }
+#endif  /*  0  */
 
 static int mt352_sleep(struct dvb_frontend* fe)
 {
@@ -601,7 +603,6 @@
 
 EXPORT_SYMBOL(mt352_attach);
 EXPORT_SYMBOL(mt352_write);
-EXPORT_SYMBOL(mt352_read);
 /*
  * Local variables:
  * c-basic-offset: 8
--- linux-2.6.12-rc2-mm3-full/drivers/media/dvb/ttpci/av7110_hw.h.old	2005-04-19 01:26:30.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/media/dvb/ttpci/av7110_hw.h	2005-04-19 01:29:15.000000000 +0200
@@ -364,7 +364,6 @@
 
 
 
-extern void av7110_reset_arm(struct av7110 *av7110);
 extern int av7110_bootarm(struct av7110 *av7110);
 extern int av7110_firmversion(struct av7110 *av7110);
 #define FW_CI_LL_SUPPORT(arm_app) ((arm_app) & 0x80000000)
@@ -373,12 +372,8 @@
 
 extern int av7110_wait_msgstate(struct av7110 *av7110, u16 flags);
 extern int av7110_fw_cmd(struct av7110 *av7110, int type, int com, int num, ...);
-extern int __av7110_send_fw_cmd(struct av7110 *av7110, u16* buf, int length);
-extern int av7110_send_fw_cmd(struct av7110 *av7110, u16* buf, int length);
-extern int av7110_send_ci_cmd(struct av7110 *av7110, u8 subcom, u8 *buf, u8 len);
 extern int av7110_fw_request(struct av7110 *av7110, u16 *request_buf,
 			     int request_buf_len, u16 *reply_buf, int reply_buf_len);
-extern int av7110_fw_query(struct av7110 *av7110, u16 tag, u16* Buff, s16 length);
 
 
 /* DEBI (saa7146 data extension bus interface) access */
--- linux-2.6.12-rc2-mm3-full/drivers/media/dvb/ttpci/av7110_hw.c.old	2005-04-19 01:27:14.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/media/dvb/ttpci/av7110_hw.c	2005-04-19 01:29:23.000000000 +0200
@@ -104,7 +104,7 @@
 
 
 /* av7110 ARM core boot stuff */
-
+#if 0
 void av7110_reset_arm(struct av7110 *av7110)
 {
 	saa7146_setgpio(av7110->dev, RESET_LINE, SAA7146_GPIO_OUTLO);
@@ -124,7 +124,7 @@
 	av7110->arm_ready = 1;
 	dprintk(1, "reset ARM\n");
 }
-
+#endif  /*  0  */
 
 static int waitdebi(struct av7110 *av7110, int adr, int state)
 {
@@ -335,7 +335,7 @@
 	return 0;
 }
 
-int __av7110_send_fw_cmd(struct av7110 *av7110, u16* buf, int length)
+static int __av7110_send_fw_cmd(struct av7110 *av7110, u16* buf, int length)
 {
 	int i;
 	unsigned long start;
@@ -455,7 +455,7 @@
 	return 0;
 }
 
-int av7110_send_fw_cmd(struct av7110 *av7110, u16* buf, int length)
+static int av7110_send_fw_cmd(struct av7110 *av7110, u16* buf, int length)
 {
 	int ret;
 
@@ -500,6 +500,7 @@
 	return ret;
 }
 
+#if 0
 int av7110_send_ci_cmd(struct av7110 *av7110, u8 subcom, u8 *buf, u8 len)
 {
 	int i, ret;
@@ -521,6 +522,7 @@
 		printk(KERN_ERR "dvb-ttpci: av7110_send_ci_cmd error %d\n", ret);
 	return ret;
 }
+#endif  /*  0  */
 
 int av7110_fw_request(struct av7110 *av7110, u16 *request_buf,
 		      int request_buf_len, u16 *reply_buf, int reply_buf_len)
@@ -593,7 +595,7 @@
 	return 0;
 }
 
-int av7110_fw_query(struct av7110 *av7110, u16 tag, u16* buf, s16 length)
+static int av7110_fw_query(struct av7110 *av7110, u16 tag, u16* buf, s16 length)
 {
 	int ret;
 	ret = av7110_fw_request(av7110, &tag, 0, buf, length);
--- linux-2.6.12-rc2-mm3-full/drivers/media/dvb/ttpci/av7110.h.old	2005-04-19 01:29:38.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/media/dvb/ttpci/av7110.h	2005-04-19 01:29:44.000000000 +0200
@@ -274,7 +274,6 @@
 extern int i2c_writereg(struct av7110 *av7110, u8 id, u8 reg, u8 val);
 extern u8 i2c_readreg(struct av7110 *av7110, u8 id, u8 reg);
 extern int msp_writereg(struct av7110 *av7110, u8 dev, u16 reg, u16 val);
-extern int msp_readreg(struct av7110 *av7110, u8 dev, u16 reg, u16 *val);
 
 
 extern int av7110_init_analog_module(struct av7110 *av7110);
--- linux-2.6.12-rc2-mm3-full/drivers/media/dvb/ttpci/av7110_v4l.c.old	2005-04-19 01:29:52.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/media/dvb/ttpci/av7110_v4l.c	2005-04-19 01:29:59.000000000 +0200
@@ -52,7 +52,7 @@
 	return 0;
 }
 
-int msp_readreg(struct av7110 *av7110, u8 dev, u16 reg, u16 *val)
+static int msp_readreg(struct av7110 *av7110, u8 dev, u16 reg, u16 *val)
 {
 	u8 msg1[3] = { dev, reg >> 8, reg & 0xff };
 	u8 msg2[2];
--- linux-2.6.12-rc2-mm3-full/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c.old	2005-04-19 01:30:10.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2005-04-19 01:30:22.000000000 +0200
@@ -1065,7 +1065,7 @@
 	return 0;
 }
 
-struct cx22700_config alps_tdmb7_config = {
+static struct cx22700_config alps_tdmb7_config = {
 	.demod_address = 0x43,
 	.pll_set = alps_tdmb7_pll_set,
 };
--- linux-2.6.12-rc2-mm3-full/drivers/media/dvb/ttusb-dec/ttusb_dec.c.old	2005-04-19 01:31:00.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2005-04-19 01:31:37.000000000 +0200
@@ -1565,15 +1565,15 @@
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
 

