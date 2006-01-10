Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932543AbWAJWD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbWAJWD5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 17:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbWAJWD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 17:03:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22955 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932543AbWAJWD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 17:03:56 -0500
Message-ID: <43C42F0C.10008@redhat.com>
Date: Tue, 10 Jan 2006 14:02:52 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mail/News 1.5 (X11/20060103)
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: ntohs/ntohl and bitops
X-Enigmail-Version: 0.93.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5BA0AE62271E2A3553A52D6E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5BA0AE62271E2A3553A52D6E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I just saw this in a patch:

+               if (ntohs(ih->frag_off) & IP_OFFSET)
+                       return EBT_NOMATCH;

This isn't optimal, it requires a byte switch little endian machines.
The compiler isn't smart enough.  It would be better to use

     if (ih->frag_off & ntohs(IP_OFFSET))

where the byte-swap can be done at compile time.  This is kind of ugly,
I guess, so maybe a dedicate macro

    net_host_bit_p(ih->frag_off, IP_OFFSET)

??

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig5BA0AE62271E2A3553A52D6E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDxC8R2ijCOnn/RHQRArbmAKCMMLjj5XOuW3X4lxU58XiE75OimwCghexD
oxVcgsA//RNDEIKFaxEjnGY=
=Yp2t
-----END PGP SIGNATURE-----

--------------enig5BA0AE62271E2A3553A52D6E--
