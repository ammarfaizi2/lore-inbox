Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265750AbUFIM1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265750AbUFIM1q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 08:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265701AbUFIM1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 08:27:22 -0400
Received: from svana.org ([203.20.62.76]:6157 "EHLO svana.org")
	by vger.kernel.org with ESMTP id S265690AbUFIM0F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 08:26:05 -0400
Date: Wed, 9 Jun 2004 22:20:30 +1000
From: Martijn van Oosterhout <kleptog@svana.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: netdev@oss.sgi.com, linux-net@vger.kernel.org, davem@redhat.com,
       yoshfuji@linux-ipv6.org, pekkas@netcore.fi, jmorris@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: UDP sockets bound to ANY send answers with wrong src ip address
Message-ID: <20040609122030.GA14854@svana.org>
Reply-To: Martijn van Oosterhout <kleptog@svana.org>
References: <200406091425.39324.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <200406091425.39324.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.3.28i
X-PGP-Key-ID: Length=1024; ID=0x0DC67BE6
X-PGP-Key-Fingerprint: 295F A899 A81A 156D B522  48A7 6394 F08A 0DC6 7BE6
X-PGP-Key-URL: <http://svana.org/kleptog/0DC67BE6.pgp.asc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 09, 2004 at 02:25:39PM +0300, Denis Vlasenko wrote:
> I observe that UDP sockets listening on ANY
> send response packets with ip addr derived from
> ip address of interface which is used to send 'em
> instead of using dst ip address of client's packet.
>=20
> I was bitten by this with DNS and NTP.

This is the responsibility of the program. Unless the UDP packet is
bound to a particular address, or the program specifies an IP, the
kernel will pick one. For this reason both the BIND and NTP daemons
open a socket for each interface so they can control this. netstat on
my machine shows:

udp        0      0 192.168.1.225:123       0.0.0.0:*                      =
    =20
udp        0      0 127.0.0.1:123           0.0.0.0:*                      =
    =20
udp        0      0 0.0.0.0:123             0.0.0.0:*                      =
 =20

for the NTP server. The DNS has similar machanism. Remember, UDP
doesn't involve connections, so there is no concept of "replying" to a
packet, the program has to manage that itself.

In your example, if you tell netcat which address to bind to, it will
work.

Hope this helps,
--=20
Martijn van Oosterhout   <kleptog@svana.org>   http://svana.org/kleptog/
> Patent. n. Genius is 5% inspiration and 95% perspiration. A patent is a
> tool for doing 5% of the work and then sitting around waiting for someone
> else to do the other 95% so you can sue them.

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQFAxwCOY5Twig3Ge+YRAuhNAJ9nPZoSBpqFJ6VKJeBEfZ/mGa1R2wCbBfzd
crXiVHsXqOnJ/gXHkGju+xM=
=vPAq
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
