Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269784AbUICTRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269784AbUICTRQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 15:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269765AbUICTPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 15:15:51 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:62107 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S269743AbUICTNg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 15:13:36 -0400
Subject: Re: TG3 doesn't work in kernel 2.4.27 (David S. Miller)
From: Paul Larson <plars@linuxtestproject.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: Brian Somers <brian.somers@sun.com>, Michael.Waychison@sun.com,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040830161126.585a6b62.davem@davemloft.net>
References: <20040816110000.1120.31256.Mailman@lists.us.dell.com>
	 <200408162049.FFF09413.8592816B@anet.ne.jp>
	 <20040816143824.15238e42.davem@redhat.com> <412CD101.4050406@sun.com>
	 <20040825120831.55a20c57.davem@redhat.com> <412CF0E9.2010903@sun.com>
	 <20040825175805.6807014c.davem@redhat.com> <412DC055.4070401@sun.com>
	 <20040830161126.585a6b62.davem@davemloft.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-2iiZsweJmr1a9j4/afeK"
Message-Id: <1094238777.9913.278.camel@plars.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 03 Sep 2004 14:12:58 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2iiZsweJmr1a9j4/afeK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I tried this patch alone on top of 2.6.9-rc1 and tg3 is still broken for
me on JS20 blades.  Was there another patch I should have applied in
conjunction with this?

Thanks,
Paul Larson

On Mon, 2004-08-30 at 18:11, David S. Miller wrote:
> Michael Chan at Broadcom spotted the bug.
>=20
> Things are totally broken if the switch/hub does not support
> autonegotiation.  Checking for the MAC_STATUS_SIGNAL_DET bit
> in the tg3 polling timer fixes the problem.
>=20
> This is probably why it worked for you and doesn't with the
> IBM blades as blades are more likely to be connected to
> non-autoneg'ing devices.
>=20
> =3D=3D=3D=3D=3D drivers/net/tg3.c 1.199 vs edited =3D=3D=3D=3D=3D
> --- 1.199/drivers/net/tg3.c	2004-08-18 19:52:35 -07:00
> +++ edited/drivers/net/tg3.c	2004-08-30 15:08:07 -07:00
> @@ -5602,7 +5602,8 @@
>  				need_setup =3D 1;
>  			}
>  			if (! netif_carrier_ok(tp->dev) &&
> -			    (mac_stat & MAC_STATUS_PCS_SYNCED)) {
> +			    (mac_stat & (MAC_STATUS_PCS_SYNCED |
> +					 MAC_STATUS_SIGNAL_DET))) {
>  				need_setup =3D 1;
>  			}
>  			if (need_setup) {
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20
>=20

--=-2iiZsweJmr1a9j4/afeK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBOMI4bkpggQiFDqcRAqjLAJ9im313+wFrXO2RbhSVBywxJoVIFQCfbUYh
IAu4gsHz6wlmOZFKw2GphXA=
=bo67
-----END PGP SIGNATURE-----

--=-2iiZsweJmr1a9j4/afeK--

