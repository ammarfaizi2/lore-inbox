Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265844AbUBJMHX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 07:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265849AbUBJMHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 07:07:23 -0500
Received: from m246.net81-65-100.noos.fr ([81.65.100.246]:14887 "EHLO
	[81.65.100.246]") by vger.kernel.org with ESMTP id S265844AbUBJMHK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 07:07:10 -0500
Subject: ide_cs cannot unload
From: Patrice Lazareff <patrice@lazareff.com>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-osJvluwEL7u1t7qKpZ0k"
Message-Id: <1076414724.1247.44.camel@nawak.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 10 Feb 2004 13:05:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-osJvluwEL7u1t7qKpZ0k
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello,

I first posted this message on the sourceforge bug-tracking system of
the pcmcia-cs project.

I was advised to repost it in the linux-pcmcia list, which I did to be
advised to repost it here. I had a look in the list archive, which is
not an easy thing to do, and could not find something both related and
recent.

So here come the rant:

Right after inserting the pcmcia card for the atapi
cd-rom drive (PGCA-CD51), the module losts interrupt.

Ejecting the card (manually since cardctl says device
busy) seems to be ok, but also prevents unmounting
ide1, where the root partition is, on shutdown/reboot.
(the cdrom, when available, is on ide2).

Re-inserting the card totally freezes the machine.

Laptop Sony Vaio Z600
Kernel 2.6.2
modules-utils 3.0pre9
all compiled with gcc-3.3.2

=46rom dmesg:

=3D=3D during bootup =3D=3D
Linux Kernel Card Services
options: [pci] [cardbus] [pm]
PCI: Found IRQ 9 for device 0000:00:0c.0
PCI: Sharing IRQ 9 with 0000:00:0a.0
Yenta: CardBus bridge found at 0000:00:0c.0 [104d:8082]
Yenta: ISA IRQ mask 0x04b8, PCI irq 9
Socket status: 30000006
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177
0x370-0x37f 0x398-0x39f 0x3c0-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.

=3D=3D on inserting card =3D=3D
hde: TOSHIBA CD-ROM XM-7002Bc, ATAPI CD/DVD-ROM drive
hdf: no response (status =3D 0xa1), resetting drive
hdf: no response (status =3D 0xa1)
ide2 at 0x180-0x187,0x386 on irq 3
Module ide_cs cannot be unloaded due to unsafe usage in
include/linux/module.h:489
ide-cs: hde: Vcc =3D 5.0, Vpp =3D 0.0
hde: lost interrupt
hde: lost interrupt
...

=3D=3D on force eject =3D=3D
remove_proc_entry: hde/identify busy, count=3D1
remove_proc_entry: ide2/hde busy, count=3D1
Unable to handle kernel NULL pointer dereference at
virtual address 00000008
printing eip:
c018681f
*pde =3D 00000000
Oops: 0000 [#1]
CPU: 0
EIP: 0060:[<c018681f>] Not tainted
EFLAGS: 00010286
EIP is at sysfs_hash_and_remove+0xf/0x7d
eax: 00000000 ebx: c047c25c ecx: c0405320 edx:
00000000
esi: 00000000 edi: 00000001 ebp: d68d2000 esp:
d68d3878
ds: 007b es: 007b ss: 0068
Process pccardd (pid: 663, threadinfo=3Dd68d2000
task=3Dd7448740)
Stack: c0473d70 c7c70f20 c047c25c c0405478 c02315b8
00000000 c047c288 c047c25c
c047c608 c0231735 c047c25c c047c2b8 c047c25c
c047c608 c02305cd c047c25c
c047c25c d4b194e0 c0230623 c047c25c c047c16c
c02538e7 c047c25c d4b194e0
Call Trace:
[<c02315b8>] device_release_driver+0x28/0x70
[<c0231735>] bus_remove_device+0x55/0xa0
[<c02305cd>] device_del+0x5d/0xa0
[<c0230623>] device_unregister+0x13/0x30
[<c02538e7>] ide_unregister+0x827/0x910
[<c0117108>] recalc_task_prio+0xa8/0x1d0
[<c0137bff>] buffered_rmqueue+0xcf/0x170
[<c0137d3f>] __alloc_pages+0x9f/0x350
[<c013ada9>] cache_init_objs+0x69/0x70
[<c011827a>] __wake_up_common+0x3a/0x70
[<c0117f59>] schedule+0x319/0x590
[<c0117108>] recalc_task_prio+0xa8/0x1d0
[<d8867a91>] ide_release+0x81/0x120 [ide_cs]
[<d8867b7e>] ide_event+0x4e/0xe0 [ide_cs]
[<d884624e>] send_event+0x5e/0x70 [pcmcia_core]
[<d88462d2>] socket_remove_drivers+0x22/0x50 [pcmcia_core]
[<d8846313>] socket_shutdown+0x13/0x60 [pcmcia_core]
[<d8846903>] socket_remove+0x13/0x70 [pcmcia_core]
[<d88469ca>] socket_detect_change+0x6a/0x90 [pcmcia_core]
[<d8846ba8>] pccardd+0x1b8/0x240 [pcmcia_core]
[<c0118220>] default_wake_function+0x0/0x20
[<c0108f82>] ret_from_fork+0x6/0x14
[<c0118220>] default_wake_function+0x0/0x20
[<d88469f0>] pccardd+0x0/0x240 [pcmcia_core]
[<c0106f25>] kernel_thread_helper+0x5/0x10

Code: 8b 46 08 8d 48 68 ff 48 68 78 63 89 34 24 8b 44
24 18 89 44
<3>ide_timer_expiry: hwgroup->drive was NULL


=3D=3D /sbin/lspci =3D=3D
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX -
82443BX/ZX/DX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX -
82443BX/ZX/DX AGP bridge (rev 03)
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA
(rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4
IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4
USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI
(rev 03)
00:08.0 FireWire (IEEE 1394): Sony Corporation CXD3222
i.LINK Controller (rev 02)
00:09.0 Multimedia audio controller: Yamaha Corporation
YMF-744B [DS-1S Audio Controller] (rev 02)
00:0a.0 Communication controller: Conexant HSF 56k
Data/Fax Modem (Mob WorldW SmartDAA) (rev 01)
00:0b.0 Ethernet controller: Intel Corp. 82557/8/9
[Ethernet Pro 100] (rev 08)
00:0c.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 80)
01:00.0 VGA compatible controller: ATI Technologies Inc
Rage Mobility P/M AGP 2x (rev 64)


=3D=3D cat /proc/interrupts =3D=3D
0: 3205158 XT-PIC timer
1: 6510 XT-PIC i8042
2: 0 XT-PIC cascade
9: 151336 XT-PIC ohci1394, uhci_hcd,
YMFPCI, eth0, yenta, hsfpcibasic2
11: 328 XT-PIC sonypi
12: 39503 XT-PIC i8042
14: 30729 XT-PIC ide0
NMI: 0
ERR: 0

=3D=3D lsmod =3D=3D
hsfmc97ali 49412 0
hsfmc97via 47368 0
hsfmc97ich 48832 0
hsfpcibasic2 54744 0
hsfserial 19204 4
hsfmc97ali,hsfmc97via,hsfmc97ich,hsfpcibasic2
hsfengine 1210176 1 hsfserial
hsfosspec 58884 9
hsfmc97ali,hsfmc97via,hsfmc97ich,hsfpcibasic2,hsfserial,hsfengine
hsfsoar 51904 4
hsfmc97ali,hsfmc97via,hsfmc97ich,hsfpcibasic2
ide_cs 6212 2 [unsafe]
appletalk 31348 20
psnap 2756 1 appletalk
llc 5428 1 psnap
ds 11460 3 ide_cs
yenta_socket 14528 1
pcmcia_core 58528 3 ide_cs,ds,yenta_socket


Thank you for any direction. In the past (2.2 and 2.4
kernels) I could never use the kernel's pcmcia stuff
and relied only on pcmcia-cs

Patrice Lazareff

--=-osJvluwEL7u1t7qKpZ0k
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAKMkELn6iK4eEuWERApDQAKCl+UBeqIzAStMen2068ukrvM28+wCfR+FT
H2Fzo7Qz5cjj2mWh/l9J6tQ=
=19Hv
-----END PGP SIGNATURE-----

--=-osJvluwEL7u1t7qKpZ0k--

