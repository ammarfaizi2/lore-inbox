Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967505AbWK2SQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967505AbWK2SQY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 13:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935996AbWK2SQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 13:16:24 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:32526 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S935979AbWK2SQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 13:16:23 -0500
Date: Wed, 29 Nov 2006 18:16:02 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Mingming Cao <cmm@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
       Mel Gorman <mel@skynet.ie>, "Martin J. Bligh" <mbligh@mbligh.org>,
       linux-kernel@vger.kernel.org,
       "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: Boot failure with ext2 and initrds
Message-ID: <20061129181602.GD23101@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Mingming Cao <cmm@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
	Mel Gorman <mel@skynet.ie>, "Martin J. Bligh" <mbligh@mbligh.org>,
	linux-kernel@vger.kernel.org,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
References: <Pine.LNX.4.64.0611151404260.11929@blonde.wat.veritas.com> <20061115214534.72e6f2e8.akpm@osdl.org> <455C0B6F.7000201@us.ibm.com> <20061115232228.afaf42f2.akpm@osdl.org> <20061116123448.GA28311@flint.arm.linux.org.uk> <20061125145915.GB13089@flint.arm.linux.org.uk> <20061129074000.GA21352@flint.arm.linux.org.uk> <20061129003036.dd27f01e.akpm@osdl.org> <20061129092023.GA23101@flint.arm.linux.org.uk> <20061129013922.053482f9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129013922.053482f9.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2006 at 01:39:22AM -0800, Andrew Morton wrote:
> On Wed, 29 Nov 2006 09:20:24 +0000
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> 
> > What I'm looking for is confirmation of the semantics of
> > find_next_zero_bit()
> 
> What are the existing semantics?  I see no documentation in any of the
> architectures I've looked at.  That's my point.
> 
> >From a quick read of fs/ext2/balloc.c
> 
> 	ext2_find_next_zero_bit(base, size, offset)
> 
> appears to expect that base is the start of the memory buffer, size is the
> number of bits at *base and offset is the bit at which to start the search,
> relative to base.  If a zero bit is found it will return the offset of that
> bit relative to base.  It will return some number greater than `size' if no
> zero-bit was found.  

Thank you for taking the time to agree with my analysis of x86 and
confirm that what ARM implements is also what is expected - that's
all that I was after.  The reason I was after it was because you'd
said in the message I originally replied to:

| yes, the `size' arg to find_next_zero_bit() represents the number of
| bits to scan at `offset'.

which is entirely different from my understanding of what is required of
this function.  Hence the confusion caused and the need to clear up
that confusion.

> Whether that's how all the implementors interpreted it is anyone's guess. 
> Presumably the architectures all do roughly the same thing.

ARM does exactly the same as x86, since x86 was the only architecture
which existed in Linux when it was originally implemented.

> > <extremely frustrated>
> 
> Well likewise.  It appears that nobody (and about 20 people have
> implemented these things) could be bothered getting off ass and
> documenting the pathetic thing.

Back in those days it very much was "read the source, luke" and when
porting the kernel that meant the x86 code.  Consider the lack of
documentation a case of just following the agreed convention at the
time.

We've since now moved on to a more mature attitude towards documentation,
and decided upon a format that it should take.  So yes, it would be nice
if someone would document the entire set of kernel functions which
architectures are expected to provide.  That'll probably be a full time
job for someone though, and probably needs someone to be paid to do it.
Or are the janitor folks up for it?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
