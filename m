Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289220AbSAGOjA>; Mon, 7 Jan 2002 09:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289222AbSAGOiu>; Mon, 7 Jan 2002 09:38:50 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:40006 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289220AbSAGOig>; Mon, 7 Jan 2002 09:38:36 -0500
Date: Mon, 7 Jan 2002 15:37:49 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Davide Libenzi <davidel@xmailserver.org>, Jens Axboe <axboe@suse.de>,
        Matthias Hanisch <mjh@vr-web.de>, Mikael Pettersson <mikpe@csd.uu.se>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.5.2 scheduler code for 2.4.18-pre1 ( was 2.5.2-pre performance degradation on an old 486 )
Message-ID: <20020107153749.D2481@athlon.random>
In-Reply-To: <20020106112129.D8673@suse.de> <Pine.LNX.4.40.0201061554410.933-100000@blue1.dev.mcafeelabs.com> <20020107023854.F1561@athlon.random> <20020107153533.A12242@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20020107153533.A12242@werewolf.able.es>; from jamagallon@able.es on Mon, Jan 07, 2002 at 03:35:33PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2002 at 03:35:33PM +0100, J.A. Magallon wrote:
> 
> On 20020107 Andrea Arcangeli wrote:
> >
> >yes please (feel free to CC me on the answers), I'd really like to
> >reduce the scheduler O(N) overhead to the number of the running tasks,
> >rather than doing the recalculate all over the processes in the machine.
> >O(1) scheduler would be even better of course, but the below would
> >ensure not to hurt the 1 task running case, and it's way simpler to
> >check for correctness (so it's easier to include it as a start).
> >
> 
> It looks like you all are going to turn the scheduler upside-down.
> Hmm, as a non-kernel-hacker observer from the world outside, could I
> make a suggestion ?
> Is it easy to split the thing in steps:
> - Move from single-queue to per-cpu-queue, with just the same algorithm
>   that is running now for per-queue scheduling.

I don't mind about SMP (I don't think SMP scalability of the scheduler
is that bad to require this change in 2.4), I'd only like an UP (or SMP
as well of course) box not to follow a linked list of 2k tasks during a
reschedule if only 1 is running all the time.

> - Get that running for 2.18.18 and 2.5.2
> - Then start to play with the per-queue scheduling algorithm:
> 	* better O(n)
> 	* O(1)
> 	* O(1) with different queues for RT and non RT
> 	etc...
> 
> Is it easy enough or are both steps so related that can not be split ?
> 
> Thanks.
> 
> (a linux user that tries experimental kernels and is seeing them grow
> like mushrooms in latest weeks...)
> 
> -- 
> J.A. Magallon                           #  Let the source be with you...        
> mailto:jamagallon@able.es
> Mandrake Linux release 8.2 (Cooker) for i586
> Linux werewolf 2.4.18-pre1-beo #1 SMP Fri Jan 4 02:25:59 CET 2002 i686


Andrea
