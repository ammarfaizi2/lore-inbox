Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267055AbRHBULU>; Thu, 2 Aug 2001 16:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269082AbRHBULL>; Thu, 2 Aug 2001 16:11:11 -0400
Received: from [65.198.37.66] ([65.198.37.66]:41702 "EHLO
	windmill.gghcwest.com") by vger.kernel.org with ESMTP
	id <S267055AbRHBUKz>; Thu, 2 Aug 2001 16:10:55 -0400
Date: Thu, 2 Aug 2001 13:10:26 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@heat.gghcwest.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Ongoing 2.4 VM suckage
In-Reply-To: <Pine.LNX.3.95.1010802154206.6297A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.33.0108021301260.21298-100000@heat.gghcwest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Aug 2001, Richard B. Johnson wrote:

> Seriously, it doesn't do any good to state that something sucks. You
> need to point out the specific problem that you are experiencing.
> "going to la la land.." is not quite technical enough. In fact, you
> imply that the machine is still alive because of "disk thrashing".
> If, in fact, you are a member of the Association for Computing Machinery
> (so am I), you should know all this. Playing Troll doesn't help.
>
> If you suspend (^Z) one of the huge tasks, does the thrashing stop?
> When suspended, do you still have swap-file space?
> Are you sure you have managed the user quotas so that the sum of
> the user's demands for resources can't bring down the machine?

Anyone having observed this mailing list over the last year knows the
problem I'm a talking about.  kswapd can get itself into a state where it
consumes 100% CPU time for hours at a stretch.  During this time, the
machine is unusable.  There is no way to kill or suspend a task because
the shells aren't getting scheduled and they can't accept input.  During
this time, the disks aren't running of course.  Leading up to this, the
disks do run.  Then when kswapd steps in, they stop, or the throughput
falls to a trickle.

Here's a nice trick to pull on any Linux 2.4 box.  Allocate all of the RAM
in the machine and keep it.  Now, thrash the VM by e.g. find / -exec cat
{} \;  Watch what happens.  The kernel will try to grow and grow the disk
cache by swapping your process out to disk.  But, there may not be enough
room for your process and all the cache that the kernel wants, so the
machine goes into this sort of soft-deadlock state where kswapd goes away
for a lunch break.

I'm about the zillionth person to complain about this problem on this
list.  It is completely unacceptable to say that I can't use the memory on
my machines because the kernel is too hungry for cache.  I expect
performance to suffer in a low memory situation.  I expect swapping to be
slow.  I do NOT expect the entire system to stop working for hours on end,
due to some broken algorithm in the VM.

-jwb

