Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262511AbVEMVaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262511AbVEMVaT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 17:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbVEMVaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 17:30:17 -0400
Received: from zak.futurequest.net ([69.5.6.152]:47759 "HELO
	zak.futurequest.net") by vger.kernel.org with SMTP id S262554AbVEMV2S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 17:28:18 -0400
Date: Fri, 13 May 2005 15:28:16 -0600
From: Bruce Guenter <bruceg@em.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: How to diagnose a kernel memory leak
Message-ID: <20050513212816.GA29230@em.ca>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050509035823.GA13715@em.ca> <1115627361.936.11.camel@localhost.localdomain> <20050511193726.GA29463@em.ca> <20050512171825.12599c1e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <20050512171825.12599c1e.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 12, 2005 at 05:18:25PM -0700, Andrew Morton wrote:
> It all looks pretty innocent.  Please send the contents of /proc/meminfo
> rather than the `free' output.  /proc/meminfo has much more info.=20

Here are the current meminfo numbers:

MemTotal:      2055648 kB
MemFree:         56512 kB
Buffers:        236880 kB
Cached:         869616 kB
SwapCached:          0 kB
Active:        1004124 kB
Inactive:       729732 kB
HighTotal:     1179072 kB
HighFree:         3584 kB
LowTotal:       876576 kB
LowFree:         52928 kB
SwapTotal:     1028152 kB
SwapFree:      1028096 kB
Dirty:            1036 kB
Writeback:           0 kB
Mapped:          13100 kB
Slab:           252444 kB
CommitLimit:   2055976 kB
Committed_AS:    25704 kB
PageTables:       1060 kB
VmallocTotal:   114680 kB
VmallocUsed:      4700 kB
VmallocChunk:   109836 kB

If I am counting right, free+buffers+cached+slab comes to 1415452 kB.
Of course, at this point, it is far from out of memory like it has been
in the past.  I am continuing to monitor, and will post numbers when it
gets closer to what I have previously observed.

> If the /proc/meminfo output indicates that there are a lot of slab pages
> then /proc/slabinfo should be looked at.

That was my first thought, yes.  However, when it has run out of memory,
even the slab totals were low (my first post showed only about 60 MB in
slab).
--=20
Bruce Guenter <bruceg@em.ca> http://em.ca/~bruceg/ http://untroubled.org/
OpenPGP key: 699980E8 / D0B7 C8DD 365D A395 29DA  2E2A E96F B2DC 6999 80E8

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFChRvw6W+y3GmZgOgRAsStAJ0W456kmKiTtFk46bDOyu/TFyABYQCfcFKc
dgAd0hf06TM970M7pEkjU4Q=
=Hqjg
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
