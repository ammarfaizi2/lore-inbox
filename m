Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266240AbUBKW4r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 17:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266223AbUBKW4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 17:56:46 -0500
Received: from caffeine.cafuego.net ([210.8.121.71]:30856 "EHLO
	caffeine.cc.com.au") by vger.kernel.org with ESMTP id S266240AbUBKW4i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 17:56:38 -0500
Subject: Re: 2.6.2 PPC ALSA snd-powermac
From: Peter Lieverdink <peter@cc.com.au>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <s5hr7x1bzvr.wl@alsa2.suse.de>
References: <1076483508.13791.6.camel@kahlua> <s5hr7x1bzvr.wl@alsa2.suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-cNGUya2wZ14SnkJE4fIh"
Organization: Creative Contingencies Pty. Ltd.
Message-Id: <1076540202.13791.19.camel@kahlua>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 12 Feb 2004 09:56:42 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cNGUya2wZ14SnkJE4fIh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-02-11 at 22:48, Takashi Iwai wrote:
> At Wed, 11 Feb 2004 18:11:48 +1100,
> Peter Lieverdink wrote:
> >=20
> > [1  <text/plain (quoted-printable)>]
> > Is it just me or does 'make menuconfig' in kernel 2.6.2 on ppc not give
> > me an option to enable i2c? It's supposed to be in Character Devices,
> > no? The ALSA snd-powermac module needs i2c and upon a 'modprobe
> > snd-powermac' spews forth:
>=20
> does the attached patch work?

Unfortunately:

cafuego@chocomel:/usr/src/linux-2.6.2$ make-kpkg clean; make-kpkg
--revision chocomel.1 kernel-image
[...]
LD      .tmp_vmlinux1
sound/built-in.o(.text+0x28770): In function `daca_init_client':
: undefined reference to `i2c_smbus_write_byte_data'
sound/built-in.o(.text+0x28788): In function `daca_init_client':
: undefined reference to `i2c_smbus_write_byte_data'
sound/built-in.o(.text+0x287a4): In function `daca_init_client':
: undefined reference to `i2c_smbus_write_block_data'
sound/built-in.o(.text+0x28834): In function `daca_set_volume':
: undefined reference to `i2c_smbus_write_block_data'
sound/built-in.o(.text+0x28aac): In function `daca_put_amp':
: undefined reference to `i2c_smbus_write_byte_data'
sound/built-in.o(.text+0x28ae8): In function `daca_resume':
: undefined reference to `i2c_smbus_write_byte_data'
sound/built-in.o(.text+0x28b0c): In function `daca_resume':
: undefined reference to `i2c_smbus_write_byte_data'
sound/built-in.o(.text+0x28bb0): In function `send_init_client':
: undefined reference to `i2c_smbus_write_byte_data'
sound/built-in.o(.text+0x28df0): In function
`tumbler_set_master_volume':
: undefined reference to `i2c_smbus_write_block_data'
sound/built-in.o(.text+0x28fd8): In function `tumbler_set_drc':
: undefined reference to `i2c_smbus_write_block_data'
sound/built-in.o(.text+0x290c0): In function `snapper_set_drc':
: undefined reference to `i2c_smbus_write_block_data'
sound/built-in.o(.text+0x29328): In function `tumbler_set_mono_volume':
: undefined reference to `i2c_smbus_write_block_data'
sound/built-in.o(.text+0x29500): In function `snapper_set_mix_vol1':
: undefined reference to `i2c_smbus_write_block_data'
sound/built-in.o(.text+0x29e04): In function `keywest_attach_adapter':
: undefined reference to `i2c_attach_client'
sound/built-in.o(.text+0x29e7c): In function `keywest_detach_client':
: undefined reference to `i2c_detach_client'
sound/built-in.o(.text+0x29ef0): In function `snd_pmac_keywest_cleanup':
: undefined reference to `i2c_del_driver'
sound/built-in.o(.init.text+0x2848): In function
`snd_pmac_keywest_init':
: undefined reference to `i2c_add_driver'
make[1]: *** [.tmp_vmlinux1] Error 1
make[1]: Leaving directory `/usr/src/linux-2.6.2'
make: *** [stamp-build] Error 2
cafuego@chocomel:/usr/src/linux-2.6.2$

- Peter.
--

> --
> Takashi Iwai <tiwai@suse.de>		ALSA Developer - www.alsa-project.org
>=20
> ______________________________________________________________________
> --- linux/sound/ppc/Kconfig	4 Nov 2002 08:43:16 -0000	1.1
> +++ linux/sound/ppc/Kconfig	11 Feb 2004 11:43:56 -0000
> @@ -5,7 +5,9 @@
> =20
>  config SND_POWERMAC
>  	tristate "PowerMac (AWACS, DACA, Burgundy, Tumbler, Keywest)"
> -	depends on SND
> +	depends on SND && PPC_PMAC
> +        select I2C
> +        select I2C_KEYWEST
> =20
>  endmenu

--=-cNGUya2wZ14SnkJE4fIh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAKrMqf34AjKyA6C4RApfyAJ9HH1BjOgUW7P8Y+rAHSqs0/8AJVACggUdu
pyHHwx86WHyu7lUagHXne2k=
=CLR7
-----END PGP SIGNATURE-----

--=-cNGUya2wZ14SnkJE4fIh--

