Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWFKLbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWFKLbj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 07:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWFKLbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 07:31:38 -0400
Received: from pops.net-conex.com ([204.244.176.3]:50399 "EHLO
	mail.net-conex.com") by vger.kernel.org with ESMTP id S1751155AbWFKLbi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 07:31:38 -0400
Date: Sun, 11 Jun 2006 04:31:41 -0700
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: linux-kernel@vger.kernel.org
Cc: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH] tmpfs time granularity fix for [acm]time moving backwards.
Message-ID: <20060611113141.GD26475@curie-int.vc.shawcable.net>
References: <20060609224936.GA30611@curie-int.vc.shawcable.net> <Pine.LNX.4.61.0606111210460.13585@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a2FkP9tdjPU2nyhF"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0606111210460.13585@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a2FkP9tdjPU2nyhF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 11, 2006 at 12:12:41PM +0200, Jan Engelhardt wrote:
> >Test output from a filesystem supporting sub-second timestamps (jfs,xfs,=
ramfs):
> >creat:   m=3D1149891452.928796249 c=3D1149891452.928796249 a=3D114989145=
2.928796249
> >futimes: m=3D1149891452.928796249 c=3D1149891452.928796249 a=3D114989145=
2.928796249
> >
> >Test output from the tmpfs filesystem with the patch below:
> >creat:   m=3D1149892086.382150894 c=3D1149892086.382150894 a=3D114989207=
5.473249075
> >futimes: m=3D1149892086.383150885 c=3D1149892086.383150885 a=3D114989208=
6.383150885
> >
> Is it normal that creat and futimes match for jfs/xfs?
My testcase just seemed to run nice and fast there, if I do some work in the
middle or sleep, the numbers will be different more, but otherwise I think =
it
implies that both operations are taking place during the same time instance=
 (I
have HZ=3D1000 as you may be able to deduce by the 1ms differences in some =
of the
pairs).

I ran it a few more times on ramfs for good measure.
creat: m=3D1150025153.933532153 c=3D1150025153.933532153 a=3D1150025151.295=
58289
futimes: m=3D1150025153.933532153 c=3D1150025153.933532153 a=3D1150025153.9=
33532153
=2E..
creat: m=3D1150025156.860505810 c=3D1150025156.860505810 a=3D1150025153.933=
532153
futimes: m=3D1150025156.861505801 c=3D1150025156.861505801 a=3D1150025156.8=
61505801
=2E..
creat: m=3D1150025247.906686387 c=3D1150025247.906686387 a=3D1150025247.459=
690410
futimes: m=3D1150025247.907686378 c=3D1150025247.907686378 a=3D1150025247.9=
07686378

> >Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
> Hint: Cc it to the shmem.c maintainer, or it may get missed :)
Will do, thanks.

--=20
Robin Hugh Johnson
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--a2FkP9tdjPU2nyhF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2-ecc0.1.6 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFEi/8dPpIsIjIzwiwRArKTAKCKb3cHLCrqwtbQtPJw45JzRWKZfwCgm+WS
cbJZPEqU2uzQjscLJe5qajc=
=igy2
-----END PGP SIGNATURE-----

--a2FkP9tdjPU2nyhF--
