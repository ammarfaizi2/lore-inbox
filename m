Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030232AbWGFQhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030232AbWGFQhb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 12:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965192AbWGFQhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 12:37:31 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:14354 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965109AbWGFQha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 12:37:30 -0400
Date: Thu, 6 Jul 2006 18:37:28 +0200
From: Adrian Bunk <bunk@stusta.de>
To: kai@germaschewski.name, sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>
Subject: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
Message-ID: <20060706163728.GN26941@stusta.de>
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

--- linux-2.6.17-mm6-full/Makefile.old	2006-07-06 12:17:02.000000000 +0200
+++ linux-2.6.17-mm6-full/Makefile	2006-07-06 12:18:52.000000000 +0200
@@ -318,7 +318,8 @@
 CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
 
 CFLAGS          := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
-                   -fno-strict-aliasing -fno-common
+                   -fno-strict-aliasing -fno-common \
+		   -Werror-implicit-function-declaration
 # Force gcc to behave correct even for buggy distributions
 CFLAGS          += $(call cc-option, -fno-stack-protector-all \
                                      -fno-stack-protector)
--- linux-2.6.17-mm6-full/drivers/input/joystick/iforce/Makefile.old	2006-07-06 12:19:08.000000000 +0200
+++ linux-2.6.17-mm6-full/drivers/input/joystick/iforce/Makefile	2006-07-06 12:19:16.000000000 +0200
@@ -16,5 +16,3 @@
 ifeq ($(CONFIG_JOYSTICK_IFORCE_USB),y)
 	iforce-objs += iforce-usb.o
 endif
-
-EXTRA_CFLAGS = -Werror-implicit-function-declaration

