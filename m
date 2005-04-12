Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262028AbVDLFAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbVDLFAv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 01:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVDLFAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 01:00:31 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:31986 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261976AbVDLDRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 23:17:51 -0400
Message-ID: <425B3DDD.7020100@comcast.net>
Date: Mon, 11 Apr 2005 23:17:49 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: USB on zx5405us
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

USB isn't working on my zv5405us on a 2.6.10 ubuntu kernel.  Or on
gentoo.  Or anything.  It works in WindowsXP though.

I can extract the error from dmesg.

Here's ACPI first (ACPI works btw)

Nvidia board detected. Ignoring ACPI timer override.
ACPI: RSDP (v000 PTLTD                                 ) @
0x00000000000f7260
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @
0x000000001ff7a87e
ACPI: FADT (v001 NVIDIA CK8      0x06040000 PTL_ 0x000f4240) @
0x000000001ff7ee13
ACPI: MADT (v001 NVIDIA NV_APIC_ 0x06040000  LTP 0x00000000) @
0x000000001ff7ee87
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @
0x000000001ff7eee1
ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @
0x000000001ff7ef09
ACPI: DSDT (v001 NVIDIA      CK8 0x06040000 MSFT 0x0100000e) @
0x0000000000000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information

ACPI wakeup devices:
USB0 USB1 USB2 PS2K PS2M MAC0
ACPI: (supports S0 S3 S4 S5)

NFORCE3-150: IDE controller at PCI slot 0000:00:08.0
NFORCE3-150: chipset revision 165
NFORCE3-150: not 100% native mode: will probe irqs later
NFORCE3-150: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE3-150: 0000:00:08.0 (rev a5) UDMA133 controller
    ide0: BM-DMA at 0x2080-0x2087, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x2088-0x208f, BIOS settings: hdc:DMA, hdd:pio



Finally, the USB messages themselves:

ohci_hcd 0000:00:02.0: nVidia Corporation nForce3 USB 1.1
ohci_hcd 0000:00:02.0: USB HC TakeOver failed!
ohci_hcd 0000:00:02.0: can't reset
ohci_hcd 0000:00:02.0: init 0000:00:02.0 fail, -16
ohci_hcd: probe of 0000:00:02.0 failed with error -16


lspci gives:

0000:00:02.0 USB Controller: nVidia Corporation nForce3 USB 1.1 (rev a5)
0000:00:02.1 USB Controller: nVidia Corporation nForce3 USB 1.1 (rev a5)
0000:00:02.2 USB Controller: nVidia Corporation nForce3 USB 2.0 (rev a2)


lsusb gives:

Bus 001 Device 001: ID 0000:0000

Happens to be the USB2 stuff.


/proc/bus/usb/devices:

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh= 6
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.10-5-amd64-generic ehci_hcd
S:  Product=nVidia Corporation nForce3 USB 2.0
S:  SerialNumber=0000:00:02.2
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms


A mass storage device that works on my desktop doesn't work here.  It
works in Windows though.


- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCWz3chDd4aOud5P8RArB9AJ9AECG8+VrPUt8Zu7djzvl+Oi3lwgCfdD17
QbgPw+B1tbY66BjcFSpz9L4=
=0WK/
-----END PGP SIGNATURE-----
