Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262358AbRERPzD>; Fri, 18 May 2001 11:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262359AbRERPy4>; Fri, 18 May 2001 11:54:56 -0400
Received: from warande3094.warande.uu.nl ([131.211.123.94]:63090 "EHLO
	warande3094.warande.uu.nl") by vger.kernel.org with ESMTP
	id <S262358AbRERPyu>; Fri, 18 May 2001 11:54:50 -0400
Date: Fri, 18 May 2001 17:54:41 +0200
From: Guus Sliepen <guus@warande3094.warande.uu.nl>
To: linux-kernel@vger.kernel.org
Cc: Hannu Savolainen <hannu@opensound.com>, Alan Cox <alan@redhat.com>
Subject: Sound sequencer (at least with a GUS card) doesn't honor HZ value
Message-ID: <20010518175440.J12147@sliepen.warande.net>
Mail-Followup-To: Guus Sliepen <guus@sliepen.warande.net>,
	linux-kernel@vger.kernel.org,
	Hannu Savolainen <hannu@opensound.com>, Alan Cox <alan@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z9t8O/5YJLB6LEUl"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
X-oi: oi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Z9t8O/5YJLB6LEUl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I've recently started compiling i386 kernels with HZ (and also CLOCKS_PER_S=
EC)
set to 1024 instead of 100 for various reasons. All works perfectly, except
when I play mod files with s3mod on my Gravis UltraSound card. The modules =
are
played 10 times too fast:

[guus@haplo]~>time s3mod /usr/lib/bb/bb.s3m
[...]
98 00000 Length  :4min 47sec
GUS (ALPHA support) Playing "/usr/lib/bb/bb.s3m"
Using 498690 of 524254 bytes of GUS RAM
0.814u 0.833s 0:29.95 5.4%      0+0k 0+0io 123pf+0w

Kernel version is plain 2.4.4. I've gone through the s3mod sources and did a
strace on it, but s3mod itself doesn't handle the timing, it only write()'s
stuff to /dev/sequencer, nothing else. This makes me strongly believe the
soundcard/sequencer driver itself is wrong here. A quick grep for 100, HZ a=
nd
CLOCKS didn't yield any useful information, so I guess it's not a trivial
problem...

P.S.: The change of HZ and CLOCKS_PER_SEC to 1024 is the only change I made.

--=20
Met vriendelijke groet / with kind regards,
  Guus Sliepen <guus@sliepen.warande.net>

--Z9t8O/5YJLB6LEUl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7BUXAAxLow12M2nsRAoiHAKCLax7DV67V7eZL+vNV8ElGi0r2IACfTQr+
YcSbX1+SLB/TyB5P2JbPOAE=
=KiHI
-----END PGP SIGNATURE-----

--Z9t8O/5YJLB6LEUl--
