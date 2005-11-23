Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030428AbVKWWel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030428AbVKWWel (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030432AbVKWWek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:34:40 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:58642 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030428AbVKWWek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:34:40 -0500
Date: Wed, 23 Nov 2005 23:34:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
Message-ID: <20051123223438.GY3963@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, using an undeclared function gives a compile warning, but it 
can lead to a nasty runtime error if the prototype of the function is 
different from what gcc guessed.

With -Werror-implicit-function-declaration, we are getting an immediate 
compile error instead.

There will be some compile errors in cases where compilation previously
worked because the undefined function wasn't called due to gcc dead code
elimination, but in these cases a proper fix doesnt harm.


This patch also removes some unneeded spaces between two tabs in the 
following line and a now no longer required
-Werror-implicit-function-declaration from
drivers/input/joystick/iforce/Makefile.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc3-mm3-full/Makefile.old	2005-07-30 13:55:32.000000000 +0200
+++ linux-2.6.13-rc3-mm3-full/Makefile	2005-07-30 13:55:56.000000000 +0200
@@ -351,7 +351,8 @@
 CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
 
 CFLAGS 		:= -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
-	  	   -fno-strict-aliasing -fno-common \
+		   -Werror-implicit-function-declaration \
+		   -fno-strict-aliasing -fno-common \
 		   -ffreestanding
 AFLAGS		:= -D__ASSEMBLY__
 

--- linux-2.6.15-rc2-mm1-full/drivers/input/joystick/iforce/Makefile.old	2005-11-23 14:22:11.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/drivers/input/joystick/iforce/Makefile	2005-11-23 14:22:17.000000000 +0100
@@ -17,4 +17,3 @@
 	iforce-objs += iforce-usb.o
 endif
 
-EXTRA_CFLAGS = -Werror-implicit-function-declaration
