Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283582AbRK3Jat>; Fri, 30 Nov 2001 04:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283580AbRK3Jaa>; Fri, 30 Nov 2001 04:30:30 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:50699 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S283582AbRK3JaI>; Fri, 30 Nov 2001 04:30:08 -0500
Message-ID: <3C075196.613894EA@zip.com.au>
Date: Fri, 30 Nov 2001 01:29:58 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: space-00002@vortex.physik.uni-konstanz.de
CC: linux-kernel@vger.kernel.org
Subject: Re: buffer/memory strangeness in 2.4.16
In-Reply-To: <200111291201.fATC1pd04206@lists.us.dell.com>,
		<200111291201.fATC1pd04206@lists.us.dell.com> <200111292030.fATKU1s05921@vortex.physik.uni-konstanz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

space-00002@vortex.physik.uni-konstanz.de wrote:
> 
> Hi,
> 
> I am experiencing a bit of strange system behaviour in a vanilla 2.4.16
> kernel (2.95.3, very stable machine etc.)
> 
> I noticed, that after running for a while (day) I had significantly less
> memory available for my simulation program than right after booting. Looking
> at the problem using 'xosview' (or 'free'), I noticed that there was a large
> number of MBs filled with 'buffers' that did not get wiped when other
> programs need the memory. The system seems to rather kill an 'offender' than
> clean out buffers.
> 
>

Seconded.   After an updatedb run, my 768 megabyte 2.5.1-pre4 machine
shows:

             total       used       free     shared    buffers     cached
Mem:        770668     384460     386208          0     138548      17744
-/+ buffers/cache:     228168     542500

and, after malloc/memset of 700 megs:

             total       used       free     shared    buffers     cached
Mem:        770668      73340     697328          0      41160       5960
-/+ buffers/cache:      26220     744448
Swap:       499928      18628     481300

I repeated the malloc/memset a few times, wrote a gigabyte file
and was unable to make the 40 megabytes of buffermem go away.

MemTotal:       770668 kB
MemFree:        698008 kB
MemShared:           0 kB
Buffers:         42092 kB
Cached:           6088 kB
SwapCached:       9808 kB
Active:          48064 kB
Inactive:        10112 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       770668 kB
LowFree:        698008 kB
SwapTotal:      499928 kB
SwapFree:       484512 kB

After running an extremely memory-intensive test program for
two minutes, buffermem fell to 38 megabytes.

Seems broken to me.

-
