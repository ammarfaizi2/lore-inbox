Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbWIJRKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWIJRKu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 13:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWIJRKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 13:10:21 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:49638 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932316AbWIJRJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 13:09:34 -0400
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Andrew de Quincey <adq_dvb@lidskialf.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 5/6] V4L/DVB (4608b): i2c deps fix on DVB
Date: Sun, 10 Sep 2006 14:06:45 -0300
Message-id: <20060910170645.PS7942060005@infradead.org>
In-Reply-To: <20060910170419.PS3030230000@infradead.org>
References: <20060910170419.PS3030230000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.92-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Andrew de Quincey <adq_dvb@lidskialf.net>

Several DVB modules depends on I2C

Signed-off-by: Andrew de Quincey <adq_dvb@lidskialf.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/b2c2/Kconfig         |    1 +
 drivers/media/dvb/bt8xx/Kconfig        |    1 +
 drivers/media/dvb/dvb-usb/Kconfig      |    1 +
 drivers/media/dvb/frontends/Kconfig    |   60 +++++++++++++++++---------------
 drivers/media/dvb/frontends/Makefile   |    2 +
 drivers/media/dvb/pluto2/Kconfig       |    1 +
 drivers/media/dvb/ttpci/Kconfig        |    5 +++
 drivers/media/dvb/ttusb-budget/Kconfig |    3 +-
 drivers/media/video/cx88/Kconfig       |    1 +
 drivers/media/video/saa7134/Kconfig    |    1 +
 10 files changed, 46 insertions(+), 30 deletions(-)

diff --git a/drivers/media/dvb/b2c2/Kconfig b/drivers/media/dvb/b2c2/Kconfig
index d7f1fd5..49a06fc 100644
--- a/drivers/media/dvb/b2c2/Kconfig
+++ b/drivers/media/dvb/b2c2/Kconfig
@@ -1,6 +1,7 @@
 config DVB_B2C2_FLEXCOP
 	tristate "Technisat/B2C2 FlexCopII(b) and FlexCopIII adapters"
 	depends on DVB_CORE && I2C
+	select DVB_PLL
 	select DVB_STV0299
 	select DVB_MT352
 	select DVB_MT312
diff --git a/drivers/media/dvb/bt8xx/Kconfig b/drivers/media/dvb/bt8xx/Kconfig
index f394002..7d0ee1a 100644
--- a/drivers/media/dvb/bt8xx/Kconfig
+++ b/drivers/media/dvb/bt8xx/Kconfig
@@ -1,6 +1,7 @@
 config DVB_BT8XX
 	tristate "BT8xx based PCI cards"
 	depends on DVB_CORE && PCI && I2C && VIDEO_BT848
+	select DVB_PLL
 	select DVB_MT352
 	select DVB_SP887X
 	select DVB_NXT6000
diff --git a/drivers/media/dvb/dvb-usb/Kconfig b/drivers/media/dvb/dvb-usb/Kconfig
index 3bc6722..75824b7 100644
--- a/drivers/media/dvb/dvb-usb/Kconfig
+++ b/drivers/media/dvb/dvb-usb/Kconfig
@@ -2,6 +2,7 @@ config DVB_USB
 	tristate "Support for various USB DVB devices"
 	depends on DVB_CORE && USB && I2C
 	select FW_LOADER
+	select DVB_PLL
 	help
 	  By enabling this you will be able to choose the various supported
 	  USB1.1 and USB2.0 DVB devices.
diff --git a/drivers/media/dvb/frontends/Kconfig b/drivers/media/dvb/frontends/Kconfig
index 0ef361f..db97855 100644
--- a/drivers/media/dvb/frontends/Kconfig
+++ b/drivers/media/dvb/frontends/Kconfig
@@ -6,43 +6,43 @@ comment "DVB-S (satellite) frontends"
 
 config DVB_STV0299
 	tristate "ST STV0299 based"
-	depends on DVB_CORE
+	depends on DVB_CORE && I2C
 	help
 	  A DVB-S tuner module. Say Y when you want to support this frontend.
 
 config DVB_CX24110
 	tristate "Conexant CX24110 based"
-	depends on DVB_CORE
+	depends on DVB_CORE && I2C
 	help
 	  A DVB-S tuner module. Say Y when you want to support this frontend.
 
 config DVB_CX24123
 	tristate "Conexant CX24123 based"
-	depends on DVB_CORE
+	depends on DVB_CORE && I2C
 	help
 	  A DVB-S tuner module. Say Y when you want to support this frontend.
 
 config DVB_TDA8083
 	tristate "Philips TDA8083 based"
-	depends on DVB_CORE
+	depends on DVB_CORE && I2C
 	help
 	  A DVB-S tuner module. Say Y when you want to support this frontend.
 
 config DVB_MT312
 	tristate "Zarlink VP310/MT312 based"
-	depends on DVB_CORE
+	depends on DVB_CORE && I2C
 	help
 	  A DVB-S tuner module. Say Y when you want to support this frontend.
 
 config DVB_VES1X93
 	tristate "VLSI VES1893 or VES1993 based"
-	depends on DVB_CORE
+	depends on DVB_CORE && I2C
 	help
 	  A DVB-S tuner module. Say Y when you want to support this frontend.
 
 config DVB_S5H1420
 	tristate "Samsung S5H1420 based"
-	depends on DVB_CORE
+	depends on DVB_CORE && I2C
 	help
 	  A DVB-S tuner module. Say Y when you want to support this frontend.
 
@@ -51,7 +51,7 @@ comment "DVB-T (terrestrial) frontends"
 
 config DVB_SP8870
 	tristate "Spase sp8870 based"
-	depends on DVB_CORE
+	depends on DVB_CORE && I2C
 	select FW_LOADER
 	help
 	  A DVB-T tuner module. Say Y when you want to support this frontend.
@@ -63,7 +63,7 @@ config DVB_SP8870
 
 config DVB_SP887X
 	tristate "Spase sp887x based"
-	depends on DVB_CORE
+	depends on DVB_CORE && I2C
 	select FW_LOADER
 	help
 	  A DVB-T tuner module. Say Y when you want to support this frontend.
@@ -75,25 +75,25 @@ config DVB_SP887X
 
 config DVB_CX22700
 	tristate "Conexant CX22700 based"
-	depends on DVB_CORE
+	depends on DVB_CORE && I2C
 	help
 	  A DVB-T tuner module. Say Y when you want to support this frontend.
 
 config DVB_CX22702
 	tristate "Conexant cx22702 demodulator (OFDM)"
-	depends on DVB_CORE
+	depends on DVB_CORE && I2C
 	help
 	  A DVB-T tuner module. Say Y when you want to support this frontend.
 
 config DVB_L64781
 	tristate "LSI L64781"
-	depends on DVB_CORE
+	depends on DVB_CORE && I2C
 	help
 	  A DVB-T tuner module. Say Y when you want to support this frontend.
 
 config DVB_TDA1004X
 	tristate "Philips TDA10045H/TDA10046H based"
-	depends on DVB_CORE
+	depends on DVB_CORE && I2C
 	select FW_LOADER
 	help
 	  A DVB-T tuner module. Say Y when you want to support this frontend.
@@ -106,32 +106,32 @@ config DVB_TDA1004X
 
 config DVB_NXT6000
 	tristate "NxtWave Communications NXT6000 based"
-	depends on DVB_CORE
+	depends on DVB_CORE && I2C
 	help
 	  A DVB-T tuner module. Say Y when you want to support this frontend.
 
 config DVB_MT352
 	tristate "Zarlink MT352 based"
-	depends on DVB_CORE
+	depends on DVB_CORE && I2C
 	help
 	  A DVB-T tuner module. Say Y when you want to support this frontend.
 
 config DVB_ZL10353
 	tristate "Zarlink ZL10353 based"
-	depends on DVB_CORE
+	depends on DVB_CORE && I2C
 	help
 	  A DVB-T tuner module. Say Y when you want to support this frontend.
 
 config DVB_DIB3000MB
 	tristate "DiBcom 3000M-B"
-	depends on DVB_CORE
+	depends on DVB_CORE && I2C
 	help
 	  A DVB-T tuner module. Designed for mobile usage. Say Y when you want
 	  to support this frontend.
 
 config DVB_DIB3000MC
 	tristate "DiBcom 3000P/M-C"
-	depends on DVB_CORE
+	depends on DVB_CORE && I2C
 	help
 	  A DVB-T tuner module. Designed for mobile usage. Say Y when you want
 	  to support this frontend.
@@ -141,19 +141,19 @@ comment "DVB-C (cable) frontends"
 
 config DVB_VES1820
 	tristate "VLSI VES1820 based"
-	depends on DVB_CORE
+	depends on DVB_CORE && I2C
 	help
 	  A DVB-C tuner module. Say Y when you want to support this frontend.
 
 config DVB_TDA10021
 	tristate "Philips TDA10021 based"
-	depends on DVB_CORE
+	depends on DVB_CORE && I2C
 	help
 	  A DVB-C tuner module. Say Y when you want to support this frontend.
 
 config DVB_STV0297
 	tristate "ST STV0297 based"
-	depends on DVB_CORE
+	depends on DVB_CORE && I2C
 	help
 	  A DVB-C tuner module. Say Y when you want to support this frontend.
 
@@ -162,7 +162,7 @@ comment "ATSC (North American/Korean Ter
 
 config DVB_NXT200X
 	tristate "NxtWave Communications NXT2002/NXT2004 based"
-	depends on DVB_CORE
+	depends on DVB_CORE && I2C
 	select FW_LOADER
 	help
 	  An ATSC 8VSB and QAM64/256 tuner module. Say Y when you want
@@ -176,7 +176,7 @@ config DVB_NXT200X
 
 config DVB_OR51211
 	tristate "Oren OR51211 based"
-	depends on DVB_CORE
+	depends on DVB_CORE && I2C
 	select FW_LOADER
 	help
 	  An ATSC 8VSB tuner module. Say Y when you want to support this frontend.
@@ -188,7 +188,7 @@ config DVB_OR51211
 
 config DVB_OR51132
 	tristate "Oren OR51132 based"
-	depends on DVB_CORE
+	depends on DVB_CORE && I2C
 	select FW_LOADER
 	help
 	  An ATSC 8VSB and QAM64/256 tuner module. Say Y when you want
@@ -203,7 +203,7 @@ config DVB_OR51132
 
 config DVB_BCM3510
 	tristate "Broadcom BCM3510"
-	depends on DVB_CORE
+	depends on DVB_CORE && I2C
 	select FW_LOADER
 	help
 	  An ATSC 8VSB/16VSB and QAM64/256 tuner module. Say Y when you want to
@@ -211,7 +211,7 @@ config DVB_BCM3510
 
 config DVB_LGDT330X
 	tristate "LG Electronics LGDT3302/LGDT3303 based"
-	depends on DVB_CORE
+	depends on DVB_CORE && I2C
 	help
 	  An ATSC 8VSB and QAM64/256 tuner module. Say Y when you want
 	  to support this frontend.
@@ -220,15 +220,19 @@ config DVB_LGDT330X
 comment "Miscellaneous devices"
 	depends on DVB_CORE
 
+config DVB_PLL
+	tristate
+	depends on DVB_CORE && I2C
+
 config DVB_LNBP21
 	tristate "LNBP21 SEC controller"
-	depends on DVB_CORE
+	depends on DVB_CORE && I2C
 	help
 	  An SEC control chip.
 
 config DVB_ISL6421
 	tristate "ISL6421 SEC controller"
-	depends on DVB_CORE
+	depends on DVB_CORE && I2C
 	help
 	  An SEC control chip.
 
diff --git a/drivers/media/dvb/frontends/Makefile b/drivers/media/dvb/frontends/Makefile
index 5222245..0e4880b 100644
--- a/drivers/media/dvb/frontends/Makefile
+++ b/drivers/media/dvb/frontends/Makefile
@@ -4,7 +4,7 @@ #
 
 EXTRA_CFLAGS = -Idrivers/media/dvb/dvb-core/
 
-obj-$(CONFIG_DVB_CORE) += dvb-pll.o
+obj-$(CONFIG_DVB_PLL) += dvb-pll.o
 obj-$(CONFIG_DVB_STV0299) += stv0299.o
 obj-$(CONFIG_DVB_SP8870) += sp8870.o
 obj-$(CONFIG_DVB_CX22700) += cx22700.o
diff --git a/drivers/media/dvb/pluto2/Kconfig b/drivers/media/dvb/pluto2/Kconfig
index 7d8e6e8..9b84b1b 100644
--- a/drivers/media/dvb/pluto2/Kconfig
+++ b/drivers/media/dvb/pluto2/Kconfig
@@ -2,6 +2,7 @@ config DVB_PLUTO2
 	tristate "Pluto2 cards"
 	depends on DVB_CORE && PCI && I2C
 	select I2C_ALGOBIT
+	select DVB_PLL
 	select DVB_TDA1004X
 	help
 	  Support for PCI cards based on the Pluto2 FPGA like the Satelco
diff --git a/drivers/media/dvb/ttpci/Kconfig b/drivers/media/dvb/ttpci/Kconfig
index 987881f..5fb0975 100644
--- a/drivers/media/dvb/ttpci/Kconfig
+++ b/drivers/media/dvb/ttpci/Kconfig
@@ -3,6 +3,7 @@ config DVB_AV7110
 	depends on DVB_CORE && PCI && I2C && VIDEO_V4L1
 	select FW_LOADER
 	select VIDEO_SAA7146_VV
+	select DVB_PLL
 	select DVB_VES1820
 	select DVB_VES1X93
 	select DVB_STV0299
@@ -61,6 +62,7 @@ config DVB_BUDGET
 	tristate "Budget cards"
 	depends on DVB_CORE && PCI && I2C && VIDEO_V4L1
 	select VIDEO_SAA7146
+	select DVB_PLL
 	select DVB_STV0299
 	select DVB_VES1X93
 	select DVB_VES1820
@@ -83,6 +85,7 @@ config DVB_BUDGET_CI
 	tristate "Budget cards with onboard CI connector"
 	depends on DVB_CORE && PCI && I2C && VIDEO_V4L1
 	select VIDEO_SAA7146
+	select DVB_PLL
 	select DVB_STV0297
 	select DVB_STV0299
 	select DVB_TDA1004X
@@ -104,6 +107,7 @@ config DVB_BUDGET_AV
 	tristate "Budget cards with analog video inputs"
 	depends on DVB_CORE && PCI && I2C && VIDEO_V4L1
 	select VIDEO_SAA7146_VV
+	select DVB_PLL
 	select DVB_STV0299
 	select DVB_TDA1004X
 	select DVB_TDA10021
@@ -122,6 +126,7 @@ config DVB_BUDGET_PATCH
 	tristate "AV7110 cards with Budget Patch"
 	depends on DVB_CORE && DVB_BUDGET && VIDEO_V4L1
 	select DVB_AV7110
+	select DVB_PLL
 	select DVB_STV0299
 	select DVB_VES1X93
 	select DVB_TDA8083
diff --git a/drivers/media/dvb/ttusb-budget/Kconfig b/drivers/media/dvb/ttusb-budget/Kconfig
index 92c7cdc..46a6a60 100644
--- a/drivers/media/dvb/ttusb-budget/Kconfig
+++ b/drivers/media/dvb/ttusb-budget/Kconfig
@@ -1,6 +1,7 @@
 config DVB_TTUSB_BUDGET
 	tristate "Technotrend/Hauppauge Nova-USB devices"
-	depends on DVB_CORE && USB
+	depends on DVB_CORE && USB && I2C
+	select DVB_PLL
 	select DVB_CX22700
 	select DVB_TDA1004X
 	select DVB_VES1820
diff --git a/drivers/media/video/cx88/Kconfig b/drivers/media/video/cx88/Kconfig
index 80e23ee..7a94e6a 100644
--- a/drivers/media/video/cx88/Kconfig
+++ b/drivers/media/video/cx88/Kconfig
@@ -51,6 +51,7 @@ config VIDEO_CX88_DVB
 	tristate "DVB/ATSC Support for cx2388x based TV cards"
 	depends on VIDEO_CX88 && DVB_CORE
 	select VIDEO_BUF_DVB
+	select DVB_PLL
 	---help---
 	  This adds support for DVB/ATSC cards based on the
 	  Conexant 2388x chip.
diff --git a/drivers/media/video/saa7134/Kconfig b/drivers/media/video/saa7134/Kconfig
index e1c1805..f554316 100644
--- a/drivers/media/video/saa7134/Kconfig
+++ b/drivers/media/video/saa7134/Kconfig
@@ -40,6 +40,7 @@ config VIDEO_SAA7134_DVB
 	depends on VIDEO_SAA7134 && DVB_CORE
 	select VIDEO_BUF_DVB
 	select FW_LOADER
+	select DVB_PLL
 	---help---
 	  This adds support for DVB cards based on the
 	  Philips saa7134 chip.

