Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262216AbVC2LhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbVC2LhF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 06:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbVC2LhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 06:37:05 -0500
Received: from dea.vocord.ru ([217.67.177.50]:20645 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262216AbVC2Lgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 06:36:43 -0500
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
	(2.6.11)
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@redhat.com>, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, cryptoapi@lists.logix.cz,
       Jeff Garzik <jgarzik@pobox.com>, David McCullough <davidm@snapgear.com>
In-Reply-To: <20050329104627.GD19468@gondor.apana.org.au>
References: <42432972.5020906@pobox.com> <1111725282.23532.130.camel@uganda>
	 <42439839.7060702@pobox.com> <1111728804.23532.137.camel@uganda>
	 <4243A86D.6000408@pobox.com> <1111731361.20797.5.camel@uganda>
	 <20050325061311.GA22959@gondor.apana.org.au>
	 <20050329102104.GB6496@elf.ucw.cz>
	 <20050329103049.GB19541@gondor.apana.org.au>
	 <1112093428.5243.88.camel@uganda>
	 <20050329104627.GD19468@gondor.apana.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-hFDZdMKcUVIlLrIIGPp5"
Organization: MIPT
Date: Tue, 29 Mar 2005 15:42:05 +0400
Message-Id: <1112096525.5243.98.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Tue, 29 Mar 2005 15:35:31 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hFDZdMKcUVIlLrIIGPp5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-03-29 at 20:46 +1000, Herbert Xu wrote:
> On Tue, Mar 29, 2005 at 02:50:28PM +0400, Evgeniy Polyakov wrote:
> >
> > Without ability speed this up in kernel, we completely [ok, almost]=20
> > loose all RNG advantages.
>=20
> Well if you can demonstrate that you're getting a higher rate of
> throughput from your RNG by doing this in kernel space vs. doing
> it in user space please let me know.

Quote from VIA RNG crypto analysis:

"Bitrate. The RNG generates output at significantly
higher rates than most PC-based randomness resources.
Raw bits are produced at rates of 30 to 50 Mbits/sec,
and whitened bits were observed at rates of 4 to 9
Mbits/sec. Variations in output rates depend on the
RNG configuration and the oscillator rates. PRNGs
seeded with the Nehemiah RNG should be able to
easily sustain output in excess of 2 Mbits of entropy per
second, which should eliminate blocked PRNG reads in
virtually all applications."


While raw bits reading from hw_random on the fastest=20
VIA boards can exceed 55mbits per second=20
[above quite was taken from VIA C3 Nehemiah analysis],=20
it is not evaluated in rngd and is not written=20
back to the /dev/random.

David provided his patch exactly because of
"Adding this can dramatically improve the performance of=20
/dev/random on small embedded systems which do not=20
generate much entropy."
and it works.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-hFDZdMKcUVIlLrIIGPp5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCST8NIKTPhE+8wY0RAp9eAJ4ovnyfrJ/tR/a+oYok77AwHaQClwCeIBfU
3Y7o1XWPlgjef06egqDh3II=
=r0/F
-----END PGP SIGNATURE-----

--=-hFDZdMKcUVIlLrIIGPp5--

