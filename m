Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265339AbTFZCiH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 22:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265341AbTFZCiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 22:38:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59335 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265339AbTFZCh7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 22:37:59 -0400
Date: Thu, 26 Jun 2003 03:52:10 +0100
From: Matthew Wilcox <willy@debian.org>
To: Matthew Wilcox <willy@debian.org>
Cc: Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] pci_name()
Message-ID: <20030626025210.GF451@parcelfarce.linux.theplanet.co.uk>
References: <20030625233525.GB451@parcelfarce.linux.theplanet.co.uk> <20030626003620.GB13892@kroah.com> <20030626005315.GD451@parcelfarce.linux.theplanet.co.uk> <20030626010239.GB15189@kroah.com> <20030626025057.GE451@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030626025057.GE451@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 26, 2003 at 03:50:57AM +0100, Matthew Wilcox wrote:
> On Wed, Jun 25, 2003 at 06:02:40PM -0700, Greg KH wrote:
> > Ok, I'll buy that, feel free to send the patch :)
> 
> It's kind of late to be writing patches ... but this boots & works for me.

Here's an example of converting a driver (tg3, just to annoy jeff ;-) to
pci_name().

Index: drivers/net/tg3.c
===================================================================
RCS file: /var/cvs/linux-2.5/drivers/net/tg3.c,v
retrieving revision 1.16
diff -u -p -r1.16 tg3.c
--- drivers/net/tg3.c	14 Jun 2003 22:15:21 -0000	1.16
+++ drivers/net/tg3.c	26 Jun 2003 02:45:54 -0000
@@ -5118,7 +5118,7 @@ static int tg3_ethtool_ioctl (struct net
 		strcpy (info.driver, DRV_MODULE_NAME);
 		strcpy (info.version, DRV_MODULE_VERSION);
 		memset(&info.fw_version, 0, sizeof(info.fw_version));
-		strcpy (info.bus_info, pci_dev->slot_name);
+		strcpy (info.bus_info, pci_name(pci_dev));
 		info.eedump_len = 0;
 		info.regdump_len = TG3_REGDUMP_LEN;
 		if (copy_to_user (useraddr, &info, sizeof (info)))
@@ -6087,7 +6087,7 @@ static int __devinit tg3_get_invariants(
 	err = tg3_set_power_state(tp, 0);
 	if (err) {
 		printk(KERN_ERR PFX "(%s) transition to D0 failed\n",
-		       tp->pdev->slot_name);
+		       pci_name(tp->pdev));
 		return err;
 	}
 
@@ -6198,7 +6198,7 @@ static int __devinit tg3_get_invariants(
 	err = tg3_phy_probe(tp);
 	if (err) {
 		printk(KERN_ERR PFX "(%s) phy probe failed, err %d\n",
-		       tp->pdev->slot_name, err);
+		       pci_name(tp->pdev), err);
 		/* ... but do not return immediately ... */
 	}
 
@@ -6682,7 +6682,7 @@ static int __devinit tg3_init_one(struct
 	if (!pci_set_dma_mask(pdev, (u64) 0xffffffffffffffffULL)) {
 		pci_using_dac = 1;
 		if (pci_set_consistent_dma_mask(pdev,
-						(u64) 0xffffffffffffffff)) {
+						(u64) 0xffffffffffffffffULL)) {
 			printk(KERN_ERR PFX "Unable to obtain 64 bit DMA "
 			       "for consistent allocations\n");
 			goto err_out_free_res;

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
