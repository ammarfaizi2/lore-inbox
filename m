Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263870AbUDVIp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263870AbUDVIp3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 04:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbUDVIp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 04:45:29 -0400
Received: from legolas.restena.lu ([158.64.1.34]:4007 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S263870AbUDVIpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 04:45:16 -0400
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
	for idle=C1halt, 2.6.5
From: Craig Bradney <cbradney@zip.com.au>
To: Len Brown <len.brown@intel.com>
Cc: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>, ross@datscreative.com.au,
       christian.kroener@tu-harburg.de, linux-kernel@vger.kernel.org,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>,
       Ian Kumlien <pomac@vapor.com>, Jesse Allen <the3dfxdude@hotmail.com>,
       a.verweij@student.tudelft.nl, Allen Martin <AMartin@nvidia.com>
In-Reply-To: <1082587298.16336.138.camel@dhcppc4>
References: <200404131117.31306.ross@datscreative.com.au>
	 <200404131703.09572.ross@datscreative.com.au>
	 <1081893978.2251.653.camel@dhcppc4>
	 <200404160110.37573.ross@datscreative.com.au>
	 <1082060255.24425.180.camel@dhcppc4>
	 <1082063090.4814.20.camel@amilo.bradney.info>
	 <1082578957.16334.13.camel@dhcppc4>  <4086E76E.3010608@gmx.de>
	 <1082587298.16336.138.camel@dhcppc4>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-hKkPPVf+Q4nkwCIzXL3q"
Message-Id: <1082623508.10528.7.camel@amilo.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 22 Apr 2004 10:45:09 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hKkPPVf+Q4nkwCIzXL3q
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-04-22 at 00:41, Len Brown wrote:
> > Please send me the output from dmidecode, available in /usr/sbin/, or
> > > here:
> > > http://www.nongnu.org/dmidecode/
> > > or
> > > http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/
>=20
> On Wed, 2004-04-21 at 17:28, Prakash K. Cheemplavam wrote:
>=20
> > this is the output for Abit NF7-S Rev20 using bios d23. I have NOT=20
> > activated APIC for this. Is it needed?
>=20
> Yes, you need to enable ACPI and IOAPIC.  The goal of this patch
> is to address the XT-PIC timer issue in IOAPIC mode.
>=20
> Here's the latest (vs 2.6.5).


Do we need any other patch? eg the idlec1halt patch? My Athlon still has
2.6.3 on it.

> I've got 1 Abit, 2 Asus, and 1 Shuttle DMI entry.  Let me know if the
> product names (1st line of dmidecode entry) are correct,
> these are not from DMI, but are supposed to be human-readable titles.

+ { ignore_timer_override, "Asus A7N8X v2", {=20
> +			MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
> +			MATCH(DMI_BOARD_NAME, "A7N8X2.0"),
> +			MATCH(DMI_BIOS_VERSION, "ASUS A7N8X2.0 Deluxe ACPI BIOS Rev 1007"),
> +			MATCH(DMI_BIOS_DATE, "10/06/2003") }},

my dmidecode output also shows (in the first BIOS information section):
Vendor: Phoenix Technologies, LTD
although the Manufacturer is ASUSTek Computer INC. form the Base Board
and System sections.

Not really sure about the code. If it matches on all of above then it
might not work. Ill try a new kernel later today and see the result.

> I'm interested only in the latest BIOS -- if it is still broken.
> The assumption is that if a fixed BIOS is available, the users
> should upgrade.
>=20

Yes, I just checked yesterday and there was nothing new.

thanks
Craig

> thanks,
> -Len
>=20
> ps. latest BIOS on my shuttle has a C1 disconnect enable setting,
> (curiously, it is disabled by default) so I'll try to reproduce the hang
> on it...
>=20
> =3D=3D=3D=3D=3D Documentation/kernel-parameters.txt 1.44 vs edited =3D=3D=
=3D=3D=3D
> --- 1.44/Documentation/kernel-parameters.txt	Mon Mar 22 16:03:22 2004
> +++ edited/Documentation/kernel-parameters.txt	Wed Apr 21 15:28:12 2004
> @@ -122,6 +122,10 @@
> =20
>  	acpi_serialize	[HW,ACPI] force serialization of AML methods
> =20
> +	acpi_skip_timer_override [HW,ACPI]
> +			Recognize and ignore IRQ0/pin2 Interrupt Override.
> +			For broken nForce2 BIOS resulting in XT-PIC timer.
> +
>  	ad1816=3D		[HW,OSS]
>  			Format: <io>,<irq>,<dma>,<dma2>
>  			See also Documentation/sound/oss/AD1816.
> =3D=3D=3D=3D=3D arch/i386/kernel/dmi_scan.c 1.57 vs edited =3D=3D=3D=3D=
=3D
> --- 1.57/arch/i386/kernel/dmi_scan.c	Fri Apr 16 22:03:06 2004
> +++ edited/arch/i386/kernel/dmi_scan.c	Wed Apr 21 18:29:35 2004
> @@ -540,6 +540,19 @@
>  #endif
> =20
>  /*
> + * early nForce2 reference BIOS shipped with a
> + * bogus ACPI IRQ0 -> pin2 interrupt override -- ignore it
> + */
> +static __init int ignore_timer_override(struct dmi_blacklist *d)
> +{
> +	extern int acpi_skip_timer_override;
> +	printk(KERN_NOTICE "%s detected: BIOS IRQ0 pin2 override"
> +		" will be ignored\n", d->ident); =09
> +
> +	acpi_skip_timer_override =3D 1;
> +	return 0;
> +}
> +/*
>   *	Process the DMI blacklists
>   */
>  =20
> @@ -944,6 +957,37 @@
>  			MATCH(DMI_BOARD_VENDOR, "IBM"),
>  			MATCH(DMI_PRODUCT_NAME, "eserver xSeries 440"),
>  			NO_MATCH, NO_MATCH }},
> +
> +/*
> + * Systems with nForce2 BIOS timer override bug
> + * add Albatron KM18G Pro
> + * add DFI NFII 400-AL
> + * add Epox 8RGA+
> + * add Shuttle AN35N
> + */
> +	{ ignore_timer_override, "Abit NF7-S v2", {
> +			MATCH(DMI_BOARD_VENDOR, "http://www.abit.com.tw/"),
> +			MATCH(DMI_BOARD_NAME, "NF7-S/NF7,NF7-V (nVidia-nForce2)"),
> +			MATCH(DMI_BIOS_VERSION, "6.00 PG"),
> +			MATCH(DMI_BIOS_DATE, "03/24/2004") }},
> +
> +	{ ignore_timer_override, "Asus A7N8X v2", {
> +			MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
> +			MATCH(DMI_BOARD_NAME, "A7N8X2.0"),
> +			MATCH(DMI_BIOS_VERSION, "ASUS A7N8X2.0 Deluxe ACPI BIOS Rev 1007"),
> +			MATCH(DMI_BIOS_DATE, "10/06/2003") }},
> +
> +	{ ignore_timer_override, "Asus A7N8X-X", {
> +			MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
> +			MATCH(DMI_BOARD_NAME, "A7N8X-X"),
> +			MATCH(DMI_BIOS_VERSION, "ASUS A7N8X-X ACPI BIOS Rev 1007"),
> +			MATCH(DMI_BIOS_DATE, "10/07/2003") }},
> +
> +	{ ignore_timer_override, "Shuttle SN41G2", {
> +			MATCH(DMI_BOARD_VENDOR, "Shuttle Inc"),
> +			MATCH(DMI_BOARD_NAME, "FN41"),
> +			MATCH(DMI_BIOS_VERSION, "6.00 PG"),
> +			MATCH(DMI_BIOS_DATE, "01/14/2004") }},
>  #endif	// CONFIG_ACPI_BOOT
> =20
>  #ifdef	CONFIG_ACPI_PCI
> =3D=3D=3D=3D=3D arch/i386/kernel/setup.c 1.115 vs edited =3D=3D=3D=3D=3D
> --- 1.115/arch/i386/kernel/setup.c	Fri Apr  2 07:21:43 2004
> +++ edited/arch/i386/kernel/setup.c	Wed Apr 21 15:28:12 2004
> @@ -614,6 +614,9 @@
>  		else if (!memcmp(from, "acpi_sci=3Dlow", 12))
>  			acpi_sci_flags.polarity =3D 3;
> =20
> +		else if (!memcmp(from, "acpi_skip_timer_override", 24))
> +			acpi_skip_timer_override =3D 1;
> +
>  #ifdef CONFIG_X86_LOCAL_APIC
>  		/* disable IO-APIC */
>  		else if (!memcmp(from, "noapic", 6))
> =3D=3D=3D=3D=3D arch/i386/kernel/acpi/boot.c 1.58 vs edited =3D=3D=3D=3D=
=3D
> --- 1.58/arch/i386/kernel/acpi/boot.c	Tue Apr 20 20:54:03 2004
> +++ edited/arch/i386/kernel/acpi/boot.c	Wed Apr 21 15:28:13 2004
> @@ -62,6 +62,7 @@
> =20
>  acpi_interrupt_flags acpi_sci_flags __initdata;
>  int acpi_sci_override_gsi __initdata;
> +int acpi_skip_timer_override __initdata;
> =20
>  #ifdef CONFIG_X86_LOCAL_APIC
>  static u64 acpi_lapic_addr __initdata =3D APIC_DEFAULT_PHYS_BASE;
> @@ -327,6 +328,12 @@
>  		acpi_sci_ioapic_setup(intsrc->global_irq,
>  			intsrc->flags.polarity, intsrc->flags.trigger);
>  		return 0;
> +	}
> +
> +	if (acpi_skip_timer_override &&
> +		intsrc->bus_irq =3D=3D 0 && intsrc->global_irq =3D=3D 2) {
> +			printk(PREFIX "BIOS IRQ0 pin2 override ignored.\n");
> +			return 0;
>  	}
> =20
>  	mp_override_legacy_irq (
> =3D=3D=3D=3D=3D include/asm-i386/acpi.h 1.18 vs edited =3D=3D=3D=3D=3D
> --- 1.18/include/asm-i386/acpi.h	Tue Mar 30 17:05:19 2004
> +++ edited/include/asm-i386/acpi.h	Wed Apr 21 15:28:14 2004
> @@ -118,6 +118,7 @@
>  #ifdef CONFIG_X86_IO_APIC
>  extern int skip_ioapic_setup;
>  extern int acpi_irq_to_vector(u32 irq);	/* deprecated in favor of
> acpi_gsi_to_irq */
> +extern int acpi_skip_timer_override;
> =20
>  static inline void disable_ioapic_setup(void)
>  {
>=20
>=20

--=-hKkPPVf+Q4nkwCIzXL3q
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAh4YUi+pIEYrr7mQRApgIAKCue7s/IifT/IbtGBZc2RUzHL4nAwCfeptE
OOYYOFu2JWkKvoaVPXSx4bY=
=5JCg
-----END PGP SIGNATURE-----

--=-hKkPPVf+Q4nkwCIzXL3q--

