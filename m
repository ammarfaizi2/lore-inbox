Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbUKIODw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbUKIODw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 09:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbUKIODw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 09:03:52 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:55764 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S261437AbUKIODm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 09:03:42 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] kill IN_STRING_C
Date: Tue, 9 Nov 2004 14:58:34 +0100
User-Agent: KMail/1.6.2
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <20041107142445.GH14308@stusta.de> <20041108134448.GA2456@wotan.suse.de> <20041108153436.GB9783@stusta.de>
In-Reply-To: <20041108153436.GB9783@stusta.de>
MIME-Version: 1.0
Message-Id: <200411091458.35134.arnd@arndb.de>
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_L0MkB/3o0uuXKl0";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_L0MkB/3o0uuXKl0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> On Mon, Nov 08, 2004 at 02:44:49PM +0100, Andi Kleen wrote:
>=20
> > > Can you still reproduce this problem?
> > > If not, I'll suggest to apply the patch below which saves a few kB in=
=20
> > > lib/string.o .
> >=20
> > I would prefer to keep it because there is no guarantee in gcc
> > that it always inlines all string functions unless you pass
> > -minline-all-stringops. And with that the code would
> > be bloated much more than the few out of lined fallback
> > string functions.
>=20
> If I understand your changelog entry correctly, this wasn't the problem
> (the asm string functions are "static inline").

Actually, shouldn't the string functions be "extern inline" then?
That would mean we use the copy from lib/string.c instead of generating
a new copy for each file in which gcc decides not to inline the function.
It would also let you get rid of the IN_STRING_C hack that is needed
to avoid the clash of the "static inline" and the "extern" version.

	Arnd <><



--Boundary-02=_L0MkB/3o0uuXKl0
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBkM0L5t5GS2LDRf4RAr4XAKCGB+4bU9/MXR6Gghsy6Y798ODJmACfT+Lv
rdSjTBtAZMXP5gPi0SMklNY=
=o+dC
-----END PGP SIGNATURE-----

--Boundary-02=_L0MkB/3o0uuXKl0--
