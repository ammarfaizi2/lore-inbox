Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274557AbRJJD6I>; Tue, 9 Oct 2001 23:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274611AbRJJD56>; Tue, 9 Oct 2001 23:57:58 -0400
Received: from paloma14.e0k.nbg-hannover.de ([62.159.219.14]:17407 "HELO
	paloma14.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S274557AbRJJD5s>; Tue, 9 Oct 2001 23:57:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Andrea Arcangeli <andrea@suse.de>, Robert Love <rml@tech9.net>,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: 2.4.10-ac10-preempt lmbench output.
Date: Wed, 10 Oct 2001 05:57:46 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011010035748Z274557-760+23038@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2001 at 03:06, Andrea Arcangeli wrote:
> On Tue, Oct 09, 2001 at 10:37:56PM -0400, Robert Love wrote:
> > On Tue, 2001-10-09 at 22:30, Andrea Arcangeli wrote:
> > > As said it's very very unlikely that preemption points can fix xmms
> > > skips anyways, the worst scheduler latency is always of the order of the
> > > msecs, to generate skips you need a latency of seconds.

[...]
> The point is that to avoid dropouts dbench must take say 40% of the cpu
> and xmms another 40% of the cpu. Then the 10msec doesn't matter. If each
> one takes 50% of cpu exactly you can run in dropouts anyways because of
> scheduler imprecisions.

I get the dropouts (2~3 sec) after dbench 32 is running for 9~10 seconds.
I've tried with RT artds and nice -20 mpg123.

Kernel: 2.4.11-pre6 + 00_vm-1 + preempt

Only solution:
I have to copy the test MPG3 file into /dev/shm.

CPU (1 GHz Athlon II) is ~75% idle during the hiccup.
The dbench processes are mostly in wait_page/wait_cache if I remember right.
So I think that you are right it is a file IO wait (latency) problem.

Please hurry up with your read/write copy-user paths lowlatency patches ;-)

> So again: the preemptive patch cannot make any difference, except for
> the read/write copy-user paths that originally Ingo fixed ages ago in
> 2.2, and that I also later fixed in all -aa 2.2 and 2.4 and that are
> also fixed in the lowlatency patches from Andrew (but in the
> generic_file_read/write rather than in copy-user, to possible avoid some
> overhead for short copy users, but the end result for an xmms user is
> exactly the same).

Andrew have you a current version of your lowlatency patches handy?

Robert you are running a dual PIII system, right?
Could that be the ground why you aren't see the hiccup with your nice preempt 
patch? Are you running ReiserFS or EXT2/3?

Thanks,
	Dieter

