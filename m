Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263611AbTIBIQC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 04:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263622AbTIBIQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 04:16:02 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15122 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263611AbTIBIP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 04:15:58 -0400
Date: Tue, 2 Sep 2003 09:15:53 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: "Paul J.Y. Lahaie" <pjlahaie@steamballoon.com>,
       linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030902091553.A29984@flint.arm.linux.org.uk>
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	"Paul J.Y. Lahaie" <pjlahaie@steamballoon.com>,
	linux-kernel@vger.kernel.org
References: <20030829053510.GA12663@mail.jlokier.co.uk> <1062188787.4062.21.camel@elenuial.steamballoon.com> <20030901091524.A15370@flint.arm.linux.org.uk> <20030901101224.GB1638@mail.jlokier.co.uk> <20030901151710.A22682@flint.arm.linux.org.uk> <20030901165239.GB3556@mail.jlokier.co.uk> <20030901181148.C22682@flint.arm.linux.org.uk> <20030902053415.GA7619@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030902053415.GA7619@mail.jlokier.co.uk>; from jamie@shareable.org on Tue, Sep 02, 2003 at 06:34:15AM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 06:34:15AM +0100, Jamie Lokier wrote:
> Russell King wrote:
> > If you take a moment to think about what should be going on -
> > 
> > - first write gets translated to physical address, and the address with
> >   the data is placed in the write buffer.
> > - second write gets translated to the same physical address, and the
> >   address and data is placed into the write buffer such that we store
> >   the first write then the second write to the same physical memory.
> > - reading from the first mapping should return the second writes value
> >   no matter what.
> 
> That is an incomplete explanation, because it should never be possible
> for reads to access data from the write buffer which isn't the most
> recent.

Umm, that's what I said.

> > ARM doesn't do any of those tricks.
> 
> Don't some of the ARMs executed two instructions concurrently, like
> the original Pentium?

Nope - they're all single issue CPUs, and, if non-buggy, they guarantee
that stores never bypass loads.  (In a later architecture revision, this
is controllable.)

Remember - ARM CPUs aren't a high spec desktop CPU.  They're an embedded
CPU where power consumption matters.  Superscalar/multiple issue/high
performance isn't viable in such many embedded environments.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

