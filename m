Return-Path: <linux-kernel-owner+w=401wt.eu-S1750943AbXAUAcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbXAUAcJ (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 19:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbXAUAcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 19:32:09 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:59156 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750972AbXAUAcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 19:32:08 -0500
From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: lkml <linux-kernel@vger.kernel.org>
Subject: Weird XFS slowness
Date: Sun, 21 Jan 2007 02:29:53 +0200
User-Agent: KMail/1.9.6
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart233871657.Lt2R8Mg2hV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200701210229.53179.caglar@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart233871657.Lt2R8Mg2hV
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi;

After switching ext3 to xfs, i realize system starts to _really_ unresponsi=
ve=20
and extracting tarballs, copying or deleting files or checking out svn=20
repositories are really slow, so i basically try to measure some for both x=
fs=20
and ext3 with same computer, same kernel (2.6.18.6), same disk, here are th=
e=20
results=20

* between all tests i dropped caches
* i already tried to change block device's scheduler to as, noop and cfq,=20
nothing really changes
* i already tried 2.6.20-rc5 and 2.6.20-rc5.1.rt8.0085 which Ingo provides =
but=20
again nothing really changes

Kernel Tarball
=2D-------------

a) XFS

ekin@idaho ~ $ time tar xvf linux-2.6.19.tar.bz2
=2E..
real    2m16.865s
user    0m21.113s
sys     0m2.426s

b) EXT3

ekin@idaho ~ $ time tar xvf linux-2.6.19.tar.bz2
=2E..
real    0m34.192s
user    0m20.624s
sys     0m1.771s

Deletion
=2D-------

a) XFS

ekin@idaho ~ $ time rm -rf linux-2.6.19/

real    0m50.902s
user    0m0.064s
sys     0m1.378s

b) EXT3

ekin@idaho ~ $ time rm -rf linux-2.6.19/

real    0m1.162s
user    0m0.031s
sys     0m0.411s

Copying
=2D------

a) XFS

ekin@idaho test $ time cp -r ../linux-2.6.19 .
=2E..
real    1m42.833s
user    0m0.124s
sys     0m2.621s

b) EXT3

ekin@idaho test $ time cp -r ../linux-2.6.19 .
=2E..
real    0m38.456s
user    0m0.166s
sys     0m2.744s

I'm not sure these are normal numbers or its a regression (i'm just startin=
g=20
to use XFS) so any hints will be appreciated.

Cheers
=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart233871657.Lt2R8Mg2hV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.1 (GNU/Linux)

iD8DBQBFsrQBy7E6i0LKo6YRAnFrAJkBzBshfbldRsetmfr1/YjR0ooUfwCaA4RE
OMZy89TcPX1pM0BbbMEucHw=
=/HBe
-----END PGP SIGNATURE-----

--nextPart233871657.Lt2R8Mg2hV--
