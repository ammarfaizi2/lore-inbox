Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270795AbRHYTQe>; Sat, 25 Aug 2001 15:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270600AbRHYTQZ>; Sat, 25 Aug 2001 15:16:25 -0400
Received: from postfix1-2.free.fr ([213.228.0.130]:16905 "HELO
	postfix1-2.free.fr") by vger.kernel.org with SMTP
	id <S270795AbRHYTQI> convert rfc822-to-8bit; Sat, 25 Aug 2001 15:16:08 -0400
Date: Sat, 25 Aug 2001 21:13:37 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <200108251802.f7PI2Oh18565@mailg.telia.com>
Message-ID: <20010825205320.S493-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 25 Aug 2001, Roger Larsson wrote:

> On Saturdayen den 25 August 2001 13:49, Gérard Roudier wrote:
> > On Sat, 25 Aug 2001, Roger Larsson wrote:
>
> > > Where did the seek time go? And rotational latency?
> >
> > They just go away, for the following reasons:
> >
> > - For random IOs, IOs are rather seek time bounded.
> >   Tagged commands may help here.
>
> > - For sequential IOs, the drive is supposed to prefetch data.
> >
>
> Ok, the disk does buffering itself (but it has less memory than . But will it
> do read ahead when
> there is a request to do something else waiting?
> Will it continue to read when it should have moved?
> (Note: lets assume that the disk are never out of requests)
> When it moves. The arm has to move and the platter will rotate to the right
> spot - lets see. You can start reading directly when you are at the right
> track. It can be stuff needed later... (ok, latency can be ignored)
>
> > > This is mine (a IBM Deskstar 75GXP)
> > > Sustained data rate (MB/sec)  37
> > > Seek time  (read typical)
> > >       Average (ms)             8.5
> > >       Track-to-track (ms)      1.2
> > >       Full-track (ms)         15.0
> > > Data buffer                   2 MB
> > > Latency (calculated 7200 RPM) 4.2 ms
> > >
> > > So sustained data rate is 37 MB/s
> > >
> > > > hdparm -t gives around 35 MB/s
> > >
> > > best I got during testing or real files is 32 MB/s
>
> Note: the 32 MB/s is for reading two big file sequentially.
> (first one then the other)
> If I instead do a diff the two files the throughput drops
> 2.4.0 gave around 15 MB/s
> 2.4.7 gave only 11 MB/s
> 2.4.8-pre3 give around 25 MB/s (READA higher than normal)
> 2.4.9-pre2 gives 11 MB/s
> 2.4.9-pre4 gives 12 MB/s
> My patch against 2.4.8-pre1 gives 28 MB/s

I didn't write that your calculation was incorrect. :)

But diffing large files on the same hard disks is not that usual a
pattern. The application (diff) knows of it. So, it should be up to it to
use large buffering per file, instead of relying on guessing from the
kernel.

Just entering 'man diff' shows that no buffer size option seem to be
available with GNU diff. :)

Early UNIXes did 1xIO per FS block. This should have been true for BSD <
4, I think. At this time, FS allocation was based on a free block list and
FS fragmented very quickly. Disk throughput should probably not excess
100KB/second. Despite all that, programmers were certainly happy to diff
source files on those systems. But time has changed... :-)

  Gérard.


