Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbVCYHw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVCYHw1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 02:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbVCYHw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 02:52:27 -0500
Received: from dea.vocord.ru ([217.67.177.50]:12173 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261527AbVCYHvx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 02:51:53 -0500
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
	(2.6.11)
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jeff Garzik <jgarzik@pobox.com>, David McCullough <davidm@snapgear.com>,
       cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@redhat.com>
In-Reply-To: <20050325072531.GA416@gondor.apana.org.au>
References: <42439839.7060702@pobox.com> <1111728804.23532.137.camel@uganda>
	 <4243A86D.6000408@pobox.com> <1111731361.20797.5.camel@uganda>
	 <20050325061311.GA22959@gondor.apana.org.au>
	 <1111732459.20797.16.camel@uganda>
	 <20050325063333.GA27939@gondor.apana.org.au>
	 <1111733958.20797.30.camel@uganda>
	 <20050325065622.GA31127@gondor.apana.org.au>
	 <1111735195.20797.42.camel@uganda>
	 <20050325072531.GA416@gondor.apana.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-FgooCfE12CEckd4Wx0ik"
Organization: MIPT
Date: Fri, 25 Mar 2005 10:58:16 +0300
Message-Id: <1111737496.20797.59.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Fri, 25 Mar 2005 10:51:02 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FgooCfE12CEckd4Wx0ik
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-03-25 at 18:25 +1100, Herbert Xu wrote:
> On Fri, Mar 25, 2005 at 10:19:55AM +0300, Evgeniy Polyakov wrote:
> >=20
> > Noone will complain on Linux if NIC is broken and produces wrong
> > checksum
> > and HW checksum offloading is enabled using ethtools.
>=20
> This is completely different.  The worst that can happen with checksum
> offloading is that the packet is dropped.  That's something people deal
> with on a daily basis since the Internet as a whole does not guarantee
> the delivery of packets.

It will just completely stop network dataflow.
It is of course not as catastrophic as removing strong random numbers=20
from system.
But nevertheless - write cahce in disks may corrupt data on power-down,
but people do not turn it off, crypto HW can be broken and does not=20
encrypt dataflow, but people want it, broken NIC can corrupt data with=20
various sg/offload combinations, but it can be enabled.

It is a feature, that _may_ broke thing badly.
But if all is ok - it is extremly usefull.

And as I said there may be other [HW/driver] validating techniques,=20
not only userspace daemon.

> On the other hand, /dev/random is something that has always promised
> to deliver random numbers that are totally unpredictable.  People out
> there *depend* on this.
>=20
> If that assumption is violated the result could be catastrophic.
>=20
> That's why it's OK to have hardware RNG spit out unverified numbers
> in /dev/hw_random, but it's absolutely unaccpetable for the same
> numbers to add entropy to /dev/random without verification.

Userspace daemon can read data from /dev/random and validate it
in background, if it fells it is broken - turn feature off.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-FgooCfE12CEckd4Wx0ik
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCQ8SYIKTPhE+8wY0RApx5AKCJcktCBK0gHvy6azj3BTBuTMl9xACeKoQO
k69FVkrtLyxnRRt15Bi1/z0=
=95bn
-----END PGP SIGNATURE-----

--=-FgooCfE12CEckd4Wx0ik--

