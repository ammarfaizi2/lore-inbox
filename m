Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289307AbSCDAwu>; Sun, 3 Mar 2002 19:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289348AbSCDAwj>; Sun, 3 Mar 2002 19:52:39 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:6176 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289307AbSCDAwa>; Sun, 3 Mar 2002 19:52:30 -0500
Date: Mon, 4 Mar 2002 01:49:50 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Bill Davidsen <davidsen@tmr.com>, Mike Fedyk <mfedyk@matchmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
Message-ID: <20020304014950.E20606@dualathlon.random>
In-Reply-To: <20020301013056.GD2711@matchmail.com> <Pine.LNX.3.96.1020228221750.3310D-100000@gatekeeper.tmr.com> <20020302030615.G4431@inspiron.random> <E16hdgg-0000Py-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16hdgg-0000Py-00@starship.berlin>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 03, 2002 at 10:38:34PM +0100, Daniel Phillips wrote:
> On March 2, 2002 03:06 am, Andrea Arcangeli wrote:
> > On Thu, Feb 28, 2002 at 10:26:48PM -0500, Bill Davidsen wrote:
> > > rather than patches. But there are a lot more small machines (which I feel
> > > are better served by rmap) than large. I would like to leave the jury out
> > 
> > I think there's quite some confusion going on from the rmap users, let's
> > clarify the facts.
> > 
> > The rmap design in the VM is all about decreasing the complexity of
> > swap_out on the huge boxes (so it's all about saving CPU), by slowing
> > down a big lots of fast common paths like page faults and by paying with
> > some memory too. See the lmbench numbers posted by Randy after applying
> > rmap to see what I mean.
> 
> Do you know any reason why rmap must slow down the page fault fast, or are
> you just thinking about Rik's current implementation?  Yes, rmap has to add
> a pte_chain entry there, but it can be a direct pointer in the unshared case
> and the spinlock looks like it can be avoided in the common case as well.

unshared isn't the very common case (shm, and file mappings like
executables are all going to be shared, not unshared).

So unless you first share all the pagetables as well (like Ben once said
years ago), it's not going to be a direct pointer in the very common
case. And there's no guarantee you can share the pagetable (even
assuming the kernels supports that at the maximum possible degree across
execve and at random mmaps too) if you map those pages at different
virtual addresses.

Andrea
