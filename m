Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264834AbUEEWsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264834AbUEEWsu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 18:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264836AbUEEWsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 18:48:50 -0400
Received: from lists.us.dell.com ([143.166.224.162]:65246 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S264834AbUEEWss
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 18:48:48 -0400
Date: Wed, 5 May 2004 17:48:47 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: PCI devices with no PCI_CACHE_LINE_SIZE implemented
Message-ID: <20040505224847.GA2283@lists.us.dell.com>
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

Appended for 2.6.6-rc3.  I'll send a 2.4.x patch separately.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

===== drivers/pci/pci.c 1.65 vs edited =====
--- 1.65/drivers/pci/pci.c	Fri Mar 26 10:58:01 2004
+++ edited/drivers/pci/pci.c	Wed May  5 17:39:08 2004
@@ -640,7 +640,7 @@
 	if (cacheline_size == pci_cache_line_size)
 		return 0;
 
-	printk(KERN_WARNING "PCI: cache line size of %d is not supported "
+	printk(KERN_DEBUG "PCI: cache line size of %d is not supported "
 	       "by device %s\n", pci_cache_line_size << 2, pci_name(dev));
 
 	return -EINVAL;
