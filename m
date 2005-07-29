Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262703AbVG2Sdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbVG2Sdn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 14:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262701AbVG2Sdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 14:33:38 -0400
Received: from [84.77.83.123] ([84.77.83.123]:12501 "EHLO
	dardhal.24x7linux.com") by vger.kernel.org with ESMTP
	id S262707AbVG2SdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 14:33:23 -0400
Date: Fri, 29 Jul 2005 20:33:18 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: Kevin Radloff <radsaq@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Followup on 2.6.13-rc3 ACPI processor C-state regression
Message-ID: <20050729183318.GA27093@localhost>
Mail-Followup-To: Kevin Radloff <radsaq@gmail.com>,
	linux-kernel@vger.kernel.org
References: <3b0ffc1f050713150527c7c649@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <3b0ffc1f050713150527c7c649@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday, 13 July 2005, at 18:05:30 -0400,
Kevin Radloff wrote:

> Previously, I had said that in 2.6.13-rc3, C2/C3 capabilities were not
> detected on my Fujitsu Lifebook P7010D. I found that in the merge at:
>=20
I was just about to gather data to report the exact same problem in my
box, a no-brand non-mobile PC (AMD Athlon XP 1700+). Kernel version
2.6.13-rc2 and before correctly detected both C1 and C2 processor states,
so when the system is idle some energy and heat is preserved. Now, with
2.6.13-rc3-git8 only C1 gets detected, so no power save.

I am going to try the patch Andrew suggest in this same thread right now,
and will report back is this fixes the issue.

I inline a (trimmed) diff of two boots, the first with the (working)
2.6.13-rc2 kernel version, and the other with the (non-working)
2.6.13-rc3-git8 one. No changes in the .config file except for the new
options appeared in between (some options shuffling apart, the only change
relevant to the problem should be the new CONFIG_ACPI_HOTKEY=3Dm):

--- boot_stripped-2.6.13-rc2.txt	2005-07-29 19:46:44.000000000 +0200
+++ boot_stripped-2.6.13-rc3-git8.txt	2005-07-29 19:46:59.000000000 +0200
@@ -1,4 +1,4 @@
-dardhal kernel: Linux version 2.6.13-rc2 (jdomingo@dardhal) (gcc versi=F3n=
 3.3.6 (Debian 1:3.3.6-7)) #2 Fri Jul 8 22:06:45 CEST 2005
+dardhal kernel: Linux version 2.6.13-rc3-git8 (jdomingo@dardhal) (gcc vers=
i=F3n 3.3.6 (Debian 1:3.3.6-7)) #3 Wed Jul 27 20:53:55 CEST 2005
 dardhal kernel: BIOS-provided physical RAM map:
 dardhal kernel: BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 dardhal kernel: BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
@@ -11,7 +11,7 @@
 dardhal kernel: DMI 2.3 present.
 dardhal kernel: Allocating PCI resources starting at 20000000 (gap: 200000=
00:dfff0000)
 dardhal kernel: Built 1 zonelists
-dardhal kernel: Kernel command line: auto BOOT_IMAGE=3D2.6.13-rc2 ro root=
=3D302 rootfstype=3Dext3
+dardhal kernel: Kernel command line: BOOT_IMAGE=3D2.6.13rc3git8 ro root=3D=
302 rootfstype=3Dext3
 dardhal kernel: Local APIC disabled by BIOS -- you can enable it with "lap=
ic"
 dardhal kernel: Initializing CPU#0
 dardhal kernel: PID hash table entries: 2048 (order: 11, 32768 bytes)
@@ -20,31 +20,32 @@
 dardhal kernel: Console: colour VGA+ 80x25
 dardhal kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 =
bytes)
 dardhal kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 by=
tes)
-dardhal kernel: Memory: 515756k/524224k available (1805k kernel code, 7920=
k reserved, 835k data, 160k init, 0k highmem)
+dardhal kernel: Memory: 515740k/524224k available (1817k kernel code, 7936=
k reserved, 843k data, 160k init, 0k highmem)
 dardhal kernel: Checking if this processor honours the WP bit even in supe=
rvisor mode... Ok.
-dardhal kernel: Calibrating delay using timer specific routine.. 2959.79 B=
ogoMIPS (lpj=3D5919586)
+dardhal kernel: Calibrating delay using timer specific routine.. 2959.75 B=
ogoMIPS (lpj=3D5919514)
 dardhal kernel: Mount-cache hash table entries: 512
 dardhal kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 byte=
s/line)
 dardhal kernel: CPU: L2 Cache: 256K (64 bytes/line)
 dardhal kernel: Intel machine check architecture supported.
 dardhal kernel: Intel machine check reporting enabled on CPU#0.
+dardhal kernel: mtrr: v2.0 (20020519)
 dardhal kernel: CPU: AMD Athlon(tm) XP 1700+ stepping 02
 dardhal kernel: Enabling fast FPU save and restore... done.
 dardhal kernel: Enabling unmasked SIMD FPU exception support... done.
 dardhal kernel: Checking 'hlt' instruction... OK.
-dardhal kernel: tbxface-0118 [02] acpi_load_tables      : ACPI Tables succ=
essfully acquired
+dardhal kernel: tbxface-0120 [02] acpi_load_tables      : ACPI Tables succ=
essfully acquired
 dardhal kernel: Parsing all Control Methods:..............................=
=2E........................................................................
 dardhal kernel: Table [DSDT](id F004) - 398 Objects with 37 Devices 103 Me=
thods 23 Regions
-dardhal kernel: ACPI Namespace successfully loaded at root c03d7ba0
+dardhal kernel: ACPI Namespace successfully loaded at root c03dc5a0
 dardhal kernel: ACPI: setting ELCR to 0200 (from 0a20)
-dardhal kernel: evxfevnt-0094 [03] acpi_enable           : Transition to A=
CPI mode successful
+dardhal kernel: evxfevnt-0096 [03] acpi_enable           : Transition to A=
CPI mode successful
 dardhal kernel: NET: Registered protocol family 16
+dardhal kernel: ACPI: bus type pci registered
 dardhal kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb250, last bus=3D1
 dardhal kernel: PCI: Using configuration type 1
-dardhal kernel: mtrr: v2.0 (20020519)
-dardhal kernel: ACPI: Subsystem revision 20050309
-dardhal kernel: evgpeblk-0979 [06] ev_create_gpe_block   : GPE 00 to 0F [_=
GPE] 2 regs on int 0x9
-dardhal kernel: evgpeblk-0987 [06] ev_create_gpe_block   : Found 4 Wake, E=
nabled 1 Runtime GPEs in this block
+dardhal kernel: ACPI: Subsystem revision 20050408
+dardhal kernel: evgpeblk-1016 [06] ev_create_gpe_block   : GPE 00 to 0F [_=
GPE] 2 regs on int 0x9
+dardhal kernel: evgpeblk-1024 [06] ev_create_gpe_block   : Found 4 Wake, E=
nabled 1 Runtime GPEs in this block
 dardhal kernel: Completing Region/Field/Buffer/Package initialization:....=
=2E...............................................
 dardhal kernel: Initialized 23/23 Regions 5/5 Fields 18/18 Buffers 6/10 Pa=
ckages (407 nodes)
 dardhal kernel: Executing all Device _STA and_INI methods:................=
=2E.......................
@@ -53,6 +54,8 @@
 dardhal kernel: ACPI: Using PIC for interrupt routing
 dardhal kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
 dardhal kernel: PCI: Probing PCI hardware (bus 00)
+dardhal kernel: ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
+dardhal kernel: ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
 dardhal kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 1=
2 14 15)
 dardhal kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 *5 6 7 10 11 1=
2 14 15)
 dardhal kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 *5 6 7 10 11 1=
2 14 15)
@@ -68,8 +71,9 @@
 dardhal kernel: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
 dardhal kernel: Initializing Cryptographic API
 dardhal kernel: ACPI: Power Button (FF) [PWRF]
+dardhal kernel: ACPI: Power Button (CM) [PWRB]
 dardhal kernel: ACPI: Sleep Button (CM) [SLPB]
-dardhal kernel: ACPI: CPU0 (power states: C1[C1] C2[C2])
+dardhal kernel: ACPI: CPU0 (power states: C1[C1])
 dardhal kernel: ACPI: Processor [CPU0] (supports 2 throttling states)
 dardhal kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
 dardhal kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
@@ -85,6 +89,7 @@
 dardhal kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
 dardhal kernel: ide: Assuming 33MHz system bus speed for PIO modes; overri=
de with idebus=3Dxx
 dardhal kernel: VP_IDE: IDE controller at PCI slot 0000:00:11.1
+dardhal kernel: acpi_bus-0212 [01] acpi_bus_set_power    : Device is not p=
ower manageable
 dardhal kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
 dardhal kernel: PCI: setting IRQ 11 as level-triggered
 dardhal kernel: ACPI: PCI Interrupt 0000:00:11.1[A] -> Link [LNKA] -> GSI =
11 (level, low) -> IRQ 11
@@ -193,6 +191,7 @@
 dardhal kernel: usbcore: registered new driver usbfs
 dardhal kernel: usbcore: registered new driver hub
 dardhal kernel: USB Universal Host Controller Interface driver v2.3
+dardhal kernel: acpi_bus-0212 [01] acpi_bus_set_power    : Device is not p=
ower manageable
 dardhal kernel: ACPI: PCI Interrupt 0000:00:11.2[D] -> Link [LNKD] -> GSI =
11 (level, low) -> IRQ 11
 dardhal kernel: PCI: Via IRQ fixup for 0000:00:11.2, from 0 to 11
 dardhal kernel: uhci_hcd 0000:00:11.2: VIA Technologies, Inc. VT82xxxxx UH=
CI USB 1.1 Controller
@@ -200,6 +199,7 @@
 dardhal kernel: uhci_hcd 0000:00:11.2: irq 11, io base 0x0000dc00
 dardhal kernel: hub 1-0:1.0: USB hub found
 dardhal kernel: hub 1-0:1.0: 2 ports detected
+dardhal kernel: acpi_bus-0212 [01] acpi_bus_set_power    : Device is not p=
ower manageable
 dardhal kernel: ACPI: PCI Interrupt 0000:00:11.3[D] -> Link [LNKD] -> GSI =
11 (level, low) -> IRQ 11
 dardhal kernel: PCI: Via IRQ fixup for 0000:00:11.3, from 255 to 11
 dardhal kernel: uhci_hcd 0000:00:11.3: VIA Technologies, Inc. VT82xxxxx UH=
CI USB 1.1 Controller (#2)

Hope it helps.

Greetings,

--=20
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.13-rc3-git8)


--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC6nZuao1/w/yPYI0RAl3gAJ4oguvPjHWnuahGSJOmcKPhnh/2vQCfWV0v
mDeREByQv6nt/vQfUgPF+AM=
=gntT
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
