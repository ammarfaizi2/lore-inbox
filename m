Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310514AbSBRM1k>; Mon, 18 Feb 2002 07:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310515AbSBRM1a>; Mon, 18 Feb 2002 07:27:30 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:40214 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S310514AbSBRM1P>; Mon, 18 Feb 2002 07:27:15 -0500
Date: Mon, 18 Feb 2002 13:27:57 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel@vger.kernel.org, rsf@us.ibm.com
Subject: Re: [TEST] page tables filling non-highmem
Message-ID: <20020218132757.K7940@athlon.random>
In-Reply-To: <20020215045106.GB26322@holomorphy.com> <E16beDZ-0002jy-00@starship.berlin> <20020218023800.A23743@athlon.random> <20020218032644.GD3511@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020218032644.GD3511@holomorphy.com>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2002 at 07:26:44PM -0800, William Lee Irwin III wrote:
> On Mon, Feb 18, 2002 at 02:38:00AM +0100, Andrea Arcangeli wrote:
> > My tree doesn't lock up hard even without pte-highmem applied.  The task
> > gets killed. backout pte-highmem, try the same testcase again on my tree
> > and you'll see. The oom handling in mainline is deadlock prone, I always
> > known this and that's why I always rejected it. Nobody but me
> > acklowledged this problem and I spent quite an amount of time convincing
> > mainline maintainers about those deadlock flaws of the mainline approch
> > but I failed so I giveup waiting for a report like this, just like with
> > all the other stuff that is now in my vm patch, 90% of it I tried to
> > push it separately into mainline before having to accumulate it.
> 
> This is a basic issue. Does the kernel run or does it crash?

It keeps running, there's no way to stop it. Go ahead and try it. I tell
you I'm sure because when I wrote pte-highmem, before realizing the
problem with the pagetables, people was very happy with my tree because
it was the first one not deadlocking, but instead oom killing one of those
pagetable hogs. Now thanks to pte-highmem all their problems are gone
and they have no limit any longer (other than cpu resources).

> Mainline can't live without it. Nothing can.

Agreed, this is why I fighted with Linus and Marcelo trying to convince
them not to reintroduce the loop crap into the allocator that leads to
all sort of oom deadlocks because we lack the knowledge on the amount of
freeable pages (I even re-read the emails about such stuff in the thread
"VM tweaks" to be sure I was remembering right). OTOH, I really cannot
complain, they included so much stuff from my tree that even if we
disagreed on something at the end I don't mind :).  And this is probably
also why I don't like very much to restart those threads about oom
deadlocks, I know my way is the only right way (i.e. non deadlock prone)
possible, and I live with it just fine.

The only way we can learn if a page or a mapping is freeable or not, is
by trying to free it and by checking if we failed or not. We cannot know
in another manner, only checking the size of the caches or the amount of
the swap still unused is totally meaningless and broken. That's
unfortunate but that's how all linux kernels I know of works, and what I
did in my tree at the moment is the only possible way to avoid deadlocks
without having to do a major rework on the accounting side.

Andrea
