Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbULBVzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbULBVzZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 16:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbULBVx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 16:53:57 -0500
Received: from ctb-mesg6.saix.net ([196.25.240.78]:16291 "EHLO
	ctb-mesg6.saix.net") by vger.kernel.org with ESMTP id S261782AbULBVub
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 16:50:31 -0500
Subject: Re: cdrecord dev=ATA cannont scanbus as non-root [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: astralstorm@gorzow.mm.pl
Cc: Jens Axboe <axboe@suse.de>, "J.A. Magallon" <jamagallon@able.es>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200412021723.48883.astralstorm@gorzow.mm.pl>
References: <1101763996l.13519l.0l@werewolf.able.es>
	 <20041130071638.GC10450@suse.de> <1101935773.11949.86.camel@nosferatu.lan>
	 <200412021723.48883.astralstorm@gorzow.mm.pl>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-t2YqRL8dkwnjiaxDyNjt"
Date: Thu, 02 Dec 2004 23:50:52 +0200
Message-Id: <1102024252.11949.89.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-t2YqRL8dkwnjiaxDyNjt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-12-02 at 17:23 +0100, Radoslaw Szkodzinski wrote:
> On Wednesday 01 of December 2004 22:16, Martin Schlemmer [c] wrote:
> > On Tue, 2004-11-30 at 08:16 +0100, Jens Axboe wrote:
> > > On Mon, Nov 29 2004, J.A. Magallon wrote:
> > > > dev=3DATAPI uses ide-scsi interface, through /dev/sgX. And:
> > > > > scsibus: -1 target: -1 lun: -1
> > > > > Warning: Using ATA Packet interface.
> > > > > Warning: The related Linux kernel interface code seems to be
> > > > > unmaintained. Warning: There is absolutely NO DMA, operations thu=
s
> > > > > are slow.
> > > >
> > > > dev=3DATA uses direct IDE burning. Try that as root. In my box, as =
root:
> > >
> > > Oh no, not this again... Please check the facts: the ATAPI method use=
s
> > > the SG_IO ioctl, which is direct-to-device. It does _not_ go through
> > > /dev/sgX, unless you actually give /dev/sgX as the device name. It ha=
s
> > > nothing to do with ide-scsi. Period.
> > >
> > > ATA uses CDROM_SEND_PACKET. This has nothing to do with direct IDE
> > > burning, it's a crippled interface from the CDROM layer that should n=
ot
> > > be used for anything.  scsi-linux-ata.c should be ripped from the
> > > cdrecord sources, or at least cdrecord should _never_ select that
> > > transport for 2.6 kernels. For 2.4 you are far better off using
> > > ide-scsi.
> > >
> > > > The scan through ATA lasts much less than with ATAPI, and you can b=
urn
> > > > with dev=3DATA:1,0,0 or dev=3D/dev/burner, which is the new recomme=
nded
> > > > way.
> > >
> > > No! ATAPI is the recommended way.
> >
> > Ok, so I am a bit confused here.  We basically have 3 ways to use
> > cdrecord on linux-2.6 without ide-scsi:
> >
> > 1) cdrecord dev=3D/dev/hdx
> > 2) cdrecord dev=3DATA
> > 3) cdrecord dev=3DATAPI
> >
> > Now, if I run all three and grep for '^Warning', I get:
> >
> > -----
> >  $ cdrecord dev=3D/dev/cdrw -scanbus 2>&1 | grep '^Warning'
> > Warning: Open by 'devname' is unintentional and not supported.
> >  $ cdrecord dev=3DATA -scanbus 2>&1 | grep '^Warning'
> > Warning: Using badly designed ATAPI via /dev/hd* interface.
> >  $ cdrecord dev=3DATAPI -scanbus 2>&1 | grep '^Warning'
> > Warning: Using ATA Packet interface.
> > Warning: The related Linux kernel interface code seems to be unmaintain=
ed.
> > Warning: There is absolutely NO DMA, operations thus are slow.
> >  $
> > -----
> >
> > Which means:
> >
> > 1) dev=3D/dev/hdx - Open by 'devname' is unintentional and not supporte=
d.
> > 2) dev=3DATA - Using badly designed ATAPI via /dev/hd* interface.
> > 3) dev=3DATAPI - Using ATA Packet interface.
> >                   (And some nice things about it not being maintained a=
nd
> >                    slow)
> >
>=20
> Well, dev=3DATA:nr,nr,nr will not produce any warning and works correctly=
 with=20
> full performance.
> dev=3DATAPI:* gives bad performance and as stated above, shouldn't be use=
d.
> dev=3D/dev/hdx is just the same as dev=3DATA:/dev/hdx, you can of course =
replace=20
> it with correct numbers if you know them or an alias=20
> in /etc/defaults/cdrecord.dfl (The path's from Gentoo, may be different=20
> elsewhere.)

Yes, I know .. its just that I have been under the impression (and also
what experience shows) that 'dev=3D/dev/hdx' and 'dev=3DATA' is the same
thing, with 'dev=3DATAPI' the depreciated one, but Jens stated differently
above ...

--=20
Martin Schlemmer


--=-t2YqRL8dkwnjiaxDyNjt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBr448qburzKaJYLYRAlNJAJ9gAR7Uto1+dLNGuyordfpYBXSuQACfea7y
XnWUrIQngGqZPaZn/1x3270=
=KMLe
-----END PGP SIGNATURE-----

--=-t2YqRL8dkwnjiaxDyNjt--

