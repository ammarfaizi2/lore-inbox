Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277541AbRJVFXf>; Mon, 22 Oct 2001 01:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277551AbRJVFXZ>; Mon, 22 Oct 2001 01:23:25 -0400
Received: from ns1.uklinux.net ([212.1.130.11]:30726 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S277541AbRJVFXF>;
	Mon, 22 Oct 2001 01:23:05 -0400
Envelope-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Message-Id: <a05100301b7f95ccaa13e@[192.168.239.101]>
In-Reply-To: <20011022045925Z277532-17408+3211@vger.kernel.org>
In-Reply-To: <20011022045925Z277532-17408+3211@vger.kernel.org>
Date: Mon, 22 Oct 2001 06:22:28 +0100
To: safemode <safemode@speakeasy.net>, linux-kernel@vger.kernel.org
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: 2.4.12-ac3 + e2defrag
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>OK, i ran e2defrag -p 16384 on a disk thinking, hey, 128MB of buffer isn't
>anything to me since i have 770MB of ram and 128MB of swap.   Well, according
>to top this is e2defrag a quarter of the way running through my 20GB fs. 
>   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
>12023 root      16   0  125M  76M  9304 R    22.8 10.1   5:50 e2defrag
>
>That seems right.  Yet this is the /proc/meminfo reading
>         total:    used:    free:  shared: buffers:  cached:
>Mem:  790016000 783785984  6230016     4096 632762368 20373504
>Swap: 133885952 101707776 32178176
>MemTotal:       771500 kB
>MemFree:          6084 kB
>MemShared:           4 kB
>Buffers:        617932 kB
>Cached:           6176 kB
>SwapCached:      13720 kB
>Active:         330800 kB
>Inact_dirty:    307032 kB
>Inact_clean:         0 kB
>Inact_target:   157272 kB
>HighTotal:           0 kB
>HighFree:            0 kB
>LowTotal:       771500 kB
>LowFree:          6084 kB
>SwapTotal:      130748 kB
>SwapFree:        31424 kB
>
>So where does this 500+MB of buffer come from?  It grinded the system to a
>swapcrazy like state even though it wasn't swapping like crazy.  From the way
>it was acting i was getting scared that it might oom out and kill e2defrag
>even though top seemed to show that the program was only using about 125M.
>The question is, why did the kernel decide 610MB of buffers was necessary ?

The 128Mb of "buffers" is within e2defrag itself.  The kernel, seeing 
a HUGE amount of disk activity, allocates as much RAM as possible to 
aid the cause - this also means it evicts unused applications to 
swap.  This is *perfectly normal*.  Your machine is not pageing 
heavily, so overall it's a win.  Once you start using those apps 
again, they'll come straight back into memory where and when you want 
them.

Come to that, this is the first time I've heard of e2defrag.  I'm 
gonna take a look.  :)

-- 
--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
website:  http://www.chromatix.uklinux.net/vnc/
geekcode: GCS$/E dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$
           V? PS PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
tagline:  The key to knowledge is not to rely on people to teach you it.
