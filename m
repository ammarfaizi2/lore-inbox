Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbWFQSkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWFQSkS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 14:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbWFQSkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 14:40:18 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:63351 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750841AbWFQSkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 14:40:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=N9Vkr/nMuSdHdKpH0BI1VrbjlPjDiuAb1g7arFdZbvMMOykV/gMM+oQ7A6cTsQS9q6YeKhE1wLPXiYCZviaMslethwN6//i0xY+LxAkkQMW8O3MYzQ9n2/PB/B+YDdc0XLEowT0XgD9ricliHhV4L1E0Xh6DketoMzPdqJ0wUow=
Message-ID: <44944C8D.2000600@gmail.com>
Date: Sat, 17 Jun 2006 12:40:13 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [patch -mm 19/20] chardev: GPIO for SCx200 & PC-8736x:  add proper
 Kconfig, Makefile entries
References: <448DB57F.2050006@gmail.com> <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
In-Reply-To: <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

19/20. patch.kconfig

Replace the temp makefile hacks with proper CONFIG entries, which are
also added to Kconfig.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

---

diffstat gpio-scx/patch.kconfig
 Kconfig  |   23 +++++++++++++++++++++++
 Makefile |    4 +++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff -ruNp -X dontdiff -X exclude-diffs ax-18/drivers/char/Kconfig ax-19/drivers/char/Kconfig
--- ax-18/drivers/char/Kconfig	2006-06-06 17:15:36.000000000 -0600
+++ ax-19/drivers/char/Kconfig	2006-06-17 01:57:21.000000000 -0600
@@ -934,12 +934,35 @@ config MWAVE
 config SCx200_GPIO
 	tristate "NatSemi SCx200 GPIO Support"
 	depends on SCx200
+	select NSC_GPIO
 	help
 	  Give userspace access to the GPIO pins on the National
 	  Semiconductor SCx200 processors.
 
 	  If compiled as a module, it will be called scx200_gpio.
 
+config PC8736x_GPIO
+	tristate "NatSemi PC8736x GPIO Support"
+	depends on X86
+	default SCx200_GPIO	# mostly N
+	select NSC_GPIO		# needed for support routines
+	help
+	  Give userspace access to the GPIO pins on the National
+	  Semiconductor PC-8736x (x=[03456]) SuperIO chip.  The chip
+	  has multiple functional units, inc several managed by
+	  hwmon/pc87360 driver.  Tested with PC-87366
+
+	  If compiled as a module, it will be called pc8736x_gpio.
+
+config NSC_GPIO
+	tristate "NatSemi Base GPIO Support"
+	# selected by SCx200_GPIO and PC8736x_GPIO
+	# what about 2 selectors differing: m != y
+	help
+	  Common support used (and needed) by scx200_gpio and
+	  pc8736x_gpio drivers.  If those drivers are built as
+	  modules, this one will be too, named nsc_gpio
+
 config CS5535_GPIO
 	tristate "AMD CS5535/CS5536 GPIO (Geode Companion Device)"
 	depends on X86_32
diff -ruNp -X dontdiff -X exclude-diffs ax-18/drivers/char/Makefile ax-19/drivers/char/Makefile
--- ax-18/drivers/char/Makefile	2006-06-17 01:39:58.000000000 -0600
+++ ax-19/drivers/char/Makefile	2006-06-17 01:57:21.000000000 -0600
@@ -81,7 +81,9 @@ obj-$(CONFIG_COBALT_LCD)	+= lcd.o
 obj-$(CONFIG_PPDEV)		+= ppdev.o
 obj-$(CONFIG_NWBUTTON)		+= nwbutton.o
 obj-$(CONFIG_NWFLASH)		+= nwflash.o
-obj-$(CONFIG_SCx200_GPIO)	+= scx200_gpio.o nsc_gpio.o pc8736x_gpio.o
+obj-$(CONFIG_SCx200_GPIO)	+= scx200_gpio.o
+obj-$(CONFIG_PC8736x_GPIO)	+= pc8736x_gpio.o
+obj-$(CONFIG_NSC_GPIO)		+= nsc_gpio.o
 obj-$(CONFIG_CS5535_GPIO)	+= cs5535_gpio.o
 obj-$(CONFIG_GPIO_VR41XX)	+= vr41xx_giu.o
 obj-$(CONFIG_TANBAC_TB0219)	+= tb0219.o


