Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263080AbUB0SBf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 13:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbUB0SBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 13:01:34 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:51331 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263080AbUB0SBG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 13:01:06 -0500
Subject: Re: [PATCH] further __KERNEL_SYSCALLS__ removal
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>
In-Reply-To: <200402271835.48649.arnd@arndb.de>
References: <200402271835.48649.arnd@arndb.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-GGo7z5rheyJ8yc/oC/Ti"
Organization: Red Hat, Inc.
Message-Id: <1077904855.10066.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 27 Feb 2004 19:00:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GGo7z5rheyJ8yc/oC/Ti
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-02-27 at 18:35, Arnd Bergmann wrote:

> =3D=3D=3D=3D=3D drivers/media/dvb/frontends/alps_tdlb7.c 1.8 vs edited =
=3D=3D=3D=3D=3D
> --- 1.8/drivers/media/dvb/frontends/alps_tdlb7.c	Thu Feb 26 03:09:55 2004
> +++ edited/drivers/media/dvb/frontends/alps_tdlb7.c	Thu Feb 26 23:57:05 2=
004
> @@ -29,8 +29,6 @@
>  */ =20
> =20
>=20
> -
> -#define __KERNEL_SYSCALLS__
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/vmalloc.h>
> @@ -58,8 +56,6 @@
>  #define SP8870_FIRMWARE_OFFSET 0x0A
> =20
>=20
> -static int errno;
> -
>  static struct dvb_frontend_info tdlb7_info =3D {
>  	.name			=3D "Alps TDLB7",
>  	.type			=3D FE_OFDM,
> @@ -174,13 +170,13 @@
>  	loff_t filesize;
>  	char *dp;
> =20
> -	fd =3D open(fn, 0, 0);
> +	fd =3D sys_open(fn, 0, 0);
>  	if (fd =3D=3D -1) {
>                  printk("%s: unable to open '%s'.\n", __FUNCTION__, fn);
>  		return -EIO;
>  	}
> =20
> -	filesize =3D lseek(fd, 0L, 2);
> +	filesize =3D sys_lseek(fd, 0L, 2);
>  	if (filesize <=3D 0 || filesize < SP8870_FIRMWARE_OFFSET + SP8870_FIRMW=
ARE_SIZE) {
>  	        printk("%s: firmware filesize to small '%s'\n", __FUNCTION__, f=
n);
>  		sys_close(fd);
> @@ -194,8 +190,8 @@
>  		return -EIO;
>  	}
> =20
> -	lseek(fd, SP8870_FIRMWARE_OFFSET, 0);
> -	if (read(fd, dp, SP8870_FIRMWARE_SIZE) !=3D SP8870_FIRMWARE_SIZE) {
> +	sys_lseek(fd, SP8870_FIRMWARE_OFFSET, 0);
> +	if (sys_read(fd, dp, SP8870_FIRMWARE_SIZE) !=3D SP8870_FIRMWARE_SIZE) {
>  		printk("%s: failed to read '%s'.\n",__FUNCTION__, fn);
>  		vfree(dp);
>  		sys_close(fd);


this is the wrong way to "fix" this; might as well leave this driver as
is until it is fixed to use request_firmware()

> =3D=3D=3D=3D=3D drivers/media/dvb/frontends/sp887x.c 1.6 vs edited =3D=3D=
=3D=3D=3D
> --- 1.6/drivers/media/dvb/frontends/sp887x.c	Thu Feb 26 03:09:55 2004
> +++ edited/drivers/media/dvb/frontends/sp887x.c	Thu Feb 26 23:57:05 2004
> @@ -12,7 +12,6 @@
>     next 0x4000 loaded. This may change in future versions.
>   */
> =20
> -#define __KERNEL_SYSCALLS__
>  #include <linux/kernel.h>
>  #include <linux/vmalloc.h>
>  #include <linux/module.h>
> @@ -68,8 +67,6 @@
>  		FE_CAN_QPSK | FE_CAN_QAM_16 | FE_CAN_QAM_64 | FE_CAN_RECOVER
>  };
> =20
> -static int errno;
> -
>  static
>  int i2c_writebytes (struct dvb_frontend *fe, u8 addr, u8 *buf, u8 len)
>  {
> @@ -216,13 +213,13 @@
> =20
>  	// Load the firmware
>  	set_fs(get_ds());
> -	fd =3D open(sp887x_firmware, 0, 0);
> +	fd =3D sys_open(sp887x_firmware, 0, 0);
>  	if (fd < 0) {
>  		printk(KERN_WARNING "%s: Unable to open firmware %s\n", __FUNCTION__,
>  		       sp887x_firmware);
>  		return -EIO;
>  	}
> -	filesize =3D lseek(fd, 0L, 2);
> +	filesize =3D sys_lseek(fd, 0L, 2);
>  	if (filesize <=3D 0) {
>  		printk(KERN_WARNING "%s: Firmware %s is empty\n", __FUNCTION__,
>  		       sp887x_firmware);

same here
>  		printk("%s: Unable to open firmware %s\n", __FUNCTION__,
>  		       tda1004x_firmware);
>  		return -EIO;
>  	}
> -	filesize =3D lseek(fd, 0L, 2);
> +	filesize =3D sys_lseek(fd, 0L, 2);
>  	if (filesize <=3D 0) {
>  		printk("%s: Firmware %s is empty\n", __FUNCTION__,
>  		       tda1004x_firmware);

same here

> =3D=3D=3D=3D=3D sound/isa/wavefront/wavefront_synth.c 1.13 vs edited =3D=
=3D=3D=3D=3D
> --- 1.13/sound/isa/wavefront/wavefront_synth.c	Tue Feb 25 19:44:25 2003
> +++ edited/sound/isa/wavefront/wavefront_synth.c	Thu Feb 26 23:57:05 2004
> @@ -1913,11 +1913,11 @@
>  	return (1);
>  }
> =20
> -#define __KERNEL_SYSCALLS__
>  #include <linux/fs.h>
>  #include <linux/mm.h>
>  #include <linux/slab.h>
>  #include <linux/unistd.h>
> +#include <linux/syscalls.h>
>  #include <asm/uaccess.h>
> =20
>  static int errno;
> @@ -1947,7 +1947,7 @@
>  	fs =3D get_fs();
>  	set_fs (get_ds());
> =20
> -	if ((fd =3D open (path, 0, 0)) < 0) {
> +	if ((fd =3D sys_open (path, 0, 0)) < 0) {
>  		snd_printk ("Unable to load \"%s\".\n",
>  			path);
>  		return 1;
> @@ -1956,7 +1956,7 @@
>  	while (1) {
>  		int x;
> =20
> -		if ((x =3D read (fd, &section_length, sizeof (section_length))) !=3D
> +		if ((x =3D sys_read (fd, &section_length, sizeof (section_length))) !=
=3D
>  		    sizeof (section_length)) {
>  			snd_printk ("firmware read error.\n");
>  			goto failure;

same here
> =3D=3D=3D=3D=3D sound/oss/wavfront.c 1.15 vs edited =3D=3D=3D=3D=3D
> --- 1.15/sound/oss/wavfront.c	Mon Apr 21 09:32:53 2003
> +++ edited/sound/oss/wavfront.c	Thu Feb 26 23:57:05 2004
> @@ -2489,11 +2489,9 @@
>  }
> =20
>  #include "os.h"
> -#define __KERNEL_SYSCALLS__
>  #include <linux/fs.h>
>  #include <linux/mm.h>
>  #include <linux/slab.h>
> -#include <linux/unistd.h>
>  #include <asm/uaccess.h>
> =20
>  static int errno;=20
> @@ -2523,7 +2521,7 @@
>  	fs =3D get_fs();
>  	set_fs (get_ds());
> =20
> -	if ((fd =3D open (path, 0, 0)) < 0) {
> +	if ((fd =3D sys_open (path, 0, 0)) < 0) {
>  		printk (KERN_WARNING LOGNAME "Unable to load \"%s\".\n",
>  			path);
>  		return 1;

and here


--=-GGo7z5rheyJ8yc/oC/Ti
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAP4XWxULwo51rQBIRAmhQAJ4lIF7lrVETsvMZZXxn+PFq9FoyIACeIz1j
GltGmPXn1dOAxNCwFUNIJCE=
=QBbj
-----END PGP SIGNATURE-----

--=-GGo7z5rheyJ8yc/oC/Ti--
