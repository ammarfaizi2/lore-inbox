Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbUA3Rd0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 12:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbUA3Rd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 12:33:26 -0500
Received: from wblv-238-222.telkomadsl.co.za ([165.165.238.222]:52867 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S262731AbUA3RdH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 12:33:07 -0500
Subject: Re: [ANNOUNCE] udev 015 release
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: Greg KH <greg@kroah.com>, linux-hotplug-devel@lists.sourceforge.net,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <401A8A35.1020105@gmx.de>
References: <20040126215036.GA6906@kroah.com>  <401A8A35.1020105@gmx.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-gfTAFbiXaHYlRmM7SCL+"
Message-Id: <1075483984.7206.4.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 30 Jan 2004 19:33:05 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gfTAFbiXaHYlRmM7SCL+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-01-30 at 18:45, Prakash K. Cheemplavam wrote:
> Hi Greg,
>=20
> perhaps you remember me being a gentoo user wanting to switch to udev.=20
> Well I did so, but am having some problems:
>=20
> 1.) Minor one: Nodes for Nvidia (I am using binary display modules=20
> 1.0.5328) ar not created. I have to do it by hand each start-up (written=20
> into loacal.start.):
> mknod /dev/nvidia0 c 195 0
> mknod /dev/nvidiactl c 195 255
>=20

What version baselayout?  Unstable use a tarball to save device nodes
...

> 2.) More probelmatic: I am having some serious troubles with my Epson=20
> Perfection USB scanner:
> a) I am to dumb to write a rule for it to map it to /dev/usb/scanner0
>=20
> Excerp of lsusb -v:
>=20
> Bus 001 Device 004: ID 04b8:010f Seiko Epson Corp. Perfection 1250
> Device Descriptor:
>    bLength                18
>    bDescriptorType         1
>    bcdUSB               1.10
>    bDeviceClass          255 Vendor Specific Class
>    bDeviceSubClass         0
>    bDeviceProtocol       255
>    bMaxPacketSize0         8
>    idVendor           0x04b8 Seiko Epson Corp.
>    idProduct          0x010f Perfection 1250
>    bcdDevice            1.00
>    iManufacturer           1 EPSON
>    iProduct                2 EPSON Scanner 010F
>    iSerial                 0
>    bNumConfigurations      1
>=20
> I don't exactly know which SYSFS_ field to use as the don't match the=20
> lsusb descriptor. I tried various ones, but the scanner always gets=20
> mapped to /dev/scanner0. I managed to get my HP printer to be mapped to=20
> usb/lp0 by using its serial. This is my (latest non working )line for=20
> the scanner:
>=20
> BUS=3D"usb", SYSFS_model=3D"Perfection 1250", NAME=3D"usb/scanner0"
>=20
> Now the serious issue: When rebooting or disconnecting the scanner I get=20
> a kernel oops:
>=20
> hub 1-0:1.0: new USB device on port 2, assigned address 4
> drivers/usb/image/scanner.c: USB scanner device (0x04b8/0x010f) now=20
> attached to usb/scanner0
> drivers/usb/core/usb.c: registered new driver usbscanner
> drivers/usb/image/scanner.c: 0.4.16:USB Scanner Driver
> usb 1-2: USB disconnect, address 4
> Unable to handle kernel NULL pointer dereference at virtual address 00000=
01e
>   printing eip:
> f9b370cc
> *pde =3D 00000000
> Oops: 0000 [#1]
> CPU:    0
> EIP:    0060:[<f9b370cc>]    Tainted: PF
> EFLAGS: 00010282
> EIP is at disconnect_scanner+0x2c/0x6d [scanner]
> eax: f685f0c0   ebx: f685f0d4   ecx: f9b370a0   edx: 00000007
> esi: 00000000   edi: f73194e8   ebp: f9b3abfc   esp: f78c3e50
> ds: 007b   es: 007b   ss: 0068
> Process khubd (pid: 983, threadinfo=3Df78c2000 task=3Df78da720)
> Stack: f685f0c0 f9b3ac78 f685f0c0 f9b3ace0 f9a4611b f685f0c0 f685f0c0=20
> f685f100
>         f685f0d4 f9b3ad00 c026c214 f685f0d4 f685f100 f73194fc f73194c0=20
> f9b36a4f
>         f685f0d4 f685f0c0 f73194fc f9b3ac0c 00000000 00000000 c021cbf8=20
> f73194fc
> Call Trace:
>   [<f9a4611b>] usb_unbind_interface+0x7b/0x80 [usbcore]
>   [<c026c214>] device_release_driver+0x64/0x70
>   [<f9b36a4f>] destroy_scanner+0x4f/0xb0 [scanner]
>   [<c021cbf8>] kobject_cleanup+0x98/0xa0
>   [<f9a4611b>] usb_unbind_interface+0x7b/0x80 [usbcore]
>   [<c026c214>] device_release_driver+0x64/0x70
>   [<c026c345>] bus_remove_device+0x55/0xa0
>   [<c026b27d>] device_del+0x5d/0xa0
>   [<f9a4c6af>] usb_disable_device+0x6f/0xb0 [usbcore]
>   [<f9a46b76>] usb_disconnect+0x96/0xf0 [usbcore]
>   [<f9a492df>] hub_port_connect_change+0x30f/0x320 [usbcore]
>   [<f9a48c13>] hub_port_status+0x43/0xb0 [usbcore]
>   [<f9a495ba>] hub_events+0x2ca/0x340 [usbcore]
>   [<f9a4965d>] hub_thread+0x2d/0xf0 [usbcore]
>   [<c010925e>] ret_from_fork+0x6/0x14
>   [<c011c9e0>] default_wake_function+0x0/0x20
>   [<f9a49630>] hub_thread+0x0/0xf0 [usbcore]
>   [<c0107289>] kernel_thread_helper+0x5/0xc
>=20
> Code: 80 7e 1e 00 75 2e 85 f6 74 17 8d 46 3c 8b 5c 24 08 8b 74 24
>=20
>=20
> And that's it. I cannot do a clean shut-down anymore, as the scanner=20
> module won't get unloaded. Is this an udev issue or is the module=20
> faulty? I am using latest Linus kernel 2.6.2-rc2.
>=20
> Other than that I am quite impressed by udev. I disabled the use of an=20
> archive saving all the nodes. This was getting on my nerves with a=20
> former udev release as populating /dev took several seconds. Now I=20
> cannot see any delay. Very well!
>=20
> bye,
>=20
> Prakash
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--=20
Martin Schlemmer

--=-gfTAFbiXaHYlRmM7SCL+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAGpVQqburzKaJYLYRAuHQAJoD0vL6Jbrwl0XvSlbC+/amjLaAfgCbBZQU
y7boJbjwCx3gNRxiN82Oax8=
=TSWY
-----END PGP SIGNATURE-----

--=-gfTAFbiXaHYlRmM7SCL+--

