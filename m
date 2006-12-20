Return-Path: <linux-kernel-owner+w=401wt.eu-S932865AbWLTBel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932865AbWLTBel (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 20:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932912AbWLTBel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 20:34:41 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:55664 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932865AbWLTBek (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 20:34:40 -0500
X-Sasl-enc: NIXXFP79KZDAXjoTV96ZJKpAeeTdcqvcxg8i7jDaoC4r 1166578474
Message-ID: <4588940B.2020604@imap.cc>
Date: Wed, 20 Dec 2006 02:38:19 +0100
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch] hrtimers: add state tracking, fix
References: <20061214225913.3338f677.akpm@osdl.org> <200612191815.kBJIFF4O018306@lx1.pxnet.com> <20061219195650.GA8797@elte.hu>
In-Reply-To: <20061219195650.GA8797@elte.hu>
X-Enigmail-Version: 0.94.1.2
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4E810FE41CC294C085C6043C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4E810FE41CC294C085C6043C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 19.12.2006 20:56 schrieb Ingo Molnar:
> thanks for the report - this made me review the hrtimer state engine=20
> logic, and bingo, it indeed has a nasty typo! Could you try the fix=20
> below, does it fix your problem? It might explain the crash you are=20
> seeing, because the typo means we'd ignore HRTIMER_STATE_PENDING state =

> (which is rare but possible).

Ok, the machine has been running for a couple of hours with that patch
and so far hasn't frozen again. I'll watch it some more but it looks
like your patch did indeed fix my problem.

Thanks
Tilman

> -------------------------->
> Subject: [patch] hrtimers: add state tracking, fix
> From: Ingo Molnar <mingo@elte.hu>
>=20
> fix bug in hrtimer_is_queued(), introduced by a cleanup during
> the recent refactoring.
>=20
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ---
>  kernel/hrtimer.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Index: linux/kernel/hrtimer.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/kernel/hrtimer.c
> +++ linux/kernel/hrtimer.c
> @@ -157,7 +157,7 @@ static void hrtimer_get_softirq_time(str
>  static inline int hrtimer_is_queued(struct hrtimer *timer)
>  {
>  	return timer->state &
> -		(HRTIMER_STATE_ENQUEUED || HRTIMER_STATE_PENDING);
> +		(HRTIMER_STATE_ENQUEUED | HRTIMER_STATE_PENDING);
>  }
> =20
>  /*

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enig4E810FE41CC294C085C6043C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFiJQLMdB4Whm86/kRAgZ2AJ92+/OlIHxgoQDm3fcbbsgPXYQunACggkVH
sEqoDKFjBRkC0F2lF1l/p8A=
=E5g4
-----END PGP SIGNATURE-----

--------------enig4E810FE41CC294C085C6043C--
