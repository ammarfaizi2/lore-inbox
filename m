Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbUA3XGj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 18:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264361AbUA3XGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 18:06:39 -0500
Received: from fed1mtao02.cox.net ([68.6.19.243]:39581 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S264358AbUA3XGf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 18:06:35 -0500
Date: Fri, 30 Jan 2004 16:06:33 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andre Noll <noll@mathematik.tu-darmstadt.de>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: [ANNOUNCE] udev 015 release
Message-ID: <20040130230633.GZ6577@stop.crashing.org>
References: <20040126215036.GA6906@kroah.com> <20040126215036.GA6906@kroah.com> <401A8A35.1020105@gmx.de> <slrnc1l72v.9m.noll@localhost.mathematik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <slrnc1l72v.9m.noll@localhost.mathematik.tu-darmstadt.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2004 at 06:03:11PM -0000, Andre Noll wrote:
> On Fri, 30 Jan 2004 17:45:41 +0100 you wrote in local.lists.kernel:
> > Unable to handle kernel NULL pointer dereference at virtual address 000=
0001e
> >   printing eip:
> > f9b370cc
> > *pde =3D 00000000
> > Oops: 0000 [#1]
> > CPU:    0
> > EIP:    0060:[<f9b370cc>]    Tainted: PF
> > EFLAGS: 00010282
> > EIP is at disconnect_scanner+0x2c/0x6d [scanner]
> > eax: f685f0c0   ebx: f685f0d4   ecx: f9b370a0   edx: 00000007
> > esi: 00000000   edi: f73194e8   ebp: f9b3abfc   esp: f78c3e50
> > ds: 007b   es: 007b   ss: 0068
> > Process khubd (pid: 983, threadinfo=3Df78c2000 task=3Df78da720)
> > Stack: f685f0c0 f9b3ac78 f685f0c0 f9b3ace0 f9a4611b f685f0c0 f685f0c0=
=20
> > f685f100
> >         f685f0d4 f9b3ad00 c026c214 f685f0d4 f685f100 f73194fc f73194c0=
=20
> > f9b36a4f
> >         f685f0d4 f685f0c0 f73194fc f9b3ac0c 00000000 00000000 c021cbf8=
=20
> > f73194fc
> > Call Trace:
> >   [<f9a4611b>] usb_unbind_interface+0x7b/0x80 [usbcore]
> >   [<c026c214>] device_release_driver+0x64/0x70
> >   [<f9b36a4f>] destroy_scanner+0x4f/0xb0 [scanner]
> >   [<c021cbf8>] kobject_cleanup+0x98/0xa0
> >   [<f9a4611b>] usb_unbind_interface+0x7b/0x80 [usbcore]
> >   [<c026c214>] device_release_driver+0x64/0x70
> >   [<c026c345>] bus_remove_device+0x55/0xa0
> >   [<c026b27d>] device_del+0x5d/0xa0
> >   [<f9a4c6af>] usb_disable_device+0x6f/0xb0 [usbcore]
> >   [<f9a46b76>] usb_disconnect+0x96/0xf0 [usbcore]
> >   [<f9a492df>] hub_port_connect_change+0x30f/0x320 [usbcore]
> >   [<f9a48c13>] hub_port_status+0x43/0xb0 [usbcore]
> >   [<f9a495ba>] hub_events+0x2ca/0x340 [usbcore]
> >   [<f9a4965d>] hub_thread+0x2d/0xf0 [usbcore]
> >   [<c010925e>] ret_from_fork+0x6/0x14
> >   [<c011c9e0>] default_wake_function+0x0/0x20
> >   [<f9a49630>] hub_thread+0x0/0xf0 [usbcore]
> >   [<c0107289>] kernel_thread_helper+0x5/0xc
> >
> > Code: 80 7e 1e 00 75 2e 85 f6 74 17 8d 46 3c 8b 5c 24 08 8b 74 24
>=20
> Same problem here. Also with Epson Perfection (640U) and kernel
> 2.6.2-rc1:

Greg, I think this now makes 2 distinct bugs in the scanner kernel
driver.  Maybe it should be protected with a BROKEN:
--- 1.6/drivers/usb/image/Kconfig	Mon Dec  1 06:51:48 2003
+++ edited/drivers/usb/image/Kconfig	Fri Jan 30 16:05:24 2004
@@ -19,7 +19,7 @@
=20
 config USB_SCANNER
 	tristate "USB Scanner support (OBSOLETE)"
-	depends on USB
+	depends on USB && BROKEN
 	help
 	  Say Y here if you want to connect a USB scanner to your computer's
 	  USB port. Please read <file:Documentation/usb/scanner.txt> for more

=2E.. or simply removed from the kernel.

--=20
Tom Rini
http://gate.crashing.org/~trini/

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAGuN5dZngf2G4WwMRAuPLAKCBoDeBS420bIISVNFuZ2apxcOMPwCgjHMh
woYtH1pYsVHEAV5rED+N2Kw=
=euhw
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
