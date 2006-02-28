Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932480AbWB1UHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbWB1UHn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 15:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbWB1UHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 15:07:43 -0500
Received: from node8.mtu.edu ([141.219.69.8]:47239 "EHLO node8.mtu.edu")
	by vger.kernel.org with ESMTP id S932480AbWB1UHm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 15:07:42 -0500
Date: Tue, 28 Feb 2006 15:07:36 -0500
From: Jon DeVree <jadevree@mtu.edu>
To: linux-kernel@vger.kernel.org
Subject: networking bug?
Message-ID: <20060228200736.GA23000@junkers.homelinux.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.2.0.0, Antispam-Data: 2006.02.28.110612
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='IP_HTTP_ADDR 0, __CD 0, __CT 0, __CTYPE_HAS_BOUNDARY 0, __CTYPE_MULTIPART 0, __HAS_MSGID 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Is this desired (but odd) behavior or a bug?
The driver is 3c59x and the kernel is 2.6.13.2 if that is relevant.

eth0 has no information (the driver was just freshly loaded)

# ip route show table main dev eth0
# ip route show table local dev eth0

Bring it up with an address

# ifconfig eth0 1.2.3.4
# ip route show table main dev eth0
1.0.0.0/8  proto kernel  scope link  src 1.2.3.4=20
# ip route show table local dev eth0
broadcast 1.0.0.0  proto kernel  scope link  src 1.2.3.4=20
local 1.2.3.4  proto kernel  scope host  src 1.2.3.4=20
broadcast 1.255.255.255  proto kernel  scope link  src 1.2.3.4

Turn it back off

# ifconfig eth0 down
# ping -c 1 1.2.3.4
PING 1.2.3.4 (1.2.3.4) 56(84) bytes of data.
64 bytes from 1.2.3.4: icmp_seq=3D1 ttl=3D64 time=3D0.091 ms

--- 1.2.3.4 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev =3D 0.091/0.091/0.091/0.000 ms

The address is still pingable

# ip route show table main dev eth0
# ip route show table local dev eth0
local 1.2.3.4  proto kernel  scope host  src 1.2.3.4

The routing table entry was left behind.

I've had some great paranoid moments with SSH host-key errors thanks to
this quirk.
--=20
Jon
"RISC architecture is gonna change everything." -Kate Libby

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFEBK2I4m3oE/xVNJ4RAiyvAJ9WZ+6kQiEiM2HYqjGsjh2r07TJUwCfacTF
cDGJC682wqFP1GE+MXqgZXw=
=2Qg8
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
