Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266985AbTGVTSW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 15:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267634AbTGVTSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 15:18:22 -0400
Received: from chaos.analogic.com ([204.178.40.224]:29568 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266985AbTGVTSV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 15:18:21 -0400
Date: Tue, 22 Jul 2003 15:34:51 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Timothy Miller <miller@techsource.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ON TOPIC] HELP:  Getting lousy memory throughput from Abit KD7
In-Reply-To: <3F1D8EAB.6020801@techsource.com>
Message-ID: <Pine.LNX.4.53.0307221520290.5609@chaos>
References: <3F1711B5.9020800@techsource.com> <3F1D8EAB.6020801@techsource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jul 2003, Timothy Miller wrote:

> Below is a message I wrote earlier to the list, but I didn't see any
> reply.
>
> Since that time, I installed Windows and ran SiSoft SANDRA to test my
> memory throughput.  The result I got was a little over 2300 MiB/sec,
> which is pretty much what I'd expect.  On the other hand, STREAM shows
> me getting about half that while I'm running Linux.
>
> This suggests to me that there is one of these possibilities which is
> contributing to the poor performance under Linux:
>
> 1) Linux is not programming the KT400 chipset properly and is thus not
> getting the throughput it could.
> 2) SANDRA uses instructions (SSE, etc) which are able to access memory
> more efficiently than whatever STREAM is using.
> 3) SANDRA inflates its scores to make people feel better.
> 4) Linux has not properly set up the CPU caches.
>
>
> Given the speed of the processor and the fact that usually, most memory
> access hits the cache, I would expect the memory bus to be saturated
> during the test.  The KT400 does some amount of read-ahead, and since
> the data can be read out of a cache line much faster than it can be
> loaded into the cache, I wouldn't expect much time delay between when
> one line is read and the next one has a miss.  Is the latency so great?
>   What about the out-of-order execution of the CPU?
>
[SNIPPED...]

First, Linux doesn't muck with the memory controller so whatever
the BIOS has set up, you get when Linux runs. Some programs that
test RAM speed do not use 'Wall clock', i.e., actual, time. They
use some other invention. This makes form comparison problems.

If I needed to really find the memory access time, I would write
a program to test it.

(1) Use getttimeofday() for timing.
(2) Record minimum, maximum, and average times. That tells you a lot.
(3) Disconnect the "!#^@$!@*_$" network when you are running the test.
    The broadcast junk on a typical LAN, especially when there are
    M$ machines on it, will eat up so may CPU cycles, you will think
    you are testing an i386!
(4) Warm the cache first by reading everything in the buffer you
    are going to test.
(5) Use large buffers to minimize loop-count overhead.

Properly perform the math, i.e., do the timing in the milliseconds
you get from gettimeofday(), like:

   double_start_time = (double)tb.tv_usecs + ((double)tb.tv_secs * 1e6);

(you put the casts where they will preserve the values correctly)....

You will probably be amazed at how well your system performs. This
dual CPU 400 MHz thing, with 100 MHz memory does 1,900++ MiB/sec.

Basically trust nobody. Make your own test.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.

