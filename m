Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262306AbSJIWSJ>; Wed, 9 Oct 2002 18:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262301AbSJIWSJ>; Wed, 9 Oct 2002 18:18:09 -0400
Received: from smtp07.iddeo.es ([62.81.186.17]:26046 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id <S262306AbSJIWSH>;
	Wed, 9 Oct 2002 18:18:07 -0400
Date: Thu, 10 Oct 2002 00:23:49 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: More on O_STREAMING (goodby read pauses)
Message-ID: <20021009222349.GA2353@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

I have discovered one other (good) side effect of O_STREAMING.

I tested it on my duap PII@400, ~900Mb RAM.

Timings:

Without O_STREAMING:
  0.00user 10.13system 0:41.16elapsed 24%CPU (0avgtext+0avgdata 0maxresident)k
  0inputs+0outputs (81major+2574minor)pagefaults 0swaps
With O_STREAMING:
  0.00user 11.03system 0:40.06elapsed 27%CPU (0avgtext+0avgdata 0maxresident)k
  0inputs+0outputs (81major+2574minor)pagefaults 0swaps

Memory:

Before
        total:    used:    free:  shared: buffers:  cached:
Mem:  926797824 228376576 698421248        0 20729856 95637504
Swap: 353644544   114688 353529856
MemTotal:       905076 kB
MemFree:        682052 kB
MemShared:           0 kB
Buffers:         20244 kB
Cached:          93284 kB
SwapCached:        112 kB
Active:          77284 kB
Inactive:        97160 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       905076 kB
LowFree:        682052 kB
SwapTotal:      345356 kB
SwapFree:       345244 kB
BigFree:             0 kB

After test without O_STREAMING:
        total:    used:    free:  shared: buffers:  cached:
Mem:  926797824 910376960 16420864        0 13369344 788623360
Swap: 353644544  1077248 352567296
MemTotal:       905076 kB
MemFree:         16036 kB
MemShared:           0 kB
Buffers:         13056 kB
Cached:         769088 kB
SwapCached:       1052 kB
Active:          83672 kB
Inactive:       759388 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       905076 kB
LowFree:         16036 kB
SwapTotal:      345356 kB
SwapFree:       344304 kB
BigFree:             0 kB

After test with O_STREAMING:
        total:    used:    free:  shared: buffers:  cached:
Mem:  926797824 228241408 698556416        0 20647936 95596544
Swap: 353644544   114688 353529856
MemTotal:       905076 kB
MemFree:        682184 kB
MemShared:           0 kB
Buffers:         20164 kB
Cached:          93244 kB
SwapCached:        112 kB
Active:          77200 kB
Inactive:        97112 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       905076 kB
LowFree:        682184 kB
SwapTotal:      345356 kB
SwapFree:       345244 kB
BigFree:             0 kB

But I did the test with an addition: read a 1Gb file and print an '*'
after every 10M. Without O_STREAMING, when memory fills, the 'progress
bar' stalls for a few seconds while pages are sent to disk.
So the patch also favours a constant sustained rate of read from the
disk. Very interesting for things like video edition and so on.
I like it ;).

Thanks.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-pre10-jam1 (gcc 3.2 (Mandrake Linux 9.0 3.2-2mdk))
