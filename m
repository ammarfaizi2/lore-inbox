Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbWIRL7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbWIRL7R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 07:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbWIRL7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 07:59:17 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:3034 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S964985AbWIRL7Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 07:59:16 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: Exporting array data in sysfs
Date: Mon, 18 Sep 2006 13:59:17 +0200
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1960380.chpDrTqYZk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609181359.31489.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1960380.chpDrTqYZk
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I would like to put the contents of an array in sysfs files. I found no sim=
ple=20
way to do this, so here are my thoughts in hope someone can hand me a light.

=2Dsimple array (array of simple type like int, char* and so on)

needs:
=2Ename, .read, .write, .num, .writenum

When exported a directory "name" is created, containing num()+1 entries. Th=
ere=20
is one entry for each array entry plus the special entry "n". "cat n" gives=
=20
you the result of num, writing to num calls writenum to change the number o=
f=20
array members. If writenum is NULL the array has fixed size.

read is read(struct whatever *, int, char *). The second argument gives the=
=20
array number, the last one the buffer to print to (as usual). write looks=20
similar, just as in existing sysfs interface (e.g. device_create_file()).

=2Dcomplex array (array of struct)

This is even more tricky. You can't do this now if you don't know the numbe=
r=20
of entries. If you do you can create a struct device_attribute (or similar)=
=20
for every entry and have different access functions that "know" their index=
=2E=20
This is horribly inefficient and ugly.

Sort of access struct could be:

=2Ename is fmt-string containing %i (or %lli or something like this)
=2Emembers is an array of structs looking similar to what I described above=
 for=20
the simple array. Now the index gives the index of the struct.
=2Enum, .writenum as above

Nesting them is probably not worth it at all as it would look horrible. :)

Thoughts?

--nextPart1960380.chpDrTqYZk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFDoojXKSJPmm5/E4RAqNAAJ9hyfq57c0jSGLY6Lz+EkS8+b5D4QCeIFhi
xHCRnRGwxMnxXbqZ6IOC73w=
=U4VI
-----END PGP SIGNATURE-----

--nextPart1960380.chpDrTqYZk--
