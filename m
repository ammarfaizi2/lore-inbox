Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbTD3Lyv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 07:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbTD3Lyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 07:54:51 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:28143 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S262097AbTD3Lyu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 07:54:50 -0400
Subject: Re: [PATCH] PATCH: ibm hot plug driver fix
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: marcelo@contectiva.com.br
In-Reply-To: <200304012105.h31L5ep10931@hera.kernel.org>
References: <200304012105.h31L5ep10931@hera.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-u01k0Tim1J4+9TBWU4RI"
Organization: Red Hat, Inc.
Message-Id: <1051704428.1404.11.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 30 Apr 2003 14:07:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-u01k0Tim1J4+9TBWU4RI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-04-01 at 21:30, Linux Kernel Mailing List wrote:
> # This patch includes the following deltas:
> #	           ChangeSet	1.1044  -> 1.1045=20
> #	drivers/hotplug/ibmphp_ebda.c	1.6     -> 1.7   =20
> #
>=20
>  ibmphp_ebda.c |   25 ++++++++++++++++++++++---
>  1 files changed, 22 insertions(+), 3 deletions(-)
>=20
>=20
> diff -Nru a/drivers/hotplug/ibmphp_ebda.c b/drivers/hotplug/ibmphp_ebda.c
> --- a/drivers/hotplug/ibmphp_ebda.c	Tue Apr  1 13:05:41 2003
> +++ b/drivers/hotplug/ibmphp_ebda.c	Tue Apr  1 13:05:41 2003

> @@ -608,13 +608,20 @@
>  		return str;
>  	default: =09
>  		//2 digits number
> +		str1 =3D (char *) kmalloc (2, GFP_KERNEL);
> +		if (!str1) {
> +			break;
> +		}
> +		memset (str, 0, 3);
>  		*str1 =3D (char)(bit + 48);
>  		strncpy (str, str1, 1);
>  		memset (str1, 0, 3);
>  		*str1 =3D (char)((var % 10) + 48);
>  		strcat (str, str1);
> +		kfree(str1);
>  		return str;
> -	}=09
> +	}
> +	kfree(str);
>  	return NULL;=09
>  }

ehm I'd suggest backing out this change. Not only do we have snprintf
nowadays, it also corrupts memory by memsetting stuff bigger than it
allocated....

--=-u01k0Tim1J4+9TBWU4RI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+r7xrxULwo51rQBIRAn7MAKCEXnuqzI0IjAsI7Upu//I5Feh6lQCffd2f
LdWO6SYLC9gX64sm1aMQ8Cc=
=UhTu
-----END PGP SIGNATURE-----

--=-u01k0Tim1J4+9TBWU4RI--
