Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131143AbRCGS3H>; Wed, 7 Mar 2001 13:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131151AbRCGS3A>; Wed, 7 Mar 2001 13:29:00 -0500
Received: from [38.204.212.32] ([38.204.212.32]:8888 "HELO srv2.ecropolis.com")
	by vger.kernel.org with SMTP id <S131143AbRCGS14>;
	Wed, 7 Mar 2001 13:27:56 -0500
Date: Wed, 7 Mar 2001 13:27:15 -0500 (EST)
From: Jeremy Hansen <jeremy@xxedgexx.com>
X-X-Sender: <jeremy@srv2.ecropolis.com>
To: Mike Black <mblack@csihq.com>
cc: Andre Hedrick <andre@linux-ide.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Douglas Gilbert <dougg@torque.net>, <linux-kernel@vger.kernel.org>
Subject: Re: scsi vs ide performance on fsync's  
In-Reply-To: <Pine.LNX.4.33L2.0103061056410.5957-100000@srv2.ecropolis.com>
Message-ID: <Pine.LNX.4.33L2.0103071302140.30803-100000@srv2.ecropolis.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So in the meantime as this gets worked out on a lower level, we've decided
to take the fsync() out of berkeley db for mysql transaction logs and
mount the filesystem -o sync.

Can anyone perhaps tell me why this may be a bad idea?

Thanks
-jeremy



On Tue, 6 Mar 2001, Jeremy Hansen wrote:

>
> Ahh, now we're getting somewhere.
>
> IDE:
>
> jeremy:~# time ./xlog file.out fsync
>
> real    0m33.739s
> user    0m0.010s
> sys     0m0.120s
>
>
> so now this corresponds to the performance we're seeing on SCSI.
>
> So I guess what I'm wondering now is can or should anything be done about
> this on the SCSI side?
>
> Thanks
> -jeremy
>
> On Tue, 6 Mar 2001, Mike Black wrote:
>
> > Write caching is the culprit for the performance diff:
> >
> > On IDE:
> > time xlog /blah.dat fsync
> > 0.000u 0.190s 0:01.72 11.0%     0+0k 0+0io 91pf+0w
> > # hdparm -W 0 /dev/hda
> >
> > /dev/hda:
> >  setting drive write-caching to 0 (off)
> > # time xlog /blah.dat fsync
> > 0.000u 0.220s 0:50.60 0.4%      0+0k 0+0io 91pf+0w
> > # hdparm -W 1 /dev/hda
> >
> > /dev/hda:
> >  setting drive write-caching to 1 (on)
> > # time xlog /blah.dat fsync
> > 0.010u 0.230s 0:01.88 12.7%     0+0k 0+0io 91pf+0w
> >
> > On my SCSI setup:
> > # time xlog /usr5/blah.dat fsync
> > 0.020u 0.230s 0:30.48 0.8%      0+0k 0+0io 91pf+0w
> >
> >
> > ________________________________________
> > Michael D. Black   Principal Engineer
> > mblack@csihq.com  321-676-2923,x203
> > http://www.csihq.com  Computer Science Innovations
> > http://www.csihq.com/~mike  My home page
> > FAX 321-676-2355
> > ----- Original Message -----
> > From: "Andre Hedrick" <andre@linux-ide.org>
> > To: "Linus Torvalds" <torvalds@transmeta.com>
> > Cc: "Douglas Gilbert" <dougg@torque.net>; <linux-kernel@vger.kernel.org>
> > Sent: Tuesday, March 06, 2001 2:12 AM
> > Subject: Re: scsi vs ide performance on fsync's
> >
> >
> > On Mon, 5 Mar 2001, Linus Torvalds wrote:
> >
> > > Well, it's fairly hard for the kernel to do much about that - it's almost
> > > certainly just IDE doing write buffering on the disk itself. No OS
> > > involved.
> >
> > I am pushing for WC to be defaulted in the off state, but as you know I
> > have a bigger fight than caching on my hands...
> >
> > > I don't know if there is any way to turn of a write buffer on an IDE disk.
> >
> > You want a forced set of commands to kill caching at init?
> >
> > Andre Hedrick
> > Linux ATA Development
> > ASL Kernel Development
> > ----------------------------------------------------------------------------
> > -
> > ASL, Inc.                                     Toll free: 1-877-ASL-3535
> > 1757 Houret Court                             Fax: 1-408-941-2071
> > Milpitas, CA 95035                            Web: www.aslab.com
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
>

-- 
this is my sig.

