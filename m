Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264650AbUE0PBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264650AbUE0PBr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 11:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264625AbUE0PBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 11:01:47 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:405 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264650AbUE0PAb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 11:00:31 -0400
Date: Thu, 27 May 2004 16:59:35 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andi Kleen <ak@muc.de>, "David S. Miller" <davem@redhat.com>,
       mingo@elte.hu, riel@redhat.com, torvalds@osdl.org, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: 4k stacks in 2.6
Message-ID: <20040527145935.GE23194@wohnheim.fh-wedel.de>
References: <1ZQz8-1Yh-15@gated-at.bofh.it> <1ZRFf-2Vt-3@gated-at.bofh.it> <203Zu-4aT-15@gated-at.bofh.it> <206b3-5WN-33@gated-at.bofh.it> <20baw-1Lz-15@gated-at.bofh.it> <m38yff7zn3.fsf@averell.firstfloor.org> <20040527112705.GA21190@wohnheim.fh-wedel.de> <20040527134950.GB3889@dualathlon.random> <20040527141547.GC23194@wohnheim.fh-wedel.de> <20040527144916.GE3889@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040527144916.GE3889@dualathlon.random>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2004 16:49:16 +0200, Andrea Arcangeli wrote:
> On Thu, May 27, 2004 at 04:15:47PM +0200, Jörn Engel wrote:
> > 
> > Would it be possible to add something short to the function preamble
> > on x86 then?  Similar to this code, maybe:
> > 
> > if (!(stack_pointer & 0xe00))	/* less than 512 bytes left */
> > 	*NULL = 1;
> > 
> > Not sure how this can be translated into short and fast x86 assembler,
> > but if it is possible, I would really like to have it.  Then all we
> > have left to do is make sure no function ever uses more than 512
> > bytes.  Famous last words, I know.
> 
> If it would be _inlined_ it would be *much* faster, but it would likely
> be measurable anyways. Less measurable though. There's no way with gcc
> to inline the above in the preamble, one could hack gcc for it though
> (there's exactly an asm preable thing in gcc that is the one that is
> currently implemented as call mcount plus the register saving, chaning
> it to the above may be feasible, though it would need a new option in
> gcc)

It is on my list, although I care more about ppc32.  Can anyone
translate the above into assembler?

> another nice thing to have (this one zerocost at runtime) would be a
> way to set a limit on the size of the local variables for each function.
> gcc knows that value very well, it's the sub it does on the stack
> pointer the first few asm instructions after the call.  That would
> reduce the common mistakes.  An equivalent script is the one from Keith
> Owens checking the vmlinux binary after compilation but I'm afraid
> people runs that one only after the fact.

Plus the script is wrong sometimes.  I have had trouble with sizes
around 4G or 2G, and never found the time to really figure out what's
going on.  Might be an alloca thing that got misparsed somehow.

Having the check in gcc should cause less surprises.

Jörn

-- 
It's not whether you win or lose, it's how you place the blame.
-- unknown
