Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262026AbUK3I4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbUK3I4u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 03:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbUK3I4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 03:56:50 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:23174 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S262026AbUK3I4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 03:56:47 -0500
To: Andrea Arcangeli <andrea@suse.de>
cc: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>, linux-kernel@vger.kernel.org,
       Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
       Keir.Fraser@cl.cam.ac.uk, "David S. Miller" <davem@redhat.com>,
       William Lee Irwin III <wli@holomorphy.com>, Ian.Pratt@cl.cam.ac.uk
Subject: Re: [4/7] Xen VMM patch set : /dev/mem io_remap_page_range for CONFIG_XEN 
In-reply-to: Your message of "Tue, 30 Nov 2004 04:08:12 +0100."
             <20041130030812.GN4365@dualathlon.random> 
Date: Tue, 30 Nov 2004 08:56:29 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1CZ3oT-0001tU-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Nov 19, 2004 at 11:22:51PM +0000, Ian Pratt wrote:
> > 
> > This patch modifies /dev/mem to call io_remap_page_range rather than
> > remap_pfn_range under CONFIG_XEN.  This is required because in arch
> 
> Why don't we change /dev/mem to use io_remap_page_range unconditionally
> for ranges above high_memory? Clearly io_remap_page_range can map device
> space, and I guess that's what io_remap_page_range is there for. 

In the Xen case, we actually need to use io_remap_page_range for
all /dev/mem accesses, so as to be able to map the BIOS area, DMI
tables etc.

Are people generally happy with the introduction of
ARCH_HAS_DEV_MEM as a way of migrating away from the nest of
#ifdef's in mem.c ?

I wasn't sure how best to handle the fact that /dev/kmem shared
its mmap implementation with /dev/mem.  BTW: Does anyone know of
any programs that make use of mmap'ing /dev/kmem?

Thanks,
Ian
