Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271988AbRHVLwl>; Wed, 22 Aug 2001 07:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271989AbRHVLwb>; Wed, 22 Aug 2001 07:52:31 -0400
Received: from ns.ithnet.com ([217.64.64.10]:13839 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S271988AbRHVLwR>;
	Wed, 22 Aug 2001 07:52:17 -0400
Date: Wed, 22 Aug 2001 13:52:07 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Memory Problem in 2.4.9 ?
Message-Id: <20010822135207.4e0250b2.skraw@ithnet.com>
In-Reply-To: <20010821190414Z16086-32384+294@humbolt.nl.linux.org>
In-Reply-To: <20010821154617.4671f85d.skraw@ithnet.com>
	<20010821174918Z16114-32383+718@humbolt.nl.linux.org>
	<20010821201733.40fae5cf.skraw@ithnet.com>
	<20010821190414Z16086-32384+294@humbolt.nl.linux.org>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2001 21:10:44 +0200
Daniel Phillips <phillips@bonn-fries.net> wrote:

> Do you have the same problem on 2.4.8, but not in 2.4.7?

I tested the situation with 2.4.7 (straight, no patches) and it looks like this:

meminfo before:

        total:    used:    free:  shared: buffers:  cached:
Mem:  921735168 88141824 833593344        0  6643712 36012032
Swap: 271392768        0 271392768
MemTotal:       900132 kB
MemFree:        814056 kB
MemShared:           0 kB
Buffers:          6488 kB
Cached:          35168 kB
SwapCached:          0 kB
Active:          34920 kB
Inact_dirty:      6736 kB
Inact_clean:         0 kB
Inact_target:      864 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       900132 kB
LowFree:        814056 kB
SwapTotal:      265032 kB
SwapFree:       265032 kB

meminfo after test:

        total:    used:    free:  shared: buffers:  cached:
Mem:  921735168 917393408  4341760        0 221192192 567046144
Swap: 271392768        0 271392768
MemTotal:       900132 kB
MemFree:          4240 kB
MemShared:           0 kB
Buffers:        216008 kB
Cached:         553756 kB
SwapCached:          0 kB
Active:         107912 kB
Inact_dirty:    658432 kB
Inact_clean:      3420 kB
Inact_target:    11360 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       900132 kB
LowFree:          4240 kB
SwapTotal:      265032 kB
SwapFree:       265032 kB

I can see these:

Aug 22 13:34:53 admin kernel: __alloc_pages: 2-order allocation failed.
Aug 22 13:34:53 admin kernel: __alloc_pages: 3-order allocation failed.
Aug 22 13:34:53 admin last message repeated 21 times

_BUT_ I cannot see any errors during NFS-filecopy. I tried hard, but no errors. Another thing is the CPU load. It is definitely lower than with 2.4.9 around 3 - 3.5, but never 4 or above.
Swap is not used, although turned on.
Besides the above kernel-messages I would say that 2.4.7 performs a lot better (and more stable) than 2.4.9 in this test case.
I think a deep look should be taken into this topic, because it makes 2.4.9 pretty unusable for server-environment. I wonder if anybody can produce (low-memory) errors during normal file-operation on localhost (not NFS like me). I would expect that, for it doesn't look NFS specific. I can make the kernel shoot loads of error messages only by reading CDs while copying in the background from the net. The effect can be seen vice versa, too. So you could say it is clearly a memory management problem, and not related to the allocating process.

Should I try with a plain 2.4.8 ?

Regards, Stephan

