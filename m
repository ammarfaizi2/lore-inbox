Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270519AbTG1UAj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 16:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270520AbTG1UAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 16:00:39 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:55771 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S270519AbTG1UAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 16:00:35 -0400
Date: Mon, 28 Jul 2003 22:00:26 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: isdn4linux@listserv.isdn4linux.de
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.6 patch] HISAX_SEDLBAUER_CS needs HISAX_SEDLBAUER
Message-ID: <20030728200026.GL25402@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you compile 2.6.0-test2 with HISAX_SEDLBAUER_CS and !HISAX_SEDLBAUER 
the final linking fails with the followingg error:

<--  snip  -->

...
  LD      .tmp_vmlinux1
...
drivers/built-in.o(.text+0x8f0b3f): In function `sedlbauer_config':
: undefined reference to `sedl_init_pcmcia'
...
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

There might be better solutions, but the following patch at least
revents this problem:

--- linux-2.6.0-test2-not-full/drivers/isdn/hisax/Kconfig~	2003-07-27 19:07:12.000000000 +0200
+++ linux-2.6.0-test2-not-full/drivers/isdn/hisax/Kconfig	2003-07-28 21:55:00.000000000 +0200
@@ -367,7 +367,7 @@
 
 config HISAX_SEDLBAUER_CS
 	tristate "Sedlbauer PCMCIA cards"
-	depends on PCMCIA
+	depends on PCMCIA && HISAX_SEDLBAUER
 	help
 	  This enables the PCMCIA client driver for the Sedlbauer Speed Star
 	  and Speed Star II cards.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

