Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932628AbWCAAFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932628AbWCAAFe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 19:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932727AbWCAAFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 19:05:33 -0500
Received: from dilbert.robsims.com ([209.120.158.98]:49672 "EHLO
	mail.robsims.com") by vger.kernel.org with ESMTP id S932628AbWCAAFd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 19:05:33 -0500
Date: Tue, 28 Feb 2006 17:05:28 -0700
From: Rob Sims <lkml-z@robsims.com>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Sam Vilain <sam@vilain.net>,
       Luke-Jr <luke@dashjr.org>, Jesper Juhl <jesper.juhl@gmail.com>,
       Bernhard Rosenkraenzer <bero@arklinux.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [slightly OT] dvdrecord 0.3.1 -- and yes, dev=/dev/cdrom works ;)
Message-ID: <20060301000528.GD3503@robsims.com>
References: <200602250042.51677.bero@arklinux.org> <200602261330.15709.luke@dashjr.org> <9a8748490602260529h3a2890bhce4112feefb7cb1f@mail.gmail.com> <200602261339.13821.luke@dashjr.org> <Pine.LNX.4.61.0602262331330.12118@yvahk01.tjqt.qr> <Pine.LNX.4.61.0602271946470.13987@yvahk01.tjqt.qr> <44049D5A.1010806@cfl.rr.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wULyF7TL5taEdwHz"
Content-Disposition: inline
In-Reply-To: <44049D5A.1010806@cfl.rr.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wULyF7TL5taEdwHz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 28, 2006 at 01:58:34PM -0500, Phillip Susi wrote:
> Jan Engelhardt wrote:
> >Yes. A 650 MB *CD*-RW (DVD-RW too?) formatted in packet mode only has li=
ke
> >500-something megabytes to allow for the sort of seeks required.
> >On DVD+RW, you get the full 4.3 GB (4.7 gB) AFAICS.
=20
> DVD-RAM physically is formatted like a hard disk.  It is broken up into=
=20
> zones that hold different numbers of sectors which are individually and=
=20
> randomly read/writable.  CD/DVD+-RW media is organized as a single long=
=20
> groove that consists of an unbroken series of large blocks composed of=20
> small blocks with user and control data interleaved and error corrected.=
=20
>  It is for this reason that historically it could only be recorded from=
=20
> start to finish in one pass.

While DVD-RAM has per-sector embossing of headers, the ECC size is
still 16 sectors, so writing any one sector requires a read-modify-write
pass. =20

> There are two modern techniques to allow pseudo random write access for=
=20
> all forms of CD/DVD +/- RW media.  These are packet mode, and mount=20
> rainier mode.  MRW mode formats the disk into 32 KB blocks made up of=20
> 2048 byte sectors which are individually writable as far as the OS=20
> knows, because an MRW compliant drive is required to internally handle=20
> any required read/modify/write cycles to update the 32 KB blocks.  MRW=20
> mode also reserves some of the disk for sector sparing which the drive=20
> firmware also handles.  MRW mode is typically used on dvd+rw media.=20
> IIRC, this format typically "wastes" about 10% of the capacity of the=20
> medium.

DVD+RW and theoretically DVD-RW support writing of 32K chunks randomly
on the disk.  DVD+RW has a tight tolerance on positioning (+/-16 bits)
and DVD-RW about 150 bytes.  Both rely on ECC to correct those bits,
though DVD+RW obviously eats less of the ECC budget.  Neither format
uses a special packet format.  The drives themselves are supposed to do
read-modify-write as required.

> The other technique is packet mode.  Packet mode formats the media into=
=20
> packets of sectors and each packet can be randomly rewritten.  The=20
> current default size is only 32 sectors per packet.  Each packet has 7=20
> sectors of linking loss so around 18% of the disk space is wasted.  I=20
> recently submitted a patch to pktcdvd and have some patches to the=20
> udftools package to support larger packet sizes.  A packet size of 128=20
> sectors reduces the waste to only 5.2%.
=20
Fixed packet writing is only a CD attribute.

Using 128 sector packets will likely break UDF interchangeability, and
likely even some drive firmware.
--=20
Rob

--wULyF7TL5taEdwHz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFEBOVInvKppSZW8osRAgBjAJ4/ib3d91Ko4/WRhscdxtu8u+SHHgCfQley
FUVTKn2c4KRnJxkU4+7dsnQ=
=FamV
-----END PGP SIGNATURE-----

--wULyF7TL5taEdwHz--

