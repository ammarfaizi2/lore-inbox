Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261529AbTCTPZH>; Thu, 20 Mar 2003 10:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261571AbTCTPZH>; Thu, 20 Mar 2003 10:25:07 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:30969 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261529AbTCTPUk>; Thu, 20 Mar 2003 10:20:40 -0500
Date: Thu, 20 Mar 2003 16:31:35 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Subject: [2.5 patch] fix .text.exit error in OSS awe_wave.c
Message-ID: <20030320153134.GA3174@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got a .exit.text error in 2.5.65.

The problem is that in sound/oss/awe_wave.c the __init function
_attach_awe calls the __exit function awe_release_region.

The following patch that removes the __exit from awe_release_region 
fixes it:


--- linux-2.5.65-notfull/sound/oss/awe_wave.c.old	2003-03-20 16:09:19.000000000 +0100
+++ linux-2.5.65-notfull/sound/oss/awe_wave.c	2003-03-20 16:09:40.000000000 +0100
@@ -757,7 +757,7 @@
 	return 0;
 }
 
-static void __exit
+static void
 awe_release_region(void)
 {
 	if (! port_setuped) return;


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

