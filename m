Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbVCLTLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbVCLTLa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 14:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbVCLTL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 14:11:29 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:37068 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262001AbVCLTLW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 14:11:22 -0500
Date: Sat, 12 Mar 2005 20:11:07 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>, linux-net@vger.kernel.org
Subject: Re: Fix suspend/resume on via-velocity
Message-ID: <20050312191107.GC12070@elf.ucw.cz>
References: <20050311141132.GA1539@elf.ucw.cz> <4231F281.8060202@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4231F281.8060202@pobox.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes suspend-resume on via-velocity. It was confused
w.r.t. pointers... Now uses netdev_priv(). [Well, someone should run
sed over that driver, there are many more dev->priv]. Please apply,

Signed-off-by: Pavel Machek <pavel@suse.cz>
							Pavel


--- clean/drivers/net/via-velocity.c	2005-01-22 21:24:52.000000000 +0100
+++ linux/drivers/net/via-velocity.c	2005-03-12 20:07:29.000000000 +0100
@@ -3210,9 +3210,10 @@
 	return 0;
 }
 
 static int velocity_suspend(struct pci_dev *pdev, pm_message_t state)
 {
-	struct velocity_info *vptr = pci_get_drvdata(pdev);
+	struct net_device *dev = pci_get_drvdata(pdev);
+	struct velocity_info *vptr = netdev_priv(dev);
 	unsigned long flags;
 
 	if(!netif_running(vptr->dev))
@@ -3245,7 +3246,8 @@
 
 static int velocity_resume(struct pci_dev *pdev)
 {
-	struct velocity_info *vptr = pci_get_drvdata(pdev);
+	struct net_device *dev = pci_get_drvdata(pdev);
+	struct velocity_info *vptr = netdev_priv(dev);
 	unsigned long flags;
 	int i;
 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
