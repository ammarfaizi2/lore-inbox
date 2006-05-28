Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWE1QTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWE1QTA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 12:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWE1QTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 12:19:00 -0400
Received: from nef2.ens.fr ([129.199.96.40]:33543 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S1750708AbWE1QS7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 12:18:59 -0400
Date: Sun, 28 May 2006 18:18:58 +0200
From: Nicolas George <nicolas.george@ens.fr>
To: linux-kernel@vger.kernel.org
Subject: [UDF] (bogus?) overlap of directories and files
Message-ID: <20060528161858.GA4705@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Sun, 28 May 2006 18:18:58 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi.

<I-tell-my-life>

I have a hard drive with an UDF filesystem, and something strange happened a
few weeks ago: I had a directory foo, then I created a file bar at a
completely different place; after that, foo was no longer a directory, it
was a plain file, a hard-link to the newly created bar, except that the link
count was wrong. Obviously there is a bug somewhere.

Since then, I spent part of my free-time to dissect my filesystem, and I
found the following strange detail.

</I-tell-my-life>


Some directories have eight allocated unrecorded (extent.length >> 30 =3D=
=3D 1,
according to ECMA 167, 4/14.14.1.1, page 4/46) sectors at the end. The
strange thing is that some of these sectors also belong to others files or
directories, as recorded sectors.

Is this situation normal?

(For the record, I am currently using a 2.6.14.1 kernel, but I did not see
anything related in the ChangeLog of later releases.)



PS: I managed to build and run fsck.udf from OpenSolaris under GNU/Linux,
but it seems to be limited to version 2 records, while Linux produces both
version 2 and version 3 records, so it did not help. I intend to release the
tools I have written to dissect my filesystem, but they still need a lot of
work.


Regards,

--=20
  Nicolas George

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (SunOS)

iD8DBQFEec1ysGPZlzblTJMRAtgMAJ4ujuzX/1qZ6EfxuJufqTV6Tn4ibACgo/QA
rinYDFND+TcN8lqXYAdybTA=
=znsW
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
