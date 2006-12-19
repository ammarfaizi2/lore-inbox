Return-Path: <linux-kernel-owner+w=401wt.eu-S932895AbWLSSqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932895AbWLSSqq (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 13:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932894AbWLSSqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 13:46:45 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:54826 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932895AbWLSSqo (ORCPT
	<RFC822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 13:46:44 -0500
Message-Id: <200612191846.kBJIkSX7019987@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: =?utf-8?B?SsO2cm4=?= Engel <joern@lazybastard.org>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Randy Dunlap <randy.dunlap@oracle.com>, Pavel Machek <pavel@ucw.cz>,
       Scott Preece <sepreece@gmail.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6.20-rc1-mm1 suspicious prececence code ( was Re: [PATCH/v2] CodingStyle updates
In-Reply-To: Your message of "Fri, 15 Dec 2006 22:59:12 +0100."
             <Pine.LNX.4.61.0612152255400.28506@yvahk01.tjqt.qr>
From: Valdis.Kletnieks@vt.edu
References: <20061207165508.e6bf0269.randy.dunlap@oracle.com> <20061215120942.GA4551@ucw.cz> <4582AEC8.7030608@s5r6.in-berlin.de> <20061215142206.GC2053@elf.ucw.cz> <7b69d1470612150652p609c38d2n9bff58bdb0a1edb7@mail.gmail.com> <20061215150717.GA2345@elf.ucw.cz> <20061215090037.05c021af.randy.dunlap@oracle.com> <20061215201127.GA32210@lazybastard.org> <d120d5000612151256h5428eddcpbd137ce939a58b32@mail.gmail.com> <Pine.LNX.4.61.0612152158240.28506@yvahk01.tjqt.qr> <20061215212724.GB317@lazybastard.org>
            <Pine.LNX.4.61.0612152255400.28506@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1166553988_3767P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 19 Dec 2006 13:46:28 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1166553988_3767P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Dec 2006 22:59:12 +0100, Jan Engelhardt said:

> I take it that people will automatically DTRT for obscure cases like
> shown before. Well, and if they don't, hopefully some reviewer catches
> things like 3*i + l<<2.

So I hacked up a few very ugly 'find=7Cegrep' to look for some cases of t=
hat, and
found:

./include/asm-arm/arch-ebsa110/hardware.h:18: * Region 0 (addr =3D 0xf000=
0000 + io << 2)

Only one odd-looking use of +-*/ and <</>> - and it's in a comment.

And that's using a pattern like '=5C+=5B=5E,()=3D=5D*<<' (basically, any =
plus sign that
has a << after it, but no comma parens or equals to force grouping in bet=
ween), and
then using /bin/eyeball to filter the resulting several hundred lines.
I admit I didn't try to catch expressions split over multiple lines, and
something of the form =22foo * bar + (a-b) << 2=22 would have snuck by (b=
ut I
suspect if somebody bothered doing the (a-b), they would have another pai=
r).

So either that sort of thing isn't really an error we make often, or the
reviewers are very good at catching it, or I'm a lot worse at finding the=
m
than I thought I was... :)

--==_Exmh_1166553988_3767P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFiDOEcC3lWbTT17ARAvJhAKDp60LE0jiKR8DGWWDaie7Z7Gl3TACg3PRO
yDOifIu1q+8vbIjmhYpyS2w=
=vmEf
-----END PGP SIGNATURE-----

--==_Exmh_1166553988_3767P--
