Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270387AbTGMUDV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 16:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270390AbTGMUDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 16:03:21 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:45293 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S270387AbTGMUDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 16:03:17 -0400
Date: Sun, 13 Jul 2003 22:17:51 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: [2.5 patch] fix section type conflict in sound/isa/sscape.c
Message-ID: <20030713201751.GA12104@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling 2.5.75-mm1 with !CONFIG_HOTPLUG using gcc 3.3 I got the
following compile error (but it doesn't seem to be specific to -mm):

<--  snip  -->

...
  CC      sound/isa/sscape.o
sound/isa/sscape.c: In function `get_irq_config':
sound/isa/sscape.c:812: error: valid_irq causes a section type conflict
make[2]: *** [sound/isa/sscape.o] Error 1
make[1]: *** [sound/isa] Error 2
make: *** [sound] Error 2

<--  snip  -->


The following patch fixes the problem:


--- linux-2.5.75-mm1/sound/isa/sscape.c.old	2003-07-13 22:10:52.000000000 +0200
+++ linux-2.5.75-mm1/sound/isa/sscape.c	2003-07-13 22:11:21.000000000 +0200
@@ -809,7 +809,7 @@
  */
 static unsigned __devinit get_irq_config(int irq)
 {
-	static const int valid_irq[] __devinitdata = { 9, 5, 7, 10 };
+	static const int valid_irq[] = { 9, 5, 7, 10 };
 	unsigned cfg;
 
 	for (cfg = 0; cfg < ARRAY_SIZE(valid_irq); ++cfg) {




cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

