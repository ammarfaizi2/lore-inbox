Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267711AbTAaG3W>; Fri, 31 Jan 2003 01:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267713AbTAaG3W>; Fri, 31 Jan 2003 01:29:22 -0500
Received: from SMTP6.andrew.cmu.edu ([128.2.10.86]:48522 "EHLO
	smtp6.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id <S267711AbTAaG3T>; Fri, 31 Jan 2003 01:29:19 -0500
Message-ID: <3E3A19E0.5080407@andrew.cmu.edu>
Date: Fri, 31 Jan 2003 01:38:24 -0500
From: Nathaniel Wesley Filardo <nwf@andrew.cmu.edu>
Organization: BentTroll Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030108
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Ison <cisos@bigpond.net.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: Radeon PCI support
References: <3E398BF0.65C32CFE@bigpond.net.au>
In-Reply-To: <3E398BF0.65C32CFE@bigpond.net.au>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2A9A7EFB421C022C3CAE225B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2A9A7EFB421C022C3CAE225B
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Chris Ison wrote:
> I am looking for any information that may help in getting my Radeon PCI
> card working in linux with acceloration.
> 
> I am in the process of trying to obtain information from ATI about the
> chipset but apart from that I haven't been successful in any other way
> except I have determined the card becomes locked and often its FIFO read
> pointer is occassionally at 0 when it has locked (with the FIFO write
> pointer often several kilobytes ahead of it).
> 
> I have had no luck with DRI or XFree86 people as PCI support for Radeons
> on x86 platform isn't a priority at this time.
> 
> The suggestion is that the problem is in the DRM but I can't find
> information confirming that in the lkml at this time.
> 
> If you do have any information/patches that could help for the x86
> platform could you please CC me as I am not on the lkml due to its
> traffic volume.
> 
> I am determined to have this fixed so please help if you can.
> 
> 
> Thank you in advance
> Chris Ison

You have to enable PCIGART in drivers/char/drm/radeon_cp.c:

There should be a block that looks like this, near the top of the file:
#if defined(__alpha__)
# define PCIGART_ENABLED
#else
# undef PCIGART_ENABLED
#endif

Either replace it with, or add below it, "#define PCIGART_ENABLED" without the ""s.  This has worked fine for me, though I do 
not know if it is the technically "right" solution.  There is a leftover quirk that I have not looked into investigating that 
the module "agpgart" will still be loaded and ISTR that the radeon driver still registers itself as an AGP device.  However, 
this is not really a big deal.

Unfortunately, I think you also need to recompile X and I do not remember where in the source tree PCIGART_ENABLED needs to be 
defined - probably in the ati/ driver directory somewhere.  Hope that is enough of a pointer to get you looking in the right place.

--NWF;

--------------enig2A9A7EFB421C022C3CAE225B
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+OhnjR4WVIgmDWjIRAjI1AKCX8i/5mdMwpm0AZTxjKEPezLhEQwCgjs8C
xM/OaWTaCfjbnt0F7eamIgQ=
=TV0t
-----END PGP SIGNATURE-----

--------------enig2A9A7EFB421C022C3CAE225B--

