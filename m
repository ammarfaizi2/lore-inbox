Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbVIDN1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbVIDN1I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 09:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbVIDN1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 09:27:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:9088 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750820AbVIDN1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 09:27:06 -0400
Date: Sun, 4 Sep 2005 15:27:04 +0200
From: Olaf Hering <olh@suse.de>
To: Jesse Barnes <jbarnes@sgi.com>, Jon Smirl <jonsmirl@gmail.com>
Cc: akpm@osdl.org, benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quiet non-x86 option ROM warnings
Message-ID: <20050904132704.GA27274@suse.de>
References: <200502151557.06049.jbarnes@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200502151557.06049.jbarnes@sgi.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Feb 15, Jesse Barnes wrote:

> Both the r128 and radeon drivers complain if they don't find an x86 option ROM 
> on the device they're talking to.  This would be fine, except that the 
> message is incorrect--not all option ROMs are required to be x86 based.  This 
> small patch just removes the messages altogether, causing the drivers to 
> *silently* fall back to the non-x86 option ROM behavior (it works fine and 
> there's no cause for alarm).

This patch wasnt applied, back in February this year. Please do so now.



Quiet an incorrect warning in aty128fb and radeonfb about the PCI ROM
content. Macs work just find without that signature.


Signed-off-by: Olaf Hering <olh@suse.de>

 drivers/video/aty/aty128fb.c    |    2 +-
 drivers/video/aty/radeon_base.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.13-fb-rom/drivers/video/aty/aty128fb.c
===================================================================
--- linux-2.6.13-fb-rom.orig/drivers/video/aty/aty128fb.c
+++ linux-2.6.13-fb-rom/drivers/video/aty/aty128fb.c
@@ -806,7 +806,7 @@ static void __iomem * __init aty128_map_
 
 	/* Very simple test to make sure it appeared */
 	if (BIOS_IN16(0) != 0xaa55) {
-		printk(KERN_ERR "aty128fb: Invalid ROM signature %x should be 0xaa55\n",
+		printk(KERN_DEBUG "aty128fb: Invalid ROM signature %x should be 0xaa55\n",
 		       BIOS_IN16(0));
 		goto failed;
 	}
Index: linux-2.6.13-fb-rom/drivers/video/aty/radeon_base.c
===================================================================
--- linux-2.6.13-fb-rom.orig/drivers/video/aty/radeon_base.c
+++ linux-2.6.13-fb-rom/drivers/video/aty/radeon_base.c
@@ -329,7 +329,7 @@ static int __devinit radeon_map_ROM(stru
 
 	/* Very simple test to make sure it appeared */
 	if (BIOS_IN16(0) != 0xaa55) {
-		printk(KERN_ERR "radeonfb (%s): Invalid ROM signature %x should be"
+		printk(KERN_DEBUG "radeonfb (%s): Invalid ROM signature %x should be"
 		       "0xaa55\n", pci_name(rinfo->pdev), BIOS_IN16(0));
 		goto failed;
 	}
