Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266253AbUBDH27 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 02:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266305AbUBDH27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 02:28:59 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:4480 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S266253AbUBDH25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 02:28:57 -0500
Date: Wed, 4 Feb 2004 07:37:19 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200402040737.i147bJqq000455@81-2-122-30.bradfords.org.uk>
To: Martin Schlemmer <azarah@nosferatu.za.org>, Jens Axboe <axboe@suse.de>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       John Bradford <john@grabjohn.com>,
       Martin =?ISO-8859-1?Q?Povoln=FD?= <xpovolny@aurora.fi.muni.cz>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       alan@redhat.com
In-Reply-To: <1075849526.11322.9.camel@nosferatu.lan>
References: <Pine.LNX.4.53.0402030839380.31203@chaos>
 <401FB78A.5010902@zvala.cz>
 <Pine.LNX.4.53.0402031018170.31411@chaos>
 <200402031602.i13G2NFi002400@81-2-122-30.bradfords.org.uk>
 <yw1xsmhsf882.fsf@kth.se>
 <200402031635.i13GZJ9Q002866@81-2-122-30.bradfords.org.uk>
 <20040203174606.GG3967@aurora.fi.muni.cz>
 <200402031853.i13Ir1e0003202@81-2-122-30.bradfords.org.uk>
 <yw1xn080m1d2.fsf@kth.se>
 <Pine.LNX.4.53.0402031509100.32547@chaos>
 <20040203224021.GK11683@suse.de>
 <1075849526.11322.9.camel@nosferatu.lan>
Subject: Re: 2.6.0, cdrom still showing directories after being erased
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Martin Schlemmer <azarah@nosferatu.za.org>:
> 
> --=-jU1p/KAdUL1ChKMTod+5
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: quoted-printable
> 
> On Wed, 2004-02-04 at 00:40, Jens Axboe wrote:
> > On Tue, Feb 03 2004, Richard B. Johnson wrote:
> > > On Tue, 3 Feb 2004, [iso-8859-1] M=C3=A5ns Rullg=C3=A5rd wrote:
> > >=20
> > > > John Bradford <john@grabjohn.com> writes:
> > > >
> > > > > Regardless of specs, I don't know what the majority of devices in t=
> he
> > > > > real world actually do.  Maybe Jens and Alan, (cc'ed), can help.
> > > >
> > > > Just tested with an ASUS SCB-2408 in my laptop.  It gives read errors
> > > > after doing a fast erase, just like it should.
> > > >
> > > > --
> > > > M=C3=A5ns Rullg=C3=A5rd
> > > > mru@kth.se
> > > > -
> > >=20
> > > I had to borrow a R/W CDROM because most everybody uses CR-R only
> > > here. That's why it took so long to check. With SCSI, Linux 2.4.24,
> > > cdrecord fails to umount the drive before it burns it. The result
> > > is that the previous directory still remains at the mount-point.
> > > This, even though cdrecord ejected the drive to "re-read" its
> > > status.
> > >=20
> > > Bottom line: If the CDROM isn't umounted first, you can still
> > > get a directory entry even though the CDROM has been written with
> > > about 500 magabytes of new data.
> >=20
> > So what? Just because you can do it, doesn't mean it's a valid thing to
> > do. You can literally come up with thousands of similar weird things, if
> > you wanted to.
> >=20
> > This whole discussion is silly and pointless.
> 
> I am assuming its cdrecord's responsibility to check if the device is
> not in use?  How difficult will it be to add a kernel side stopper to
> this (as it will after all also stop this thread) ?

The problem you are discussing now is completely different to what we
were originally discussing, and almost completely pointless.

Of course you get problems if a raw devices changes underneath a
mounted filesystem, I would expect that.  That is _NOT_ what we were
talking about _AT ALL_.  The point is that the device itself caches
the state of the disc over an erase, so even if the device is
unmounted before an erase, when it is re-mounted, the stale data is
read from the device's own cache, which should have been invalidated
by the erase.

John.
