Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbVLTMJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbVLTMJW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 07:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbVLTMJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 07:09:22 -0500
Received: from sipsolutions.net ([66.160.135.76]:57102 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S1750922AbVLTMJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 07:09:21 -0500
Subject: sungem hangs in atomic if netconsole enabled but no carrier
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@redhat.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Eric Lemoine <eric.lemoine@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-byUykypJTrKMvLv+6Ym4"
Date: Tue, 20 Dec 2005 13:08:58 +0100
Message-Id: <1135080538.3937.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-byUykypJTrKMvLv+6Ym4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I've been debugging some issues and wondered why I got hangs in random
places in the code. It turns out that the problem is that I still had
netconsole enabled even though I have no network at the moment. So what
I had was:
  * sungem compiled in
  * netconsole=3D.... as command line
  * no network cable plugged in

sungem does recognise this situation and says that waiting for carrier
timed out. However, later, when I printk() in with interrupts disabled,
the system hangs after printing out a few lines to the console (I think
it's more than one, not sure though, might be just a single one).

Turns out that if I remove the netconsole=3D... option to my kernel, all
works fine and the system no longer hangs. Obviously not plugging in a
network cable is pretty useless when netconsole is turned on, but I
think it should not hang the system completely. So far I haven't been
able to figure out where it actually hangs and don't even know how to do
so -- I'm open for suggestions on how to find out why/where it hangs or
even fixes.

johannes


--=-byUykypJTrKMvLv+6Ym4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQ6f0WaVg1VMiehFYAQJSNA//UUGZJraE1B7uz7iJuen3tQMxiJLd/qaT
13znBCgtOp8kuY1uSu5czqwa84bWv6mqaVQngZbY8NmesgeN31oqZRvOcv8nko1u
CtoH4uMz6V6T4aQbjhur4SDsVZWua38OczcJ+j2YhPHY22VhxtIXt8gnIo0SZ+Xl
4hAwT3G+pnyFIQsGrng3YzZymRSn7/wxia2wi0aT85e87e2W5v9mwKziYpknq/4P
AyqVJe1xNgZkG3oZjZmXPSxDBHLh8ZW9hzDUnegpCGv1m0fHi0y9OXjgJ9ZKM89J
uM1ZpuLZGe4Hn+KJu4ZeGgSBiQktUsWmZylqEKvFoeB/FuBbviMQLTMO91ivN0br
lEJBK4V2waNqoNPr7ZtUDEQYw/S1wdOnnXdTRGJUmEqv/kmfu46ostfDjq01dlWA
7QgCPS+62ULsekLgn+yBWK8V7+VMLM3T+cn5roVg3Hjq4m5HlfOZdd4DIGlcANC9
qX3maNkn61u1Ohl925PXkxmFjiQutLJMkgW3tj/KapdVK2B47VGGQ0kY7whbOtD8
8iNZnzXQtSb+knoo3af1bfSlGZ3UCK/FsNSa0CaGyYZUTQZ8H37daOo9N8syHWeC
gI6oKefVbDMRHq1j3q2XgUrWjtd6tjKgoQ+1lEDnsUnXumrzoIaQK/tswFBJ1bNF
gnVRWxrlfzk=
=adyd
-----END PGP SIGNATURE-----

--=-byUykypJTrKMvLv+6Ym4--

