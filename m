Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbTELVwg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 17:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbTELVwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 17:52:36 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:31433 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262788AbTELVwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 17:52:34 -0400
Date: Tue, 13 May 2003 00:05:12 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: yoshfuji@linux-ipv6.org
Cc: "David S. Miller" <davem@redhat.com>, jt@hpl.hp.com,
       linux-kernel@vger.kernel.org
Subject: [patch] 2.5.69-bk7: wireless.c must include module.h
Message-ID: <20030512220512.GC1107@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<--  snip  -->

...
  gcc -Wp,-MD,net/core/.wireless.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=k6 
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=wireless -DKBUILD_MODNAME=wireless -c -o 
net/core/wireless.o net/core/wireless.c
net/core/wireless.c:488: `THIS_MODULE' undeclared here (not in a function)
net/core/wireless.c:488: initializer element is not constant
net/core/wireless.c:488: (near initialization for `wireless_seq_fops.owner')
make[2]: *** [net/core/wireless.o] Error 1

<--  snip  -->


The fix is simple:

--- linux-2.5.69-bk7/net/core/wireless.c.old	2003-05-13 00:02:06.000000000 +0200
+++ linux-2.5.69-bk7/net/core/wireless.c	2003-05-13 00:02:42.000000000 +0200
@@ -60,6 +60,7 @@
 #include <linux/seq_file.h>
 #include <linux/init.h>			/* for __init */
 #include <linux/if_arp.h>		/* ARPHRD_ETHER */
+#include <linux/module.h>
 
 #include <linux/wireless.h>		/* Pretty obvious */
 #include <net/iw_handler.h>		/* New driver API */



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

