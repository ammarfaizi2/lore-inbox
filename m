Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263182AbTDYNwr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 09:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263186AbTDYNwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 09:52:46 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:1009 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263182AbTDYNwo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 09:52:44 -0400
Subject: Re: RE:cciss patches for 2.4.21-rc1, 4 of 4
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: mikem@beardog.cca.cpqcorp.net
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, mike.miller@hp.com,
       steve.cameron@hp.com
In-Reply-To: <200304242212.h3OMCgc01143@beardog.cca.cpqcorp.net>
References: <200304242212.h3OMCgc01143@beardog.cca.cpqcorp.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Y+kA5p7TutJhQUlZBthl"
Organization: Red Hat, Inc.
Message-Id: <1051279472.1391.15.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 25 Apr 2003 16:04:33 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Y+kA5p7TutJhQUlZBthl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-04-25 at 00:12, mikem@beardog.cca.cpqcorp.net wrote:
> 20030424
>=20
> Changes:
> 	1. Sets the DMA mask to 64 bits. Removes RH's code for the DMA mask.
>=20
> diff -urN lx2421rc1-p3/drivers/block/cciss.c lx2421rc1/drivers/block/ccis=
s.c
> --- lx2421rc1-p3/drivers/block/cciss.c	Wed Apr 23 14:40:48 2003
> +++ lx2421rc1/drivers/block/cciss.c	Wed Apr 23 14:51:55 2003
> @@ -106,7 +106,7 @@
>  #define NR_CMDS		 128 /* #commands that can be outstanding */
>  #define MAX_CTLR 8
> =20
> -#define CCISS_DMA_MASK	0xFFFFFFFF	/* 32 bit DMA */
> +#define CCISS_DMA_MASK 0xFFFFFFFFFFFFFFFF /* 64 bit DMA */
> =20
>  static ctlr_info_t *hba[MAX_CTLR];
> =20
> @@ -2861,17 +2861,6 @@
>  	hba[i]->ctlr =3D i;
>  	hba[i]->pdev =3D pdev;
> =20
> -	/* configure PCI DMA stuff */
> -	if (!pci_set_dma_mask(pdev, (u64) 0xffffffffffffffff))
> -		printk("cciss: using DAC cycles\n");
> -	else if (!pci_set_dma_mask(pdev, (u64) 0xffffffff))
> -		printk("cciss: not using DAC cycles\n");
> -	else {
> -		printk("cciss: no suitable DMA available\n");
> -		free_hba(i);
> -		return -ENODEV;
> -	}
> -	=09


this is wrong. The code there is EXACTLY what is needed as per
Documentation/DMA-mapping.txt, removing it is a bug.


--=-Y+kA5p7TutJhQUlZBthl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+qUBwxULwo51rQBIRAhlrAJ9Z2MYTFrKIeDyb5+R0UiBUAlBzEgCfbGmA
cZdYxpVjkqKcn5BeHpJ/fyo=
=rxi/
-----END PGP SIGNATURE-----

--=-Y+kA5p7TutJhQUlZBthl--
