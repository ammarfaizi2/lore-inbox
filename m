Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbVDEO41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbVDEO41 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 10:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbVDEO41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 10:56:27 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:1474 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261773AbVDEO4D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 10:56:03 -0400
Date: Tue, 5 Apr 2005 16:55:52 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Message-ID: <20050405145552.GA11360@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Greg KH <greg@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
X-SA-Exim-Connect-IP: 217.231.56.173
Subject: [PATCH] [fix Bug 4395] modprobe bttv freezes the computer
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch that fixes
http://bugme.osdl.org/show_bug.cgi?id=4395.

In case there's a 2.6.11.7 before 2.6.12 is released it would
be nice to include this patch there, too.

Johannes

---
Patch by Manu Abraham and Gerd Knorr:
Remove redundant bttv_reset_audio() which caused the computer to
freeze with some bt8xx based DVB cards when loading the bttv driver.

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/video/bttv-cards.c |    2 --
 1 files changed, 2 deletions(-)

Index: linux-2.6.12-rc2/drivers/media/video/bttv-cards.c
===================================================================
--- linux-2.6.12-rc2.orig/drivers/media/video/bttv-cards.c	2005-04-05 02:35:41.000000000 +0200
+++ linux-2.6.12-rc2/drivers/media/video/bttv-cards.c	2005-04-05 02:37:31.000000000 +0200
@@ -2785,8 +2785,6 @@ void __devinit bttv_init_card2(struct bt
         }
 	btv->pll.pll_current = -1;
 
-	bttv_reset_audio(btv);
-
 	/* tuner configuration (from card list / autodetect / insmod option) */
  	if (UNSET != bttv_tvcards[btv->c.type].tuner_type)
 		if(UNSET == btv->tuner_type)
