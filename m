Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270657AbRHSRKz>; Sun, 19 Aug 2001 13:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270648AbRHSRKg>; Sun, 19 Aug 2001 13:10:36 -0400
Received: from Expansa.sns.it ([192.167.206.189]:49930 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S270647AbRHSRKZ>;
	Sun, 19 Aug 2001 13:10:25 -0400
Date: Sun, 19 Aug 2001 19:10:35 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Rik van Riel <riel@conectiva.com.br>, Steven Cole <elenstev@mesatop.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: disk I/O slower with kernel 2.4.9
In-Reply-To: <200108190307.f7J373e23205@thor.mesatop.com>
Message-ID: <Pine.LNX.4.33.0108191853010.5840-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I did some test with 2.4.8-ac7 and 2.4.9aa3

make -j 2 bzImage on the athlon 1300 mhz with adaptec 2940 and scsi 3 UW
disks.

2.4.8-ac7
real    3m16.738s
user    1m57.980s
sys     0m8.880s

2.4.9-aa3
real    3m26.948s
user    1m58.180s
sys     0m8.810s

Those compilation have been done on the same sources as before with the
same configuration on the reiserFS partition, but with ext2 results are
quite similar (that is not a simple reiserFS slowdown).

Both are better than vanilla 2.4.9 kernel, but I/O is anyway mutch slower
than with 2.4.7.


I saw that there are big changes in beetwen, VM, updated aic7xxx driver,
reiserFS...

I just made another test starting early this morning.

full kde 2.2 building from source (i prepared a script that untars,
executes configure script with --disable-debug and CXXFLAGS="-O -s", makes
installs, runs ldconfig for every kde package).

with 2.4.7 kernel on the athlon this asked 7 hours and a half,

on another Athlon identical to the first one, i am still waiting to end,
and 10 hours have gone.

On the other side i used 2.4.8-ac8 for a while with kde 2.2 as a desktop,
and i have to admitt that VM is better than with 2.4.9. Expecially memory
gets freed the right time!!!!
And that is very important, but this I/O slowdown really has a big impact
on all my servers. Infact the applications I run do not require
big amount of memory, and all servers are dedicated, (one web server, one
mysql and so on).
On this point of view with 2.4.7 my servers simply are
running better.


bests
Luigi

 On Sat, 18 Aug 2001, Steven Cole wrote:

> On Saturday 18 August 2001 09:19 pm, Luigi Genoni wrote:
> > I still have to try it, tomorrow i will post the results....
> >
> > On Sat, 18 Aug 2001, Rik van Riel wrote:
> > > On Sun, 19 Aug 2001, Luigi Genoni wrote:
> > > > just making time make -j 2 bzImage with kernel source 2.4.9
> > > > gives me:
> > > >
> > > > real    3m36.041s
> > > > user    2m2.950s
> > > > sys     0m9.740s
> > > >
> > > > while compiling the same sources running kernel 2.4.7 gives:
> > > >
> > > > real    2m28.350s
> > > > user    1m56.150s
> > > > sys     0m5.262s
> > >
> > > How does 2.4.8-ac7 do ?
> > >
> > > Rik
>
> Rik, Luigi:
>
> Excuse me for jumping in, but here are a few more data points,
> using a slower system. I built 2.4.8-ac7 with the following kernels, using:
>
> time make -j2 'MAKE = make -j2' bzImage
>
> to produce the output. Yes, I know this is overkill for an UP system.
> This version of time is GNU time 1.7.  Each kernel build was performed
> right after the boot and login, running KDE 2.2 and an xterm.
>
> The system is UP, PIII 450, 384 MB, ATA-33, /usr/src mounted ReiserFS
> on a WDC WD102AA, the rest of the system ReiserFS on a WDC WD136AA.
>
> 2.4.7
> 681.66user 80.16system 13:32.51elapsed 93%CPU (0avgtext+0avgdata
> 0maxresident)k
>
> 2.4.8
> 682.90user 83.25system 13:29.98elapsed 94%CPU (0avgtext+0avgdata
> 0maxresident)k
>
> 2.4.9
> 684.77user 80.55system 13:32.35elapsed 94%CPU (0avgtext+0avgdata
> 0maxresident)k
>
> 2.4.8-ac7
> 683.99user 80.54system 13:21.91elapsed 95%CPU (0avgtext+0avgdata
> 0maxresident)k
>
> Steven
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

