Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbVASSBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbVASSBD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 13:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVASSBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 13:01:03 -0500
Received: from use.the.admin.shell.to.set.your.reverse.dns.for.this.ip ([80.68.90.107]:29188
	"EHLO irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S261804AbVASR5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 12:57:45 -0500
Subject: Re: Announce loop-AES-v3.0b file/swap crypto package
From: Fruhwirth Clemens <clemens@endorphin.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Dan Hollis <goemon@anime.net>, Venkat Manakkal <venkat@rayservers.com>,
       Andries Brouwer <aebr@win.tue.nl>,
       Paul Walker <paul@black-sun.demon.co.uk>, linux-kernel@vger.kernel.org,
       linux-crypto@nl.linux.org, James Morris <jmorris@redhat.com>
In-Reply-To: <Pine.LNX.3.96.1050119115600.8036H-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1050119115600.8036H-100000@gatekeeper.tmr.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-fjc1Kbnlm7nutSy6fUMk"
Date: Wed, 19 Jan 2005 18:57:39 +0100
Message-Id: <1106157459.19164.8.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fjc1Kbnlm7nutSy6fUMk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-01-19 at 12:03 -0500, Bill Davidsen wrote:
> On Tue, 18 Jan 2005, Dan Hollis wrote:
>=20
> > On Tue, 18 Jan 2005, Venkat Manakkal wrote:
> > > As for cryptoloop, I'm sorry, I cannot say the same. The password has=
hing
> > > system being changed in the past year, poor stability and machine loc=
kups are
> > > what I have noticed, besides there is nothing like the readme here:
> >=20
> > cryptoloop is also unusably slow, even on my x86_64 machines...
>=20
> I'm obviously doing something wrong, I just copied about 40MB of old
> kernels (vmlinuz*) and some jpg files into a subdir on my cryptoloop
> filesystem, and I measured 4252.2375kB/s realtime and 18819.7879 kB/s CPU
> time. This doesn't seem unusably slow, even on my mighty P-II/350 and
> eight year old 4GB drives. The hdb is so old it has to run in pio mode, t=
o
> give you an idea, and the original data was not in memory.

I've rewritten some CBC code to fit the facilities I introduce in my LRW
patch[1]. Here are the results for my P4@1.8GHZ:

loop-aes, CBC: ~30.5mb/s
dm-crypt, CBC prior to my rewrite: ~23mb/s
dm-crypt, CBC with my LRW patch: ~27mb/s
dm-crypt, LRW with my LRW patch: ~27mb/s (slightly faster than CBC)

As you can see my LRW patches (actually it's the generic scatterwalker
which is part of the LRW patch set) halves the gap to loop-aes.=20

I'm sure dm-crypt is never going to achieve the speed of loop-aes.
That's just the price you pay, when you have to do things right and
clean, so they get merged into main. Kernel developers are choosey
customers, you know.

[1] http://clemens.endorphin.org/patches/lrw/

--=20
Fruhwirth Clemens <clemens@endorphin.org>  http://clemens.endorphin.org

--=-fjc1Kbnlm7nutSy6fUMk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB7p+SW7sr9DEJLk4RAlsfAJ9cl/8iN9Thx7qiGQSS2FvCV7bgzACeKDak
dQJ5rdIeMY313KhP1nEVSEA=
=MSb+
-----END PGP SIGNATURE-----

--=-fjc1Kbnlm7nutSy6fUMk--
