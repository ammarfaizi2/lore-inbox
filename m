Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317949AbSGWEeQ>; Tue, 23 Jul 2002 00:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317950AbSGWEeQ>; Tue, 23 Jul 2002 00:34:16 -0400
Received: from codepoet.org ([166.70.99.138]:57018 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S317949AbSGWEeO>;
	Tue, 23 Jul 2002 00:34:14 -0400
Date: Mon, 22 Jul 2002 22:37:24 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] compile fix for Linux 2.4.19-rc3-ac2
Message-ID: <20020723043724.GA12088@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
References: <200207230022.g6N0Mgh30698@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207230022.g6N0Mgh30698@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Jul 22, 2002 at 08:22:42PM -0400, Alan Cox wrote:
> o	AMD native powermanagement			(Tony Lindgren,
> 							 Johnathan Hicks)
> 	| Replaces amd768_pm as its already far better

Doesn't compile:

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -Os -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include -DKBUILD_BASENAME=amd76x_pm  -c -o amd76x_pm.o amd76x_pm.c
amd76x_pm.c: In function `sb_idle_amd_766':
amd76x_pm.c:137: warning: unused variable `regshort'
amd76x_pm.c: In function `amd_idle_main':
amd76x_pm.c:360: `pm_idle' undeclared (first use in this function)
amd76x_pm.c:360: (Each undeclared identifier is reported only once
amd76x_pm.c:360: for each function it appears in.)
amd76x_pm.c: In function `amd_idle_cleanup':
amd76x_pm.c:377: `pm_idle' undeclared (first use in this function)
make[3]: *** [amd76x_pm.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/char'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers/char'
make[1]: *** [_subdir_char] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_dir_drivers] Error 2


This trivial patch fixes it:


--- drivers/char/amd76x_pm.c.orig	Mon Jul 22 22:32:55 2002
+++ drivers/char/amd76x_pm.c	Mon Jul 22 22:34:49 2002
@@ -35,6 +35,7 @@
 #include <linux/slab.h>
 #include <linux/pci.h>
 #include <linux/delay.h>
+#include <linux/pm.h>
 
 #include "amd76x_pm.h"
 
@@ -134,7 +135,6 @@
 sb_idle_amd_766(int enable)
 {
 	unsigned int regdword;
-	unsigned short regshort;
 	unsigned char regbyte;
 
 
 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
