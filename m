Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbUFTXMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbUFTXMQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 19:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbUFTXMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 19:12:16 -0400
Received: from wblv-246-169.telkomadsl.co.za ([165.165.246.169]:35255 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S262370AbUFTXMK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 19:12:10 -0400
Subject: Re: [PATCH 0/2] kbuild updates
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: s0348365@sms.ed.ac.uk
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <200406202326.54354.s0348365@sms.ed.ac.uk>
References: <20040620211905.GA10189@mars.ravnborg.org>
	 <20040620220319.GA10407@mars.ravnborg.org>
	 <1087769761.14794.69.camel@nosferatu.lan>
	 <200406202326.54354.s0348365@sms.ed.ac.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WYqcmLbK6iOyhD4Od4yY"
Message-Id: <1087772041.14794.104.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 21 Jun 2004 00:54:01 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WYqcmLbK6iOyhD4Od4yY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-06-21 at 00:26, Alistair John Strachan wrote:
> [snipped a few CC addresses]
>=20
> On Sunday 20 June 2004 23:16, Martin Schlemmer wrote:
> > On Mon, 2004-06-21 at 00:03, Sam Ravnborg wrote:
> > > On Sun, Jun 20, 2004 at 11:30:34PM +0200, Martin Schlemmer wrote:
> > > > I know Sam's mta blocks my mail at least (lame isp), but for the re=
st,
> > > > please reconsider using this.
> > >
> > > Hmm, got your mail.
> > >
> > > > Many external modules, libs, etc use
> > > > /lib/modules/`uname -r`/build to locate the _source_, and this will
> > > > break them all.
> > >
> > > Examples please. What I have seen so far is modules that was not
> > > adapted to use kbuild when being build.
> > > If they fail to do so they are inherently broken.
> >
> > Well, glibc use it for instance as an fall-through if you do not specif=
y
> > it via ./configure arguments, or environment (yes, glibc should not use
> > it, etc, etc, no flames please =3D).  So as well does alsa-driver,
> > nvidia's drivers (gah, puke, yes, its got some binary-only stuff in
> > there ;), ati's drivers and a lot of other stuff (if you really need
> > them all I can try to find time to look for more).
> >
> > I am not sure about ati's drivers and alsa, but nvidia uses kbuild.
> >
> >
> > Thanks,
>=20
> Sam's point is that unless you ask KBUILD to put the kernel build in a=20
> separate directory to its sources (this is not the default=20
> behaviour), /lib/modules/`uname -r`/build will still point to the mixture=
 of=20
> source and build data, therefore no breakage will occur.
>=20
> I understand Sam's reasoning and I believe it is sensible to have the sou=
rce=20
> and build output in separate directories within /lib/modules/`uname -r`. =
The=20
> drivers in question can easily be updated to support the exceptional case=
=20
> whereby users build kernels in a different directory to the source.
>=20
> Sam, maybe if there was a way to easily detect whether a kernel had been =
build=20
> with or without a different output directory, it would be easier to have=20
> vendors take this change on board. For example, I imagine in the typical =
case=20
> whereby no change in build directory is made, you will have something lik=
e=20
> this:
>=20
> /lib/modules/2.6.7/build -> /home/alistair/linux-2.6
> /lib/modules/2.6.7/source -> /home/alistair/linux-2.6
>=20
> Whereas when O is given, it will instead be like this:
>=20
> /lib/modules/2.6.7/build -> /home/alistair/my-dir
> /lib/modules/2.6.7/source -> /home/alistair/linux-2.6
>=20
> I presume that checking for the existence of /lib/modules/`uname -r`/sour=
ce=20
> will be enough.
>=20
> #
> # where's the kernel source?
> #
>=20
> if [ -d /lib/modules/`uname -r`/source ]; then
> 	# 2.6.8 and newer
> 	KERNDIR=3D"/lib/modules/`uname -r`/source"
> else
> 	# pre 2.6.8 kernels
> 	KERNDIR=3D"/lib/modules/`uname -r`/build"
> fi
>=20
> Yeah?

Yes, as said before, I can understand the name change.  The point is
more that the 'build' symlink will change in behavior in certain
circumstances, and because many projects already support 2.6, and
make use of the 'build' symlink, they will break.

If it was however done in 2.7, things will get supported well before
2.8 is out, or in general use ...

--=20
Martin Schlemmer

--=-WYqcmLbK6iOyhD4Od4yY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA1hWJqburzKaJYLYRAiYSAJ9eWj2dndeytXgUbhP8KKclEegM2ACfThee
TiH3PtzC3NBCjU+4+PKs4/g=
=t7pR
-----END PGP SIGNATURE-----

--=-WYqcmLbK6iOyhD4Od4yY--

