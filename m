Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbVKTCof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbVKTCof (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 21:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbVKTCof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 21:44:35 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:58375 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751148AbVKTCoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 21:44:34 -0500
Date: Sun, 20 Nov 2005 03:44:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: mchehab@brturbo.com.br
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/media/video/: make code static
Message-ID: <20051120024432.GV16060@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes needlessly global code static.


 drivers/media/video/bttv-cards.c           |    6 +++---
 drivers/media/video/cx25840/cx25840-core.c |    4 ++--
 drivers/media/video/em28xx/em28xx-core.c   |    6 +++---
 drivers/media/video/em28xx/em28xx-video.c  |    2 +-
 drivers/media/video/saa7127.c              |    6 +++---
 drivers/media/video/saa7134/saa7134-alsa.c |    9 +++++----
 drivers/media/video/saa7134/saa7134-oss.c  |    4 ++--
 7 files changed, 19 insertions(+), 18 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

--- linux-2.6.15-rc1-mm2-full/drivers/media/video/em28xx/em28xx-video.c.old	2005-11-20 02:48:40.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/media/video/em28xx/em28xx-video.c	2005-11-20 02:48:51.000000000 +0100
@@ -226,7 +226,7 @@
  * em28xx_config_i2c()
  * configure i2c attached devices
  */
-void em28xx_config_i2c(struct em28xx *dev)
+static void em28xx_config_i2c(struct em28xx *dev)
 {
 	struct v4l2_frequency f;
 	struct video_decoder_init em28xx_vdi = {.data = NULL };
--- linux-2.6.15-rc1-mm2-full/drivers/media/video/saa7134/saa7134-alsa.c.old	2005-11-20 02:49:12.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/media/video/saa7134/saa7134-alsa.c	2005-11-20 02:58:01.000000000 +0100
@@ -58,7 +58,7 @@
 module_param_array(index, int, NULL, 0444);
 MODULE_PARM_DESC(index, "Index value for SAA7134 capture interface(s).");
 
-int position;
+static int position;
 
 #define dprintk(fmt, arg...)    if (debug) \
         printk(KERN_DEBUG "%s/alsa: " fmt, dev->name , ## arg)
@@ -140,7 +140,8 @@
  *
  */
 
-void saa7134_irq_alsa_done(struct saa7134_dev *dev, unsigned long status)
+static void saa7134_irq_alsa_done(struct saa7134_dev *dev,
+				  unsigned long status)
 {
 	int next_blk, reg = 0;
 
@@ -881,7 +882,7 @@
  *
  */
 
-int alsa_card_saa7134_create(struct saa7134_dev *dev, int devnum)
+static int alsa_card_saa7134_create(struct saa7134_dev *dev, int devnum)
 {
 
 	snd_card_t *card;
@@ -994,7 +995,7 @@
  * Module destructor
  */
 
-void saa7134_alsa_exit(void)
+static void saa7134_alsa_exit(void)
 {
 	int idx;
 
--- linux-2.6.15-rc1-mm2-full/drivers/media/video/saa7134/saa7134-oss.c.old	2005-11-20 02:50:22.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/media/video/saa7134/saa7134-oss.c	2005-11-20 02:58:15.000000000 +0100
@@ -899,7 +899,7 @@
 	spin_unlock(&dev->slock);
 }
 
-int saa7134_dsp_create(struct saa7134_dev *dev)
+static int saa7134_dsp_create(struct saa7134_dev *dev)
 {
 	int err;
 
@@ -955,7 +955,7 @@
 
 }
 
-void saa7134_oss_exit(void)
+static void saa7134_oss_exit(void)
 {
         struct saa7134_dev *dev = NULL;
         struct list_head *list;
--- linux-2.6.15-rc1-mm2-full/drivers/media/video/bttv-cards.c.old	2005-11-20 02:52:53.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/media/video/bttv-cards.c	2005-11-20 02:54:11.000000000 +0100
@@ -2904,7 +2904,7 @@
  */
 
 /* Some Modular Technology cards have an eeprom, but no subsystem ID */
-void identify_by_eeprom(struct bttv *btv, unsigned char eeprom_data[256])
+static void identify_by_eeprom(struct bttv *btv, unsigned char eeprom_data[256])
 {
 	int type = -1;
 
@@ -3879,7 +3879,7 @@
  *                error. ERROR_CPLD_Check_Failed.
  */
 /* ----------------------------------------------------------------------- */
-void
+static void
 init_RTV24 (struct bttv *btv)
 {
 	uint32_t dataRead = 0;
@@ -4103,7 +4103,7 @@
 /* ----------------------------------------------------------------------- */
 /* winview                                                                 */
 
-void winview_audio(struct bttv *btv, struct video_audio *v, int set)
+static void winview_audio(struct bttv *btv, struct video_audio *v, int set)
 {
 	/* PT2254A programming Jon Tombs, jon@gte.esi.us.es */
 	int bits_out, loops, vol, data;
--- linux-2.6.15-rc1-mm2-full/drivers/media/video/cx25840/cx25840-core.c.old	2005-11-20 02:55:12.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/media/video/cx25840/cx25840-core.c	2005-11-20 02:55:23.000000000 +0100
@@ -714,7 +714,7 @@
 
 /* ----------------------------------------------------------------------- */
 
-struct i2c_driver i2c_driver_cx25840;
+static struct i2c_driver i2c_driver_cx25840;
 
 static int cx25840_detect_client(struct i2c_adapter *adapter, int address,
 				 int kind)
@@ -807,7 +807,7 @@
 
 /* ----------------------------------------------------------------------- */
 
-struct i2c_driver i2c_driver_cx25840 = {
+static struct i2c_driver i2c_driver_cx25840 = {
 	.name = "cx25840",
 
 	.id = I2C_DRIVERID_CX25840,
--- linux-2.6.15-rc1-mm2-full/drivers/media/video/em28xx/em28xx-core.c.old	2005-11-20 02:56:08.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/media/video/em28xx/em28xx-core.c	2005-11-20 02:56:36.000000000 +0100
@@ -32,7 +32,7 @@
 
 /* #define ENABLE_DEBUG_ISOC_FRAMES */
 
-unsigned int core_debug;
+static unsigned int core_debug;
 module_param(core_debug,int,0644);
 MODULE_PARM_DESC(core_debug,"enable debug messages [core]");
 
@@ -41,7 +41,7 @@
 		printk(KERN_INFO "%s %s :"fmt, \
 			 dev->name, __FUNCTION__ , ##arg); } while (0)
 
-unsigned int reg_debug;
+static unsigned int reg_debug;
 module_param(reg_debug,int,0644);
 MODULE_PARM_DESC(reg_debug,"enable debug messages [URB reg]");
 
@@ -50,7 +50,7 @@
 		printk(KERN_INFO "%s %s :"fmt, \
 			 dev->name, __FUNCTION__ , ##arg); } while (0)
 
-unsigned int isoc_debug;
+static unsigned int isoc_debug;
 module_param(isoc_debug,int,0644);
 MODULE_PARM_DESC(isoc_debug,"enable debug messages [isoc transfers]");
 
--- linux-2.6.15-rc1-mm2-full/drivers/media/video/saa7127.c.old	2005-11-20 03:00:36.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/media/video/saa7127.c	2005-11-20 03:00:59.000000000 +0100
@@ -223,7 +223,7 @@
 };
 
 #define SAA7127_50HZ_DAC_CONTROL 0x02
-struct i2c_reg_value saa7127_init_config_50hz[] = {
+static struct i2c_reg_value saa7127_init_config_50hz[] = {
 	{ SAA7127_REG_BURST_START, 			0x21 },
 	/* BURST_END is also used as a chip ID in saa7127_detect_client */
 	{ SAA7127_REG_BURST_END, 			0x1d },
@@ -696,7 +696,7 @@
 
 /* ----------------------------------------------------------------------- */
 
-struct i2c_driver i2c_driver_saa7127;
+static struct i2c_driver i2c_driver_saa7127;
 
 /* ----------------------------------------------------------------------- */
 
@@ -818,7 +818,7 @@
 
 /* ----------------------------------------------------------------------- */
 
-struct i2c_driver i2c_driver_saa7127 = {
+static struct i2c_driver i2c_driver_saa7127 = {
 	.name = "saa7127",
 	.id = I2C_DRIVERID_SAA7127,
 	.flags = I2C_DF_NOTIFY,

