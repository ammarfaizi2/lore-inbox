Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbVBOAsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVBOAsV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 19:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbVBOAsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 19:48:21 -0500
Received: from gprs215-140.eurotel.cz ([160.218.215.140]:51132 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261423AbVBOAsN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 19:48:13 -0500
Date: Tue, 15 Feb 2005 01:47:59 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>, bcollins@debian.org,
       scjody@steamballoon.com
Cc: ncunningham@cyclades.com, bernard@blackham.com.au, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: FIx u32 vs. pm_message_t confusion in firewire
Message-ID: <20050215004759.GE5415@elf.ucw.cz>
References: <1108359808.12611.37.camel@desktop.cunningham.myip.net.au> <20050214213400.GF12235@elf.ucw.cz> <20050214134658.324076c9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050214134658.324076c9.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This should fix u32 vs. pm_message_t confusion in firewire. No code
changes. Please apply,
							Pavel
Signed-off-by: Pavel Machek <pavel@suse.cz>

--- clean-mm/drivers/ieee1394/nodemgr.c	2005-02-15 00:46:40.000000000 +0100
+++ linux-mm/drivers/ieee1394/nodemgr.c	2005-02-15 01:04:10.000000000 +0100
@@ -1284,7 +1284,7 @@
 
 		if (ud->device.driver &&
 		    (!ud->device.driver->suspend ||
-		      ud->device.driver->suspend(&ud->device, 0, 0)))
+		      ud->device.driver->suspend(&ud->device, PMSG_SUSPEND, 0)))
 			device_release_driver(&ud->device);
 	}
 	up_write(&ne->device.bus->subsys.rwsem);
--- clean-mm/drivers/ieee1394/ohci1394.c	2005-02-15 00:46:40.000000000 +0100
+++ linux-mm/drivers/ieee1394/ohci1394.c	2005-02-15 01:04:10.000000000 +0100
@@ -3546,7 +3546,7 @@
 }
 
 
-static int ohci1394_pci_suspend (struct pci_dev *pdev, u32 state)
+static int ohci1394_pci_suspend (struct pci_dev *pdev, pm_message_t state)
 {
 #ifdef CONFIG_PMAC_PBOOK
 	{


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
