Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271155AbTHCK77 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 06:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271158AbTHCK76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 06:59:58 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:18922 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S271155AbTHCK7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 06:59:10 -0400
Date: Sun, 3 Aug 2003 12:59:05 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.4 patch] fix a compile warning in ip2main.c
Message-ID: <20030803105905.GP16426@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile warning in 2.4.22-pre10:

<--  snip  -->

...
gcc -D__KERNEL__ 
-I/home/bunk/linux/kernel-2.4/linux-2.4.22-pre10-full/include -
Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -iwithprefix 
include -DKBUILD_BASENAME=ip2main  -c -o ip2main.o ip2main.c
ip2main.c: In function `ip2_init_board':
ip2main.c:991: warning: unused variable `rc'
...

<--  snip  -->


The following patch removes this unused variable:

--- linux-2.4.22-pre10-full/drivers/char/ip2main.c.old	2003-08-02 22:46:51.000000000 +0200
+++ linux-2.4.22-pre10-full/drivers/char/ip2main.c	2003-08-02 22:47:23.000000000 +0200
@@ -988,7 +988,7 @@
 static void __init
 ip2_init_board( int boardnum )
 {
-	int i,rc;
+	int i;
 	int nports = 0, nboxes = 0;
 	i2ChanStrPtr pCh;
 	i2eBordStrPtr pB = i2BoardPtrTable[boardnum];



I've tested the compilation with 2.4.22-pre10.

Please apply
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

