Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264835AbUEEWu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264835AbUEEWu5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 18:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264836AbUEEWu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 18:50:56 -0400
Received: from lists.us.dell.com ([143.166.224.162]:18911 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S264835AbUEEWuy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 18:50:54 -0400
Date: Wed, 5 May 2004 17:50:53 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: PCI devices with no PCI_CACHE_LINE_SIZE implemented
Message-ID: <20040505225053.GB2283@lists.us.dell.com>
References: <20040429195301.GB15106@lists.us.dell.com> <20040505223102.GF30003@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040505223102.GF30003@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
