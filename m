Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWDBLUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWDBLUF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 07:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWDBLUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 07:20:05 -0400
Received: from 169.248.adsl.brightview.com ([80.189.248.169]:57349 "EHLO
	getafix.willow.local") by vger.kernel.org with ESMTP
	id S932315AbWDBLUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 07:20:04 -0400
Date: Sun, 2 Apr 2006 12:20:02 +0100
From: John Mylchreest <johnm@gentoo.org>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, paulus@samba.org
Subject: Re: [PATCH 1/1] POWERPC: Fix ppc32 compile with gcc+SSP in 2.6.16
Message-ID: <20060402112002.GA3443@getafix.willow.local>
References: <20060401224849.GH16917@getafix.willow.local> <20060402085850.GA28857@suse.de> <20060402102259.GM16917@getafix.willow.local> <20060402102815.GA29717@suse.de> <20060402105859.GN16917@getafix.willow.local> <20060402111002.GA30017@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <20060402111002.GA30017@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 02, 2006 at 01:10:02PM +0200, Olaf Hering <olh@suse.de> wrote:
>  On Sun, Apr 02, John Mylchreest wrote:
>=20
> > On Sun, Apr 02, 2006 at 12:28:15PM +0200, Olaf Hering <olh@suse.de> wro=
te:
> > >  On Sun, Apr 02, John Mylchreest wrote:
> > >=20
> > > >   BOOTLD  arch/powerpc/boot/zImage.vmode
> > > >   arch/powerpc/boot/prom.o(.text+0x19c): In function `call_prom':
> > > >   : undefined reference to `__stack_smash_handler'
> > >=20
> > > Any this strange "security feature" is disabled by defining __KERNEL_=
_?
> >=20
> > That correct, yes. SSP is actually used by quite a lot of vendors, and
> > shouldn't be used outside of userland. Typically speaking it isn't, but
> > in this case its being leaked.
>=20
> Either way, file a bugreport upstream to remove the dep on __KERNEL__ in
> the gcc patch.
>=20
> A patch which adds -fno-dumb-feature to CFLAGS may be acceptable.

Going from that, I can push a patch for gcc upstream to remove the
__KERNEL__ dep, but gcc4.1 ships with ssp by standard, and the semantics
between the IBM patch for SSP applied to gcc-3 and ggc-4 have changed.

-fno-stack-protector would work for gcc4, but for gcc3 it could still be
patially enabled, and requires -fno-stack-protector-all. Mind If I ask
whats incorrect about defining __KERNEL__ for the bootcflags?

--=20
Role:            Gentoo Linux Kernel Lead
Gentoo Linux:    http://www.gentoo.org
Public Key:      gpg --recv-keys 9C745515
Key fingerprint: A0AF F3C8 D699 A05A EC5C  24F7 95AA 241D 9C74 5515


--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEL7NiNzVYcyGvtWURAp3GAKCb1CruWzjtycJckQW5lGe0d5vjawCg4KlX
9F3gDDZGUzNHwFr8Rw7/DLQ=
=hCD5
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
