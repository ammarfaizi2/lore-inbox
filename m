Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161010AbWGZS3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161010AbWGZS3D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 14:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161014AbWGZS3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 14:29:01 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:38082 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161010AbWGZS3A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 14:29:00 -0400
Date: Wed, 26 Jul 2006 11:28:44 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Pekka Enberg <penberg@cs.helsinki.fi>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] slab: always follow arch requested alignments
In-Reply-To: <44C7B352.9020307@colorfullife.com>
Message-ID: <Pine.LNX.4.64.0607261126030.6690@schroedinger.engr.sgi.com>
References: <20060722110601.GA9572@osiris.boeblingen.de.ibm.com> 
 <Pine.LNX.4.58.0607261430520.17986@sbz-30.cs.Helsinki.FI> 
 <Pine.LNX.4.64.0607260433410.3855@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.58.0607261443150.17986@sbz-30.cs.Helsinki.FI> 
 <Pine.LNX.4.58.0607261448520.17986@sbz-30.cs.Helsinki.FI> 
 <Pine.LNX.4.64.0607260451250.4021@schroedinger.engr.sgi.com> 
 <84144f020607260505s17daa5c8j6e5095eb956828ee@mail.gmail.com> 
 <Pine.LNX.4.64.0607260511430.4075@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.58.0607261529240.20519@sbz-30.cs.Helsinki.FI> 
 <Pine.LNX.4.64.0607260823160.5647@schroedinger.engr.sgi.com>
 <84144f020607260843i15247ddai7f447f0d9422fec5@mail.gmail.com>
 <44C7B352.9020307@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2006, Manfred Spraul wrote:

> There are two different types of alignment:
> - SLAB_HWCACHE_ALIGN: it's a recommendation, it's regularly ignored.
> - the align parameter, or ARCH_SLAB_MINALIGN: It's mandatory. For example the
> pgd structures must be 4 kB aligned, it's required by the hardware. And I
> think there was (is?) a structure where ptr & ~(size-1) was used to find the
> start of the structure.

I agree with the above if there is an issue there then lets fix it.

> Thus the patch is correct, it's a bug in the slab allocator. If HWCACHE_ALIGN
> is set, then the allocator ignores align or ARCH_SLAB_MINALIGN.

But then Heiko does not want to set ARCH_SLAB_MINALIGN at all. This is not 
the issue we are discussing. In the DEBUG case he wants 
ARCH_KMALLOC_MINALIGN to be enforced even if ARCH_SLAB_MINALIGN is not 
set.
