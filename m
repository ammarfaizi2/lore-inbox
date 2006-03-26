Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbWCZOLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbWCZOLs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 09:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWCZOLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 09:11:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:49845 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751216AbWCZOLs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 09:11:48 -0500
X-Authenticated: #2308221
Date: Sun, 26 Mar 2006 16:11:44 +0200
From: Christian Trefzer <ctrefzer@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: snd-nm256: hard lockup on every second module load after powerup
Message-ID: <20060326141144.GA12575@hermes.uziel.local>
References: <20060326054542.GA11961@hermes.uziel.local> <20060326061124.GA9501@hermes.uziel.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <20060326061124.GA9501@hermes.uziel.local>
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline


OK, apparently the importance of this issue is quite modest, so I won't
expect too much attention - not that I'd have presumed any in the first
place ; )

Here's what I found so far, anyway:

Writing the following to the device one word at a time prior to loading
snd-nm256 saved my laptop from hanging. It was dumped in a shell loop
after successful driver loading:

0x71918086
0x0220011f
0x06040003
0x00012000
0x00000000
0x00000000
0x20010100
0xa2a0c0c0
0xfef0fd00
0xf9f0f800
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x008c0000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000


The following I get when reading stuff right before a crash:


0x71918086
0x0220011f
0x06040003
0x00012000
0x00000000
0x00000000
0x20010100
0x22a0c0c0
0xfef0fd00
0xf9f0f800
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x008c0000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000


The funny part is that only writing word #7 won't save the suicidal
fsck from going over the edge, I only succeeded when writing all the
stuff back to the device. By the way, here's a diff:


--- nm256-device-beforedriver	2006-03-26 15:27:32.873773008 +0200
+++ nm256-device-driverloaded	2006-03-26 15:27:42.669283864 +0200
@@ -5,7 +5,7 @@
 0x00000000
 0x00000000
 0x20010100
-0x22a0c0c0
+0xa2a0c0c0
 0xfef0fd00
 0xf9f0f800
 0x00000000


It came out of suspend2 just the way it was supposed to crash, I flushed
the registers and it is now happily playing music for me. Strange
thing... For now, I'll add the register paint job to an install
directive in modprobe.conf, let's see what this can do.


Kind regards,
Chris


--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQIVAwUBRCahHl2m8MprmeOlAQIKuA//bNLMDt6BlcXfWjejB3kBfu5ltAtVqsOI
j9EAMuIxElPG4zHKbOD8CP6PgJspqaBB94/+GeqZSWpG34scq4T5ITpPNPUkFmGl
Xzj0dhZKkLscE2PqavsTn7SoWCMwFG28F98fG99g8semAKCN3FrFDawg4+S2/YYK
UAbKRlOOBmopAU9ileOkq14ovR5tdMFcQFKdDPev8fM/LBKbs01GMCeno6cTUgae
TXb4eOy3wKz+rU8SoXSbcFZEFrz5Ll6elykvVFuVs1AqnSHoEbKVH14GPIX0qUTB
lm9BZ/mT26JUKkof7vXBzXwUBfqm0LZyixNY9U4oKUKPKuHNL9EWuDeVRUee2TN1
+X9b3KL8z6r45Ris4r2vpB5uD9Z60E0KkGdUOgcx5hBd0ay3oNEvOcLFpn6N+Cu3
TWOydfEyECmvEPCPfkClM+Q2eovYQD9EmEhKYTVnmMuPBojJe9XChf71nsEGI7XI
MnKxTTe22gryjYznpfMx1M3qXBb/MJQcoyiCYqaBeoNtxZv1kZhfm/pCy3XYQGfs
RiVN/wd8/eOgq4SWA0TpyJAFxOv3KKJLpYzHEs/JnucDFiE/nAIq5pFmJwY3HExa
79lm98Wg3miz4SsGyRVZ1Fw3qaqNVQnfPjRtBX7UMXFahj6o+rOhh+Wrckalhar/
7xYD3IOmCM4=
=OVY2
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--

