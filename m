Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVG1L54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVG1L54 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 07:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbVG1L54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 07:57:56 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:63930 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S261280AbVG1L5z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 07:57:55 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [openib-general] Re: [PATCH] arch/xx/pci: remap_pfn_range -> io_remap_pfn_range
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Thu, 28 Jul 2005 12:57:51 +0100
Message-ID: <A95E2296287EAD4EB592B5DEEFCE0E9D282808@liverpoolst.ad.cl.cam.ac.uk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [openib-general] Re: [PATCH] arch/xx/pci: remap_pfn_range -> io_remap_pfn_range
Thread-Index: AcWTMDewY2dTu7otSUWTtO3ohLzguwAOtd3Q
From: "Ian Pratt" <m+Ian.Pratt@cl.cam.ac.uk>
To: "Greg KH" <gregkh@suse.de>, "Roland Dreier" <rolandd@cisco.com>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
       <linux-pci@atrey.karlin.mff.cuni.cz>, <openib-general@openib.org>,
       <linux-kernel@vger.kernel.org>, <mj@ucw.cz>, <ian.pratt@cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >     Greg> Hm, you do realize that io_remap_pfn_range() is the same
> >     Greg> thing as remap_pfn_range() on i386, right?
> > 
> >     Greg> So, why would this patch change anything?
> > 
> > It's not the same thing under Xen.  I think this patch 
> fixes userspace 
> > access to PCI memory for XenLinux.
> 
> But Xen is a separate arch, and hence, will get different pci 
> arch specific functions, right?
> 
> In short, what is this patch trying to fix?  What is the 
> problem anyone is seeing with the existing code?

As I understand it, remap_pfn_range should be used for mapping pages
that are backed by memory, and io_remap_pfn_range should be used for
mapping MMIO regions.
There's a distinciton between the two for architectures like Sparc and
xen/x86. 

For example, drivers/char/mem.c uses io_remap_pfn_range for mmap'ing
/dev/mem

Ian
