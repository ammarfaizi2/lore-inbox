Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316167AbSFDDbu>; Mon, 3 Jun 2002 23:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316195AbSFDDbt>; Mon, 3 Jun 2002 23:31:49 -0400
Received: from [209.184.141.168] ([209.184.141.168]:9938 "HELO UberGeek")
	by vger.kernel.org with SMTP id <S316167AbSFDDbt>;
	Mon, 3 Jun 2002 23:31:49 -0400
Subject: Max groups at 32?
From: Austin Gonyou <austin@coremetrics.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-2s/iHjLrADF7oTg9moIs"
Organization: Coremetrics, Inc.
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 03 Jun 2002 22:31:44 -0500
Message-Id: <1023161504.4595.5.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2s/iHjLrADF7oTg9moIs
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I'm not sure if this is a Linux capabilities problem, a PAM problem, or
what, but I've noticed that If I add a user to > 32 groups...that user
cannot access anything in a directory owned by a group > the 32nd group.

Has anyone else experienced this?

Here is a sample script to help troubleshoot if you're interested:

#!/bin/bash
x=3D34;
useradd testuser
while [ ! $x -lt 1 ]
  do groupadd group$x
     gpasswd -a testuser group$x
     x=3D$(( $x - 1 ))
done

groups
read=20
printf "press any key..."
groups testuser
printf "press any key..."
read
mkdir /testdir
chown root:group1 /testdir
chmod 770 /testdir
su - testuser -c "ls /testdir"
printf "press any key..."
read
userdel -r testuser

If all has gone properly, and group1 is *not* in the first groups
listing, (not "groups testuser"), then the user will not be able to even
ls /testdir, and you'll get permission denied.=20

Please advise, if you can.
TIA.

--=20
Austin Gonyou
Systems Architect, CCNA
Coremetrics, Inc.
Phone: 512-698-7250
email: austin@coremetrics.com

"One ought never to turn one's back on a threatened danger and=20
try to run away from it. If you do that, you will double the danger.=20
But if you meet it promptly and without flinching, you will=20
reduce the danger by half."
Sir Winston Churchill

--=-2s/iHjLrADF7oTg9moIs
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8/DSg94g6ZVmFMoIRAiJwAJ9ykyDH1JAef2zETbO563aKZHriCgCghclP
QVaVtkZuERqyoFYa8Wzaqyw=
=+tbP
-----END PGP SIGNATURE-----

--=-2s/iHjLrADF7oTg9moIs--
