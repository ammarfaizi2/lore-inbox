Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264922AbUELA4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264922AbUELA4r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 20:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264402AbUELAxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 20:53:11 -0400
Received: from panda.sul.com.br ([200.219.150.4]:63502 "EHLO panda.sul.com.br")
	by vger.kernel.org with ESMTP id S263173AbUELAwe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 20:52:34 -0400
Date: Tue, 11 May 2004 21:50:08 -0300
To: mike <mike@bristolreccc.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem with sis900 driver 2.6.5 +
Message-ID: <20040512005008.GA18347@cathedrallabs.org>
References: <1084300104.24569.8.camel@datacontrol>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9zSXsLTf0vkW971A"
Content-Disposition: inline
In-Reply-To: <1084300104.24569.8.camel@datacontrol>
From: aris@cathedrallabs.org (Aristeu Sergio Rozanski Filho)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> In kernels 2.6.5 and above (may affect 2.6.4 as well) there seems to be
> a problem with the sis900 eth driver
>=20
> I have a sis chipset with integrated ethernet sis900 driver which has
> always worked perfectly up to and including 2.6.3 (fedora)
>=20
> Now with both fedora 2.6.5 kernel and vanilla 2.6.6 eth0 does not come
> up
>=20
> relevant messages
>=20
> sis900 device eth0 does not appear to be present delaying initialisation
>=20
> and from dmesg eth0: cannot find ISA bridge
>=20
> 2.6.3 works fine
>=20
> lsmod shows sis and sis900 modules loaded fine
I had the same problem, the patch attached is a dirty fix to get it
running again. in newer kernels its isa bridge is listed with a different
product id (0x0018). no idea why.

--=20
Aristeu


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sis900-isa_bridge.patch"
Content-Transfer-Encoding: quoted-printable

--- linux-2.6.5/drivers/net/sis900.c.old	2004-05-11 21:50:35.000000000 -0300
+++ linux-2.6.5/drivers/net/sis900.c	2004-05-11 21:51:38.000000000 -0300
@@ -260,7 +260,8 @@ static int __devinit sis630e_get_mac_add
 	u8 reg;
 	int i;
=20
-	if ((isa_bridge =3D pci_find_device(0x1039, 0x0008, isa_bridge)) =3D=3D N=
ULL) {
+	if ((isa_bridge =3D pci_find_device(0x1039, 0x0008, isa_bridge)) =3D=3D N=
ULL &&
+		(isa_bridge =3D pci_find_device(0x1039, 0x0018, isa_bridge)) =3D=3D NULL=
) {
 		printk("%s: Can not find ISA bridge\n", net_dev->name);
 		return 0;
 	}

--9zSXsLTf0vkW971A--
