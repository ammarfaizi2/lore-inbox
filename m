Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262104AbVBBJaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbVBBJaQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 04:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262201AbVBBJaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 04:30:16 -0500
Received: from astra.telenet-ops.be ([195.130.132.58]:15014 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S262104AbVBBJaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 04:30:06 -0500
From: Lennert Van Alboom <lennert.vanalboom@ugent.be>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Memory leak in 2.6.11-rc1?
Date: Wed, 2 Feb 2005 10:29:58 +0100
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>, alexn@dsv.su.se,
       kas@fi.muni.cz, linux-kernel@vger.kernel.org
References: <20050121161959.GO3922@fi.muni.cz> <20050124125649.35f3dafd.akpm@osdl.org> <Pine.LNX.4.58.0501241435010.4191@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501241435010.4191@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1974240.3Sv1D2lVon";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200502021030.06488.lennert.vanalboom@ugent.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1974240.3Sv1D2lVon
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I applied the patch and it works like a charm. As a kinky side effect: befo=
re=20
this patch, using a compiled-in vesa or vga16 framebuffer worked with the=20
proprietary nvidia driver, whereas now tty1-6 are corrupt when not using=20
80x25. Strangeness :)

Lennert

On Monday 24 January 2005 23:35, Linus Torvalds wrote:
> On Mon, 24 Jan 2005, Andrew Morton wrote:
> > Would indicate that the new pipe code is leaking.
>
> Duh. It's the pipe merging.
>
> 		Linus
>
> ----
> --- 1.40/fs/pipe.c	2005-01-15 12:01:16 -08:00
> +++ edited/fs/pipe.c	2005-01-24 14:35:09 -08:00
> @@ -630,13 +630,13 @@
>  	struct pipe_inode_info *info =3D inode->i_pipe;
>
>  	inode->i_pipe =3D NULL;
> -	if (info->tmp_page)
> -		__free_page(info->tmp_page);
>  	for (i =3D 0; i < PIPE_BUFFERS; i++) {
>  		struct pipe_buffer *buf =3D info->bufs + i;
>  		if (buf->ops)
>  			buf->ops->release(info, buf);
>  	}
> +	if (info->tmp_page)
> +		__free_page(info->tmp_page);
>  	kfree(info);
>  }

--nextPart1974240.3Sv1D2lVon
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCAJ2eo6KaR1afCnARAvBnAJsHhdK7l0SwS/UfSX+5TpZrr7fzsQCg6T94
hgPGE9/aFlyjV0Rfedi+ask=
=kFp9
-----END PGP SIGNATURE-----

--nextPart1974240.3Sv1D2lVon--
