Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290818AbSCDByg>; Sun, 3 Mar 2002 20:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290827AbSCDByZ>; Sun, 3 Mar 2002 20:54:25 -0500
Received: from dsl-213-023-043-059.arcor-ip.net ([213.23.43.59]:16015 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S290818AbSCDByP>;
	Sun, 3 Mar 2002 20:54:15 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.19pre1aa1
Date: Mon, 4 Mar 2002 02:46:22 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Bill Davidsen <davidsen@tmr.com>, Mike Fedyk <mfedyk@matchmail.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020301013056.GD2711@matchmail.com> <E16hdgg-0000Py-00@starship.berlin> <20020304014950.E20606@dualathlon.random>
In-Reply-To: <20020304014950.E20606@dualathlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16hhYV-0000Qz-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 4, 2002 01:49 am, Andrea Arcangeli wrote:
> On Sun, Mar 03, 2002 at 10:38:34PM +0100, Daniel Phillips wrote:
> > On March 2, 2002 03:06 am, Andrea Arcangeli wrote:
> > > On Thu, Feb 28, 2002 at 10:26:48PM -0500, Bill Davidsen wrote:
> > > > rather than patches. But there are a lot more small machines (which I feel
> > > > are better served by rmap) than large. I would like to leave the jury out
> > > 
> > > I think there's quite some confusion going on from the rmap users, let's
> > > clarify the facts.
> > > 
> > > The rmap design in the VM is all about decreasing the complexity of
> > > swap_out on the huge boxes (so it's all about saving CPU), by slowing
> > > down a big lots of fast common paths like page faults and by paying with
> > > some memory too. See the lmbench numbers posted by Randy after applying
> > > rmap to see what I mean.
> > 
> > Do you know any reason why rmap must slow down the page fault fast, or are
> > you just thinking about Rik's current implementation?  Yes, rmap has to add
> > a pte_chain entry there, but it can be a direct pointer in the unshared case
> > and the spinlock looks like it can be avoided in the common case as well.
> 
> unshared isn't the very common case (shm, and file mappings like
> executables are all going to be shared, not unshared).

As soon as you have shared pages you start to benefit from rmap's ability
to unmap in one step, so the cost of creating the link is recovered by not
having to scan two page tables to unmap it.  In theory.  Do you see a hole
in that?
 
> So unless you first share all the pagetables as well (like Ben once said
> years ago), it's not going to be a direct pointer in the very common
> case. And there's no guarantee you can share the pagetable (even
> assuming the kernels supports that at the maximum possible degree across
> execve and at random mmaps too) if you map those pages at different
> virtual addresses.

The virtual alignment just needs to be the same modulo 4 MB.  There are
other requirements as well, but being able to share seems to be the common
case.

-- 
Daniel
