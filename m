Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263317AbVCKOMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263317AbVCKOMF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 09:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263316AbVCKOME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 09:12:04 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13224 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263315AbVCKOLr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 09:11:47 -0500
Date: Fri, 11 Mar 2005 15:11:32 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>, jgarzik@pobox.com,
       linux-net@vger.kernel.org
Subject: Fix suspend/resume on via-velocity
Message-ID: <20050311141132.GA1539@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes suspend-resume on via-velocity. It was confused
w.r.t. pointers... Please apply,

Signed-off-by: Pavel Machek <pavel@suse.cz>
							Pavel

--- clean-mm/drivers/net/via-velocity.c	2005-03-11 11:25:36.000000000 +0100
+++ linux/drivers/net/via-velocity.c	2005-03-11 10:06:05.000000000 +0100
@@ -3212,7 +3212,8 @@
 
 static int velocity_suspend(struct pci_dev *pdev, pm_message_t state)
 {
-	struct velocity_info *vptr = pci_get_drvdata(pdev);
+	struct net_device *dev = pci_get_drvdata(pdev);
+	struct velocity_info *vptr = dev->priv;
 	unsigned long flags;
 
 	if(!netif_running(vptr->dev))
@@ -3245,7 +3246,8 @@
 
 static int velocity_resume(struct pci_dev *pdev)
 {
-	struct velocity_info *vptr = pci_get_drvdata(pdev);
+	struct net_device *dev = pci_get_drvdata(pdev);
+	struct velocity_info *vptr = dev->priv;
 	unsigned long flags;
 	int i;
 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
