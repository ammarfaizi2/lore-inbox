Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265992AbUBQEXP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 23:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265978AbUBQEXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 23:23:14 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:47277 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265992AbUBQEXC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 23:23:02 -0500
Message-ID: <40319720.3090709@cyberone.com.au>
Date: Tue, 17 Feb 2004 15:22:56 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: bill davidsen <davidsen@tmr.com>
CC: linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>
Subject: Re: [BENCHMARK] 2.6.3-rc2 v 2.6.3-rc3-mm1 kernbench
References: <200402170000.00524.kernel@kolivas.org> <4030C38A.4050909@cyberone.com.au> <200402170130.24070.kernel@kolivas.org> <c0ro1h$48t$1@gatekeeper.tmr.com>
In-Reply-To: <c0ro1h$48t$1@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



bill davidsen wrote:

>In article <200402170130.24070.kernel@kolivas.org>,
>Con Kolivas  <kernel@kolivas.org> wrote:
>| On Tue, 17 Feb 2004 00:20, Nick Piggin wrote:
>
>| >
>| > Thanks Con,
>| > Results look pretty good. The half-load context switches are
>| > increased - that is probably a result of active balancing.
>| > And speaking of active balancing, it is not yet working across
>| > nodes with the configuration you're on.
>| >
>| > To get some idea of our worst case SMT performance (-j8), would
>| > it be possible to do -j8 and -j64 runs with HT turned off?
>| 
>| sure.
>
>Now, I have a problem with the numbers here, either I don't understand
>them (likely) or I don't believe them (also possible).
>| 
>| results.2.6.3-rc3-mm1 + SMT:
>| Average Half Load Run:
>| Elapsed Time 113.008
>| User Time 742.786
>| System Time 90.65
>| Percent CPU 738
>| Context Switches 28062.6
>| Sleeps 24571.8
>
>
>| 2.6.3-rc3-mm1 no SMT:
>| Average Half Load Run:
>| Elapsed Time 133.51
>| User Time 799.268
>| System Time 92.784
>| Percent CPU 669
>| Context Switches 19340.8
>| Sleeps 24427.4
>
>As I look at these numbers, I see that with SMT the real time is lower,
>the system time is higher, and the system time is higher. All what I
>would expect since effectively the system has twice as many CPUs.
>
>But the user time, there I have a problem understanding. User time is
>time in the user program, and I would expect user time to go up, since
>resource contention inside a CPU is likely to mean less work being done
>per unit of time, and therefore if you measure CPU time from the outside
>you need more of it to get the job done.
>
>And what do you get running on one non-SMT CPU for the same mix? When I
>run stuff I usually see the user CPU go up a tad and the e.t. go down a
>little (SMT) or quite a bit (SMP).
>
>I have faith in the reporting of the numbers, but I wonder about the way
>the data were measured. Hopefully someone can clarify, because it looks
>a little like what you would see if you counted "one" for one tick worth
>of user mode time in the CPU, regardless of whether one or two threads
>were executing.
>

Bill, I have CC'ed your message without modification because Con is
not subscribed to the list. Even for people who are subscribed, the
convention on lkml is to reply to all.

Anyway, the "no SMT" run is with CONFIG_SCHED_SMT turned off, P4 HT
is still on. This was my fault because I didn't specify clearly that
I wanted to see a run with hardware HT turned off, although these
numbers are still interesting.

Con hasn't tried HT off AFAIK because we couldn't work out how to
turn it off at boot time! :(

