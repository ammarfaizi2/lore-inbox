Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbTFHUDV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 16:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263750AbTFHUDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 16:03:21 -0400
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:53162 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP id S263752AbTFHUDQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 16:03:16 -0400
Message-ID: <20030608201700.3850.qmail@email.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Clayton Weaver" <cgweav@email.com>
To: willy@w.ods.org
Cc: linux-kernel@vger.kernel.org
Date: Sun, 08 Jun 2003 15:17:00 -0500
Subject: Re: Linux 2.4.21-rc7
X-Originating-Ip: 172.162.207.199
X-Originating-Server: ws3-1.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: Willy Tarreau <willy@w.ods.org>
Date: Sun, 8 Jun 2003 11:47:29 +0200
To: Clayton Weaver <cgweav@email.com>
Subject: Re: Linux 2.4.21-rc7

> Hi !

Greets.

> [ first, please fix your mailer and cut your lines, it's not easy to quote you in replies ]

Long lines?

email.com is a web mailer. If it is failing
to wrap where I put newlines, I'll see what I
can do.
 
> On Sun, Jun 08, 2003 at 03:54:48AM -0500, Clayton Weaver wrote:
> > > Now I really hope its the last one, all this
> > > rc's are making me mad.

> > We still have ide problems, and I don't see
any
> > potential fixes for that in the changelog between -rc6 and -rc7.
> > 
> > I tried -rc6 on a whim and had hda report
> > a timeout (dma, I think, but the message went by kind of quick), then the big freeze with the
> > disk light stuck on,  Never happened in 6 months on the same hardware running
> > 2.4.19-rc2 (with glibc-2.2.5, gcc-2.95.3, binutils-2.12.90.0.9, all ext2 filesystems).
 
> Did you try with "ide0=nodma", or other similar options ?

No.

Note that "nodma" is unnecessary on this
same box running kernel 2.4.19-rc2. Why would
2.4.21-rcX need it? To pin down whether the
problem is in the ide dma code or some other
part of the ide code?

> > SiS530/5513, k6-II/450, udma33 Maxtor
drivethat 2.4.19-rc2 has no problems with.

Here is the data on the drive from hdparm
while running under 2.4.19-rc2. rc.local
executes "hdparm -c 1 /dev/hda" at boot.

hdparm -v:

/dev/hda:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 1655/255/63, sectors = 26588016, start = 0

hdparm -i:

/dev/hda:

 Model=Maxtor 91360U4, FwRev=MA540RR0, SerialNo=C40LMAFC
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=26588016
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-4 T13 1153D revision 17:  1 2 3 4 5

> That's not exactly what you said below. You said that you could reliably kill it with 32 threads...
> Perhaps you have a broken hardware, and 2.4.21 stresses it more than 2.4.19-rc2. Perhaps it's
> really an old driver bug, then having reported it since this you encountered it would have been
> more constructive than telling us at 2.4.21 time that it dies even more easily than a one year old
> 2.4.19-rc2.

It does not die more easily with 2.4.19-rc2
(in my opinion). It dies in a threads context
but not in a forks context, where the threads
and the forks are doing the same i/o to/from
the same controller/disk (different versions
of same program).

I have also seen it freeze with an unlucky
mouse click in XFree86 4.0 under 2.4.19-rc2,
so I did not assume that the threads hang
was necessarily ide-relevant. Something
disk i/o intensive was merely what it
happened to be doing with those threads,
but that problem seemed to me more thread
related than ide related. (Guess I'll have
to spawn a bunch of threads doing some other
kind of i/o to test that assumption.)

[]

> > (Better to find out sooner than release
> > 2.4.21-stable and watch 52 different bug reports on it arrive at the list the next day.)
 
> Well, look through the archives, there have been two patches by Lionel Bouton and Vojtech Pavlik
> posted in May for the 5513 driver, to support newer chipsets. I don't know if they have been
> included, nor if they also fixed old bugs. Perhaps you'll be intersted in checking them.

(SiS530 is not newer, k6-II era, but it
is worth a look anyway.)

The SiS5513 driver seems fine. You can
hammer on it all day with this motherboard
with gcc, multiple smb mounts, gigabyte ftp or
sftp transfers, etc, in parallel, and no blinks from the hard drive (modulo threads or the X-server under 2.4.19-rc2).

(Why 2.4.19-rc2? It mostly works, ie it is
stable for what I typically use that box
for. Someone running a different application
mix or different hardware might consider it useless crap. It has the lcall fix and a
few other minor bug fixes that were posted
to the kernel list between then and now.)
 
> BTW, someone reported yesterday that his 5513 worked flawlessly in 2.4.20, but behaved like yours
> on 2.5.70. Have you tested 2.4.20, or better, have you tried to narrow the problem down to a
> particular version (but I bet it will be tied to the introduction of the newer IDE code).

No. (I do actually need this thing to work at
times.) The newer ide code as the source of the
problem matches my hunch. Maybe the kernel
debugging that I enabled at compile time will
come up with something (*before* the
deadlock, so it can actually log an anomaly).

The newer ide code may have found a bug in
the SiS5513 driver that the old code did
not exercise. Let us hope not, because then
a fix only fixes it for me and other users
of that driver, while lots of people with
other kinds of ide hardware seem to be
reporting similar problems.

My guess is that the problems are upstream
of any specific driver, but that is merely
a hunch. (It is possible that they all do
the same wrong thing *in the drivers*.)

> You may also try -ac kernels which have more recent, but less tested code.

> Regards,
> Willy

Thanks for the insight.

Regards,

Clayton Weaver
<mailto: cgweav@email.com>

-- 
_______________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

