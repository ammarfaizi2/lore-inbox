Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbWF1Qyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbWF1Qyv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 12:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbWF1Qyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 12:54:47 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:35076 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751432AbWF1Qyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 12:54:41 -0400
Date: Wed, 28 Jun 2006 18:54:40 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>
Subject: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
Message-ID: <20060628165440.GO13915@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, using an undeclared function gives a compile warning, but it 
can lead to a nasty to debug runtime stack corruptions if the prototype 
of the function is different from what gcc guessed.

With -Werror-implicit-function-declaration we are getting an immediate
compile error instead.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Makefile                               |    3 ++-
 drivers/input/joystick/iforce/Makefile |    2 --
 2 files changed, 2 insertions(+), 3 deletions(-)

--- linux-2.6.17-mm3-full/Makefile.old	2006-06-27 11:06:51.000000000 +0200
+++ linux-2.6.17-mm3-full/Makefile	2006-06-27 11:07:12.000000000 +0200
@@ -317,7 +317,8 @@
 CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
 
 CFLAGS          := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
-                   -fno-strict-aliasing -fno-common
+                   -fno-strict-aliasing -fno-common \
+		   -Werror-implicit-function-declaration
 AFLAGS          := -D__ASSEMBLY__
 
 # Read KERNELRELEASE from include/config/kernel.release (if it exists)
--- linux-2.6.17-mm3-full/drivers/input/joystick/iforce/Makefile.old	2006-06-27 11:07:20.000000000 +0200
+++ linux-2.6.17-mm3-full/drivers/input/joystick/iforce/Makefile	2006-06-27 11:07:32.000000000 +0200
@@ -16,5 +16,3 @@
 ifeq ($(CONFIG_JOYSTICK_IFORCE_USB),y)
 	iforce-objs += iforce-usb.o
 endif
-
-EXTRA_CFLAGS = -Werror-implicit-function-declaration

