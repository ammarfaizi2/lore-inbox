Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262204AbVATWv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbVATWv5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 17:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbVATWv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 17:51:57 -0500
Received: from smtp07.auna.com ([62.81.186.17]:16783 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id S262204AbVATWvq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 17:51:46 -0500
Date: Thu, 20 Jan 2005 22:51:42 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: [patch 3/3] spinlock fix #3: type-checking spinlock primitives,
 x86
To: linux-kernel@vger.kernel.org
References: <20050120114317.GA29876@elte.hu>
	<20050120115947.GA31305@elte.hu> <20050120120905.GA3493@elte.hu>
In-Reply-To: <20050120120905.GA3493@elte.hu> (from mingo@elte.hu on Thu Jan
	20 13:09:05 2005)
X-Mailer: Balsa 2.2.6
Message-Id: <1106261502l.7080l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-TO5RHc5WYTTg8qLztRrx"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-TO5RHc5WYTTg8qLztRrx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On 2005.01.20, Ingo Molnar wrote:
>=20
> this patch would have caught the bug in -BK-curr (that patch #1 fixes),
> via a compiler warning. Test-built/booted on x86.
>=20
> 	Ingo
>=20
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
>=20
> --- linux/include/asm-i386/spinlock.h.orig
> +++ linux/include/asm-i386/spinlock.h
> @@ -36,7 +36,10 @@ typedef struct {
> =20
>  #define SPIN_LOCK_UNLOCKED (spinlock_t) { 1 SPINLOCK_MAGIC_INIT }
> =20
> -#define spin_lock_init(x)	do { *(x) =3D SPIN_LOCK_UNLOCKED; } while(0)
> +static inline void spin_lock_init(spinlock_t *lock)

Will have any real effect if you add things like:

+static inline void spin_lock_init(spinlock_t *lock) __attribute__((__pure_=
_));

??

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-jam4 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-3mdk)) #2


--=-TO5RHc5WYTTg8qLztRrx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBB8DX+RlIHNEGnKMMRAkBpAJ4rVWijoxBJYxhmRFePtXvIfzBPggCfXLI5
GMbO9jkjGtu/ve4COaT1wnk=
=avOj
-----END PGP SIGNATURE-----

--=-TO5RHc5WYTTg8qLztRrx--

