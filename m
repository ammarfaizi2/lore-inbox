Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265951AbUAKSpE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 13:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265952AbUAKSpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 13:45:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:22703 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265951AbUAKSox (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 13:44:53 -0500
X-Authenticated: #21388368
Subject: Re: USB hangs
From: Lukas Postupa <postupa@gmx.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1073779636.17720.3.camel@dhcp23.swansea.linux.org.uk>
References: <1073779636.17720.3.camel@dhcp23.swansea.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-FWhjK4ckvjOk6ZgEbjRK"
Message-Id: <1073846788.2087.29.camel@linux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 11 Jan 2004 19:46:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FWhjK4ckvjOk6ZgEbjRK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Alan Cox wrote:
> With the various fixes people had been posting USB storage
> writing was still hanging repeatedly when doing a 20Gb rsync
> to usb-storage disks with a low memory system. Doing things
> like while(true) sync() made it hang even more often.
>=20
> After a bit of digging the following seems to fix it
>=20
> Not sure if 2.6 needs this as well.

I have similiar problems with kernel 2.6.0 on Intel architecture with
512 MB Ram.

My Abit IT7-MAX2 2.0 mainboard has two USB - EHCI controllers:

00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 02)

02:06.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51)

I'm using rsync to transfer my data to usb storage.
Connecting usb storage to one of the 4 ports of VIA EHCI controller and
then transferring data to it works good.

But connecting usb storage to one of the 6 ports of INTEL EHCI
controller and then transferring data to it, will hang up usb storage:

Buffer I/O error on device sda1, logical block 121479
lost page write due to I/O error on sda1
Buffer I/O error on device sda1, logical block 121480
lost page write due to I/O error on sda1
ehci_hcd 0000:00:1d.7: GetStatus port 2 status 001002 POWER sig=3Dse0  CSC
hub 6-0:1.0: port 2, status 100, change 1, 12 Mb/s
usb 6-2: USB disconnect, address 4
usb 6-2: usb_disable_device nuking all URBs
usb 6-2: unregistering interface 6-2:1.0
usb-storage: storage_disconnect() called
usb-storage: usb_stor_stop_transport called
usb-storage: -- dissociate_dev
usb-storage: -- sending exit command to thread
usb-storage: *** thread awakened.
usb-storage: -- exit command received
usb-storage: -- usb_stor_release_resources finished
usb 6-2: unregistering device

VIA EHCI controller uses interrupt 21.
INTEL EHCI controller uses interrupt 23.

cat /proc/interrupts:

           CPU0      =20
  0:   16675721    IO-APIC-edge  timer
  1:       6876    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  9:          5   IO-APIC-level  acpi
 12:     191706    IO-APIC-edge  i8042
 14:     251218    IO-APIC-edge  ide0
 15:          1    IO-APIC-edge  ide1
 16:    1446615   IO-APIC-level  uhci_hcd, nvidia
 18:          0   IO-APIC-level  uhci_hcd, uhci_hcd
 19:        278   IO-APIC-level  uhci_hcd, uhci_hcd, EMU10K1
 21:     257509   IO-APIC-level  ehci_hcd
 22:       7640   IO-APIC-level  eth0
 23:     322432   IO-APIC-level  ehci_hcd
NMI:          0=20
LOC:   16675149=20
ERR:          0
MIS:          0

Any ideas?

Lukas

--=-FWhjK4ckvjOk6ZgEbjRK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQBAAZoC7NqD+yPvj1cRApOoAJ9sA+GccMiQ1Y0P7W/gRgczYlp3QwCg6umT
OpQ+8Rl1jKYvhb3spBRRKYs=
=tn5g
-----END PGP SIGNATURE-----

--=-FWhjK4ckvjOk6ZgEbjRK--

