Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbTLSXII (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 18:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263680AbTLSXII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 18:08:08 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:27890 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263679AbTLSXID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 18:08:03 -0500
Date: Sat, 20 Dec 2003 00:07:55 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Johnathan Hicks <thetech@folkwolf.net>
Cc: linux-kernel@vger.kernel.org
Subject: [2.4 patch] fix a compile warning in amd76x_pm.c (fwd)
Message-ID: <20031219230755.GY12750@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

the patch forwarded below still applies and compiles against 
2.4.24-pre1.

Please apply
Adrian


----- Forwarded message from Adrian Bunk <bunk@fs.tum.de> -----

Date:	Sun, 3 Aug 2003 12:58:08 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
	Johnathan Hicks <thetech@folkwolf.net>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.4 patch] fix a compile warning in amd76x_pm.c

I got the following compile warning in 2.4.22-pre10:

<--  snip  -->

...
gcc -D__KERNEL__ 
-I/home/bunk/linux/kernel-2.4/linux-2.4.22-pre10-full/include -
Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -iwithprefix 
include -DKBUILD_BASENAME=amd76x_pm  -c -o amd76x_pm.o amd76x_pm.c
amd76x_pm.c:483: warning: `activate_amd76x_SLP' defined but not used
...

<--  snip  -->


The following patch puts this function under the same #ifdef as it's 
only caller:

--- linux-2.4.22-pre10-full/drivers/char/amd76x_pm.c.old	2003-08-02 23:02:38.000000000 +0200
+++ linux-2.4.22-pre10-full/drivers/char/amd76x_pm.c	2003-08-02 23:03:11.000000000 +0200
@@ -474,7 +474,7 @@
 }
 #endif
 
-
+#ifdef AMD76X_POS
 /*
  * Activate sleep state via its ACPI register (PM1_CNT).
  */
@@ -489,8 +489,6 @@
 	outw(regshort, amd76x_pm_cfg.slp_reg);
 }
 
-
-#ifdef AMD76X_POS
 /*
  * Wrapper function to activate POS sleep state.
  */


I've tested the compilation with 2.4.22-pre10.

Please apply
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

