Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbVKZUaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbVKZUaT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 15:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbVKZUaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 15:30:19 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:62423 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1750734AbVKZUaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 15:30:17 -0500
Message-ID: <4388C5F6.70705@m1k.net>
Date: Sat, 26 Nov 2005 15:30:46 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Sam Ravnborg <sam@ravnborg.org>, Adrian Bunk <bunk@stusta.de>,
       Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org,
       Johannes Stezenbach <js@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] fix broken hybrid v4l-dvb frontend selection
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org> <200511202049.30952.gene.heskett@verizon.net> <4383CC4E.40206@m1k.net> <200511222336.48506.gene.heskett@verizon.net> <20051123174237.GO3963@stusta.de> <20051123182609.GA8336@mars.ravnborg.org>
In-Reply-To: <20051123182609.GA8336@mars.ravnborg.org>
Content-Type: multipart/mixed;
 boundary="------------030300040109040207020800"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030300040109040207020800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Linus-

This patch corrects the build problems for cx88 and saa7134 hybrid 
v4l/dvb drivers, described in the "Re: Linux 2.6.15-rc2" thread on LKML, 
by Adrian and Gene.  Please apply this to your -git tree.

Adrian Bunk wrote:

>configurations like CONFIG_VIDEO_CX88_DVB=y, CONFIG_DVB_CX22702=m are currently compile 
>errors.
>  
>
Gene Heskett wrote:

>*** Warning: "nxt200x_attach" [drivers/media/video/cx88/cx88-dvb.ko]
>undefined!
>  
>
Thanks to Sam Ravnborg for pointing out a much needed correction in the 
Makefile.



--------------030300040109040207020800
Content-Type: text/x-patch;
 name="hybrid-frontend-selection-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hybrid-frontend-selection-fix.patch"

Repair broken build configuration for hybrid v4l/dvb card
frontend selection.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 drivers/media/video/Kconfig          |    2 +-
 drivers/media/video/cx88/Kconfig     |   20 ++++++++++----------
 drivers/media/video/cx88/Makefile    |   27 +++++++++------------------
 drivers/media/video/saa7134/Kconfig  |   12 ++++++------
 drivers/media/video/saa7134/Makefile |   19 +++++++------------
 5 files changed, 33 insertions(+), 47 deletions(-)

--- linux-2.6.15-rc2-git6.orig/drivers/media/video/cx88/Kconfig
+++ linux-2.6.15-rc2-git6/drivers/media/video/cx88/Kconfig
@@ -46,8 +46,8 @@
 	  If you are unsure, choose Y.
 
 config VIDEO_CX88_DVB_MT352
-	tristate "Zarlink MT352 DVB-T Support"
-	default m
+	bool "Zarlink MT352 DVB-T Support"
+	default y
 	depends on VIDEO_CX88_DVB && !VIDEO_CX88_DVB_ALL_FRONTENDS
 	select DVB_MT352
 	---help---
@@ -55,8 +55,8 @@
 	  Connexant 2388x chip and the MT352 demodulator.
 
 config VIDEO_CX88_DVB_OR51132
-	tristate "OR51132 ATSC Support"
-	default m
+	bool "OR51132 ATSC Support"
+	default y
 	depends on VIDEO_CX88_DVB && !VIDEO_CX88_DVB_ALL_FRONTENDS
 	select DVB_OR51132
 	---help---
@@ -64,8 +64,8 @@
 	  Connexant 2388x chip and the OR51132 demodulator.
 
 config VIDEO_CX88_DVB_CX22702
-	tristate "Conexant CX22702 DVB-T Support"
-	default m
+	bool "Conexant CX22702 DVB-T Support"
+	default y
 	depends on VIDEO_CX88_DVB && !VIDEO_CX88_DVB_ALL_FRONTENDS
 	select DVB_CX22702
 	---help---
@@ -73,8 +73,8 @@
 	  Connexant 2388x chip and the CX22702 demodulator.
 
 config VIDEO_CX88_DVB_LGDT330X
-	tristate "LG Electronics DT3302/DT3303 ATSC Support"
-	default m
+	bool "LG Electronics DT3302/DT3303 ATSC Support"
+	default y
 	depends on VIDEO_CX88_DVB && !VIDEO_CX88_DVB_ALL_FRONTENDS
 	select DVB_LGDT330X
 	---help---
@@ -82,8 +82,8 @@
 	  Connexant 2388x chip and the LGDT3302/LGDT3303 demodulator.
 
 config VIDEO_CX88_DVB_NXT200X
-	tristate "NXT2002/NXT2004 ATSC Support"
-	default m
+	bool "NXT2002/NXT2004 ATSC Support"
+	default y
 	depends on VIDEO_CX88_DVB && !VIDEO_CX88_DVB_ALL_FRONTENDS
 	select DVB_NXT200X
 	---help---
--- linux-2.6.15-rc2-git6.orig/drivers/media/video/Kconfig
+++ linux-2.6.15-rc2-git6/drivers/media/video/Kconfig
@@ -26,7 +26,7 @@
 	  module will be called bttv.
 
 config VIDEO_BT848_DVB
-	tristate "DVB/ATSC Support for bt878 based TV cards"
+	bool "DVB/ATSC Support for bt878 based TV cards"
 	depends on VIDEO_BT848 && DVB_CORE
 	select DVB_BT8XX
 	---help---
--- linux-2.6.15-rc2-git6.orig/drivers/media/video/saa7134/Kconfig
+++ linux-2.6.15-rc2-git6/drivers/media/video/saa7134/Kconfig
@@ -42,8 +42,8 @@
 	  If you are unsure, choose Y.
 
 config VIDEO_SAA7134_DVB_MT352
-	tristate "Zarlink MT352 DVB-T Support"
-	default m
+	bool "Zarlink MT352 DVB-T Support"
+	default y
 	depends on VIDEO_SAA7134_DVB && !VIDEO_SAA7134_DVB_ALL_FRONTENDS
 	select DVB_MT352
 	---help---
@@ -51,8 +51,8 @@
 	  Philips saa7134 chip and the MT352 demodulator.
 
 config VIDEO_SAA7134_DVB_TDA1004X
-	tristate "Phillips TDA10045H/TDA10046H DVB-T Support"
-	default m
+	bool "Phillips TDA10045H/TDA10046H DVB-T Support"
+	default y
 	depends on VIDEO_SAA7134_DVB && !VIDEO_SAA7134_DVB_ALL_FRONTENDS
 	select DVB_TDA1004X
 	---help---
@@ -60,8 +60,8 @@
 	  Philips saa7134 chip and the TDA10045H/TDA10046H demodulator.
 
 config VIDEO_SAA7134_DVB_NXT200X
-	tristate "NXT2002/NXT2004 ATSC Support"
-	default m
+	bool "NXT2002/NXT2004 ATSC Support"
+	default y
 	depends on VIDEO_SAA7134_DVB && !VIDEO_SAA7134_DVB_ALL_FRONTENDS
 	select DVB_NXT200X
 	---help---
--- linux-2.6.15-rc2-git6.orig/drivers/media/video/cx88/Makefile
+++ linux-2.6.15-rc2-git6/drivers/media/video/cx88/Makefile
@@ -9,21 +9,12 @@
 EXTRA_CFLAGS += -I$(src)/..
 EXTRA_CFLAGS += -I$(srctree)/drivers/media/dvb/dvb-core
 EXTRA_CFLAGS += -I$(srctree)/drivers/media/dvb/frontends
-ifneq ($(CONFIG_VIDEO_BUF_DVB),n)
- EXTRA_CFLAGS += -DHAVE_VIDEO_BUF_DVB=1
-endif
-ifneq ($(CONFIG_DVB_CX22702),n)
- EXTRA_CFLAGS += -DHAVE_CX22702=1
-endif
-ifneq ($(CONFIG_DVB_OR51132),n)
- EXTRA_CFLAGS += -DHAVE_OR51132=1
-endif
-ifneq ($(CONFIG_DVB_LGDT330X),n)
- EXTRA_CFLAGS += -DHAVE_LGDT330X=1
-endif
-ifneq ($(CONFIG_DVB_MT352),n)
- EXTRA_CFLAGS += -DHAVE_MT352=1
-endif
-ifneq ($(CONFIG_DVB_NXT200X),n)
- EXTRA_CFLAGS += -DHAVE_NXT200X=1
-endif
+
+extra-cflags-$(CONFIG_VIDEO_BUF_DVB) += -DHAVE_VIDEO_BUF_DVB=1
+extra-cflags-$(CONFIG_DVB_CX22702)   += -DHAVE_CX22702=1
+extra-cflags-$(CONFIG_DVB_OR51132)   += -DHAVE_OR51132=1
+extra-cflags-$(CONFIG_DVB_LGDT330X)  += -DHAVE_LGDT330X=1
+extra-cflags-$(CONFIG_DVB_MT352)     += -DHAVE_MT352=1
+extra-cflags-$(CONFIG_DVB_NXT200X)   += -DHAVE_NXT200X=1
+
+EXTRA_CFLAGS += $(extra-cflags-y) $(extra-cflags-m)
--- linux-2.6.15-rc2-git6.orig/drivers/media/video/saa7134/Makefile
+++ linux-2.6.15-rc2-git6/drivers/media/video/saa7134/Makefile
@@ -11,15 +11,10 @@
 EXTRA_CFLAGS += -I$(src)/..
 EXTRA_CFLAGS += -I$(srctree)/drivers/media/dvb/dvb-core
 EXTRA_CFLAGS += -I$(srctree)/drivers/media/dvb/frontends
-ifneq ($(CONFIG_VIDEO_BUF_DVB),n)
- EXTRA_CFLAGS += -DHAVE_VIDEO_BUF_DVB=1
-endif
-ifneq ($(CONFIG_DVB_MT352),n)
- EXTRA_CFLAGS += -DHAVE_MT352=1
-endif
-ifneq ($(CONFIG_DVB_TDA1004X),n)
- EXTRA_CFLAGS += -DHAVE_TDA1004X=1
-endif
-ifneq ($(CONFIG_DVB_NXT200X),n)
- EXTRA_CFLAGS += -DHAVE_NXT200X=1
-endif
+
+extra-cflags-$(CONFIG_VIDEO_BUF_DVB) += -DHAVE_VIDEO_BUF_DVB=1
+extra-cflags-$(CONFIG_DVB_MT352)     += -DHAVE_MT352=1
+extra-cflags-$(CONFIG_DVB_TDA1004X)  += -DHAVE_TDA1004X=1
+extra-cflags-$(CONFIG_DVB_NXT200X)   += -DHAVE_NXT200X=1
+
+EXTRA_CFLAGS += $(extra-cflags-y) $(extra-cflags-m)

--------------030300040109040207020800--
