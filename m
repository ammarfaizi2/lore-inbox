Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbVA3WwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbVA3WwH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 17:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbVA3WwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 17:52:07 -0500
Received: from natpreptil.rzone.de ([81.169.145.163]:21701 "EHLO
	natpreptil.rzone.de") by vger.kernel.org with ESMTP id S261822AbVA3Wvf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 17:51:35 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: kbuild: shorthand ym2y, ym2m etc
Date: Sun, 30 Jan 2005 23:41:34 +0100
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20050130193733.GA8984@mars.ravnborg.org>
In-Reply-To: <20050130193733.GA8984@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_fKW/BYeZOqC26Zo";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200501302341.35086.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_fKW/BYeZOqC26Zo
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On S=FCnndag 30 Januar 2005 20:37, Sam Ravnborg wrote:
> We have in several cases the need to transpose a i'm' to 'y' in the Kbuild
> files.
> One example is the following snippet from sound/Makefile:
> ifeq ($(CONFIG_SND),y)
>   obj-y +=3D last.o
> endif
>=20
> Alternative syntax could be:
> obj-$(call y2y,CONFIG_SND) +=3D last.o

You can already write this as

last-$(CONFIG_SND) :=3D last.o
obj-y +=3D $(last-y)

I'm not sure if this is better than the current version, but I'd
prefer it to using the extra function.

> From drivers/vidoe/Makfile:
> ifeq ($(CONFIG_FB),y)
>   obj-$(CONFIG_PPC)                 +=3D macmodes.o
> endif

macmodes-$(CONFIG_FB) :=3D macmodes.o
obj-$(CONFIG_PPC) +=3D $(macmodes-y)

> ym2y
> ym2m

tmp-$(CONFIG_FOO) :=3D foo.o
tmp-$(CONFIG_BAR) :=3D $(tmp-y)
obj-m +=3D $(tmp-m)

> empty2y
> empty2m

tmp-$(CONFIG_FOO) :=3D foo.o
obj-m +=3D $(tmp-) $(tmp-n)

> y2y
> m2y
> y2m
> m2m
> yx2x
> mx2x
>=20
> Would that be considered usefull?

I don't fully understand what all those examples should do, so they
are probably not that intuitive. I'm pretty sure that we can already
express them all with either ifeq() or two assignments, though.
Both are already used in the kernel (see ipc/Makefile for an
example of yx2x), so maybe the preferred style should be documented
in CodingStyle.

	Arnd <><

--Boundary-02=_fKW/BYeZOqC26Zo
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBB/WKf5t5GS2LDRf4RAgrHAJ9pS3rd1FCZ3mRjHqSSxfDlhJ1WyACeOEuL
C6HhVOz7y/CUp5wpbaSAr2k=
=6pbQ
-----END PGP SIGNATURE-----

--Boundary-02=_fKW/BYeZOqC26Zo--
