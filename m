Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbTISHjl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 03:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbTISHjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 03:39:41 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:43502 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S261413AbTISHjh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 03:39:37 -0400
Subject: Re: [PATCH 7/13] use cpu_relax() in busy loop
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
In-Reply-To: <20030918163523.K16499@osdlab.pdx.osdl.net>
References: <20030918162522.E16499@osdlab.pdx.osdl.net>
	 <20030918162748.F16499@osdlab.pdx.osdl.net>
	 <20030918162930.G16499@osdlab.pdx.osdl.net>
	 <20030918163156.H16499@osdlab.pdx.osdl.net>
	 <20030918163311.I16499@osdlab.pdx.osdl.net>
	 <20030918163408.J16499@osdlab.pdx.osdl.net>
	 <20030918163523.K16499@osdlab.pdx.osdl.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-dN3MCQKN5zkwDxw51VNB"
Organization: Red Hat, Inc.
Message-Id: <1063957044.5394.7.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Fri, 19 Sep 2003 09:37:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dN3MCQKN5zkwDxw51VNB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-09-19 at 01:35, Chris Wright wrote:
> Replace busy loop nop with cpu_relax().
>=20
> Jeff, here's a batch for net drivers.  They all look pretty straight
> forward.
>=20
> =3D=3D=3D=3D=3D drivers/net/3c501.c 1.19 vs edited =3D=3D=3D=3D=3D
> --- 1.19/drivers/net/3c501.c	Tue Aug 26 13:21:28 2003
> +++ edited/drivers/net/3c501.c	Thu Sep 18 11:30:18 2003
> @@ -251,7 +251,8 @@
>  		outb(0x00, AX_CMD);
> =20
>  		delay =3D jiffies + HZ/50;
> -		while (time_before(jiffies, delay)) ;
> +		while (time_before(jiffies, delay))
> +			cpu_relax();
>  		autoirq =3D probe_irq_off(irq_mask);

mdelay()

> =20
>  		if (autoirq =3D=3D 0)
> =3D=3D=3D=3D=3D drivers/net/3c505.c 1.25 vs edited =3D=3D=3D=3D=3D
> --- 1.25/drivers/net/3c505.c	Tue Aug 26 13:29:32 2003
> +++ edited/drivers/net/3c505.c	Thu Sep 18 11:32:26 2003
> @@ -299,16 +299,20 @@
>  	}
>  	outb_control(adapter->hcr_val | ATTN | DIR, dev);
>  	timeout =3D jiffies + 1*HZ/100;
> -	while (time_before_eq(jiffies, timeout));
> +	while (time_before_eq(jiffies, timeout))
> +		cpu_relax();

mdelay()

>  	timeout =3D jiffies + 1*HZ/100;
> -	while (time_before_eq(jiffies, timeout));
> +	while (time_before_eq(jiffies, timeout))
> +		cpu_relax();

mdelay()

>  	outb_control(adapter->hcr_val | FLSH, dev);
>  	timeout =3D jiffies + 1*HZ/100;
> -	while (time_before_eq(jiffies, timeout));
> +	while (time_before_eq(jiffies, timeout))
> +		cpu_relax();

mdelay()
>  	outb_control(adapter->hcr_val & ~FLSH, dev);
>  	timeout =3D jiffies + 1*HZ/100;
> -	while (time_before_eq(jiffies, timeout));
> +	while (time_before_eq(jiffies, timeout))
> +		cpu_relax();
> =20

mdelay()
> =3D=3D=3D=3D=3D drivers/net/eepro.c 1.19 vs edited =3D=3D=3D=3D=3D
> --- 1.19/drivers/net/eepro.c	Tue Jul 15 10:01:29 2003
> +++ edited/drivers/net/eepro.c	Thu Sep 18 11:33:52 2003
> @@ -904,7 +904,8 @@
>  			eepro_diag(ioaddr); /* RESET the 82595 */
> =20
>  			delay =3D jiffies + HZ/50;
> -			while (time_before(jiffies, delay)) ;
> +			while (time_before(jiffies, delay))
> +				cpu_relax();

mdelay()
> =3D=3D=3D=3D=3D drivers/net/lance.c 1.18 vs edited =3D=3D=3D=3D=3D
> --- 1.18/drivers/net/lance.c	Sun Apr 20 22:41:09 2003
> +++ edited/drivers/net/lance.c	Thu Sep 18 11:37:30 2003
> @@ -554,7 +554,8 @@
>  		outw(0x0041, ioaddr+LANCE_DATA);
> =20
>  		delay =3D jiffies + HZ/50;
> -		while (time_before(jiffies, delay)) ;
> +		while (time_before(jiffies, delay))
> +			cpu_relax();

mdelay()



--=-dN3MCQKN5zkwDxw51VNB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/arI0xULwo51rQBIRAu8/AKCGVSgdsJJZqWloFaoMN4OiDAW9YQCePWZm
7Ul7jL0IhHH4D5onAsCOvU0=
=gUjX
-----END PGP SIGNATURE-----

--=-dN3MCQKN5zkwDxw51VNB--
