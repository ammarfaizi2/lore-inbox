Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267244AbSK3Nyo>; Sat, 30 Nov 2002 08:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267245AbSK3Nyo>; Sat, 30 Nov 2002 08:54:44 -0500
Received: from 174-121-ADSL.red.retevision.es ([80.224.121.174]:62915 "EHLO
	jerry.marcet.dyndns.org") by vger.kernel.org with ESMTP
	id <S267244AbSK3Nyn>; Sat, 30 Nov 2002 08:54:43 -0500
Date: Sat, 30 Nov 2002 15:02:04 +0100
From: Javier Marcet <jmarcet@pobox.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Exaggerated swap usage && -aa lockup
Message-ID: <20021130140204.GA15565@jerry.marcet.dyndns.org>
References: <20021130013832.GF15682@jerry.marcet.dyndns.org> <Pine.LNX.4.44L.0211292349550.15981-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0211292349550.15981-100000@imladris.surriel.com>
X-Editor: Vim http://www.vim.org/
X-Operating-System: Gentoo GNU/Linux 1.4 / 2.5.47-ac6 i686 AMD Athlon(TM) XP 1800+ AuthenticAMD
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Rik van Riel <riel@conectiva.com.br> [021130 02:57]:

>> root # vmstat 1
>> procs -----------memory---------- ---swap-- -----io---- --system-- ----c=
pu----
>>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy=
 id wa
>>  0  1 265048   5248  32248 119108    6   15    65    62  252   585 21  6=
 73  0
>>  1  6 266648   4480  32316 120300    0 4656  2152  4652 1348   821 13  8=
 79  0
>>  1  0 265052   4496  31036 120184    8  336  1668   340 1226   765 15  7=
 78  0
>>  0  1 265052   4496  31112 121564    4    0  3152     0 1198   894 18  8=
 74  0
>>  1  0 265052   4504  31076 123112    0    0  3024  8576 1229   857 17  7=
 76  0
>                                      ^^^^^^^^^^^^^^^^^^^

>Looks like my guess was right after all.  The amount of swap
>IO is maybe 10% of the amount of filesystem IO in your vmstat
>snippet above.

[...]

>Two things could be happening here:

>1) the kernel decides to cache the wrong things in the
>   page cache

>and/or

>2) the IO scheduler is giving worse latencies now

>If the problem is (1) it might get resolved by using the -rmap
>or -aa kernels.  If the problem is (2) you'll want Andrew Morton's
>read_latency patch (which I'll port to 2.4.20 real soon now).

I tend to believe is (1). I was using 2.4.20-jam0 (-aa derived) all this
morning. It seemed to behave better than 2.4.20-rc4-ac1 on this point. I
compiled a couple apps without problems, had different apps and servers
running while both si & so and bi & bo were low. However, when I was
uncompressing mozilla-1.2.tar.gz the system locked up, just as
2.4.20-rc2aa1 did days before. ALT-SYSRQ allowed me to reboot, but I did
not take note of any kernel dump...


I am now running 2.5.47-ac6 and things are _way_ better in any aspect.
I'll post some vmstat output later when the system has been running for
a while. So far it has already uncompressed mozilla's source with no
slowdown or lockup.


--=20
Javier Marcet <jmarcet@pobox.com>

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iEYEARECAAYFAj3oxNwACgkQx/ptJkB7frw5sgCfexHxDc5IhByzTV0R4O71lGHp
NEAAnjQR3NaGeOflHs7sXg9rSN5o09A9
=qAO8
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
