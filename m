Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbUFKFlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUFKFlV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 01:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbUFKFlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 01:41:20 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:17639 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S261763AbUFKFlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 01:41:15 -0400
Date: Thu, 10 Jun 2004 23:41:11 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: Unaligned accesses in net/ipv4/netfilter/arp_tables.c:184
Message-ID: <20040611054111.GV24042@schnapps.adilger.int>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org,
	linux-ia64@vger.kernel.org
References: <Pine.LNX.4.58.0406091106210.21291@schroedinger.engr.sgi.com> <20040610220445.2116457b.davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e1+sTVyxRliB/aPL"
Content-Disposition: inline
In-Reply-To: <20040610220445.2116457b.davem@redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--e1+sTVyxRliB/aPL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 10, 2004  22:04 -0700, David S. Miller wrote:
> This is far from a critical code path, so this is how I'm
> going to fix this.
>=20
> # This is a BitKeeper generated diff -Nru style patch.
> #
> # ChangeSet
> #   2004/06/10 22:05:19-07:00 davem@nuts.davemloft.net=20
> #   [IPV4]: Fix unaligned accesses in arp_tables.c
> #=20
> # net/ipv4/netfilter/arp_tables.c
> #   2004/06/10 22:05:03-07:00 davem@nuts.davemloft.net +3 -4
> #   [IPV4]: Fix unaligned accesses in arp_tables.c
> #=20
> diff -Nru a/net/ipv4/netfilter/arp_tables.c b/net/ipv4/netfilter/arp_tabl=
es.c
> --- a/net/ipv4/netfilter/arp_tables.c	2004-06-10 22:05:40 -07:00
> +++ b/net/ipv4/netfilter/arp_tables.c	2004-06-10 22:05:40 -07:00
> @@ -179,11 +179,10 @@
>  		return 0;
>  	}
> =20
> -	/* Look for ifname matches; this should unroll nicely. */
> +	/* Look for ifname matches.  */
>  	for (i =3D 0, ret =3D 0; i < IFNAMSIZ/sizeof(unsigned long); i++) {
> -		ret |=3D (((const unsigned long *)indev)[i]
> -			^ ((const unsigned long *)arpinfo->iniface)[i])
> -			& ((const unsigned long *)arpinfo->iniface_mask)[i];
> +		ret |=3D (indev[i] ^ arpinfo->iniface[i])
> +			& arpinfo->iniface_mask[i];
>  	}

- 	for (i =3D 0, ret =3D 0; i < IFNAMSIZ/sizeof(unsigned long); i++) {
+ 	for (i =3D 0, ret =3D 0; i < IFNAMSIZ; i++) {

Shouldn't your change include the above?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/                 http://members.shaw.ca/goli=
nux/


--e1+sTVyxRliB/aPL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAyUX3pIg59Q01vtYRAsflAJwO5AxKxY1aVIkCnBR/3m808ubcKQCfaIAa
xLotjsN974C78QtWnqVdnEM=
=k0UD
-----END PGP SIGNATURE-----

--e1+sTVyxRliB/aPL--
