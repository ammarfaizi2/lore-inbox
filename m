Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWDEJkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWDEJkV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 05:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWDEJkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 05:40:21 -0400
Received: from mail.phnxsoft.com ([195.227.45.4]:8717 "EHLO
	posthamster.phnxsoft.com") by vger.kernel.org with ESMTP
	id S1751198AbWDEJkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 05:40:19 -0400
Message-ID: <4433903F.7070309@imap.cc>
Date: Wed, 05 Apr 2006 11:39:11 +0200
From: Tilman Schmidt <tilman@imap.cc>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.8) Gecko/20050511
X-Accept-Language: de, en, fr
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: hjlipp@web.de, gigaset307x-common@lists.sourceforge.net, kkeil@suse.de,
       isdn4linux@listserv.isdn4linux.de, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] isdn/gigaset/common.c: fix a memory leak
References: <20060404190002.GZ6529@stusta.de>
In-Reply-To: <20060404190002.GZ6529@stusta.de>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6ED02B4A4B5A683FA2F3008C"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6ED02B4A4B5A683FA2F3008C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Adrian Bunk wrote:

> This patch fixes a memory leak spotted by the Coverity checker
> if (!try_module_get(owner)).

Good catch. Thanks.

> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-by: Tilman Schmidt <tilman@imap.cc>

>
> ---
>
>  drivers/isdn/gigaset/common.c |   13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> --- linux-2.6.17-rc1-mm1-full/drivers/isdn/gigaset/common.c.old	2006-04-04 19:45:19.000000000 +0200
> +++ linux-2.6.17-rc1-mm1-full/drivers/isdn/gigaset/common.c	2006-04-04 19:51:23.000000000 +0200
> @@ -1110,8 +1110,9 @@ struct gigaset_driver *gigaset_initdrive
>  	drv = kmalloc(sizeof *drv, GFP_KERNEL);
>  	if (!drv)
>  		return NULL;
> +
>  	if (!try_module_get(owner))
> -		return NULL;
> +		goto out1;
>
>  	drv->cs = NULL;
>  	drv->have_tty = 0;
> @@ -1125,10 +1126,11 @@ struct gigaset_driver *gigaset_initdrive
>
>  	drv->cs = kmalloc(minors * sizeof *drv->cs, GFP_KERNEL);
>  	if (!drv->cs)
> -		goto out1;
> +		goto out2;
> +
>  	drv->flags = kmalloc(minors * sizeof *drv->flags, GFP_KERNEL);
>  	if (!drv->flags)
> -		goto out2;
> +		goto out3;
>
>  	for (i = 0; i < minors; ++i) {
>  		drv->flags[i] = 0;
> @@ -1145,11 +1147,12 @@ struct gigaset_driver *gigaset_initdrive
>
>  	return drv;
>
> -out2:
> +out3:
>  	kfree(drv->cs);
> +out2:
> +	module_put(owner);
>  out1:
>  	kfree(drv);
> -	module_put(owner);
>  	return NULL;
>  }
>  EXPORT_SYMBOL_GPL(gigaset_initdriver);
>


--
Tilman Schmidt                    E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeöffnet mindestens haltbar bis: (siehe Rückseite)

--------------enig6ED02B4A4B5A683FA2F3008C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEM5A/MdB4Whm86/kRAlFYAJ98DnY4EFIrGaMVbBF9oC5E93PyTwCfTdns
yWTBAh0fCU9GI1RJttUa5BQ=
=14x2
-----END PGP SIGNATURE-----

--------------enig6ED02B4A4B5A683FA2F3008C--
