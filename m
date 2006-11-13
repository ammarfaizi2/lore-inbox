Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755362AbWKMWDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755362AbWKMWDW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 17:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755363AbWKMWDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 17:03:22 -0500
Received: from threatwall.zlynx.org ([199.45.143.218]:41088 "EHLO zlynx.org")
	by vger.kernel.org with ESMTP id S1755362AbWKMWDV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 17:03:21 -0500
Subject: Re: 2.6.19-rc5: grub is much slower resuming from suspend-to-disk
	than in 2.6.18
From: Zan Lynx <zlynx@acm.org>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
       Stefan Seyfried <seife@suse.de>
In-Reply-To: <200611132154.38644.arvidjaar@mail.ru>
References: <200611121436.46436.arvidjaar@mail.ru>
	 <200611130642.18990.arvidjaar@mail.ru> <20061113081528.GB18022@suse.de>
	 <200611132154.38644.arvidjaar@mail.ru>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YO/IniAvO+5FipzWv9wT"
Date: Mon, 13 Nov 2006 15:03:16 -0700
Message-Id: <1163455396.9482.38.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 
X-Envelope-From: zlynx@acm.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YO/IniAvO+5FipzWv9wT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-11-13 at 21:54 +0300, Andrey Borzenkov wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> On Monday 13 November 2006 11:15, Stefan Seyfried wrote:
> > Hi,
> >
> > On Mon, Nov 13, 2006 at 06:42:15AM +0300, Andrey Borzenkov wrote:
> > > On Sunday 12 November 2006 17:55, Pavel Machek wrote:
> > > > On Sun 12-11-06 14:36:41, Andrey Borzenkov wrote:
> > > > > -----BEGIN PGP SIGNED MESSAGE-----
> > > > > Hash: SHA1
> > > > >
> > > > > This is rather funny; in 2.6.19-rc5 grub is *really* slow loading
> > > > > kernel when I switch on the system after suspend to disk. Actuall=
y,
> > > > > after kernel has been loaded, the whole resuming (up to the point=
 I
> > > > > have usable
> >
> > The most important question:
> > What filesystem is your /boot on? I'd bet quite some money that it is
> > reiser or some other journaling FS (not ext3).
> >
>=20
> there is no /boot, I use single / which is reiser.
>=20
> > > > > desktop again) takes about three time less than the process of
> > > > > loading kernel + initrd. During loading disk LED is constantly li=
t.
> > > > > This almost looks like kernel leaves HDD in some strange state,
> > > > > although I always assumed HDD/IDE is completely reinitialized in =
this
> > > > > case.
> > > >
> > > > Seems like broken hw, really. No state should survive machine
> > > > poweroff.
> >
> > No. Broken FS / crappy GRUB.
> >
> > > To recap - this never happens upon simple power off; I do not remembe=
r
> > > this to
> >
> > I am pretty sure that it will also happen if you do "updatedb &", wait =
a
> > minute and then do a _HARD_ power off.
> >
> > I am pretty sure that it has nothing to do with the kernel version, jus=
t
> > with the layout of your /boot partition (which of course changes with e=
very
> > kernel update). In other words: until now, you just have been lucky.
>=20
> The idea is nice; unfortunately it fails to explain the difference=20
> between 'poweroff' and 'suspend disk' cases. I doubt disk layout is chang=
ed=20
> between them.

I have not checked if this is true, but it is a possible explanation:

Perhaps the filesystem is not properly unmounted during a suspend?  That
would mean GRUB is reading from a incoherent filesystem on resume.
GRUB's filesystem drivers are not very fancy.  It could be it does
something silly like check the journal before returning each block.

Maybe its a journal size thing, you could try "sync" before suspend and
see if it helps.  Another thing would be to create /boot as a separate
partition.
--=20
Zan Lynx <zlynx@acm.org>

--=-YO/IniAvO+5FipzWv9wT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFWOukG8fHaOLTWwgRAl2EAJ4zxkOlhSe9S017O41meam1Kj/qKgCfZCOd
Q46tTJ7CGlTSnyff/Cxlbz0=
=FfRh
-----END PGP SIGNATURE-----

--=-YO/IniAvO+5FipzWv9wT--

