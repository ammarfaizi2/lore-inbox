Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbVJQSVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbVJQSVf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 14:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbVJQSVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 14:21:35 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:27108 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932108AbVJQSVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 14:21:35 -0400
Date: Mon, 17 Oct 2005 11:20:23 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: alex.williamson@hp.com
cc: Ravikiran G Thirumalai <kiran@scalex86.org>, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, tglx@linutronix.de,
       shai@scalex86.org, linville@tuxdriver.com
Subject: Re: x86_64: 2.6.14-rc4 swiotlb broken
In-Reply-To: <20051017175231.GA4959@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0510171110450.1480@schroedinger.engr.sgi.com>
References: <20051017093654.GA7652@localhost.localdomain> <200510171153.56063.ak@suse.de>
 <Pine.LNX.4.64.0510170819290.23590@g5.osdl.org> <200510171740.57614.ak@suse.de>
 <20051017175231.GA4959@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2005, Ravikiran G Thirumalai wrote:

> Maybe someone with access to ia64 NUMA boxen can check if the NODE(0)
> solution works (and does not break anything) on ia64?  Chrisoph, can you help?

Umm... SGI does not use the swiotlb and we do not have these issues. HP 
does use the swiotlb on IA64. CCing John and Alex.

For the newcomers: Thread is at 
http://marc.theaimsgroup.com/?t=112954203900001&r=1&w=2

Proposed patch by Kiran:

Index: linux-2.6.14-rc4/arch/ia64/lib/swiotlb.c
===================================================================
--- linux-2.6.14-rc4.orig/arch/ia64/lib/swiotlb.c	2005-10-14 
00:06:21.000000000 -0700
+++ linux-2.6.14-rc4/arch/ia64/lib/swiotlb.c	2005-10-17 
00:05:22.000000000 -0700
@@ -123,7 +123,7 @@
 	/*
 	 * Get IO TLB memory from the low pages
 	 */
-	io_tlb_start = alloc_bootmem_low_pages(io_tlb_nslabs *
+	io_tlb_start = alloc_bootmem_node(NODE_DATA(0), io_tlb_nslabs *
 					       (1 << IO_TLB_SHIFT));
 	if (!io_tlb_start)
 		panic("Cannot allocate SWIOTLB buffer");



