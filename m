Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277532AbRJVE7n>; Mon, 22 Oct 2001 00:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277545AbRJVE7e>; Mon, 22 Oct 2001 00:59:34 -0400
Received: from mail6.speakeasy.net ([216.254.0.206]:49925 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP
	id <S277532AbRJVE7Z>; Mon, 22 Oct 2001 00:59:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.12-ac3 + e2defrag
Date: Mon, 22 Oct 2001 00:59:58 -0400
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011022045925Z277532-17408+3211@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, i ran e2defrag -p 16384 on a disk thinking, hey, 128MB of buffer isn't 
anything to me since i have 770MB of ram and 128MB of swap.   Well, according 
to top this is e2defrag a quarter of the way running through my 20GB fs.  
  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
12023 root      16   0  125M  76M  9304 R    22.8 10.1   5:50 e2defrag

That seems right.  Yet this is the /proc/meminfo reading 
        total:    used:    free:  shared: buffers:  cached:
Mem:  790016000 783785984  6230016     4096 632762368 20373504
Swap: 133885952 101707776 32178176
MemTotal:       771500 kB
MemFree:          6084 kB
MemShared:           4 kB
Buffers:        617932 kB
Cached:           6176 kB
SwapCached:      13720 kB
Active:         330800 kB
Inact_dirty:    307032 kB
Inact_clean:         0 kB
Inact_target:   157272 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       771500 kB
LowFree:          6084 kB
SwapTotal:      130748 kB
SwapFree:        31424 kB

So where does this 500+MB of buffer come from?  It grinded the system to a 
swapcrazy like state even though it wasn't swapping like crazy.  From the way 
it was acting i was getting scared that it might oom out and kill e2defrag 
even though top seemed to show that the program was only using about 125M. 
The question is, why did the kernel decide 610MB of buffers was necessary ?
