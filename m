Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVAXRVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVAXRVZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 12:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVAXRVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 12:21:25 -0500
Received: from gprs213-136.eurotel.cz ([160.218.213.136]:3713 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261482AbVAXRVT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 12:21:19 -0500
Date: Mon, 24 Jan 2005 18:21:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Fix driver model in tg3
Message-ID: <20050124172106.GA2513@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

With last pci_choose_state, I passed wrong pointer to
pci_choose_state. This fixes it. Please apply,
							Pavel
Signed-off-by: Pavel Machek <pavel@suse.cz>

--- /data/l/READ-ONLY/linux/drivers/net/tg3.c	2005-01-22 21:28:41.000000000 +0100
+++ linux/drivers/net/tg3.c	2005-01-24 11:23:06.000000000 +0100
@@ -8475,7 +8475,7 @@
 	spin_unlock(&dev->xmit_lock);
 	spin_unlock_irq(&tp->lock);
 
-	err = tg3_set_power_state(tp, pci_choose_state(dev, state));
+	err = tg3_set_power_state(tp, pci_choose_state(pdev, state));
 	if (err) {
 		spin_lock_irq(&tp->lock);
 		spin_lock(&dev->xmit_lock);
 
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
