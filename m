Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTIBL5x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 07:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbTIBL5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 07:57:52 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:26762 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261294AbTIBL5k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 07:57:40 -0400
Date: Tue, 2 Sep 2003 12:57:31 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Paul J.Y. Lahaie" <pjlahaie@steamballoon.com>,
       linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030902115731.GA14354@mail.jlokier.co.uk>
References: <20030829053510.GA12663@mail.jlokier.co.uk> <1062188787.4062.21.camel@elenuial.steamballoon.com> <20030901091524.A15370@flint.arm.linux.org.uk> <20030901101224.GB1638@mail.jlokier.co.uk> <20030901151710.A22682@flint.arm.linux.org.uk> <20030901165239.GB3556@mail.jlokier.co.uk> <20030901181148.C22682@flint.arm.linux.org.uk> <20030902053415.GA7619@mail.jlokier.co.uk> <20030902091553.A29984@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030902091553.A29984@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> > > If you take a moment to think about what should be going on -
> > > 
> > > - first write gets translated to physical address, and the address with
> > >   the data is placed in the write buffer.
> > > - second write gets translated to the same physical address, and the
> > >   address and data is placed into the write buffer such that we store
> > >   the first write then the second write to the same physical memory.
> > > - reading from the first mapping should return the second writes value
> > >   no matter what.
> > 
> > That is an incomplete explanation, because it should never be possible
> > for reads to access data from the write buffer which isn't the most
> > recent.
> 
> Umm, that's what I said.

You say that "reading from the first mapping _should_ return the
second write value no matter what", but that there's a bug in the
write buffer and it isn't doing that.

I'm saying that the bug can't be that, because such a bug would affect
normal applications.

> > Don't some of the ARMs executed two instructions concurrently, like
> > the original Pentium?
> 
> Nope - they're all single issue CPUs, and, if non-buggy, they guarantee
> that stores never bypass loads.  (In a later architecture revision, this
> is controllable.)
>
> Remember - ARM CPUs aren't a high spec desktop CPU.  They're an embedded
> CPU where power consumption matters.  Superscalar/multiple issue/high
> performance isn't viable in such many embedded environments.

Fair enough.  I recall someone mentioning a dual issue ARM once upon a
time, that's all.

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
Russell King wrote:
> > > If you take a moment to think about what should be going on -
> > > 
> > > - first write gets translated to physical address, and the address with
> > >   the data is placed in the write buffer.
> > > - second write gets translated to the same physical address, and the
> > >   address and data is placed into the write buffer such that we store
> > >   the first write then the second write to the same physical memory.
> > > - reading from the first mapping should return the second writes value
> > >   no matter what.
> > 
> > That is an incomplete explanation, because it should never be possible
> > for reads to access data from the write buffer which isn't the most
> > recent.
> 
> Umm, that's what I said.

You say that "reading from the first mapping _should_ return the
second write value no matter what", but that there's a bug in the
write buffer and it isn't doing that.

I'm saying that the bug can't be that, because such a bug would affect
normal applications.

> > Don't some of the ARMs executed two instructions concurrently, like
> > the original Pentium?
> 
> Nope - they're all single issue CPUs, and, if non-buggy, they guarantee
> that stores never bypass loads.  (In a later architecture revision, this
> is controllable.)
>
> Remember - ARM CPUs aren't a high spec desktop CPU.  They're an embedded
> CPU where power consumption matters.  Superscalar/multiple issue/high
> performance isn't viable in such many embedded environments.

Fair enough.  I recall someone mentioning a dual issue ARM once upon a
time, that's all.

-- Jamie
