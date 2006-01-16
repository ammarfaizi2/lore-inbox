Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWAPJXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWAPJXN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 04:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbWAPJW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 04:22:57 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:31979 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932269AbWAPJWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 04:22:43 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 03/25] removed uneeded init on structs like static int foo=0
Date: Mon, 16 Jan 2006 07:11:19 -0200
Message-id: <20060116091119.PS55921200003@infradead.org>
In-Reply-To: <20060116091105.PS83611600000@infradead.org>
References: <20060116091105.PS83611600000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Mauro Carvalho Chehab <mchehab@infradead.org>

- Static vars are equal to zero by default. Removed unnecessary =0 from them,
  saving some data space

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/bt8xx/bt878.c            |    2 +-
 drivers/media/dvb/ttpci/av7110.c           |    4 ++--
 drivers/media/video/bt832.c                |    2 +-
 drivers/media/video/btcx-risc.c            |    2 +-
 drivers/media/video/bttv-cards.c           |    6 +++---
 drivers/media/video/bttv-driver.c          |   27 +++++++++++++--------------
 drivers/media/video/bttv-i2c.c             |    6 +++---
 drivers/media/video/cx25840/cx25840-core.c |    2 +-
 drivers/media/video/cx88/cx88-alsa.c       |    4 ++--
 drivers/media/video/msp3400-driver.c       |   10 +++++-----
 drivers/media/video/saa7134/saa7134-core.c |    2 +-
 11 files changed, 33 insertions(+), 34 deletions(-)

diff --git a/drivers/media/dvb/bt8xx/bt878.c b/drivers/media/dvb/bt8xx/bt878.c
index f295714..a04bb61 100644
--- a/drivers/media/dvb/bt8xx/bt878.c
+++ b/drivers/media/dvb/bt8xx/bt878.c
@@ -542,7 +542,7 @@ static struct pci_driver bt878_pci_drive
       .remove	= bt878_remove,
 };
 
-static int bt878_pci_driver_registered = 0;
+static int bt878_pci_driver_registered;
 
 /*******************************/
 /* Module management functions */
diff --git a/drivers/media/dvb/ttpci/av7110.c b/drivers/media/dvb/ttpci/av7110.c
index 327a808..2749490 100644
--- a/drivers/media/dvb/ttpci/av7110.c
+++ b/drivers/media/dvb/ttpci/av7110.c
@@ -81,7 +81,7 @@ static int adac = DVB_ADAC_TI;
 static int hw_sections;
 static int rgb_on;
 static int volume = 255;
-static int budgetpatch = 0;
+static int budgetpatch;
 
 module_param_named(debug, av7110_debug, int, 0644);
 MODULE_PARM_DESC(debug, "debug level (bitmask, default 0)");
@@ -103,7 +103,7 @@ MODULE_PARM_DESC(budgetpatch, "use budge
 
 static void restart_feeds(struct av7110 *av7110);
 
-static int av7110_num = 0;
+static int av7110_num;
 
 #define FE_FUNC_OVERRIDE(fe_func, av7110_copy, av7110_func) \
 {\
diff --git a/drivers/media/video/bt832.c b/drivers/media/video/bt832.c
index 07c78f1..cc54b62 100644
--- a/drivers/media/video/bt832.c
+++ b/drivers/media/video/bt832.c
@@ -43,7 +43,7 @@ static unsigned short normal_i2c[] = { I
 				       I2C_CLIENT_END };
 I2C_CLIENT_INSMOD;
 
-int debug    = 0;    /* debug output */
+int debug;    /* debug output */
 module_param(debug,            int, 0644);
 
 /* ---------------------------------------------------------------------- */
diff --git a/drivers/media/video/btcx-risc.c b/drivers/media/video/btcx-risc.c
index a48de3c..b4aca72 100644
--- a/drivers/media/video/btcx-risc.c
+++ b/drivers/media/video/btcx-risc.c
@@ -37,7 +37,7 @@ MODULE_DESCRIPTION("some code shared by 
 MODULE_AUTHOR("Gerd Knorr");
 MODULE_LICENSE("GPL");
 
-static unsigned int debug = 0;
+static unsigned int debug;
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug,"debug messages, default is 0 (no)");
 
diff --git a/drivers/media/video/bttv-cards.c b/drivers/media/video/bttv-cards.c
index 65323e7..9749d6e 100644
--- a/drivers/media/video/bttv-cards.c
+++ b/drivers/media/video/bttv-cards.c
@@ -92,8 +92,8 @@ static void identify_by_eeprom(struct bt
 static int __devinit pvr_boot(struct bttv *btv);
 
 /* config variables */
-static unsigned int triton1=0;
-static unsigned int vsfx=0;
+static unsigned int triton1;
+static unsigned int vsfx;
 static unsigned int latency = UNSET;
 int no_overlay=-1;
 
@@ -106,7 +106,7 @@ static struct bttv  *master[BTTV_MAX] = 
 #ifdef MODULE
 static unsigned int autoload = 1;
 #else
-static unsigned int autoload = 0;
+static unsigned int autoload;
 #endif
 static unsigned int gpiomask = UNSET;
 static unsigned int audioall = UNSET;
diff --git a/drivers/media/video/bttv-driver.c b/drivers/media/video/bttv-driver.c
index 0e69703..1c6cfe9 100644
--- a/drivers/media/video/bttv-driver.c
+++ b/drivers/media/video/bttv-driver.c
@@ -48,47 +48,46 @@
 unsigned int bttv_num;			/* number of Bt848s in use */
 struct bttv bttvs[BTTV_MAX];
 
-unsigned int bttv_debug = 0;
+unsigned int bttv_debug;
 unsigned int bttv_verbose = 1;
-unsigned int bttv_gpio = 0;
+unsigned int bttv_gpio;
 
 /* config variables */
 #ifdef __BIG_ENDIAN
 static unsigned int bigendian=1;
 #else
-static unsigned int bigendian=0;
+static unsigned int bigendian;
 #endif
 static unsigned int radio[BTTV_MAX];
-static unsigned int irq_debug = 0;
+static unsigned int irq_debug;
 static unsigned int gbuffers = 8;
 static unsigned int gbufsize = 0x208000;
 
 static int video_nr = -1;
 static int radio_nr = -1;
 static int vbi_nr = -1;
-static int debug_latency = 0;
+static int debug_latency;
 
-static unsigned int fdsr = 0;
+static unsigned int fdsr;
 
 /* options */
-static unsigned int combfilter  = 0;
-static unsigned int lumafilter  = 0;
+static unsigned int combfilter;
+static unsigned int lumafilter;
 static unsigned int automute    = 1;
-static unsigned int chroma_agc  = 0;
+static unsigned int chroma_agc;
 static unsigned int adc_crush   = 1;
 static unsigned int whitecrush_upper = 0xCF;
 static unsigned int whitecrush_lower = 0x7F;
-static unsigned int vcr_hack    = 0;
-static unsigned int irq_iswitch = 0;
+static unsigned int vcr_hack;
+static unsigned int irq_iswitch;
 static unsigned int uv_ratio    = 50;
-static unsigned int full_luma_range = 0;
-static unsigned int coring      = 0;
+static unsigned int full_luma_range;
+static unsigned int coring;
 extern int no_overlay;
 
 /* API features (turn on/off stuff for testing) */
 static unsigned int v4l2        = 1;
 
-
 /* insmod args */
 module_param(bttv_verbose,      int, 0644);
 module_param(bttv_gpio,         int, 0644);
diff --git a/drivers/media/video/bttv-i2c.c b/drivers/media/video/bttv-i2c.c
index 748d630..614c120 100644
--- a/drivers/media/video/bttv-i2c.c
+++ b/drivers/media/video/bttv-i2c.c
@@ -41,9 +41,9 @@ static struct i2c_client bttv_i2c_client
 
 static int attach_inform(struct i2c_client *client);
 
-static int i2c_debug = 0;
-static int i2c_hw = 0;
-static int i2c_scan = 0;
+static int i2c_debug;
+static int i2c_hw;
+static int i2c_scan;
 module_param(i2c_debug, int, 0644);
 module_param(i2c_hw,    int, 0444);
 module_param(i2c_scan,  int, 0444);
diff --git a/drivers/media/video/cx25840/cx25840-core.c b/drivers/media/video/cx25840/cx25840-core.c
index 1d75a42..0da744c 100644
--- a/drivers/media/video/cx25840/cx25840-core.c
+++ b/drivers/media/video/cx25840/cx25840-core.c
@@ -43,7 +43,7 @@ MODULE_LICENSE("GPL");
 static unsigned short normal_i2c[] = { 0x88 >> 1, I2C_CLIENT_END };
 
 
-int cx25840_debug = 0;
+int cx25840_debug;
 
 module_param_named(debug,cx25840_debug, int, 0644);
 
diff --git a/drivers/media/video/cx88/cx88-alsa.c b/drivers/media/video/cx88/cx88-alsa.c
index 7695b52..fd8bc71 100644
--- a/drivers/media/video/cx88/cx88-alsa.c
+++ b/drivers/media/video/cx88/cx88-alsa.c
@@ -116,7 +116,7 @@ MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Conexant,23881},"
 			"{{Conexant,23882},"
 			"{{Conexant,23883}");
-static unsigned int debug = 0;
+static unsigned int debug;
 module_param(debug,int,0644);
 MODULE_PARM_DESC(debug,"enable debug messages");
 
@@ -653,7 +653,7 @@ static void snd_cx88_dev_free(snd_card_t
  * Alsa Constructor - Component probe
  */
 
-static int devno=0;
+static int devno;
 static int __devinit snd_cx88_create(snd_card_t *card, struct pci_dev *pci,
 				    snd_cx88_card_t **rchip)
 {
diff --git a/drivers/media/video/msp3400-driver.c b/drivers/media/video/msp3400-driver.c
index 9b05a0a..09ff25b 100644
--- a/drivers/media/video/msp3400-driver.c
+++ b/drivers/media/video/msp3400-driver.c
@@ -66,12 +66,12 @@ MODULE_LICENSE("GPL");
 
 /* module parameters */
 static int opmode   = OPMODE_AUTO;
-int msp_debug    = 0;    /* msp_debug output */
-int msp_once     = 0;    /* no continous stereo monitoring */
-int msp_amsound  = 0;    /* hard-wire AM sound at 6.5 Hz (france),
-			       the autoscan seems work well only with FM... */
+int msp_debug;		 /* msp_debug output */
+int msp_once;		 /* no continous stereo monitoring */
+int msp_amsound;	 /* hard-wire AM sound at 6.5 Hz (france),
+			    the autoscan seems work well only with FM... */
 int msp_standard = 1;    /* Override auto detect of audio msp_standard, if needed. */
-int msp_dolby    = 0;
+int msp_dolby;
 
 int msp_stereo_thresh = 0x190; /* a2 threshold for stereo/bilingual
 					(msp34xxg only) 0x00a0-0x03c0 */
diff --git a/drivers/media/video/saa7134/saa7134-core.c b/drivers/media/video/saa7134/saa7134-core.c
index 3983a65..3dd42ef 100644
--- a/drivers/media/video/saa7134/saa7134-core.c
+++ b/drivers/media/video/saa7134/saa7134-core.c
@@ -140,7 +140,7 @@ static int pending_call(struct notifier_
 	return NOTIFY_DONE;
 }
 
-static int pending_registered=0;
+static int pending_registered;
 static struct notifier_block pending_notifier = {
 	.notifier_call = pending_call,
 };

