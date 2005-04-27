Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261820AbVD0RTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbVD0RTv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 13:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261814AbVD0RSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 13:18:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:23238 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261818AbVD0RRb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 13:17:31 -0400
Date: Wed, 27 Apr 2005 10:16:06 -0700
From: Greg KH <gregkh@suse.de>
To: js@linuxtv.org, kraxel@bytesex.org, video4linux-list@redhat.com
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Cliff White <cliffw@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [02/07] [fix Bug 4395] modprobe bttv freezes the computer
Message-ID: <20050427171606.GC3195@kroah.com>
References: <20050427171446.GA3195@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427171446.GA3195@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

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

