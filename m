Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbVCYKZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbVCYKZQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 05:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVCYKZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 05:25:16 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:61109 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261569AbVCYKZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 05:25:07 -0500
Date: Fri, 25 Mar 2005 11:24:52 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Remaining u32 vs. pm_message_t fixes
Message-ID: <20050325102452.GA1352@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes three remaining places where we put u32 (or worse
suspend_state_t) into pm_message_t-sized box. As a bonus, PCI_D0 is
used instead of constant 0. Please apply,

Signed-off-by: Pavel Machek <pavel@suse.cz>
								Pavel

PS: Nigel, if you know about some other places in -rc1-mm3 where u32
is confused with pm_message_t, please let me know....

--- clean-mm/drivers/usb/host/sl811-hcd.c	2005-03-25 10:09:01.000000000 +0100
+++ linux-delme/drivers/usb/host/sl811-hcd.c	2005-03-25 11:20:53.000000000 +0100
@@ -1809,7 +1809,7 @@
 		return 0;
 	}
 
-	dev->power.power_state = PM_SUSPEND_ON;
+	dev->power.power_state = PMSG_ON;
 	return sl811h_hub_resume(hcd);
 }
 
--- clean-mm/drivers/video/i810/i810_main.c	2005-03-25 10:09:01.000000000 +0100
+++ linux-delme/drivers/video/i810/i810_main.c	2005-03-25 11:21:09.000000000 +0100
@@ -1492,7 +1492,7 @@
 /***********************************************************************
  *                         Power Management                            *
  ***********************************************************************/
-static int i810fb_suspend(struct pci_dev *dev, u32 state)
+static int i810fb_suspend(struct pci_dev *dev, pm_message_t state)
 {
 	struct fb_info *info = pci_get_drvdata(dev);
 	struct i810fb_par *par = (struct i810fb_par *) info->par;
@@ -1538,7 +1538,7 @@
 		return 0;
 
 	pci_restore_state(dev);
-	pci_set_power_state(dev, 0);
+	pci_set_power_state(dev, PCI_D0);
 	pci_enable_device(dev);
 	agp_bind_memory(par->i810_gtt.i810_fb_memory,
 			par->fb.offset);



-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
