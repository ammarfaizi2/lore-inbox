Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262736AbUKRKkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbUKRKkP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 05:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbUKRKgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 05:36:49 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:13273 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S262731AbUKRK3n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 05:29:43 -0500
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Keir.Fraser@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk
Subject: Re: [patch 1] Xen core patch : ptep_establish_new 
In-Reply-To: Your message of "Thu, 18 Nov 2004 10:26:32 GMT."
             <E1CUjUn-0005KZ-00@mta1.cl.cam.ac.uk> 
Date: Thu, 18 Nov 2004 10:29:29 +0000
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Message-Id: <E1CUjXd-0005Mc-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > On Wed, Nov 17, 2004 at 11:46:50PM +0000, Ian Pratt wrote:
> > > 
> > > This patch adds 'ptep_establish_new', in keeping with the
> > > existing 'ptep_establish', but for use where a mapping is being
> > > established where there was previously none present. This
> > > function is useful (rather than just using set_pte) because
> > > having the virtual address available enables a very important
> > > optimisation for arch-xen. We introduce
> > > HAVE_ARCH_PTEP_ESTABLISH_NEW and define a generic implementation
> > > in asm-generic/pgtable.h, following the pattern of the existing
> > > ptep_establish.
> > 
> > What would be the problem of always passing the virtual address to
> > ptep_establish?  We already have a rather twisted maze of pte manipulation
> > macros.
> 
> ptep_establish already takes a virtual address. Perhaps you mean
> 'set_pte'? That would work, but is a much bigger change that
> would impact all architectures. I think introducing
> ptep_establish_new is cleaner.

Also, we want to know which PTE updates are to a virtual address
within the *current* address space. Just adding a VA to every set_pte
use wouldn't tell us that (without yet another parameter ;-).

 -- Keir
