Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131346AbRDJSar>; Tue, 10 Apr 2001 14:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131347AbRDJSa1>; Tue, 10 Apr 2001 14:30:27 -0400
Received: from mail1.cornernet.com ([209.98.65.6]:1802 "EHLO
	mail1.cornernet.com") by vger.kernel.org with ESMTP
	id <S131346AbRDJSaP>; Tue, 10 Apr 2001 14:30:15 -0400
Date: Tue, 10 Apr 2001 13:32:20 -0500 (CDT)
From: Chad Schwartz <cwslist@shell1.cornernet.com>
To: <linux-kernel@vger.kernel.org>
Subject: Need clues on possible brokenness.
Message-ID: <Pine.LNX.4.30.0104101303580.17312-100000@shell1.cornernet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiya, list.

Think i've found a rather nasty bug in the kernel, and I need some clues
as to where to look for the issue.

Stats:

Quad Xeon (PIII core) 700mhz machine (1mb cache on each)
4gb RAM
5x36gb SCSI disks - on a DAC1100 RAID controller
3 EEPro 100 cards

The box functions as a database server that runs at about 40% load on
each CPU, and about 1.5gb memory usage.

Kernel: 2.2.18pre11-va2.0smp (Although completely reproducible on stock
2.2.18)

If dmesg output from kernel - or any other info is required, i'd be more
than happy to provide it.


Problem:

Box appears to stop responding to network requests for 30 seconds at a
time.  it appears to be happening when we get this error:

wait_on_bh, CPU 0:
irq:  0 [0 0]
bh:   1 [0 0]
<[c010bb29]> <[c011d07b]> <[c011d1ed]> <[c0116658]> <[c01099fc]>

it LOOKS like the virtaddr's provided are a call trace, however, I can't
be sure - as SOME of the addresses don't show up as a ksym..

the problem LOOKS to be, from my perspective (And light code reading) -
that the function synchronize_bh() is called SOMEWHERE, and then,
wait_on_bh() is called from that.  It also appears that wait_on_bh() loops
through MAXCOUNT times (100000000 times), and fails - therefore exiting
the function.  (it also appears that the 1 global interrupt that is OPEN
is a TIMER interrupt.)

Can SOMEONE give me a clue as to where to start looking for this problem -
and/or perhaps some input from people who work on this code? (The really
confusing thing about this, is that the wait_for_bh() function should NOT
take 30 seconds to jump through the maximum loop count.)

Thanks in advance,

Chad


