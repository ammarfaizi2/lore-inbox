Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbTKGEK5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 23:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbTKGEK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 23:10:57 -0500
Received: from adsl-63-207-60-234.dsl.lsan03.pacbell.net ([63.207.60.234]:59148
	"EHLO obsecurity.dyndns.org") by vger.kernel.org with ESMTP
	id S261345AbTKGEK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 23:10:56 -0500
Date: Thu, 6 Nov 2003 20:10:51 -0800
From: Kris Kennaway <kris@freebsd.org>
To: linux-kernel@vger.kernel.org
Subject: NFS Locking violates protocol spec (incompatible with FreeBSD)
Message-ID: <20031107041051.GA4065@rot13.obsecurity.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

In http://lxr.linux.no/source/include/linux/lockd/xdr.h?v=3D2.6.0-test7
can be found the following comment:

35 /*
36  *      NLM cookies. Technically they can be 1K, Nobody uses over 8 bytes
37  *      however.
38  */
39 =20
40 struct nlm_cookie
41 {
42         unsigned char data[8];
43         unsigned int len;
44 };

Unfortunately, this is incorrect: FreeBSD 5.x's rpc.lockd uses a 16
byte cookie, and therefore FreeBSD 5.x NFS clients cannot interoperate
with Linux when NFS locking is enabled.

  http://www.freebsd.org/cgi/query-pr.cgi?pr=3Dkern/56461

contains more details about this problem, including a workaround for
FreeBSD to limit the cookie size to 8 bytes.  Obviously, it would be
better for this bug to be fixed in Linux, since Linux is
non-conformant to the protocol.

Kris



--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (FreeBSD)

iD8DBQE/qxtLWry0BWjoQKURAjGVAJ9Ka5o7wPNDrWj0qDjstlUVALKzQQCgqJTb
yW1JOuuH12sR8JtoX2J87nA=
=QUg2
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
