Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbUEFNad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbUEFNad (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 09:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbUEFN2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 09:28:32 -0400
Received: from lists.us.dell.com ([143.166.224.162]:57946 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S262170AbUEFN2N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 09:28:13 -0400
Date: Thu, 6 May 2004 08:28:10 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: mj@ucw.cz
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI devices with no PCI_CACHE_LINE_SIZE implemented
Message-ID: <20040506132810.GB13482@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin, below is a patch to lower the severity of this printk to
KERN_DEBUG, as there are devices which (properly) don't implement the
PCI_CACHE_LINE_SIZE register, and it's not a bug, so don't print at a
WARNING level.

Thanks,
Matt


----- Forwarded message from Matt Domsch <Matt_Domsch@dell.com> -----

Date: Wed, 5 May 2004 17:50:53 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: PCI devices with no PCI_CACHE_LINE_SIZE implemented
In-Reply-To: <20040505223102.GF30003@kroah.com>

On Wed, May 05, 2004 at 03:31:02PM -0700, Greg KH wrote:
> On Thu, Apr 29, 2004 at 02:53:01PM -0500, Matt Domsch wrote:
> > a) need this be a warning, wouldn't KERN_DEBUG suffice, if a message
> > is needed at all?  This is printed in pci_generic_prep_mwi().
> 
> Yes, we should make that KERN_DEBUG.  I don't have a problem with that.
> Care to make a patch?

Patch for 2.4.27-pre1 appended.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

===== drivers/pci/pci.c 1.47 vs edited =====
--- 1.47/drivers/pci/pci.c	Mon Sep 22 07:27:35 2003
+++ edited/drivers/pci/pci.c	Wed May  5 17:49:13 2004
@@ -943,7 +943,7 @@
 	if (cacheline_size == pci_cache_line_size)
 		return 0;
 
-	printk(KERN_WARNING "PCI: cache line size of %d is not supported "
+	printk(KERN_DEBUG "PCI: cache line size of %d is not supported "
 	       "by device %s\n", pci_cache_line_size << 2, dev->slot_name);
 
 	return -EINVAL;
