Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264671AbUDVUvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264671AbUDVUvl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 16:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264669AbUDVUvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 16:51:41 -0400
Received: from legolas.restena.lu ([158.64.1.34]:48771 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S264672AbUDVUuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 16:50:39 -0400
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
In-Reply-To: <1082646181.16333.217.camel@dhcppc4>
References: <200404131117.31306.ross@datscreative.com.au>
	 <200404131703.09572.ross@datscreative.com.au>
	 <1081893978.2251.653.camel@dhcppc4>
	 <200404160110.37573.ross@datscreative.com.au>
	 <1082060255.24425.180.camel@dhcppc4>
	 <1082063090.4814.20.camel@amilo.bradney.info>
	 <1082578957.16334.13.camel@dhcppc4>  <4086E76E.3010608@gmx.de>
	 <1082587298.16336.138.camel@dhcppc4>
	 <1082623508.10528.7.camel@amilo.bradney.info>
	 <1082646181.16333.217.camel@dhcppc4>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5cytz3+apCtSeXiaJab2"
Message-Id: <1082667033.6133.20.camel@amilo.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 22 Apr 2004 22:50:33 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5cytz3+apCtSeXiaJab2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-04-22 at 17:03, Len Brown wrote:
> On Thu, 2004-04-22 at 04:45, Craig Bradney wrote:
>=20
> > > Yes, you need to enable ACPI and IOAPIC.  The goal of this patch
> > > is to address the XT-PIC timer issue in IOAPIC mode.
> > >=20
> > > Here's the latest (vs 2.6.5).
> >=20
> >=20
> > Do we need any other patch? eg the idlec1halt patch? My Athlon still ha=
s
> > 2.6.3 on it.
>=20
> If you needed idlec1halt before, you still need it.
> This patch just addresses the XT-PIC timer issue.
>=20
> >=20
> > > I've got 1 Abit, 2 Asus, and 1 Shuttle DMI entry.  Let me know if the
> > > product names (1st line of dmidecode entry) are correct,
> > > these are not from DMI, but are supposed to be human-readable titles.
> >=20
> > + { ignore_timer_override, "Asus A7N8X v2", {=20
> > > +			MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
> > > +			MATCH(DMI_BOARD_NAME, "A7N8X2.0"),
> > > +			MATCH(DMI_BIOS_VERSION, "ASUS A7N8X2.0 Deluxe ACPI BIOS Rev 1007"=
),
> > > +			MATCH(DMI_BIOS_DATE, "10/06/2003") }},
> >=20
> > my dmidecode output also shows (in the first BIOS information section):
> > Vendor: Phoenix Technologies, LTD
> > although the Manufacturer is ASUSTek Computer INC. form the Base Board
> > and System sections.
>=20
> Right, DMI has separate sections for System, Board, BIOS, and we're
> using two pieces from the BOARD and two pieces from the BIOS sections.
>=20
> > Not really sure about the code. If it matches on all of above then it
> > might not work. Ill try a new kernel later today and see the result.
>=20
> The workaround is triggered only if all the MATCH()'s above match.
> If it doesn't trigger, then either I munged it on copy out of dmidecode
> or you've got a different BIOS and we need a new dmidecode...
>=20
> > > I'm interested only in the latest BIOS -- if it is still broken.
> > > The assumption is that if a fixed BIOS is available, the users
> > > should upgrade.
> > >=20
> >=20
> > Yes, I just checked yesterday and there was nothing new.

[Have sent this email with attachments directly to Len, attachments are
just /proc/interrupts and dmegs output. If someone is interested, please
ask for them]

Hi Len

Please find attached /proc/interrupts and dmesg from 3 boots, 2 with new
kernel.

263 : gentoo-dev-sources-r1 2.6.3 kernel with Ross Dickson's idleC1halt
and IOAPIC patches.

265: gentoo-dev-sources-r1 2.6.5 kernel with Ross Dickson's idleC1halt
for 2.6.5 kernel only. Note in 265pi (/proc/interrupts):
0:      54821          XT-PIC  timer

265-lb: gentoo-dev-sources-r1 2.6.5 kernel with Ross Dickson's
idleC1halt for 2.6.5 kernel and your patch for the interrupt.=20
Note in 265pi-lb (/proc/interrupts):
0:      51144    IO-APIC-edge  timer

so.. looks good here. :) I was surprised to see this effect with no boot
kernel option though. Having read the code I see you set the value to 1
and therefore on. Seems fine to me.

regards
Craig

--=-5cytz3+apCtSeXiaJab2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAiDAZi+pIEYrr7mQRAmhGAKCGRhC9R9mLV05XCCdh+Gwbeb76KACeP+7C
wHJu6LqcdX2vTNxeaA3s+M0=
=wese
-----END PGP SIGNATURE-----

--=-5cytz3+apCtSeXiaJab2--

