Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbVAIUsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbVAIUsS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 15:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbVAIUsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 15:48:18 -0500
Received: from smtp.etmail.cz ([160.218.43.220]:46316 "EHLO smtp.etmail.cz")
	by vger.kernel.org with ESMTP id S261774AbVAIUri (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 15:47:38 -0500
Date: Sun, 9 Jan 2005 21:47:29 +0100
To: Jens Axboe <axboe@suse.de>
Cc: Hikaru1@verizon.net, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: ide-cd in 2.6.8-2.6.10 and 2.4.26-2.4.28 high cpu use with dma
Message-ID: <20050109204729.GA3899@penguin.localdomain>
Mail-Followup-To: Jens Axboe <axboe@suse.de>, Hikaru1@verizon.net,
	linux-kernel@vger.kernel.org
References: <20050109105201.GB12497@roll> <20050109105418.GD12497@roll> <20050109123028.GA12753@roll> <20050109153212.GA28417@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <20050109153212.GA28417@suse.de>
User-Agent: Mutt/1.5.6+20040907i
From: sebek64@post.cz (Marcel Sebek)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 09, 2005 at 04:32:16PM +0100, Jens Axboe wrote:
> On Sun, Jan 09 2005, Hikaru1@verizon.net wrote:
> > A minor mistake. I forgot to state explicitly that the problem only app=
ears
> > with writing audio cds. Writing data cds does not cause problems.
>=20
> The change isn't safe, it was made for a reason since some drives
> timeout if the alignment/length isn't correct. It probably is a little
> pessimistic right now, can you see if this just works for you?
>=20
> =3D=3D=3D=3D=3D drivers/ide/ide-cd.c 1.105 vs edited =3D=3D=3D=3D=3D
> --- 1.105/drivers/ide/ide-cd.c	2005-01-08 06:43:53 +01:00
> +++ edited/drivers/ide/ide-cd.c	2005-01-09 16:31:53 +01:00
> @@ -1915,7 +1915,7 @@
>  		/*
>  		 * check if dma is safe
>  		 */
> -		if ((rq->data_len & mask) || (addr & mask))
> +		if ((rq->data_len & 3) || (addr & mask))
>  			info->dma =3D 0;
>  	}
>=20

I saw the same bug on my computer and this patch fixed it. Now I can
burn audio CDs at 40x speed instead of 24x.


--=20
Marcel Sebek
jabber: sebek@jabber.cz                     ICQ: 279852819
linux user number: 307850                 GPG ID: 5F88735E
GPG FP: 0F01 BAB8 3148 94DB B95D  1FCA 8B63 CA06 5F88 735E


--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFB4Zhhi2PKBl+Ic14RAlOTAJ48xGxywC+5mCHAqDlZR6x1ZpH1uQCgyVvF
A9GUwMf9l3YWuBNfvoJ6CYA=
=AKSv
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
