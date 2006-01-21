Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbWAUVMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWAUVMJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 16:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWAUVMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 16:12:09 -0500
Received: from mx3.mail.ru ([194.67.23.149]:63237 "EHLO mx3.mail.ru")
	by vger.kernel.org with ESMTP id S932354AbWAUVMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 16:12:08 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.6.15.1: Frequent keyboard driver reset
Date: Sun, 22 Jan 2006 00:11:59 +0300
User-Agent: KMail/1.9.1
Cc: linux-input@atrey.karlin.mff.cuni.cz
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601220012.05970.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I have Ali based Toshiba notebook. In dmesg I see frequent resets like:

input: AT Translated Set 2 keyboard as /class/input/input6
input: AT Translated Set 2 keyboard as /class/input/input7
input: AT Translated Set 2 keyboard as /class/input/input8

Interesting is I checked sysfs after having seen those messages and

{pts/0}% LC_ALL=C ll /sys/class/input
total 0
drwxr-xr-x  6 root root 0 Jan 21 13:14 input1/
drwxr-xr-x  4 root root 0 Jan 21 23:54 input8/
drwxr-xr-x  2 root root 0 Jan 21 13:14 mice/
lrwxrwxrwx  1 root root 0 Jan 22 00:02 mouse0 
- -> ../../class/input/input1/mouse0/
lrwxrwxrwx  1 root root 0 Jan 22 00:02 ts0 -> ../../class/input/input1/ts0/

So it appears similar to SCSI - old instance is stuck and new instance is 
created.

How can I debug it further? System information:

{pts/0}% lspci
00:00.0 Host bridge: ALi Corporation M1644/M1644T Northbridge+Trident (rev 01)
00:01.0 PCI bridge: ALi Corporation PCI to AGP Controller
00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00:04.0 IDE interface: ALi Corporation M5229 IDE (rev c3)
00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link 
Controller Audio Device (rev 01)
00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
00:08.0 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
00:0a.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] 
(rev 08)
00:10.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller 
(rev 01)
00:11.0 CardBus bridge: Toshiba America Info Systems ToPIC100 PCI to Cardbus 
Bridge with ZV Support (rev 32)
00:11.1 CardBus bridge: Toshiba America Info Systems ToPIC100 PCI to Cardbus 
Bridge with ZV Support (rev 32)
00:12.0 System peripheral: Toshiba America Info Systems SD TypA Controller 
(rev 03)
01:00.0 VGA compatible controller: Trident Microsystems CyberBlade XPAi1 (rev 
82)

{pts/0}% cat /proc/cmdline
root=/dev/hda2 pinit hdc=ide-cd resume=/dev/hda1 vga=791

{pts/0}% cat /proc/version
Linux version 2.6.15.1-1avb (bor@cooker.home.net) (gcc version 4.0.2 
(4.0.2-1mdk for Mandriva Linux release 2006.1)) #7 Sun Jan 15 12:23:33 MSK 
2006
 ( it has one modifed driver - i2c-ali1535 and custom config, mostly to turn 
off all unneeded drivers).

config and dmesg on request (not to spam with too long message); input related 
stuff in dmesg:

PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input0
...
input: ImPS/2 Generic Wheel Mouse as /class/input/input1

TIA

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD0qOlR6LMutpd94wRAuEIAKDDKNqzB3XUvwYetLJrdKhk8MWLcACfRET/
gKUYpFAAk/ycTo4TMLD+RoQ=
=Ea8j
-----END PGP SIGNATURE-----
