Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVAMSyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVAMSyb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 13:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVAMSvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 13:51:13 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:53200 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S261275AbVAMSru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 13:47:50 -0500
Date: Thu, 13 Jan 2005 11:47:34 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH as442] gcc 2.96 workaround in sys_getdents64()
Message-ID: <20050113184734.GF8098@schnapps.adilger.int>
Mail-Followup-To: Alan Stern <stern@rowland.harvard.edu>,
	Andrew Morton <akpm@osdl.org>,
	Kernel development list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0501131132520.959-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HENu/cXyPKFN4XCQ"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0501131132520.959-100000@ida.rowland.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HENu/cXyPKFN4XCQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 13, 2005  11:39 -0500, Alan Stern wrote:
> How serious are people about continuing to support versions of gcc prior=
=20
> to 3.0?  My copy of RedHat's gcc-2.96 croaks without this patch:
>=20
>=20
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
>=20
> =3D=3D=3D=3D=3D fs/readdir.c 1.26 vs edited =3D=3D=3D=3D=3D
> --- 1.26/fs/readdir.c	2005-01-09 08:29:46 -05:00
> +++ edited/fs/readdir.c	2005-01-13 11:31:58 -05:00
> @@ -288,7 +288,7 @@
>  	if (lastdirent) {
>  		typeof(lastdirent->d_off) d_off =3D file->f_pos;
>  		error =3D count - buf.count;
> -		if (__put_user(d_off, &lastdirent->d_off))
> +		if (put_user(d_off, &lastdirent->d_off))
>  			error =3D -EFAULT;
>  	}
> =20
>=20
> For changes involving code that's not executed very often I wouldn't
> hesitate to recommend adopting such a patch.  Does sys_getdents64() fall
> in that category?  Also I'm not sure how much extra overhead is added by
> calling put_user() rather than __put_user().

The getdents64() syscall is used for every readdir, though I doubt the
extra overhead would be fatal.  In any case, Linus already accepted a
different patch which set "error =3D -EFAULT" first, then "count - buf.coun=
t"
afterward.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--HENu/cXyPKFN4XCQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFB5sJGpIg59Q01vtYRAgpEAKC2rGoWAdaZHHbiMcYXespBJb+apgCaA10v
Ghwg14RDmx0CqSFzcXxgU+c=
=luGW
-----END PGP SIGNATURE-----

--HENu/cXyPKFN4XCQ--
