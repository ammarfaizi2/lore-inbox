Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262413AbUK3XOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbUK3XOR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 18:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262405AbUK3XLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 18:11:42 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:36588 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S262433AbUK3XF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 18:05:57 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
       Keir.Fraser@cl.cam.ac.uk, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@redhat.com>, Ian.Pratt@cl.cam.ac.uk
Subject: Re: [1/7] Xen VMM #3: add ptep_establish_new to make va available 
In-reply-to: Your message of "Wed, 01 Dec 2004 09:49:51 +1100."
             <1101854992.5174.14.camel@gaston> 
Date: Tue, 30 Nov 2004 23:05:45 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1CZH45-0000Gk-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 2004-11-30 at 02:06 +0000, Ian Pratt wrote:
> > This patch adds 'ptep_establish_new', in keeping with the
> > existing 'ptep_establish', but for use where a mapping is being
> > established where there was previously none present. This
> > function is useful (rather than just using set_pte) because
> > having the virtual address available enables a very important
> > optimisation for arch-xen. We introduce
> > HAVE_ARCH_PTEP_ESTABLISH_NEW and define a generic implementation
> > in asm-generic/pgtable.h, following the pattern of the existing
> > ptep_establish.
> 
> I would rather move toward that patch that David Miller proposed a while
> ago that makes sure the necessary infos (mm, address, ...) are always
> passed to all PTE functions.

I'd appreciate a pointer to the patch. 

It may still be of some use to distinguish between call sites
where it is likely that mm == current->mm to avoid adding a
futile test in all the others.
 
> Is there also a need for ptep_establish and ptep_establish_new to be 2
> different functions ?

They allow different TLB invalidation behaviour. I guess it could
be one function with an extra arg.

Ian
