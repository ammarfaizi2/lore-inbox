Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316705AbSGBKsN>; Tue, 2 Jul 2002 06:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316709AbSGBKsM>; Tue, 2 Jul 2002 06:48:12 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:17924 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S316705AbSGBKsL>; Tue, 2 Jul 2002 06:48:11 -0400
Date: Tue, 2 Jul 2002 03:50:36 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: hd_geometry question.
Message-ID: <20020702035036.E28771@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <OF25B15FAC.FE67359D-ONC1256BEA.0032B6AA@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <OF25B15FAC.FE67359D-ONC1256BEA.0032B6AA@de.ibm.com>; from schwidefsky@de.ibm.com on Tue, Jul 02, 2002 at 11:16:06AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2002 at 11:16:06AM +0200, Martin Schwidefsky wrote:
> 
> >About a partition one wants to know start and length.
> >About a full disk one wants to know size, and perhaps a (fake) geometry.
> >
> >The vital partition data cannot depend on obscure hardware info.
> >So, the units used must be well-known. Earlier, everything was in
> >512-byte sectors, but there are a few places where that is inconvenient
> >or unnatural, and now that one has more than 2^32 sectors and 64 bits
> >are needed anyway, things are measured in bytes.
> >
> >That the start field comes with the HDIO_GETGEO ioctl and the size with
> >the BLKGETSIZE ioctl is due to history. Both are given in 512-byte sectors.
> >BLKGETSIZE64 gives bytes.
> 
> Just to make sure I got that right, HDIO_GETGEO delivers a FAKE geometry
> based on the assumption that the sector size is 512 bytes ?

Fake because almost all non-removable disks made in the last
decade have not had a fixed number of sectors per track.  If
the disk accepts positioning based on head,cylinder,sector
it has to be translated by the controller (the circuit board
attached to the drive) into a linear address and then into
the real h,c,s values.

Geometry info is mostly a relic from before zone recording
when filesystems were tuned for geometry and when drives
didn't accept linear addressing.  Andre will probably come
back with a list of drives that still don't accept linear
addresses ;-).

More on this fakeness of geometry belongs offline as it is OT.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
