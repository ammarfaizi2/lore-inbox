Return-Path: <linux-kernel-owner+w=401wt.eu-S964991AbWLMRnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbWLMRnP (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 12:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWLMRmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 12:42:54 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:3131 "EHLO
	pollux.ds.pg.gda.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932662AbWLMRms (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 12:42:48 -0500
Date: Wed, 13 Dec 2006 17:10:50 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>, Antonino Daplas <adaplas@pol.net>
cc: linux-fbdev-devel@lists.sourceforge.net, axp-list@redhat.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.19 4/6] tgafb: Fix the mode register setting
Message-ID: <Pine.LNX.4.64N.0612131613050.24220@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 There is no need to set the GE bit (Win32 compatibility) in the mode 
register; it shall get cleared with the next subsequent update to the 
register anyway.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---

 The driver uses a number of magic constants throughout.  The hardware is 
fully documented, so my plan is to fix up them all and provide macros for 
all the used bits and perhaps more once I have finished with updating the 
driver.

 Please apply.

  Maciej

patch-mips-2.6.18-20060920-tgafb-mode-1
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/video/tgafb.c linux-mips-2.6.18-20060920/drivers/video/tgafb.c
--- linux-mips-2.6.18-20060920.macro/drivers/video/tgafb.c	2006-09-20 20:50:52.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/video/tgafb.c	2006-12-12 05:15:28.000000000 +0000
@@ -136,10 +136,10 @@ tgafb_set_par(struct fb_info *info)
 		0x00000303
 	};
 	static unsigned int const mode_presets[4] = {
-		0x00002000,
-		0x00002300,
+		0x00000000,
+		0x00000300,
 		0xffffffff,
-		0x00002300
+		0x00000300
 	};
 	static unsigned int const base_addr_presets[4] = {
 		0x00000000,
