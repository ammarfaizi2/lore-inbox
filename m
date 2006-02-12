Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWBLSDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWBLSDO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 13:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWBLSDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 13:03:14 -0500
Received: from wavehammer.waldi.eu.org ([82.139.196.55]:48348 "EHLO
	wavehammer.waldi.eu.org") by vger.kernel.org with ESMTP
	id S1750792AbWBLSDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 13:03:14 -0500
Date: Sun, 12 Feb 2006 19:03:08 +0100
From: Bastian Blank <bastian@waldi.eu.org>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, schwidefsky@de.ibm.com, linux390@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dasd: cleanup dasd_ioctl
Message-ID: <20060212180308.GA24896@wavehammer.waldi.eu.org>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, akpm@osdl.org,
	schwidefsky@de.ibm.com, linux390@de.ibm.com,
	linux-kernel@vger.kernel.org
References: <20060212173855.GB26035@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <20060212173855.GB26035@lst.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 12, 2006 at 06:38:55PM +0100, Christoph Hellwig wrote:
>  static int
> -dasd_ioctl_api_version(struct block_device *bdev, int no, long args)
> +dasd_ioctl_api_version(void __user *argp)
>  {
>  	int ver =3D DASD_API_VERSION;
> -	return put_user(ver, (int __user *) args);
> +	return put_user(ver, (int *)argp);
>  }

Doesn't this need to be "int __user *"?

> +long
> +dasd_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  {
> -	int i;
> +	int rval;
> =20
> -	for (i =3D 0; dasd_ioctls[i].no !=3D -1; i++)
> -		dasd_ioctl_no_unregister(NULL, dasd_ioctls[i].no,
> -					 dasd_ioctls[i].fn);
> +	lock_kernel();
> +	rval =3D dasd_ioctl(filp->f_dentry->d_inode, filp, cmd, arg);
> +	unlock_kernel();

The lock_kernel looks spurious.

Bastian

--=20
Conquest is easy. Control is not.
		-- Kirk, "Mirror, Mirror", stardate unknown

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iEYEARECAAYFAkPveFwACgkQnw66O/MvCNEb8QCgn9v5QFAhPaeNS7T8Abv7Ahc8
O58An32gaHhwLaynKn1wbeC4CFEJV3St
=vS5L
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
