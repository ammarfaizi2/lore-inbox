Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbVBBHS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbVBBHS5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 02:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbVBBHS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 02:18:57 -0500
Received: from relay.rost.ru ([80.254.111.11]:35737 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S262194AbVBBHSv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 02:18:51 -0500
Date: Wed, 2 Feb 2005 10:18:47 +0300
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch to enable the USB handoff on Dell 650
Message-ID: <20050202071847.GA786@pazke>
Mail-Followup-To: Pete Zaitcev <zaitcev@redhat.com>,
	linux-kernel@vger.kernel.org
References: <20050201100241.07c6c504@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <20050201100241.07c6c504@localhost.localdomain>
X-Uname: Linux 2.6.6 i686
User-Agent: Mutt/1.5.6+20040907i
From: Andrey Panin <pazke@donpac.ru>
X-SMTP-Authenticated: pazke@donpac.ru (ntlm)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 032, 02 01, 2005 at 10:02:41AM -0800, Pete Zaitcev wrote:
> Hi, guys,
>=20
> I was looking at this:
>   https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D138892
>=20
>   I have added usb-handoff as a kernel option in grub.conf for
>   2.4.21-20.EL (smp) and re-enabled USB Emulation and Controller in the
>   BIOS, and the machine now seems to boot normally.  I only had time to
>   try booting it twice, but previously it would fail almost every time,
>   so two successive successful boots seems very good.  Thanks for your
>   quick responses and working solution!
>=20
> Can someone with the Dell PW650 (which, I think, should be same as PE600)
> test this patch for me? I do not want to send this for inclusion into
> Linus' kernel before it's tested.
>=20
> In theory we probably will want USB handoff to be enabled by default, but
> I am not sure this time is now, so let us use DMI lists until then.
>=20
> Thanks,
> -- Pete
>=20
> --- linux-2.6.11-rc2/arch/i386/kernel/dmi_scan.c	2005-01-22 14:53:59.0000=
00000 -0800
> +++ linux-2.6.11-rc2-lem/arch/i386/kernel/dmi_scan.c	2005-01-31 20:42:16.=
163592792 -0800
> @@ -243,6 +243,19 @@
>  } =20
>  #endif
> =20
> +static __init int enable_usb_handoff(struct dmi_blacklist *d)
> +{
> +	extern int usb_early_handoff;
> +
> +	/*
> +	 * A printk is probably unnecessary. There's no way this causes
> +	 * any harm (famous last words). But seriously, we only add systems
> +	 * to the list if we know that they need handoff for sure.
> +	 */
> +	usb_early_handoff =3D 1;
> +	return 0;
> +}
> +

Please don't add new quirks into dmi_scan.c. Use dmi_check_system()
where possible.

>  /*
>   *	Process the DMI blacklists
>   */
> @@ -376,6 +389,14 @@
> =20
>  #endif
> =20
> +	/*
> +	 *	Boxes which need USB taken over from BIOS explicitly.
> +	 */
> +	{ enable_usb_handoff, "Dell PW650", {
> +			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
> +			MATCH(DMI_PRODUCT_NAME, "Precision WorkStation 650"),
> +			NO_MATCH, NO_MATCH }},
> +
>  	{ NULL, }

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCAH7Xby9O0+A2ZecRAqwkAKCxbXW1JFErIzR7mxPLfD2gEyDh2gCgoWcD
dv7vNYNy0jHjgoeb6I9hT4w=
=9OU/
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
