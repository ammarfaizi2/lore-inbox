Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311121AbSEAMH1>; Wed, 1 May 2002 08:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311180AbSEAMH0>; Wed, 1 May 2002 08:07:26 -0400
Received: from web20807.mail.yahoo.com ([216.136.226.196]:47110 "HELO
	web20807.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S311121AbSEAMH0>; Wed, 1 May 2002 08:07:26 -0400
Message-ID: <20020501120725.46310.qmail@web20807.mail.yahoo.com>
Date: Wed, 1 May 2002 05:07:25 -0700 (PDT)
From: Shane Walton <dsrelist@yahoo.com>
Subject: Incorrect Memory Management (Possible Leak)
To: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is the result of a system after sitting
idle for 24+ hours following a reboot.  Initially
after
the reboot, all memory is reported correctly.  After 
sitting idle for more than 24 hours, /proc/meminfo
does not account for memory usage.  This is mostly a
problem when trying to allocate contiguous DMA'able
pages for a device driver.  /proc/meminfo shows:

Total:		255140 Kb
Used:		241620 Kb
Free:		13520 Kb
Shared:		0 Kb
Buffers:	23024 Kb
Cahced:		70192 Kb

Buffers + Cache = 93216 Kb
Buffers + Cache + Free = 106736 Kb (Total Free)

This suggests that an idle system that has not done
a single manual process, (except `free` and `cat`) is
using 148404 Kb.  Any thoughts or explanations are
welcome.  Thanks.

Machine Setup:
OS:	Red Hat 6.2
ARCH:	Dual P3 1 GHz 256MB RAM
Kernel:	2.4.18 SMP

# cat /proc/meminfo

        total:    used:    free:  shared: buffers: 
cached:
Mem:  261263360 235102208 26161152        0 23543808
69218304
Swap: 526376960   716800 525660160
MemTotal:       255140 kB
MemFree:         25548 kB
MemShared:           0 kB
Buffers:         22992 kB
Cached:          67124 kB
SwapCached:        472 kB
Active:          63072 kB
Inactive:        59532 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       255140 kB
LowFree:         25548 kB
SwapTotal:      514040 kB
SwapFree:       513340 kB

# free -t

             total       used       free     shared   
buffers     cached
Mem:        255140     241620      13520          0   
  23024      70192
-/+ buffers/cache:     148404     106736
Swap:       514040        700     513340
Total:      769180     242320     526860



=====
Shane M. Walton, Software Engineer
Digital System Resources, Inc.
dsrelist@yahoo.com : swalton@dsrnet.com
703.234.1674

__________________________________________________
Do You Yahoo!?
Yahoo! Health - your guide to health and wellness
http://health.yahoo.com
