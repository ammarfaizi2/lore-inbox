Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278932AbRKMUrz>; Tue, 13 Nov 2001 15:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278927AbRKMUrq>; Tue, 13 Nov 2001 15:47:46 -0500
Received: from postfix1-2.free.fr ([213.228.0.130]:63121 "HELO
	postfix1-2.free.fr") by vger.kernel.org with SMTP
	id <S278924AbRKMUrg> convert rfc822-to-8bit; Tue, 13 Nov 2001 15:47:36 -0500
Date: Tue, 13 Nov 2001 19:02:25 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Cc: Rob Turk <r.turk@chello.nl>, <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: scsi_scan.c: emulate windows behavior
In-Reply-To: <20011113120855.A25014@one-eyed-alien.net>
Message-ID: <20011113185310.T1741-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Matthew,

A so-claimed SCSI device that fails INQUIRY is not a SCSI device. That is
as simple as that. :-)

You didn't look into all the SCSI code that is interested in INQUIRY data.
Some low-level drivers also snoop the INQUIRY data, especially when they
want to cleverly support newer features, as Ultra-160 transfers for
example.

If you really need to use Linux SCSI for your 'almost but not really SCSI
devices', you may for example, either:

- Maintain a patch for your personnal usage,
- Or propose some boot option that will do the trick.

  Gérard.

PS: Indeed, the 255 bytes for the length of INQUIRY data was not that
clever, even if it is absolutely correct.

On Tue, 13 Nov 2001, Matthew Dharm wrote:

> Rob --
>
> This patch doesn't prevent another application from getting more INQUIRY
> bytes.  What it does change is how much data the SCSI scanning loop looks
> for.  That data is requested, and then thrown away.  It's not kept around
> for anything.
>
> If it were kept, I'd agree with you.  But it's not.  Some useful data is
> copied out of the INQUIRY result, and then the buffer is overwritten by the
> next probing request.
>
> I can't see any code in the SCSI scanning section that looks beyond the
> first 36 bytes.
>
> Also, some devices just die if the INQUIRY is anything but 36-bytes.  Since
> all the data beyond the first 36 is considered vendor-specific, I would
> expect a driver to _check_ the first 36 bytes to see if this is an
> apropriate device, and then (and only then) request more data.
>
> Matt
>
> On Tue, Nov 13, 2001 at 08:49:09PM +0100, Rob Turk wrote:
> > "Matthew Dharm" <mdharm-kernel@one-eyed-alien.net> wrote in message
> > news:cistron.20011113102106.A23110@one-eyed-alien.net...
> >
> > >Attached is a one-liner patch to scsi_scan.c, which changes the length of
> > >the INQUIRY data request from 255 bytes to 36 bytes.  This subtle change
> > >makes Linux act more like Win/MacOS and other popular OSes, and reduces
> > >incompatibility with a broad range of out-of-spec devices that will simply
> > >die if asked for more than the required minimum of 36 bytes.
> >
> > >Matt
> >
> > Matt,
> >
> > Many devices have useful information in the bytes beyond 36. Media changers from
> > various vendors are starting to use byte 55 bit 0 to flag if a barcode scanner
> > is present. Other devices have revision levels and/or serial numbers there.
> >
> > Getting more than 36 bytes should not be a problem for any device. The root
> > problem seems to be that 255 is an odd number. On Wide-SCSI, a lot of devices
> > have difficulty handling odd byte counts as they have to use additional
> > messaging to flag the residue in the last 16-bit transfer. Also, the IDE-SCSI
> > layer has trouble, as the IDE spec doesn't allow odd byte transfers at all. I've
> > experienced issues with IDE devices that had to have their firmware patched just
> > to deal with the Linux odd-byte request. Maybe a better change would be to use
> > 64 or 128 byte requests. Your thoughts?
> >
> > Rob
>
> --
> Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.net
> Maintainer, Linux USB Mass Storage Driver
>
> It's not that hard.  No matter what the problem is, tell the customer
> to reinstall Windows.
> 					-- Nurse
> User Friendly, 3/22/1998
>

