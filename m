Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263792AbUAYIl5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 03:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263800AbUAYIl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 03:41:57 -0500
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:29830 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S263792AbUAYIly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 03:41:54 -0500
Date: Sun, 25 Jan 2004 00:41:41 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Bryan Whitehead <driver@megahappy.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.2-rc1-mm3] drivers/usb/storage/dpcm.c
Message-ID: <20040125084141.GA14215@one-eyed-alien.net>
Mail-Followup-To: Bryan Whitehead <driver@megahappy.net>,
	linux-kernel@vger.kernel.org
References: <20040125050342.45C3E13A354@mrhankey.megahappy.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <20040125050342.45C3E13A354@mrhankey.megahappy.net>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

One message a day to report a particular bug is really enough.... :)

That said, I think it would be better to add the ifdef's instead of more
substantial code changes.

Matt

On Sat, Jan 24, 2004 at 09:03:42PM -0800, Bryan Whitehead wrote:
>=20
> In function dpcm_transport the compiler complains about ret not being use=
d:
> drivers/usb/storage/dpcm.c: In function `dpcm_transport':
> drivers/usb/storage/dpcm.c:46: warning: unused variable `ret'
>=20
> ret is not used if CONFIG_USB_STORAGE_SDDR09 is not set. Instead of adding
> more ifdef's to the code this patch puts ret to use for the other 2 cases=
 in
> the switch statement (case 0 and default).
>=20
> --- drivers/usb/storage/dpcm.c.orig     2004-01-24 20:51:40.631038904 -08=
00
> +++ drivers/usb/storage/dpcm.c  2004-01-24 20:50:05.155553384 -0800
> @@ -56,7 +56,8 @@ int dpcm_transport(Scsi_Cmnd *srb, struc
>      /*
>       * LUN 0 corresponds to the CompactFlash card reader.
>       */
> -    return usb_stor_CB_transport(srb, us);
> +    ret =3D usb_stor_CB_transport(srb, us);
> +    break;
>  =20
>  #ifdef CONFIG_USB_STORAGE_SDDR09
>    case 1:
> @@ -72,11 +73,12 @@ int dpcm_transport(Scsi_Cmnd *srb, struc
>      ret =3D sddr09_transport(srb, us);
>      srb->device->lun =3D 1; us->srb->device->lun =3D 1;
>  =20
> -    return ret;
> +    break;
>  #endif
>  =20
>    default:
>      US_DEBUGP("dpcm_transport: Invalid LUN %d\n", srb->device->lun);
> -    return USB_STOR_TRANSPORT_ERROR;
> +    ret =3D USB_STOR_TRANSPORT_ERROR;
>    }
> +  return ret;
>  }
>=20
> --
> Bryan Whitehead
> driver@megahappy.net
>=20

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

E:  You run this ship with Windows?!  YOU IDIOT!
L:  Give me a break, it came bundled with the computer!
					-- ESR and Lan Solaris
User Friendly, 12/8/1998

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAE4FFIjReC7bSPZARAla0AJ9tngA8Si8b2LFKyCjBJNDwb8uoEACfeLiH
Aqu6NJYqdIkC5RBeUpPzACM=
=+KC9
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
