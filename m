Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291162AbSCDD1N>; Sun, 3 Mar 2002 22:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291169AbSCDD1D>; Sun, 3 Mar 2002 22:27:03 -0500
Received: from dsl-213-023-043-059.arcor-ip.net ([213.23.43.59]:4752 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S291162AbSCDD05>;
	Sun, 3 Mar 2002 22:26:57 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.19pre1aa1
Date: Mon, 4 Mar 2002 04:22:20 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Bill Davidsen <davidsen@tmr.com>, Mike Fedyk <mfedyk@matchmail.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020301013056.GD2711@matchmail.com> <E16hhYV-0000Qz-00@starship.berlin> <20020304032535.F20606@dualathlon.random>
In-Reply-To: <20020304032535.F20606@dualathlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16hj3N-0000SY-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 4, 2002 03:25 am, Andrea Arcangeli wrote:
> On Mon, Mar 04, 2002 at 02:46:22AM +0100, Daniel Phillips wrote:
> > As soon as you have shared pages you start to benefit from rmap's ability
> > to unmap in one step, so the cost of creating the link is recovered by not
> 
> we'd benefit also with unshared pages.
> 
> BTW, for the map shared mappings we just collect the rmap information,
> we need it for vmtruncate, but it's not layed out for efficient
> browsing, it's only meant to make vmtruncate work.

Sorry, transmission error, what did you mean?

> > having to scan two page tables to unmap it.  In theory.  Do you see a hole
> > in that?
> 
> Just the fact you never need the reverse lookup during lots of
> important production usages (first that cames to mind is when you have
> enough ram to do your job, all number crunching/fileserving, and most
> servers are setup that way).  This is the whole point.  Note that this
> has nothing to do with the "cache" part, this is only about the
> pageout/swapout stage, only a few servers really needs heavy swapout.

You always have to unmap the page at some point, so you win back the cost
of creating the pte_chain there, hopefully.  You could argue that paying
the cost up front makes latency a little worse.  You might have trouble
measuring that though.

> ...Another bit in the current design of round robin cycling
> over the whole VM clearing the accessed bitflag and activating physical
> pages if needed, can also be see also as a feature in some ways. It is
> much better at providing a kind of "clock based" aging to the accessed
> bit information, while the lru pass rmap aware, wouldn't really be fair
> with all the virtual pages the same way as we do now.

You get a perfectly good clock by scanning the lru list.  It's not
totally fair because a page newly promoted from the cold end to the hot
end of the list will get scanned again after a much shorter delta-t,
but it's hard to see why that's bad.

-- 
Daniel
