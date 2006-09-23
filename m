Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWIWLEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWIWLEI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 07:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWIWLEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 07:04:08 -0400
Received: from pool-71-254-65-206.ronkva.east.verizon.net ([71.254.65.206]:20675
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750700AbWIWLEE (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 07:04:04 -0400
Message-Id: <200609231103.k8NB3RiF004703@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc7-mm1  - gregkh-driver-pcmcia-device.patch breaks orinoco card
In-Reply-To: Your message of "Tue, 19 Sep 2006 01:28:48 PDT."
             <20060919012848.4482666d.akpm@osdl.org>
From: Valdis.Kletnieks@vt.edu
References: <20060919012848.4482666d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1159009406_2904P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 23 Sep 2006 07:03:26 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1159009406_2904P
Content-Type: text/plain; charset=us-ascii

On Tue, 19 Sep 2006 01:28:48 PDT, Andrew Morton said:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc7/2.6.18-rc7-mm1/

> +gregkh-driver-pcmcia-device.patch

This one breaks the orinoco wireless card on my Dell Latitude C840.  Oddly
enough, it *doesn't* break the ethernet on a Xircom multi-function card I
also have.  I tried it both with and without CONFIG_SYSFS_DEPRECATED.
Userspace udev is 095 as shipped in Fedora Core 6 test3.

(slot 0 is a Xircom 10/100/56k modem card, slot 2 is the Orinoco-based
Dell TruMobile 1150 card)

Under 2.6.18-rc6-mm2, I see:

pccard: CardBus card inserted into slot 0
PCI: Enabling device 0000:03:00.0 (0000 -> 0003)
ACPI: PCI Interrupt 0000:03:00.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:03:00.0 to 64
eth2: Xircom cardbus revision 3 at irq 11
PCI: Enabling device 0000:03:00.1 (0000 -> 0003)
ACPI: PCI Interrupt 0000:03:00.1[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
0000:03:00.1: ttyS1 at I/O 0xe080 (irq = 11) is a 16550A
pccard: PCMCIA card inserted into slot 2
[rename_device:851]: Changing netdevice name from [eth1] to [eth3]
ohci1394: fw-host0: AT dma reset ctx=0, aborting transmission
ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[374fc0002a71c021]
[rename_device:1237]: Changing netdevice name from [eth2] to [eth1]
cs: memory probe 0xf4000000-0xfbffffff: excluding 0xf4000000-0xf8ffffff 0xfa000000-0xfbffffff
pcmcia: registering new device pcmcia2.0
orinoco 0.15 (David Gibson <hermes@gibson.dropbear.id.au>, Pavel Roskin <proski@gnu.org>, et al)
orinoco_cs 0.15 (David Gibson <hermes@gibson.dropbear.id.au>, Pavel Roskin <proski@gnu.org>, et al)
pcmcia: request for exclusive IRQ could not be fulfilled.
pcmcia: the driver needs updating to supported shared IRQ lines.
cs: IO port probe 0x100-0x3af: excluding 0x370-0x37f
cs: IO port probe 0x3e0-0x4ff: clean.
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
cs: IO port probe 0x100-0x3af: excluding 0x370-0x37f
cs: IO port probe 0x3e0-0x4ff: clean.
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
cs: IO port probe 0x100-0x3af: excluding 0x370-0x37f
cs: IO port probe 0x3e0-0x4ff: clean.
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
eth2: Hardware identity 0005:0004:0005:0000
eth2: Station identity  001f:0001:0008:000a
eth2: Firmware determined as Lucent/Agere 8.10
eth2: Ad-hoc demo mode supported
eth2: IEEE standard IBSS ad-hoc mode supported
eth2: WEP supported, 104-bit key
eth2: MAC address 00:02:2D:5C:11:48
eth2: Station name "HERMES I"
eth2: ready
eth2: orinoco_cs at 2.0, irq 11, io 0xe100-0xe13f
[rename_device:1295]: Changing netdevice name from [eth2] to [eth5]
Non-volatile memory driver v1.2

and under -rc7-mm1, I see:

pccard: CardBus card inserted into slot 0
PCI: Enabling device 0000:03:00.0 (0000 -> 0003)
ACPI: PCI Interrupt 0000:03:00.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:03:00.0 to 64
eth1: Xircom cardbus revision 3 at irq 11 
PCI: Enabling device 0000:03:00.1 (0000 -> 0003)
ACPI: PCI Interrupt 0000:03:00.1[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
0000:03:00.1: ttyS1 at I/O 0xe080 (irq = 11) is a 16550A
pccard: PCMCIA card inserted into slot 2
ohci1394: fw-host0: AT dma reset ctx=0, aborting transmission
ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[374fc0002a71c021]
Non-volatile memory driver v1.2

Hmm.. a lot quieter...

Incidentally, this bisection took about 8 more compiles than it should
have because of compile-time breakage right in that section of the 'series'
file.  To bisect through it, I had to apply the following tweaks to the
series file:

--- patches/series.orig	2006-09-21 15:06:13.000000000 -0400
+++ patches/series	2006-09-23 00:18:54.000000000 -0400
@@ -104,6 +104,8 @@
 gregkh-driver-v4l-dev2-handle-__must_check.patch
 gregkh-driver-drivers-base-platform-notify-needs-to-occur-before-drivers-attach-to-the-device.patch
 gregkh-driver-drivers-base-check-errors.patch
+gregkh-driver-network-class_device-to-device.patch
+gregkh-driver-class_device_rename-remove.patch
 gregkh-driver-sysfs-add-proper-sysfs_init-prototype.patch
 gregkh-driver-config_sysfs_deprecated.patch
 gregkh-driver-udev-devices.patch
@@ -123,12 +125,11 @@
 gregkh-driver-input-device.patch
 gregkh-driver-firmware-device.patch
 gregkh-driver-fb-device.patch
+gregkh-driver-fb-device-fixes.patch
 gregkh-driver-usb-move-usb_device_class-class-devices-to-be-real-devices.patch
 gregkh-driver-usb-convert-usb-class-devices-to-real-devices.patch
 gregkh-driver-driver-multithread.patch
 gregkh-driver-pci-multithreaded-probe.patch
-gregkh-driver-network-class_device-to-device.patch
-gregkh-driver-class_device_rename-remove.patch
 gregkh-driver-put_device-might_sleep.patch
 gregkh-driver-sysfs-crash-debugging.patch
 gregkh-driver-kobject-warn.patch
@@ -140,7 +141,6 @@
 gregkh-driver-input-device-more-fixes.patch
 gregkh-driver-input-device-even-more-fixes.patch
 gregkh-driver-input-device-even-more-fixes-2.patch
-gregkh-driver-fb-device-fixes.patch
 more-driver-tree-fixes.patch
 #drivers-base-check-errors.patch
 #fix-device_attribute-memory-leak-in-device_del.patch


--==_Exmh_1159009406_2904P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFFRR+cC3lWbTT17ARApmUAKDWIzj5SXoTeNB2R6bWKV/7BTMgOgCgzmvu
5lDiTpEvjRRzidKURV6f8kY=
=+3Rs
-----END PGP SIGNATURE-----

--==_Exmh_1159009406_2904P--
