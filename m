Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbULPOJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbULPOJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 09:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262660AbULPOJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 09:09:58 -0500
Received: from mail.suse.de ([195.135.220.2]:58272 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261932AbULPOJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 09:09:55 -0500
Date: Thu, 16 Dec 2004 15:09:54 +0100
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, Ian Pratt <Ian.Pratt@cl.cam.ac.uk>,
       Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
       Keir.Fraser@cl.cam.ac.uk
Subject: Re: arch/xen is a bad idea
Message-ID: <20041216140954.GA29761@wotan.suse.de>
References: <p73acsg1za1.fsf@bragg.suse.de> <E1CeLLB-0000Sl-00@mta1.cl.cam.ac.uk> <20041215044927.GF27225@wotan.suse.de> <1103155782.3585.29.camel@localhost.localdomain> <20041216040136.GA30555@wotan.suse.de> <1103201656.3804.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103201656.3804.7.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 12:54:17PM +0000, Alan Cox wrote:
> On Iau, 2004-12-16 at 04:01, Andi Kleen wrote:
> > That is exactly the part that is wrong currently imho. The arch/xen
> > interface is a mess and in its current form unlikely to be maintainable.
> 
> It seems maintainable and well documented to me. I just don't see where
> your problem is with this. The kernel/hypervisor interface is clear, and
> the arch/xen code seems quite sane.

The main problem I see is that it is source code copy, and especially 
when they both support i386 and x86-64 there will be no sane
way to keep it all synchronized with the i386 and x86-64 
code bases. It's already hard from a single source like I can
attest from x86-64, with two sources it will be likely much more
difficult longer term. I just can't see it working well in
practice. It will be also nasty for people doing changes
because they will need to duplicate i386+x86_64 changes four 
times in the worst case (i386,x86_64,xen32,xen64) 

I guess it may be acceptable if we were maintaining obscure Lance 
drivers this way ;_), but for a important architecture it just doesn't seem
like the right approach to me. 

Also e.g. for non performance critical 
things like changing MTRRs or debug registers it would be IMHO much 
cleaner to just emulate the instructions (the ISA is very well 
defined) and not change the kernel here.  From a look at Ian's list
the majority of the changes needed for Xen actually fall into
this category. 

I suspect when the kernel is only changed for the truly performance 
critical interfaces that cannot be efficiently emulated (like idle/timers/page 
table updates) the required changes for the para virtualization will become 
much more manageable and can be cleanly integrated into the respective ports.

And as Pavel points out first merging arch/xen and then migrating
into i386 and x86_64 like it was proposed sounds extremly hard and is 
probably not really practical. 

-Andi

