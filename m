Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbWIRDVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWIRDVZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 23:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWIRDVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 23:21:25 -0400
Received: from mail.isohunt.com ([69.64.61.20]:46235 "EHLO mail.isohunt.com")
	by vger.kernel.org with ESMTP id S1751321AbWIRDVY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 23:21:24 -0400
X-Spam-Check-By: mail.isohunt.com
Date: Sun, 17 Sep 2006 20:48:26 -0700
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: Tejun Heo <htejun@gmail.com>
Cc: "Robin H. Johnson" <robbat2@gentoo.org>, Jeff Garzik <jeff@garzik.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc7-git1: AHCI not seeing devices on ICH8 mobo (DG965RY)
Message-ID: <20060918034826.GA10116@curie-int.orbis-terrarum.net>
References: <20060914200500.GD27531@curie-int.orbis-terrarum.net> <4509AB2E.1030800@garzik.org> <20060914205050.GE27531@curie-int.orbis-terrarum.net> <20060916203812.GC30391@curie-int.orbis-terrarum.net> <20060916210857.GD30391@curie-int.orbis-terrarum.net> <20060917074929.GD25800@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <20060917074929.GD25800@htj.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2006 at 04:49:29PM +0900, Tejun Heo wrote:
> On Sat, Sep 16, 2006 at 02:08:57PM -0700, Robin H. Johnson wrote:
> > I recompiled libata and AHCI using the ATA_DEBUG and ATA_VERBOSE_DEBUG
> > defines, and got an interesting trace.
> >=20
> > In specific, look at port_idx 2/3, being all zeros in ahci_host_init.
> >=20
> > I'm digging into it further now, but something makes me suspect that
> > base addresses for ports 3/4 are wrong.
> >=20
> > Full file at:
> > http://orbis-terrarum.net/~robbat2/x86_64-mmconfig-failure/2.6.18-rc7-g=
it1-libata-ahci-verbose-failure.dmesg
>=20
> Can you please try the attached patch?
Yes your patch fixes it perfectly - it's a better version of an almost
working fix I hacked up after my previous email.

Some patch review comments below as well.

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>

> @@ -186,9 +187,11 @@ struct ahci_host_priv {
>  	unsigned long		flags;
>  	u32			cap;	/* cache of HOST_CAP register */
>  	u32			port_map; /* cache of HOST_PORTS_IMPL reg */
> +	int			port_tbl[AHCI_MAX_PORTS];
>  };
maybe u8 instead of int?
also a comment - /* mapping of port_idx to the implemented port */

> +	if (n_ports =3D=3D 0) {
> +		dev_printk(KERN_ERR, &pdev->dev, "0 port implemented\n");
> +		return -EINVAL;
> +	}
Use plural form (0 ports), or negative (No ports) instead.

--=20
Robin Hugh Johnson
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFFDhcKPpIsIjIzwiwRAviOAJ4km7XOZFfsgkFdgF8seJJC6iNt1wCggDY7
MGkrvMIqN5fNwcUBBLxdeuk=
=YSvB
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
