Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266016AbSKBShc>; Sat, 2 Nov 2002 13:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266017AbSKBShc>; Sat, 2 Nov 2002 13:37:32 -0500
Received: from mail.scram.de ([195.226.127.117]:17097 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S266016AbSKBSh0>;
	Sat, 2 Nov 2002 13:37:26 -0500
Date: Sat, 2 Nov 2002 19:37:55 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@gfrw1044.bocc.de
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [BUG] USB Kernel bug in 2.5.45
Message-ID: <Pine.LNX.4.44.0211021933220.18761-100000@gfrw1044.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

when running "rmmod hid" while a USB HID device is still connected (but
not used), i get this Oops messages:

drivers/usb/core/usb.c: deregistering driver hiddev
drivers/usb/core/usb.c: deregistering driver hid
devfs_put(fffffc0009393000): poisoned pointer
Forcing Oops
Kernel bug at fs/devfs/base.c:933

rmmod(1073): Kernel Bug 1
pc = [<fffffc00003d4ad4>]  ra = [<fffffc00003d4ac8>]  ps = 0000    Not
tainted
Using defaults from ksymoops -t elf64-alpha -a alpha
v0 = 000000000000000d  t0 = 0000000000000001  t1 = fffffc000058d3a0
t2 = 0000000000000000  t3 = ffffffff00000000  t4 = 0000000000000001
t5 = 0000000000000000  t6 = fffffc0000630450  t7 = fffffc0006734000
a0 = 0000000000000000  a1 = 0000000000000001  a2 = 0000000000000000
a3 = 0000000000000000  a4 = 00000000000000a0  a5 = 000000000000000f
t8 = 0000000000000000  t9 = 0000000000003fff  t10= 000000000000000f
t11= 0000000000000010  pv = fffffc000032d160  at = 0000000000000000
gp = fffffc00006281b0  sp = fffffc0006737d88
Trace:fffffc00003d63b8 fffffc00003f5ac0 fffffc00003f5bac fffffc00003f6018
fffffc00003f64ec fffffc00003f65f8 fffffc0000334e94 fffffc0000333db8
fffffc0000310d44
Code: a61dfe00  a77daf28  6b5b7556  27ba0025  23bd36e8  00000081
<000003a5> 0050f363
>>RA;  fffffc00003d4ac8 <devfs_put+68/1e0>

>>PC;  fffffc00003d4ad4 <devfs_put+74/1e0>   <=====

Trace; fffffc00003d63b8 <devfs_unregister+38/60>
Trace; fffffc00003f5ac0 <detach+60/a0>
Trace; fffffc00003f5bac <driver_detach+6c/c0>
Trace; fffffc00003f6018 <bus_remove_driver+78/100>
Trace; fffffc00003f64ec <put_driver+6c/c0>
Trace; fffffc00003f65f8 <driver_unregister+18/40>
Trace; fffffc0000334e94 <free_module+34/160>
Trace; fffffc0000333db8 <sys_delete_module+1d8/340>
Trace; fffffc0000310d44 <entSys+a4/b8>

Code;  fffffc00003d4abc <devfs_put+5c/1e0>
0000000000000000 <_PC>:
Code;  fffffc00003d4abc <devfs_put+5c/1e0>
   0:   00 fe 1d a6       ldq  a0,-512(gp)
Code;  fffffc00003d4ac0 <devfs_put+60/1e0>
   4:   28 af 7d a7       ldq  t12,-20696(gp)
Code;  fffffc00003d4ac4 <devfs_put+64/1e0>
   8:   56 75 5b 6b       jsr  ra,(t12),ffffffffffffd564
<_PC+0xffffffffffffd564> fffffc00003d2020 <ext2_rename+140/400>
Code;  fffffc00003d4ac8 <devfs_put+68/1e0>
   c:   25 00 ba 27       ldah gp,37(ra)
Code;  fffffc00003d4acc <devfs_put+6c/1e0>
  10:   e8 36 bd 23       lda  gp,14056(gp)
Code;  fffffc00003d4ad0 <devfs_put+70/1e0>
  14:   81 00 00 00       call_pal     0x81
Code;  fffffc00003d4ad4 <devfs_put+74/1e0>   <=====
  18:   a5 03 00 00       call_pal     0x3a5   <=====
Code;  fffffc00003d4ad8 <devfs_put+78/1e0>
  1c:   63 f3 50 00       call_pal     0x50f363


--jochen

