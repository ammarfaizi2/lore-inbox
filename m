Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287743AbSANRUc>; Mon, 14 Jan 2002 12:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287764AbSANRUN>; Mon, 14 Jan 2002 12:20:13 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:3674 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S287743AbSANRUA> convert rfc822-to-8bit; Mon, 14 Jan 2002 12:20:00 -0500
Date: Mon, 14 Jan 2002 18:20:19 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Ingo Molnar <mingo@elte.hu>, Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020114182019.E22791@athlon.random>
In-Reply-To: <20020114165430.421B01ED55@Cantor.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.3.12i
In-Reply-To: <20020114165430.421B01ED55@Cantor.suse.de>; from Dieter.Nuetzel@hamburg.de on Mon, Jan 14, 2002 at 05:53:15PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 05:53:15PM +0100, Dieter Nützel wrote:
> On Mon, Jan 14, 2002 at 11:39, Andrea Arcangeli wrote:
> > On Sun, Jan 13, 2002 at 01:22:57PM -0500, Robert Love wrote:
> > > Again, preempt seems to reign supreme.  Where is all the information
> >
> > those comparison are totally flawed. There's nothing to compare in
> > there. 
> >
> > minill misses the O(1) scheduler, and -aa has faster vm etc... there's
> > absolutely nothing to compare in the above numbers, all variables
> > changes at the same time.
> >
> > I'm amazed I've to say this, but in short:
> >
> > 1) to compare minill with preempt, apply both patches to 18-pre3, as the
> >    only patch applied (no O(1) in the way of preempt!!!!)
> > 2) to compare -aa with preempt, apply -preempt on top of -aa and see
> >    what difference it makes
> 
> Oh Andrea,
> 
> I know your -aa VM is _GREAT_. I've used it all the time when I have the muse 
> to apply your vm-XX patch "by hand" to the "current" tree.
> If you only get to the point and _send_ the requested patch set to Marcelo...

I need to finish one thing in the next two days, so it won't be before
Thursday probably, sorry.

> 
> All (most) of my preempt Test were running with your -aa VM and I saw the 
> speed up with your VM _AND_ preempt especially for latency (interactivity, 
> system start time and latencytest0.42-png). O(1) gave additional "smoothness"
> 
> What should I run for you?
> 
> Below are the dbench 32 (yes, I know...) numbers for 2.4.18-pre3-VM-22 and 
> 2.4.18-pre3-VM-22-preempt+lock-break.
> Sorry, both with O(1)...
> 
> 2.4.18-pre3
> sched-O1-2.4.17-H7.patch
> 10_vm-22
> 00_nanosleep-5
> bootmem-2.4.17-pre6
> read-latency.patch
> waitq-2.4.17-mainline-1
> plus
> all 2.4.18-pre3.pending ReiserFS stuff
> 
> dbench/dbench> time ./dbench 32
> 32 clients started
> ..............................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................+..........................................................................................................................................................................................................................................................++....................................................................................................++...................................+................................+...+...+........................................+..+......+................+...........++....................++++...++..++.....+...+....+........+...+++++********************************
> Throughput 41.5565 MB/sec (NBQ.9456 MB/sec  415.565 MBit/sec)
> 14.860u 48.320s 1:41.66 62.1%   0+0k 0+0io 938pf+0w
> 
> 
> preempt-kernel-rml-2.4.18-pre3-ingo-2.patch
> lock-break-rml-2.4.18-pre1-1.patch
> 2.4.18-pre3
> sched-O1-2.4.17-H7.patch
> 10_vm-22
> 00_nanosleep-5
> bootmem-2.4.17-pre6
> read-latency.patch
> waitq-2.4.17-mainline-1
> plus
> all 2.4.18-pre3.pending ReiserFS stuff
> 
> dbench/dbench> time ./dbench 32
> 32 clients started
> ..................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................+...................................+.....................................................................+...............................................................................................................................+.....+........................................+........................+............................................................................+...........................................................+..............+...................+........+.......+...............+...............+.....+..................+..+......+...++.........+....+..+...+....+......+.....................................+.+..+.......++********************************
> Throughput 47.0049 MB/sec (NBX.7561 MB/sec  470.049 MBit/sec)
> 14.280u 49.370s 1:30.88 70.0%   0+0k 0+0io 939pf+0w

It would also be nice to see what changes by replacing lock-break and
preempt-kernel with 00_lowlatency-fixes-4. Also you should have a look
at lock-break and port the same breaking point on top of
lowlatency-fixes-4, but just make sure lock-break doesn't introduce the
usual live locks that I keep seeing over the time again and again,
I'_ve_ to reject some of those lowlat stuff because of that, at the very
least one variable on the stack should be used so we keep going at the
second/third/whatever pass, lock-break seems just a big live-lock thing.

Also a pass with only preempt  would be interesting. You should also run
more than one pass for each kernel (I always suggest 3) to be sure there
are no suprious results.

thanks,

Andrea
