Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbVEPJiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVEPJiZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 05:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbVEPJiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 05:38:24 -0400
Received: from imap.gmx.net ([213.165.64.20]:3274 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261525AbVEPJho (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 05:37:44 -0400
X-Authenticated: #453372
Message-ID: <42886A5C.6030908@gmx.net>
Date: Mon, 16 May 2005 11:39:40 +0200
From: Daniel Paschka <monkey20181@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513
X-Accept-Language: en-us, en, de-de, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: clean up and warnings patch for 2.6.12-rc4-mm1 i2c-chip
References: <44zCV-1kI-17@gated-at.bofh.it>
In-Reply-To: <44zCV-1kI-17@gated-at.bofh.it>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6B4529298A50E2B161A8719A"
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6B4529298A50E2B161A8719A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Alexey Fisher wrote:

> diff -uprN linux/drivers/i2c/chips/max1619.c linux-2.6-dev/drivers/i2c/chips/max1619.c
> --- linux/drivers/i2c/chips/max1619.c	2005-05-15 22:49:31.000000000 +0200
> +++ linux-2.6-dev/drivers/i2c/chips/max1619.c	2005-05-15 21:05:56.000000000 +0200
> @@ -195,6 +195,7 @@ static int max1619_detect(struct i2c_ada
>  	u8 reg_config=0, reg_convrate=0, reg_status=0;
>  	u8 man_id, chip_id;
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> +		err = -ENODEV;
>  		goto exit;


Sure about that, I think there are some brackets missing.

  
>  	if (!(data = kmalloc(sizeof(struct max1619_data), GFP_KERNEL))) {
> @@ -234,6 +235,7 @@ static int max1619_detect(struct i2c_ada
>  			dev_dbg(&adapter->dev,
>  				"MAX1619 detection failed at 0x%02x.\n",
>  				address);
> +			return -ENODEV;
>  			goto exit_free;
>  		}
>  	}


I would expect gcc to throw a warning about unreachable code here
because goto exit_free ist behind a return statement.
Don't you mean
err = -ENODEV;
goto exit_free;

That way the data structure data will be freed, too.

> @@ -254,6 +256,7 @@ static int max1619_detect(struct i2c_ada
>  			dev_info(&adapter->dev,
>  			    "Unsupported chip (man_id=0x%02X, "
>  			    "chip_id=0x%02X).\n", man_id, chip_id);
> +			return -ENODEV;
>  			goto exit_free;
>  		}

Same here.

I am not using this driver and am not fully up to date with the kernel
sources so I am sorry if I am talking nonesense here.

Bye Daniel

--------------enig6B4529298A50E2B161A8719A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFCiGpclycClYdpvAkRAiweAJ0YMNJVqaSosF3LTZh8ZPgp1VQ99gCfUukZ
EOcUdSORnJU/VVpSQMXeUzs=
=gg//
-----END PGP SIGNATURE-----

--------------enig6B4529298A50E2B161A8719A--
