Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267164AbSLaG3I>; Tue, 31 Dec 2002 01:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267165AbSLaG3I>; Tue, 31 Dec 2002 01:29:08 -0500
Received: from packet.digeo.com ([12.110.80.53]:406 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267164AbSLaG3H>;
	Tue, 31 Dec 2002 01:29:07 -0500
Message-ID: <3E113B25.534BEBE4@digeo.com>
Date: Mon, 30 Dec 2002 22:37:25 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] vm swappiness with contest
References: <200212271646.01487.conman@kolivas.net> <200212311658.53118.conman@kolivas.net> <3E11347B.2C8195D1@digeo.com> <200212311724.05416.conman@kolivas.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Dec 2002 06:37:26.0270 (UTC) FILETIME=[153D89E0:01C2B097]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> 
> On Tuesday 31 Dec 2002 5:08 pm, Andrew Morton wrote:
> > Con Kolivas wrote:
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA1
> > >
> > > On Saturday 28 Dec 2002 5:16 pm, Con Kolivas wrote:
> > > > Is there something about the filesystem layer or elsewhere in the
> > > > kernel that could decay or fragment over time that only a reboot can
> > > > fix? This would seem to be a bad thing.
> > >
> > > Ok Linus suggested I check slabinfo before and after.
> > >
> > > I ran contest for a few days till I recreated the problem and it did
> > > recur. I don't know how to interpret the information so I'll just dump it
> > > here:
> >
> > Looks OK.  Could we see /proc/meminfo and /proc/vmstat?
> 
> meminfo:
> MemTotal:       257296 kB
> MemFree:         47468 kB
> Buffers:         27028 kB
> Cached:           7480 kB
> SwapCached:        272 kB
> Active:         154968 kB
> Inactive:        42756 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:       257296 kB
> LowFree:         47468 kB
> SwapTotal:     4194272 kB
> SwapFree:      4193816 kB
> Dirty:            1116 kB
> Writeback:           0 kB
> Mapped:           3740 kB
> Slab:             8564 kB
> Committed_AS:     6580 kB
> PageTables:        196 kB
> ReverseMaps:      1381
> 

These numbers _look_ wrong, but ext3 truncate does funny things.
Could you now run a big usemem/fillmem application to try to allocate and
use 200 megs of memory, then resend /proc/meminfo?
