Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262687AbULPOce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbULPOce (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 09:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262678AbULPOam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 09:30:42 -0500
Received: from cantor.suse.de ([195.135.220.2]:23475 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262670AbULPO22 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 09:28:28 -0500
Date: Thu, 16 Dec 2004 15:28:24 +0100
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, Ian Pratt <Ian.Pratt@cl.cam.ac.uk>,
       Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
       Keir.Fraser@cl.cam.ac.uk
Subject: Re: arch/xen is a bad idea
Message-ID: <20041216142824.GC29761@wotan.suse.de>
References: <p73acsg1za1.fsf@bragg.suse.de> <E1CeLLB-0000Sl-00@mta1.cl.cam.ac.uk> <20041215044927.GF27225@wotan.suse.de> <1103155782.3585.29.camel@localhost.localdomain> <20041216040136.GA30555@wotan.suse.de> <1103201656.3804.7.camel@localhost.localdomain> <20041216140954.GA29761@wotan.suse.de> <1103203145.3804.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103203145.3804.13.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 01:19:06PM +0000, Alan Cox wrote:
> On Iau, 2004-12-16 at 14:09, Andi Kleen wrote:
> > Also e.g. for non performance critical 
> > things like changing MTRRs or debug registers it would be IMHO much 
> > cleaner to just emulate the instructions (the ISA is very well 
> > defined) and not change the kernel here.  From a look at Ian's list
> > the majority of the changes needed for Xen actually fall into
> > this category. 
> 
> There are so many problems in snooping and decoding instructions it
> isn't funny. Aside from the mmap pci buffer half way through instruction

Hmm? From what I remember reading the code of the Xen hypervisor
they are already emulating a lot of instructions (e.g. take a look
at xen/arch/x86/x86_32/seg_fixup.c) Emulating some more doesn't 
seem like a big issue to me.

> that will emulate type stuff there are a lot of awkward issues if you
> want to emulate multiple mtrr sets (you need PAT).

No way different from doing it with a magic interface. MTRR is exposed
to kernel subsystems (a lot of things in the service OS will want to
play with it) and to user space (with also a lot of users). The magic
interface will need to provide a full MTRR interface anyways.  The 
only difference would be basically how you tell the hypervisor to
change them.

[Not saying that PAT is actually needed for this, but as a general 
comment:]
Also using PAT for that would be definitely a good idea, MTRRs just
have so many problems that any step away from them is a good thing.


-Andi
