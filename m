Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271118AbTHCK5O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 06:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271120AbTHCK5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 06:57:14 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:25578 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S271118AbTHCK5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 06:57:12 -0400
Date: Sun, 3 Aug 2003 12:57:07 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.22-pre10-ac1: fix tp600.c compile warning
Message-ID: <20030803105707.GL16426@fs.tum.de>
References: <200308012216.h71MGLe31285@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308012216.h71MGLe31285@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile warning in 2.4.22-pre10-ac1:

<--  snip  -->

...
gcc -D__KERNEL__ 
-I/home/bunk/linux/kernel-2.4/linux-2.4.22-pre10-ac1-full/inclu
de -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -iwithprefix 
include -DKBUILD_BASENAME=tp600  -c -o tp600.o tp600.c
tp600.c: In function `h2999_cleanup':
tp600.c:417: warning: control reaches end of non-void function
...

<--  snip  -->

Since the only caller of this function doesn't check the return value, I 
assume the following patch might be correct?

--- linux-2.4.22-pre10-ac1-full/drivers/hotplug/tp600.c~	2003-08-02 01:44:02.000000000 +0200
+++ linux-2.4.22-pre10-ac1-full/drivers/hotplug/tp600.c	2003-08-02 23:13:34.000000000 +0200
@@ -402,7 +402,7 @@
  *	Unregister and free up all of our slots
  */
 
-static int __devinit h2999_cleanup(struct h2999_dev *dev)
+static void __devinit h2999_cleanup(struct h2999_dev *dev)
 {
 	struct h2999_slot *s;
 	int slot;



I've tested the compilation with 2.4.22-pre10-ac1.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

