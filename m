Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbVAHBqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbVAHBqc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 20:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbVAHBqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 20:46:32 -0500
Received: from smtp08.auna.com ([62.81.186.18]:63660 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S261770AbVAHBpz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 20:45:55 -0500
Date: Sat, 08 Jan 2005 01:45:52 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: i2c: lost sensors with 2.6.10(-mm1)
To: Jean Delvare <khali@linux-fr.org>
Cc: "J.A. Magallon" <jamagallon@able.es>, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       LM Sensors <sensors@stimpy.netroedge.com>
References: <1105058791l.5580l.0l@werewolf.able.es>
	<41DE5B99.1040602@linux-fr.org>
In-Reply-To: <41DE5B99.1040602@linux-fr.org> (from khali@linux-fr.org on Fri
	Jan  7 10:51:21 2005)
X-Mailer: Balsa 2.2.6
Message-Id: <1105148752l.9029l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-IWwiiQuRDLjqGp9U8Fis"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-IWwiiQuRDLjqGp9U8Fis
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On 2005.01.07, Jean Delvare wrote:
> J.A. Magallon wrote:
>=20
> > I have lost my sensors info with 2.6.10, in particular -mm1.
> > They work fine with 2.6.9-mm1 (current state of the box, booted on
> > 2.6.9 or 10, no other difference).
>  > (...)
> > I have noticed different contents in /sys:
> > under 2.6.9:
> > /sys/devices/platform/i2c-1:
> > /sys/devices/platform/i2c-1/1-0290:
> > /sys/devices/platform/i2c-1/1-0290/power:
> > /sys/devices/platform/i2c-1/power:
> >=20
> > under 2.6.10:
> > /sys/devices/platform/i2c-1:
> > /sys/devices/platform/i2c-1/power:
> >=20
> > So some /sys nodes are missing !!!
> > (the isa bus)
>=20
> This basically means that the i2c client was not registered.
>=20
> > Debug output from 2.6.10-mm1:
> > (...)
> > Jan  7 01:33:11 werewolf kernel: i2c-core: driver w83627hf registered.
> > Jan  7 01:33:11 werewolf kernel: i2c_adapter i2c-1: found normal isa en=
try for adapter 9191, addr 0290
>=20
> However, this suggests that the driver loaded properly and the base=20
> address was correctly read from Super-I/O space. This would mean that=20
> the problem happened later, in w83627hf_detect(). The most likely reason=20
> for this would be if the region request failed (unfortunately we have no=20
> message, not even debug, if this happens).
>=20
> > Some ideas ?
>=20
> Three things to try, in order:
>=20
> 1* Compare /proc/ioports in 2.6.9-mm1 and 2.6.10-mm1. I suspect that the=20
> 0x290-0x297 range is held by some device in 2.6.10-mm1.
>=20

Disabling "Plug and Play ACPI support" freed the ioport range and sensors
worked again.

Thanks for the info.

Is this a problem/conflict ? Or I can't use PnP-ACPI (if I ever guess
what is it useful for) and sensors at the same time ?

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-jam2 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-2mdk)) #1


--=-IWwiiQuRDLjqGp9U8Fis
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBB3ztQRlIHNEGnKMMRAmh+AJ9ZunNDr1bT+/7WyezAn3ytfwdAbACfQvgw
lDq5X/TDKuGLoTHnoocGVNA=
=gYTA
-----END PGP SIGNATURE-----

--=-IWwiiQuRDLjqGp9U8Fis--

