Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263697AbTCVQo5>; Sat, 22 Mar 2003 11:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263699AbTCVQo4>; Sat, 22 Mar 2003 11:44:56 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40456 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263697AbTCVQox>; Sat, 22 Mar 2003 11:44:53 -0500
Date: Sat, 22 Mar 2003 16:55:56 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: PCI patches (1/3)
Message-ID: <20030322165556.E8712@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030322165525.D8712@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030322165525.D8712@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sat, Mar 22, 2003 at 04:55:25PM +0000
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1130  -> 1.1131 
#	drivers/pci/setup-res.c	1.15    -> 1.16   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/22	ink@undisclosed.(none)	1.1131
# [PCI] Don't call pci_update_resource() for bridge resources.
#   
# Minor cleanup: don't call pci_update_resource() for bridges,
# get rid of bogus "trying to set non-standard region" messages thus.
# --------------------------------------------
#
diff -Nru a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
--- a/drivers/pci/setup-res.c	Sat Mar 22 16:51:48 2003
+++ b/drivers/pci/setup-res.c	Sat Mar 22 16:51:48 2003
@@ -59,9 +59,7 @@
 		reg = dev->rom_base_reg;
 	} else {
 		/* Hmm, non-standard resource. */
-		printk("PCI: trying to set non-standard region %s/%d\n",
-		       dev->slot_name, resno);
-		return;
+		BUG();
 	}
 
 	pci_write_config_dword(dev, reg, new);
@@ -141,7 +139,7 @@
 	if (ret) {
 		printk(KERN_ERR "PCI: Failed to allocate resource %d(%lx-%lx) for %s\n",
 		       resno, res->start, res->end, dev->slot_name);
-	} else {
+	} else if (resno < PCI_BRIDGE_RESOURCES) {
 		pci_update_resource(dev, res, resno);
 	}
 

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

