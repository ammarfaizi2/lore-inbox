Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274388AbRIVHmm>; Sat, 22 Sep 2001 03:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274468AbRIVHmc>; Sat, 22 Sep 2001 03:42:32 -0400
Received: from cs6625186-50.austin.rr.com ([66.25.186.50]:640 "EHLO
	hatchling.taral.net") by vger.kernel.org with ESMTP
	id <S274388AbRIVHmS>; Sat, 22 Sep 2001 03:42:18 -0400
Date: Sat, 22 Sep 2001 02:42:41 -0500
From: Taral <taral@taral.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Bug in ipip.c SIOCDELTUNNEL
Message-ID: <20010922024241.A620@taral.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tsOsTdHNUZQcU9Ye
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Patch is attached. Basically we were always removing "tunl0" even if a
different tunnel was specified.

--=20
Taral <taral@taral.net>
This message is digitally signed. Please PGP encrypt mail to me.
"Any technology, no matter how primitive, is magic to those who don't
understand it." -- Florence Ambrose

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ipip.c.patch"

--- /usr/src/linux-2.4.10-pre14/net/ipv4/ipip.c	Sat Sep 22 01:18:30 2001
+++ net/ipv4/ipip.c	Sat Sep 22 02:39:07 2001
@@ -758,6 +758,7 @@
 			err = -EPERM;
 			if (t == &ipip_fb_tunnel)
 				goto done;
+			dev = t->dev;
 		}
 		err = unregister_netdevice(dev);
 		break;

--3MwIy2ne0vdjdPXF--

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iEYEARECAAYFAjusQPEACgkQoQQF8xCPwJQfRwCdHOKe1EeKrh/M0scOv02TD+Uy
HC0An3ggnCQNt9L4cq+ypPDhaSjyxufY
=lvno
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
