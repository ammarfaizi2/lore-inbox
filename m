Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWIVJ5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWIVJ5q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 05:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWIVJ5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 05:57:46 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:56772 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1751136AbWIVJ5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 05:57:45 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [1/9] driver core fixes: make_class_name() retval check
Date: Fri, 22 Sep 2006 11:58:02 +0200
User-Agent: KMail/1.9.4
Cc: Greg K-H <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>
References: <20060922113650.612d425b@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20060922113650.612d425b@gondolin.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1661029.LoudvVX25C";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609221158.07226.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1661029.LoudvVX25C
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Cornelia Huck wrote:
> From: Cornelia Huck <cornelia.huck@de.ibm.com>
>
> Make make_class_name() return NULL on error and fixup callers in the
> driver core.

> @@ -409,8 +409,11 @@ static int make_deprecated_class_device_
>  		return 0;
>
>  	class_name =3D make_class_name(class_dev->class->name, &class_dev->kobj=
);
> -	error =3D sysfs_create_link(&class_dev->dev->kobj, &class_dev->kobj,
> -				  class_name);
> +	if (!class_name)
> +		error =3D sysfs_create_link(&class_dev->dev->kobj,
> +					  &class_dev->kobj, class_name);
> +	else
> +		error =3D -ENOMEM;
>  	kfree(class_name);
>  	return error;
>  }

Either this is inverse of what you wanted to do or just calling=20
sysfs_create_link(..., NULL) would make it clearer for readers.

Eike

--nextPart1661029.LoudvVX25C
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFE7OvXKSJPmm5/E4RAj4vAJ9uIJbLlNGy5MUnwuC0cgXJU//Y0gCcCqsl
22Oq11jQg27hZmz3g6UIm3s=
=sU8v
-----END PGP SIGNATURE-----

--nextPart1661029.LoudvVX25C--
