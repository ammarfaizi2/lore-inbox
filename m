Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262090AbSI3ObW>; Mon, 30 Sep 2002 10:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262163AbSI3ObW>; Mon, 30 Sep 2002 10:31:22 -0400
Received: from node-d-1ef6.a2000.nl ([62.195.30.246]:37102 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S262090AbSI3ObU>; Mon, 30 Sep 2002 10:31:20 -0400
Subject: Re: [PATCH] 2.5.39 s390 (3/26): drivers.
From: Arjan van de Ven <arjanv@redhat.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <200209301451.19791.schwidefsky@de.ibm.com>
References: <200209301451.19791.schwidefsky@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-0B6POSbowId8qMszVYVh"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Sep 2002 16:39:23 +0200
Message-Id: <1033396763.1718.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0B6POSbowId8qMszVYVh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> --- linux-2.5.39/drivers/s390/misc/chandev.c	Fri Sep 27 23:49:45 2002
> +++ linux-2.5.39-s390/drivers/s390/misc/chandev.c	Mon Sep 30 14:34:55 200=
2
> @@ -24,6 +24,7 @@
>  #include <asm/s390dyn.h>
>  #include <asm/queue.h>
>  #include <linux/kmod.h>
> +#include <linux/tqueue.h>
>  #ifndef MIN
>  #define MIN(a,b) ((a<b)?a:b)
>  #endif
> @@ -2825,6 +2826,7 @@
>  	struct stat statbuf;
>  	char        *buff;
>  	int         curr,left,len,fd;
> +	mm_segment_t oldfs;
> =20
>  	/* if called from chandev_register_and_probe &=20
>  	   the driver is compiled into the kernel the
> @@ -2835,6 +2837,7 @@
>  	if(in_interrupt()||current->fs->root=3D=3DNULL)
>  		return;
>  	atomic_set(&chandev_conf_read,TRUE);
> +	oldfs =3D get_fs();
>  	set_fs(KERNEL_DS);
>  	if(stat(CHANDEV_FILE,&statbuf)=3D=3D0)
>  	{
> @@ -2859,7 +2862,7 @@
>  			vfree(buff);
>  		}
>  	}
> -	set_fs(USER_DS);
> +	set_fs(oldfs);
>  }
> =20
>  static void chandev_read_conf_if_necessary(void)

Ehm. Ok. This code STILL tries to read and parse config files. If you're
fixing it, can you please fix it to NOT read and parse config files from
inside the kernel? Please?=20

Greetings,
   Arjan van de Ven


--=-0B6POSbowId8qMszVYVh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9mGIbxULwo51rQBIRAgawAJ9as+T56nxrdVJWGQaswN9moeyaQQCeLwQR
LeKxJLFwMpeZn8fFa2Ce5C8=
=CAsb
-----END PGP SIGNATURE-----

--=-0B6POSbowId8qMszVYVh--

