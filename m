Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWATVZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWATVZw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 16:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWATVZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 16:25:52 -0500
Received: from ns.dn.farlep.net ([213.130.10.10]:41991 "EHLO dn.farlep.net")
	by vger.kernel.org with ESMTP id S932213AbWATVZv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 16:25:51 -0500
Posted-Date: Fri, 20 Jan 2006 23:25:37 +0200 (EET)
X-Sagator-id: 20060120-232537-0001-67688-5LcAJu
Date: Fri, 20 Jan 2006 23:25:17 +0200
From: "Vitaly V. Bursov" <vitalyb@telenet.dn.ua>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.6.15.1 ppp_async panic on x86-64.
Message-Id: <20060120232517.4f0f551d.vitalyb@telenet.dn.ua>
In-Reply-To: <20060120043038.0dd9669b.akpm@osdl.org>
References: <20060115214838.2034a56c.vitalyb@telenet.dn.ua>
	<20060120043038.0dd9669b.akpm@osdl.org>
Organization: Telenet
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.8; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__20_Jan_2006_23_25_17_+0200_h_K6v3lg24PR_afz"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__20_Jan_2006_23_25_17_+0200_h_K6v3lg24PR_afz
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Jan 2006 04:30:38 -0800
Andrew Morton <akpm@osdl.org> wrote:

> "Vitaly V. Bursov" <vitalyb@telenet.dn.ua> wrote:
> >
> >  PPP doesn't work for me on a x86-64 kernel.
> >
>=20
> The below was merged a couple of days ago, which should fix it.  Can you
> please confirm that?
Yes, this patch resolves the problem.

Thanks.

> Begin forwarded message:
>=20
> Date: Tue, 17 Jan 2006 18:03:32 -0800
> From: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> To: git-commits-head@vger.kernel.org
> Subject: [NET]: Make second arg to skb_reserved() signed.
>=20
>=20
> tree 39750d44770efcdac150f041f71b7272c8da20f9
> parent f09484ff87f677056ce631aa3d8e486861501b51
> author David S. Miller <davem@sunset.davemloft.net> Tue, 17 Jan 2006 18:5=
4:21 -0800
> committer David S. Miller <davem@sunset.davemloft.net> Tue, 17 Jan 2006 1=
8:54:21 -0800
>=20
> [NET]: Make second arg to skb_reserved() signed.
>=20
> Some subsystems, such as PPP, can send negative values
> here.  It just happened to work correctly on 32-bit with
> an unsigned value, but on 64-bit this explodes.
>=20
> Figured out by Paul Mackerras based upon several PPP crash
> reports.
>=20
> Signed-off-by: David S. Miller <davem@davemloft.net>
>=20
>  include/linux/skbuff.h |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index e5fd66c..ad7cc22 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -926,7 +926,7 @@ static inline int skb_tailroom(const str
>   *	Increase the headroom of an empty &sk_buff by reducing the tail
>   *	room. This is only allowed for an empty buffer.
>   */
> -static inline void skb_reserve(struct sk_buff *skb, unsigned int len)
> +static inline void skb_reserve(struct sk_buff *skb, int len)
>  {
>  	skb->data +=3D len;
>  	skb->tail +=3D len;


--=20
Vitaly                                                              DON'T P=
ANIC
GPG Key ID: F95A23B9

--Signature=_Fri__20_Jan_2006_23_25_17_+0200_h_K6v3lg24PR_afz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFD0VVB73PAj/laI7kRAtHvAJ9e/EXvC7tVcNnTdeAfOOW7J3ubaACfbCge
cuOpVQBAeQCplKQgY/+anwQ=
=8x+r
-----END PGP SIGNATURE-----

--Signature=_Fri__20_Jan_2006_23_25_17_+0200_h_K6v3lg24PR_afz--
