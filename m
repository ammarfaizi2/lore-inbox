Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280615AbRKFWEI>; Tue, 6 Nov 2001 17:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280614AbRKFWDt>; Tue, 6 Nov 2001 17:03:49 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:63732
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S280612AbRKFWDm>; Tue, 6 Nov 2001 17:03:42 -0500
Date: Tue, 6 Nov 2001 14:03:35 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Memory accounting problem in 2.4.13, 2.4.14pre, and possibly 2.4.14
Message-ID: <20011106140335.A13678@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am trying to track down a memory accounting problem I've seen ever since I
tried a 2.4.13 based kernel.  Specifically I've noticed an overflow for the
"Cached" entry in /proc/meminfo, but also the numbers don't add up to the
total memory count.  Shouldn't they add up?  If they should, I haven't seen
one that does....

I first noticed it on:
2.4.13freeswan-1.91+ac5+preempt+netdev_random+vm_freeswap
2.4.14-pre6+preempt+netdev_random+ext3_0.9.14-2414p5

I thought it may be preempt so I tried:
2.4.14-pre8+netdev_random-p7+xsched+ext3_0.9.14-2414p8+elevator

But I still get the same problem with "Cached".

Now I'm trying to see if it could be ext3 with:
2.4.14-ext3-2.4-0.9.14-2414p8

And I haven't noticed the problem after 16 hours uptime.  Sometimes it would
show earlier, or later.

>From current (2.4.14-ext3-2.4-0.9.14-2414p8) kernel:
        total:    used:    free:  shared: buffers:  cached:
Mem:  261443584 254337024  7106560        0 58957824 76398592
Swap: 199815168  1228800 198586368
MemTotal:       255316 kB
MemFree:          6940 kB
MemShared:           0 kB
Buffers:         57576 kB
Cached:          73408 kB
SwapCached:       1200 kB
Active:          65048 kB
Inactive:       138040 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       255316 kB
LowFree:          6940 kB
SwapTotal:      195132 kB
SwapFree:       193932 kB

Subtracted from MemTotal should = 0:
MemFree:          6940 kB
Active:          65048 kB
Inactive:       138040 kB
= 45288 kB remaining

Shouldn't these numbers add up to MemTotal?

$ dpkg -l "*gcc*"|grep ii
ii  gcc            2.95.4-8       The GNU C compiler.
ii  gcc-2.95       2.95.4-0.01100 The GNU C compiler.

On Debian Sid.

I can provide more information upon request...

Mike
