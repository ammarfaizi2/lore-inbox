Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262214AbUKVQzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262214AbUKVQzh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 11:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbUKVQnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 11:43:46 -0500
Received: from dea.vocord.ru ([217.67.177.50]:30942 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262178AbUKVQT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 11:19:26 -0500
Subject: Re: [2.6 patch] drivers/w1/dscore: fix the inline mess
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Adrian Bunk <bunk@stusta.de>
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
In-Reply-To: <20041122155223.GF19419@stusta.de>
References: <20041122155223.GF19419@stusta.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Li04+331fWbMXJ22H58G"
Organization: MIPT
Date: Mon, 22 Nov 2004 19:22:31 +0300
Message-Id: <1101140551.9784.2.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Mon, 22 Nov 2004 16:18:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Li04+331fWbMXJ22H58G
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-11-22 at 16:52 +0100, Adrian Bunk wrote:
> <--  snip  -->
>=20
> ...
>   CC      drivers/w1/ds_w1_bridge.o
> drivers/w1/ds_w1_bridge.c: In function `ds9490r_touch_bit':
> drivers/w1/dscore.h:154: sorry, unimplemented: inlining failed in call=20
> to 'ds_touch_bit': function body not available
> drivers/w1/ds_w1_bridge.c:37: sorry, unimplemented: called from here
> make[2]: *** [drivers/w1/ds_w1_bridge.o] Error 1
>=20
> <--  snip  -->
>=20
>=20
> The patch below removes inline's in the following cases:
> - inline at the function prototype but not at the actual function
> - EXPORT_SYMBOL'ed inline functions

I'm ok with your changes and have applied it to my tree, thank you.

>=20
> diffstat output:
>  drivers/w1/dscore.c |   40 ++++++++++++++++++++--------------------
>  drivers/w1/dscore.h |   34 +++++++++++++++++-----------------
>  2 files changed, 37 insertions(+), 37 deletions(-)
>=20
>=20
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>=20
> --- linux-2.6.10-rc2-mm3-full/drivers/w1/dscore.h.old	2004-11-22 15:04:42=
.000000000 +0100
> +++ linux-2.6.10-rc2-mm3-full/drivers/w1/dscore.h	2004-11-22 15:08:14.000=
000000 +0100
> @@ -151,23 +151,23 @@
> =20
>  };
> =20
> -inline int ds_touch_bit(struct ds_device *, u8, u8 *);
> -inline int ds_read_byte(struct ds_device *, u8 *);
> -inline int ds_read_bit(struct ds_device *, u8 *);
> -inline int ds_write_byte(struct ds_device *, u8);
> -inline int ds_write_bit(struct ds_device *, u8);
> -inline int ds_start_pulse(struct ds_device *, int);
> -inline int ds_set_speed(struct ds_device *, int);
> -inline int ds_reset(struct ds_device *, struct ds_status *);
> -inline int ds_detect(struct ds_device *, struct ds_status *);
> -inline int ds_stop_pulse(struct ds_device *, int);
> -inline int ds_send_data(struct ds_device *, unsigned char *, int);
> -inline int ds_recv_data(struct ds_device *, unsigned char *, int);
> -inline int ds_recv_status(struct ds_device *, struct ds_status *);
> -inline struct ds_device * ds_get_device(void);
> -inline void ds_put_device(struct ds_device *);
> -inline int ds_write_block(struct ds_device *, u8 *, int);
> -inline int ds_read_block(struct ds_device *, u8 *, int);
> +int ds_touch_bit(struct ds_device *, u8, u8 *);
> +int ds_read_byte(struct ds_device *, u8 *);
> +int ds_read_bit(struct ds_device *, u8 *);
> +int ds_write_byte(struct ds_device *, u8);
> +int ds_write_bit(struct ds_device *, u8);
> +int ds_start_pulse(struct ds_device *, int);
> +int ds_set_speed(struct ds_device *, int);
> +int ds_reset(struct ds_device *, struct ds_status *);
> +int ds_detect(struct ds_device *, struct ds_status *);
> +int ds_stop_pulse(struct ds_device *, int);
> +int ds_send_data(struct ds_device *, unsigned char *, int);
> +int ds_recv_data(struct ds_device *, unsigned char *, int);
> +int ds_recv_status(struct ds_device *, struct ds_status *);
> +struct ds_device * ds_get_device(void);
> +void ds_put_device(struct ds_device *);
> +int ds_write_block(struct ds_device *, u8 *, int);
> +int ds_read_block(struct ds_device *, u8 *, int);
> =20
>  #endif /* __DSCORE_H */
> =20
> --- linux-2.6.10-rc2-mm3-full/drivers/w1/dscore.c.old	2004-11-22 15:05:19=
.000000000 +0100
> +++ linux-2.6.10-rc2-mm3-full/drivers/w1/dscore.c	2004-11-22 15:07:50.000=
000000 +0100
> @@ -35,26 +35,26 @@
>  int ds_probe(struct usb_interface *, const struct usb_device_id *);
>  void ds_disconnect(struct usb_interface *);
> =20
> -inline int ds_touch_bit(struct ds_device *, u8, u8 *);
> -inline int ds_read_byte(struct ds_device *, u8 *);
> -inline int ds_read_bit(struct ds_device *, u8 *);
> -inline int ds_write_byte(struct ds_device *, u8);
> -inline int ds_write_bit(struct ds_device *, u8);
> -inline int ds_start_pulse(struct ds_device *, int);
> -inline int ds_set_speed(struct ds_device *, int);
> -inline int ds_reset(struct ds_device *, struct ds_status *);
> -inline int ds_detect(struct ds_device *, struct ds_status *);
> -inline int ds_stop_pulse(struct ds_device *, int);
> -inline int ds_send_data(struct ds_device *, unsigned char *, int);
> -inline int ds_recv_data(struct ds_device *, unsigned char *, int);
> -inline int ds_recv_status(struct ds_device *, struct ds_status *);
> -inline struct ds_device * ds_get_device(void);
> -inline void ds_put_device(struct ds_device *);
> +int ds_touch_bit(struct ds_device *, u8, u8 *);
> +int ds_read_byte(struct ds_device *, u8 *);
> +int ds_read_bit(struct ds_device *, u8 *);
> +int ds_write_byte(struct ds_device *, u8);
> +int ds_write_bit(struct ds_device *, u8);
> +int ds_start_pulse(struct ds_device *, int);
> +int ds_set_speed(struct ds_device *, int);
> +int ds_reset(struct ds_device *, struct ds_status *);
> +int ds_detect(struct ds_device *, struct ds_status *);
> +int ds_stop_pulse(struct ds_device *, int);
> +int ds_send_data(struct ds_device *, unsigned char *, int);
> +int ds_recv_data(struct ds_device *, unsigned char *, int);
> +int ds_recv_status(struct ds_device *, struct ds_status *);
> +struct ds_device * ds_get_device(void);
> +void ds_put_device(struct ds_device *);
> =20
>  static inline void ds_dump_status(unsigned char *, unsigned char *, int)=
;
> -static inline int ds_send_control(struct ds_device *, u16, u16);
> -static inline int ds_send_control_mode(struct ds_device *, u16, u16);
> -static inline int ds_send_control_cmd(struct ds_device *, u16, u16);
> +static int ds_send_control(struct ds_device *, u16, u16);
> +static int ds_send_control_mode(struct ds_device *, u16, u16);
> +static int ds_send_control_cmd(struct ds_device *, u16, u16);
> =20
>=20
>  static struct usb_driver ds_driver =3D {
> @@ -503,7 +503,7 @@
>  	return 0;
>  }
> =20
> -inline int ds_read_block(struct ds_device *dev, u8 *buf, int len)
> +int ds_read_block(struct ds_device *dev, u8 *buf, int len)
>  {
>  	struct ds_status st;
>  	int err;
> @@ -529,7 +529,7 @@
>  	return err;
>  }
> =20
> -inline int ds_write_block(struct ds_device *dev, u8 *buf, int len)
> +int ds_write_block(struct ds_device *dev, u8 *buf, int len)
>  {
>  	int err;
>  	struct ds_status st;
--=20

--=-Li04+331fWbMXJ22H58G
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBohJHIKTPhE+8wY0RAg/4AJwOIyF/oh2s48p6/yYCN40iv1O5xACdGHUf
oGa9v97h2HNikpGorF8iHQk=
=WorS
-----END PGP SIGNATURE-----

--=-Li04+331fWbMXJ22H58G--

