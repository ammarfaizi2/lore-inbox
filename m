Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271120AbTHCK5w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 06:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271125AbTHCK5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 06:57:52 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:23786 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S271120AbTHCK5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 06:57:46 -0400
Date: Sun, 3 Aug 2003 12:57:41 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jakob Oestergaard <jakob@ostenfeld.dk>
Cc: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: [2.4 patch] fix a compile warning in sbc60xxwdt.c
Message-ID: <20030803105741.GM16426@fs.tum.de>
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
include -DKBUILD_BASENAME=sbc60xxwdt  -c -o sbc60xxwdt.o sbc60xxwdt.c
sbc60xxwdt.c: In function `sbc60xxwdt_init':
sbc60xxwdt.c:338: warning: label `err_out' defined but not used
...

<--  snip  -->


The following simple fix (taken from 2.6.0-test2) fixes it:

--- linux-2.4.22-pre10-full/drivers/char/sbc60xxwdt.c	2002-11-29 00:53:12.000000000 +0100
+++ linux-2.6.0-test2-full/drivers/char/watchdog/sbc60xxwdt.c	2003-07-27 19:05:13.000000000 +0200
@@ -335,7 +340,7 @@
 	release_region(WDT_START,1);
 err_out_region1:
 	release_region(WDT_STOP,1);
-err_out:
+/* err_out: */
 	return rc;
 }
 




I've tested the compilation with 2.4.22-pre10.

Please apply
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

