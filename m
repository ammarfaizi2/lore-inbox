Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263828AbUFKLu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263828AbUFKLu4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 07:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263840AbUFKLuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 07:50:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21399 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263828AbUFKLuv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 07:50:51 -0400
Subject: Re: [PATCH 1/4]Diskdump Update
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Takao Indoh <indou.takao@soft.fujitsu.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A1C44FA8EDD3EFindou.takao@soft.fujitsu.com>
References: <A0C44FA7FE6022indou.takao@soft.fujitsu.com>
	 <A1C44FA8EDD3EFindou.takao@soft.fujitsu.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-vxL8F56rcmO4qWKSxYL4"
Organization: Red Hat UK
Message-Id: <1086954645.2731.23.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 11 Jun 2004 13:50:45 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vxL8F56rcmO4qWKSxYL4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> diff -Nur linux-2.6.6.org/arch/i386/kernel/traps.c linux-2.6.6/arch/i386/=
kernel/traps.c
> --- linux-2.6.6.org/arch/i386/kernel/traps.c	2004-05-10 11:32:02.00000000=
0 +0900
> +++ linux-2.6.6/arch/i386/kernel/traps.c	2004-06-09 19:17:46.000000000 +0=
900
> @@ -258,7 +258,8 @@
>  	int nl =3D 0;
> =20
>  	console_verbose();
> -	spin_lock_irq(&die_lock);
> +	if (!crashdump_mode())
> +		spin_lock_irq(&die_lock);


why is this??


> +#ifndef TRUE
> +#define TRUE	1
> +#endif
> +#ifndef FALSE
> +#define FALSE	0
> +#endif

it's kernel convention to just use 0 and !0=20

> +MODULE_PARM(fallback_on_err, "i");
> +MODULE_PARM(allow_risky_dumps, "i");
> +MODULE_PARM(block_order, "i");
> +MODULE_PARM(sample_rate, "i");

please exclusively use the 2.6 module parameter mechanism for new code.


> +		page =3D mem_map + nr;

this is not safe for discontig mem and thus broken


> +	/*
> +	 * Check the checksum of myself
> +	 */
> +	spin_trylock(&disk_dump_lock);

you need to handle the failure case of trylock of course


> +#ifdef CONFIG_PROC_FS
> +static int proc_ioctl(struct inode *inode, struct file *file, unsigned i=
nt cmd, unsigned long param)


ehhh this looks evil


> diff -Nur linux-2.6.6.org/drivers/block/genhd.c linux-2.6.6/drivers/block=
/genhd.c
> --- linux-2.6.6.org/drivers/block/genhd.c	2004-05-10 11:32:29.000000000 +=
0900
> +++ linux-2.6.6/drivers/block/genhd.c	2004-06-09 19:17:46.000000000 +0900
> @@ -224,6 +224,8 @@
>  	return  kobj ? to_disk(kobj) : NULL;
>  }
> =20
> +EXPORT_SYMBOL(get_gendisk);


this is WRONG. VERY WRONG.





--=-vxL8F56rcmO4qWKSxYL4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAyZyVxULwo51rQBIRAraYAJ0YsK2FYYcym753gSsETqod44WsdACfc3jV
x3qBKT798Rug6jJnz2EC8kY=
=SkfN
-----END PGP SIGNATURE-----

--=-vxL8F56rcmO4qWKSxYL4--

