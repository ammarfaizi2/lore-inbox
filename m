Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281907AbRLAWKF>; Sat, 1 Dec 2001 17:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281893AbRLAWJq>; Sat, 1 Dec 2001 17:09:46 -0500
Received: from vortex.physik.uni-konstanz.de ([134.34.143.44]:3082 "EHLO
	vortex.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id <S281896AbRLAWJf>; Sat, 1 Dec 2001 17:09:35 -0500
Message-Id: <200112012209.fB1M92s12294@vortex.physik.uni-konstanz.de>
Content-Type: text/plain; charset=US-ASCII
From: space-00002@vortex.physik.uni-konstanz.de
Organization: Universitaet Konstanz/Germany
To: linux-kernel@vger.kernel.org
Subject: Re: buffer/memory strangeness in 2.4.16 / 2.4.17pre2
Date: Sat, 1 Dec 2001 23:07:19 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <200111291201.fATC1pd04206@lists.us.dell.com> <200111292030.fATKU1s05921@vortex.physik.uni-konstanz.de> <3C075196.613894EA@zip.com.au>
In-Reply-To: <3C075196.613894EA@zip.com.au>
Cc: Andrew Morton <akpm@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is still the same in 2.4.17pre2 :-(

On Friday 30 November 2001 10:29, Andrew Morton wrote:
> space-00002@vortex.physik.uni-konstanz.de wrote:
> > Hi,
> >
> > I am experiencing a bit of strange system behaviour in a vanilla 2.4.16
> > kernel (2.95.3, very stable machine etc.)
> >
> > I noticed, that after running for a while (day) I had significantly less
> > memory available for my simulation program than right after booting.
> > Looking at the problem using 'xosview' (or 'free'), I noticed that there
> > was a large number of MBs filled with 'buffers' that did not get wiped
> > when other programs need the memory. The system seems to rather kill an
> > 'offender' than clean out buffers.
>
> Seconded.   After an updatedb run, my 768 megabyte 2.5.1-pre4 machine
> shows:
>
>              total       used       free     shared    buffers     cached
> Mem:        770668     384460     386208          0     138548      17744
> -/+ buffers/cache:     228168     542500
>
> and, after malloc/memset of 700 megs:
>
>              total       used       free     shared    buffers     cached
> Mem:        770668      73340     697328          0      41160       5960
> -/+ buffers/cache:      26220     744448
> Swap:       499928      18628     481300
>
> I repeated the malloc/memset a few times, wrote a gigabyte file
> and was unable to make the 40 megabytes of buffermem go away.
>
> MemTotal:       770668 kB
> MemFree:        698008 kB
> MemShared:           0 kB
> Buffers:         42092 kB
> Cached:           6088 kB
> SwapCached:       9808 kB
> Active:          48064 kB
> Inactive:        10112 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:       770668 kB
> LowFree:        698008 kB
> SwapTotal:      499928 kB
> SwapFree:       484512 kB
>
> After running an extremely memory-intensive test program for
> two minutes, buffermem fell to 38 megabytes.
>
> Seems broken to me.
