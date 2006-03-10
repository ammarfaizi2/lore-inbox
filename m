Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751633AbWCJSGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbWCJSGR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 13:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbWCJSGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 13:06:17 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:45073 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751633AbWCJSGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 13:06:16 -0500
Date: Fri, 10 Mar 2006 19:06:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: dm-devel@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] md/bitmap.c:bitmap_mask_state(): fix inconsequent NULL checking
Message-ID: <20060310180616.GR21864@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We dereference bitmap both one line above and one line below this check 
rendering this check quite useless.

Spotted by the Coverity checker.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc5-mm3-full/drivers/md/bitmap.c.old	2006-03-10 19:02:38.000000000 +0100
+++ linux-2.6.16-rc5-mm3-full/drivers/md/bitmap.c	2006-03-10 19:02:54.000000000 +0100
@@ -546,7 +546,7 @@ static void bitmap_mask_state(struct bit
 	unsigned long flags;
 
 	spin_lock_irqsave(&bitmap->lock, flags);
-	if (!bitmap || !bitmap->sb_page) { /* can't set the state */
+	if (!bitmap->sb_page) { /* can't set the state */
 		spin_unlock_irqrestore(&bitmap->lock, flags);
 		return;
 	}
