Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291251AbSCMAJS>; Tue, 12 Mar 2002 19:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291258AbSCMAJI>; Tue, 12 Mar 2002 19:09:08 -0500
Received: from [217.79.102.244] ([217.79.102.244]:34045 "EHLO
	monkey.beezly.org.uk") by vger.kernel.org with ESMTP
	id <S291251AbSCMAIv>; Tue, 12 Mar 2002 19:08:51 -0500
Subject: Re: Dropped packets on SUN GEM
From: Beezly <beezly@beezly.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020312.155238.21594857.davem@redhat.com>
In-Reply-To: <1015974664.2652.10.camel@monkey>
	<20020312.151443.03370128.davem@redhat.com>
	<1015976181.2652.30.camel@monkey> 
	<20020312.155238.21594857.davem@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-n0MPvocuG7b+HpWnWxTo"
X-Mailer: Evolution/1.0.2 
Date: 13 Mar 2002 00:08:47 +0000
Message-Id: <1015978127.2653.49.camel@monkey>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-n0MPvocuG7b+HpWnWxTo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2002-03-12 at 23:52, David S. Miller wrote:
> Thinking... I guess my gem_rxmac_reset() does not reset the
> receive FIFO so until it is filled up and reset none of the
> packets received actually make it past the card.
>=20
> How does it behave with the patch below added to what you are running
> right now?
>=20

The problem appears to get worse;

$ ping -s 1472 -i 0.1 10.0.0.3=20
<snip>
1480 bytes from 10.0.0.3: icmp_seq=3D4487 ttl=3D255 time=3D4.13 ms
1480 bytes from 10.0.0.3: icmp_seq=3D4488 ttl=3D255 time=3D4.13 ms
1480 bytes from 10.0.0.3: icmp_seq=3D4489 ttl=3D255 time=3D4.13 ms
1480 bytes from 10.0.0.3: icmp_seq=3D4490 ttl=3D255 time=3D4.13 ms
1480 bytes from 10.0.0.3: icmp_seq=3D4491 ttl=3D255 time=3D4.14 ms
1480 bytes from 10.0.0.3: icmp_seq=3D4517 ttl=3D255 time=3D4.18 ms
1480 bytes from 10.0.0.3: icmp_seq=3D4518 ttl=3D255 time=3D4.13 ms
1480 bytes from 10.0.0.3: icmp_seq=3D4519 ttl=3D255 time=3D4.12 ms
1480 bytes from 10.0.0.3: icmp_seq=3D4520 ttl=3D255 time=3D4.13 ms

25 lost packets :(

Also, just to clarify (i wasn't clear earlier), this host is connected
via 1000Mbps full-duplex fibre to the switch.

The other machines on the switch are connected either by 100Mbps copper
or 10Mpbs copper. I'm guessing the other machines shouldn't be able to
flood the RX on this host even if they all transmitted at the same time?
(there are only three of them)

Beezly

--=-n0MPvocuG7b+HpWnWxTo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8jpiPXu4ZFsMQjPgRApbeAKDLvQIbgXTEpFAu/+xezPajENUvBQCeObeW
uqvK3OXRRrKGeE+sDJr5HtM=
=q9rE
-----END PGP SIGNATURE-----

--=-n0MPvocuG7b+HpWnWxTo--
