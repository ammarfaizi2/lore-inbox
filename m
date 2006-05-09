Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWEIWIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWEIWIn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 18:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWEIWIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 18:08:43 -0400
Received: from mga03.intel.com ([143.182.124.21]:38550 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751191AbWEIWIm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 18:08:42 -0400
X-IronPort-AV: i="4.05,107,1146466800"; 
   d="scan'208"; a="33946476:sNHT650684475"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH 2/3] swiotlb: create __alloc_bootmem_low_nopanic and add support in SWIOTLB
Date: Tue, 9 May 2006 15:08:36 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F06704163@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2/3] swiotlb: create __alloc_bootmem_low_nopanic and add support in SWIOTLB
Thread-Index: AcZzr1jK8NykJpdnQWiy3lVoOpLO+QAAhBMA
From: "Luck, Tony" <tony.luck@intel.com>
To: "Jon Mason" <jdmason@us.ibm.com>
Cc: "Muli Ben-Yehuda" <muli@il.ibm.com>, <linux-kernel@vger.kernel.org>,
       <ak@suse.de>, <linux-ia64@vger.kernel.org>, <mulix@mulix.org>
X-OriginalArrivalTime: 09 May 2006 22:08:36.0954 (UTC) FILETIME=[1ECB1BA0:01C673B5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ah, then I better describe it.  The patch makes it possible to recover
> from an insufficient amount of bootmem during swiotlb_init (instead of
> panicing).  For x86_64, I have it bailing out (via the returned int from
> swiotlb_init and using the non-iommu DMA routines from
> arch/x86_64/kernel/pci-nommu.c).  For ia64, its not that simple.
> There are no alternative DMA routines to switch to incase of an error.
> Also, There is no way to "bail-out" from its mem_init.  I could add a
> panic there, if that is more palatable.

Presumably if you have insufficient memory to allocate the swiotlb
buffers, then you actually don't need *any* swiotlb buffers at all
as all your memory is at low enough addresses to be directly accessed
by whatever devices you have (offer void on bizarre discontig systems
that put the only memory they have in an address range that can't be
used by the devices that need to access it ... but perhaps in that
case it would be better to buy a different computer :-)

But ignoring that ... a new "noop" routine that returns an int
does seem to be the right solution.  Looking at the others that
are already there, calling it machvec_noop_dma() isn't a bad fit
with the style of the other "_noop" functions that are already
there.

-Tony
