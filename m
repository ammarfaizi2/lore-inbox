Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbVCYE2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVCYE2N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 23:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbVCYE2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 23:28:13 -0500
Received: from dea.vocord.ru ([217.67.177.50]:51426 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261221AbVCYE2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 23:28:00 -0500
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
	(2.6.11)
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Jeff Garzik <jgarzik@pobox.com>
Cc: David McCullough <davidm@snapgear.com>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       Herbert Xu <herbert@gondor.apana.org.au>
In-Reply-To: <42432972.5020906@pobox.com>
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast>
	 <1111665551.23532.90.camel@uganda> <4242B712.50004@pobox.com>
	 <20050324132342.GD7115@beast> <1111671993.23532.115.camel@uganda>
	 <42432972.5020906@pobox.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-mk/wpIFvznOj3BqSIXUb"
Organization: MIPT
Date: Fri, 25 Mar 2005 07:34:42 +0300
Message-Id: <1111725282.23532.130.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Fri, 25 Mar 2005 07:27:28 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mk/wpIFvznOj3BqSIXUb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-03-24 at 15:56 -0500, Jeff Garzik wrote:

> > Idea to validate entropy data is good in general,=20
> > but it should be implemented in a way allowing external both in-kernel
> > and userspace
> > processes to contribute data.
> > So for in-kernel use we need such a mechanism, and userspace gkernel
> > daemon
> > should use it(as the latest "step") too.
>=20
> See the earlier discussion, when data validation was -removed- from the=20
> original Intel RNG driver, and moved to userspace.
>=20

I'm not arguing against userspace validation, but if data produced
_is_ cryptographically strong, why revalidate it again?

I definitely prefer such mechanism to be implemented, and if you want,
it
can be turned by default off, and can be turned on using new ioctl()=20
over /dev/random.

> > Your changes are correct, ioctl(RNDADDENTROPY) could even use it instea=
d
> > of direct
> > add_entropy_words()/credit_entropy_store(), but without external entrop=
y
> > contributors
> > it will not be applied by maintainers.
>=20
> No changes are needed, as the system is currently functional without=20
> these changes.

And how HIFN driver can contribute entropy?
It needs to create /dev/hifn_random, and rngd should be patched too?
And even using any existing crypto framework why add 2 kernel/user
copying, if we _want_ fast RNG and _know_ that it is valid?

You may say, that hardware can be broken and thus produces=20
wrong data, but if user want, it can turn it on or off.

What about new ioctl() that will enable/disable entropy contribution
from kernelspace without validating it? I can create a patch on
top of David's.

> 	Jeff
>=20
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-mk/wpIFvznOj3BqSIXUb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCQ5TiIKTPhE+8wY0RAoIoAJ4ourW0+0c9LURCZY+UnppmNty+owCbBiTj
1+B6ZLXjtmkOolC5KKx6Z3M=
=MP9k
-----END PGP SIGNATURE-----

--=-mk/wpIFvznOj3BqSIXUb--

