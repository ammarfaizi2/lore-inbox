Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269153AbUINCwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269153AbUINCwa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 22:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269147AbUINCti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 22:49:38 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:17871 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S269146AbUINCg7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 22:36:59 -0400
Date: Tue, 14 Sep 2004 04:35:33 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Natalie.Protasevich@unisys.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch 1/2] Incorrect PCI interrupt assignment on ES7000 for platform GSI
Message-ID: <20040914023533.GB20950@thundrix.ch>
References: <200409140151.i8E1p03W023713@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Content-Disposition: inline
In-Reply-To: <200409140151.i8E1p03W023713@localhost.localdomain>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Mon, Sep 13, 2004 at 07:50:59PM -0600, Natalie.Protasevich@unisys.com wr=
ote:
> diff -puN arch/i386/kernel/acpi/boot.c~mypatch arch/i386/kernel/acpi/boot=
=2Ec
> --- linux/arch/i386/kernel/acpi/boot.c~mypatch	2004-09-13 14:08:21.192015=
024 -0600
> +++ linux-root/arch/i386/kernel/acpi/boot.c	2004-09-13 14:10:51.457171248=
 -0600
> @@ -442,6 +442,7 @@ int acpi_gsi_to_irq(u32 gsi, unsigned in
>  unsigned int acpi_register_gsi(u32 gsi, int edge_level, int active_high_=
low)
>  {
>  	unsigned int irq;
> +	unsigned int plat_gsi;
> =20
>  #ifdef CONFIG_PCI
>  	/*
> @@ -463,10 +464,10 @@ unsigned int acpi_register_gsi(u32 gsi,=20
> =20
>  #ifdef CONFIG_X86_IO_APIC
>  	if (acpi_irq_model =3D=3D ACPI_IRQ_MODEL_IOAPIC) {
> -		mp_register_gsi(gsi, edge_level, active_high_low);
> +		plat_gsi =3D mp_register_gsi(gsi, edge_level, active_high_low);
>  	}
>  #endif
> -	acpi_gsi_to_irq(gsi, &irq);
> +	acpi_gsi_to_irq(plat_gsi, &irq);
>  	return irq;
>  }
>  EXPORT_SYMBOL(acpi_register_gsi);

Looking at that,  won't that cause problems if  we don't have IOAPIC?
Then you end up using an undefined value as GSI.

			    Tonnerre

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBRlj0/4bL7ovhw40RAjB8AJoCUYPd5IQ7PljSqMYi7hBjXvKWqQCfSFTD
003avf/EpGxMWPbPC1RBXZ4=
=Biw5
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
