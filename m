Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932779AbWCQU56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932779AbWCQU56 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 15:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932781AbWCQU54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 15:57:56 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:8363 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932780AbWCQU5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 15:57:53 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 12/21] Kconfig: select VIDEO_CX25840 to build cx25840 a/v
	decoder module
Date: Fri, 17 Mar 2006 17:54:36 -0300
Message-id: <20060317205436.PS11748800012@infradead.org>
In-Reply-To: <20060317205359.PS65198900000@infradead.org>
References: <20060317205359.PS65198900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Michael Krufky <mkrufky@linuxtv.org>
Date: 1142307307 \-0300

The cx25840 module requires external firmware in order to function,
so it must select FW_LOADER, but saa7115 and saa7129 do not require it.
This patch creates VIDEO_CX25840, and alters VIDEO_DECODER to select it.

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/Kconfig          |    3 +++
 drivers/media/video/Makefile         |    3 ++-
 drivers/media/video/cx25840/Kconfig  |    9 +++++++++
 drivers/media/video/cx25840/Makefile |    2 +-
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/media/video/Kconfig b/drivers/media/video/Kconfig
index d82c8a3..995f033 100644
--- a/drivers/media/video/Kconfig
+++ b/drivers/media/video/Kconfig
@@ -349,8 +349,11 @@ config VIDEO_AUDIO_DECODER
 config VIDEO_DECODER
 	tristate "Add support for additional video chipsets"
 	depends on VIDEO_DEV && I2C && EXPERIMENTAL
+	select VIDEO_CX25840
 	---help---
 	  Say Y here to compile drivers for SAA7115, SAA7127 and CX25840
 	  video decoders.
 
+source "drivers/media/video/cx25840/Kconfig"
+
 endmenu
diff --git a/drivers/media/video/Makefile b/drivers/media/video/Makefile
index faf7283..d36b145 100644
--- a/drivers/media/video/Makefile
+++ b/drivers/media/video/Makefile
@@ -61,6 +61,7 @@ obj-$(CONFIG_VIDEO_TVEEPROM) += tveeprom
 
 obj-$(CONFIG_VIDEO_M32R_AR_M64278) += arv.o
 
-obj-$(CONFIG_VIDEO_DECODER)     += saa7115.o cx25840/ saa7127.o
+obj-$(CONFIG_VIDEO_DECODER)     += saa7115.o saa7127.o
+obj-$(CONFIG_VIDEO_CX25840) += cx25840/
 
 EXTRA_CFLAGS += -I$(srctree)/drivers/media/dvb/dvb-core
diff --git a/drivers/media/video/cx25840/Kconfig b/drivers/media/video/cx25840/Kconfig
new file mode 100644
index 0000000..854264e
--- /dev/null
+++ b/drivers/media/video/cx25840/Kconfig
@@ -0,0 +1,9 @@
+config VIDEO_CX25840
+	tristate "Conexant CX2584x audio/video decoders"
+	depends on VIDEO_DEV && I2C && EXPERIMENTAL
+	select FW_LOADER
+	---help---
+	  Support for the Conexant CX2584x audio/video decoders.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called cx25840
diff --git a/drivers/media/video/cx25840/Makefile b/drivers/media/video/cx25840/Makefile
index 543ebac..32a896c 100644
--- a/drivers/media/video/cx25840/Makefile
+++ b/drivers/media/video/cx25840/Makefile
@@ -1,6 +1,6 @@
 cx25840-objs    := cx25840-core.o cx25840-audio.o cx25840-firmware.o \
 		   cx25840-vbi.o
 
-obj-$(CONFIG_VIDEO_DECODER) += cx25840.o
+obj-$(CONFIG_VIDEO_CX25840) += cx25840.o
 
 EXTRA_CFLAGS += -I$(src)/..

