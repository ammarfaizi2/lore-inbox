Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbVCYGxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVCYGxi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 01:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVCYGxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 01:53:38 -0500
Received: from dea.vocord.ru ([217.67.177.50]:10476 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261439AbVCYGxa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 01:53:30 -0500
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
	(2.6.11)
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jeff Garzik <jgarzik@pobox.com>, David McCullough <davidm@snapgear.com>,
       cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@redhat.com>
In-Reply-To: <20050325063333.GA27939@gondor.apana.org.au>
References: <20050324132342.GD7115@beast>
	 <1111671993.23532.115.camel@uganda> <42432972.5020906@pobox.com>
	 <1111725282.23532.130.camel@uganda> <42439839.7060702@pobox.com>
	 <1111728804.23532.137.camel@uganda> <4243A86D.6000408@pobox.com>
	 <1111731361.20797.5.camel@uganda>
	 <20050325061311.GA22959@gondor.apana.org.au>
	 <1111732459.20797.16.camel@uganda>
	 <20050325063333.GA27939@gondor.apana.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3hQsXWMcI89yEj8zJqP9"
Organization: MIPT
Date: Fri, 25 Mar 2005 09:59:18 +0300
Message-Id: <1111733958.20797.30.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Fri, 25 Mar 2005 09:52:49 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3hQsXWMcI89yEj8zJqP9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-03-25 at 17:33 +1100, Herbert Xu wrote:
> On Fri, Mar 25, 2005 at 09:34:19AM +0300, Evgeniy Polyakov wrote:
> >
> > Such hardware is used mostly in embedded world where SW crypto
> > processing
> > is too expensive, so users of such HW likely want to trust to=20
> > theirs hardware and likely will turn in on.
>=20
> That's fine.  All you need for these embedded users is a user-space
> daemon that feeds data from the hardware directly into /dev/random.
> No matter how small your system is, I'm sure you can spare a few
> hundred bytes for such a thing.
>=20
> In fact most of these systems will have some sort of a general-purpose
> daemon that sits around which can perform such a task.
>=20
> System calls on Linux are fast enough that there is really no
> advantage in doing this in the kernel.
>=20
> But if you're really desparate, write a kernel module that does this
> in a kernel thread.

It is not only about userspace/kernelspace system calls and data
copying,
but about whole revalidation process, which can and is quite expensive,
due to system calls, copying and validating itself,
I even think that using userspace rng daemon is completely useless for=20
crypto HW devices - it is faster to obtain entropy from interrupts,=20
than revalidating it in that way.
And what about initial bootup? When system needs to create randoom
IP/dhcp/any ids? What about small router?
There are too many cases where userspace validation is just making
things worse.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-3hQsXWMcI89yEj8zJqP9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCQ7bGIKTPhE+8wY0RAtIeAJ4kjEN1f8jhmSamnyNuR66ZysCQ1QCcDCGy
eJVqfvy/Z4MpyXQXoGe/ZHs=
=bRjm
-----END PGP SIGNATURE-----

--=-3hQsXWMcI89yEj8zJqP9--

