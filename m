Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283409AbRLZQrU>; Wed, 26 Dec 2001 11:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283876AbRLZQrK>; Wed, 26 Dec 2001 11:47:10 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:1499 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S283409AbRLZQrA>;
	Wed, 26 Dec 2001 11:47:00 -0500
Date: Wed, 26 Dec 2001 11:46:59 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
To: <linux-kernel@vger.kernel.org>
Subject: Re: severe slowdown with 2.4 series w/heavy disk access
In-Reply-To: <3C2855EF.DC7F584F@home.com>
Message-ID: <Pine.LNX.4.30.0112261139400.20982-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Dec 2001, Paul Boley wrote:

> When this happens in X, the mouse drags and skips, any processes running
> (like tar/gzip. ls in an empty dir takes about 10 seconds) slow down,
> and it happens usually for about 10sec-2min, often for no apparent
> reason.  The big decompression was just a way I can easily duplicate
> it.  Oddly enough though, according to top, it caches all that memory at
> once, and my free goes down to 5 megs, with the system hanging/slow to
> respond, for 10sec-2min.  Even typing in the console has delay before
> the characters appear, and according to top, tar and gz are both using
> under 1% cpu while this happens, and about 50% of the cpu is in use by
> the system (not by any processes that I can see.  kupdated goes up to
> about 0.3% during this)
>
> >
> > Also what disks do you have and how are they set up ?
> > -
>
> /dev/hdb3 on / type ext2 (rw)
> /dev/hdb4 on /home type ext2 (rw)
> /dev/hda1 on /dos/c type vfat (rw)
> /dev/hdb1 on /dos/d type vfat (rw)
> none on /dev/pts type devpts (rw,gid=5,mode=620)
> none on /proc type proc (rw)

Are your hard drives configured to use DMA?  I noticed that when using PIO
in linux, you definitely get some user responsiveness problems whenever
you are doing heavy disk IO.  Try turning dma mode on.  man hdparm.
However, if you say you are getting like 10sec-2min lags in
responsiveness.. i somehow doubt that is the true culprit in this case...


Also, are you using NFS and/or NIS?  These things can also really slow
down some apparently low-cost things like running ls and the like.  You
might also have bad sectors on your hard drives.  I know some hard drives
(or is it just the drivers?) internally try to repeat a read or write
request several times before reporting an error.  Sometimes your hard
drives' media are slightly bad and thus exhibit huge slowdowns whenever
they operate on the offending sectors... the drive keeps retrying and then
it succeeds with the only visible symptom being that you waited a really
long time for the request to complete.  During this time, of course, the
whole drive is retarded and cannot be accessed at all by the driver...

These are just some ideas.  Of course, since it's not so likely to be the
kernel, I thought we could rule out other more likely suspects. :)

-Calin


