Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751689AbWBMJxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbWBMJxY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 04:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751685AbWBMJxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 04:53:23 -0500
Received: from wavehammer.waldi.eu.org ([82.139.196.55]:37839 "EHLO
	wavehammer.waldi.eu.org") by vger.kernel.org with ESMTP
	id S1751200AbWBMJxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 04:53:23 -0500
Date: Mon, 13 Feb 2006 10:53:20 +0100
From: Bastian Blank <bastian@waldi.eu.org>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, schwidefsky@de.ibm.com, linux390@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dasd: cleanup dasd_ioctl
Message-ID: <20060213095319.GA26627@wavehammer.waldi.eu.org>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, akpm@osdl.org,
	schwidefsky@de.ibm.com, linux390@de.ibm.com,
	linux-kernel@vger.kernel.org
References: <20060212173855.GB26035@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <20060212173855.GB26035@lst.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 12, 2006 at 06:38:55PM +0100, Christoph Hellwig wrote:
> @@ -480,68 +389,90 @@
>   * Set read only
>   */
>  static int
> -dasd_ioctl_set_ro(struct block_device *bdev, int no, long args)
> +dasd_ioctl_set_ro(struct block_device *bdev, void __user *argp)
>  {
> -	struct dasd_device *device;
> -	int intval, rc;
> +	struct dasd_device *device =3D  bdev->bd_disk->private_data;
> +	int intval;
> =20
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EACCES;
>  	if (bdev !=3D bdev->bd_contains)
>  		// ro setting is not allowed for partitions
>  		return -EINVAL;
> -	if (get_user(intval, (int __user *) args))
> +	if (get_user(intval, (int *)argp))
>  		return -EFAULT;

I think this is another candidate for "int __user *".

Bastian

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iEYEARECAAYFAkPwVw8ACgkQnw66O/MvCNH1hgCgoi4ERUGgof471zOtNKiHXMbt
ENMAn38D20RWHyVedr+xfz32U7NAB27F
=Mg1J
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
