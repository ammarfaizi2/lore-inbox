Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270657AbTGNOLY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 10:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270620AbTGNOJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 10:09:38 -0400
Received: from grobbebol.xs4all.nl ([194.109.248.218]:58968 "EHLO
	grobbebol.xs4all.nl") by vger.kernel.org with ESMTP id S270612AbTGNOG3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 10:06:29 -0400
Date: Mon, 14 Jul 2003 16:21:15 +0200
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: USB and 2.4.x
Message-ID: <20030714142115.GA14230@grobbebol.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have seen this with 2.4.18 where USB after some time died with thge
message :

Jul 14 16:05:44 grobbebol kernel: usb.c: USB device not accepting new
address=12 (error=-110)

2.4.19 and 2.4.20 yielded me a non-working USB stack at all. 

2.4.21 works better but it happens after some time again. now, with a
kernel error :

Jul 14 16:08:22 grobbebol kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000048
Jul 14 16:08:22 grobbebol kernel:  printing eip:
Jul 14 16:08:22 grobbebol kernel: f95e0337
Jul 14 16:08:22 grobbebol kernel: *pde = 00000000
Jul 14 16:08:22 grobbebol kernel: Oops: 0000
Jul 14 16:08:22 grobbebol kernel: CPU:    0
Jul 14 16:08:22 grobbebol kernel: EIP:
0010:[af_packet:__insmod_af_packet_O/lib/modules/2.4.21/kernel/net/packet/a+-23657673/96] Tainted: PF
Jul 14 16:08:22 grobbebol kernel: EFLAGS: 00010246
Jul 14 16:08:22 grobbebol kernel: eax: 00000000   ebx: bfffd4a8   ecx: e29df7a0   edx: f95e0320
Jul 14 16:08:22 grobbebol kernel: esi: 40047612   edi: 40047612   ebp: ffffffe7   esp: f7577f84
Jul 14 16:08:22 grobbebol kernel: ds: 0018   es: 0018   ss: 0018 
Jul 14 16:08:22 grobbebol kernel: Process camserv (pid: 4511, stackpage=f7577000)
Jul 14 16:08:22 grobbebol kernel: Stack: 00000000 40047612 bfffd4a8 e2fe3740 e2fe3740 bfffd4a8 c013f867 e2987420
Jul 14 16:08:22 grobbebol kernel:        e2fe3740 40047612 bfffd4a8 f7576000 0805f760 0805f760 bfffd4ac c0108813
Jul 14 16:08:22 grobbebol kernel:        00000005 40047612 bfffd4a8 0805f760 0805f760 bfffd4ac 00000036 0000002b
Jul 14 16:08:22 grobbebol kernel: Call Trace:    [sys_ioctl+363/388] [system_call+51/64]
Jul 14 16:08:22 grobbebol kernel:
Jul 14 16:08:22 grobbebol kernel: Code: 8b 40 48 ff d0 83 c4 10 3d fd fd ff ff 75 05 b8 ea ff ff ff


also :


Oops: 0000
CPU:    0
EIP:    0010:[<f95e0337>]    Tainted: PF
EFLAGS: 00010246
eax: 00000000   ebx: bfffd4a8   ecx: e29df7a0   edx: f95e0320
esi: 40047612   edi: 40047612   ebp: ffffffe7   esp: f7577f84
ds: 0018   es: 0018   ss: 0018
Process camserv (pid: 4511, stackpage=f7577000)
Stack: 00000000 40047612 bfffd4a8 e2fe3740 e2fe3740 bfffd4a8 c013f867 e2987420
       e2fe3740 40047612 bfffd4a8 f7576000 0805f760 0805f760 bfffd4ac c0108813
       00000005 40047612 bfffd4a8 0805f760 0805f760 bfffd4ac 00000036 0000002b
Call Trace:    [<c013f867>] [<c0108813>]

Code: 8b 40 48 ff d0 83 c4 10 3d fd fd ff ff 75 05 b8 ea ff ff ff

and the camserv process in fact is the program which accesses the USB
device.


I looked at several googled pages some time ago but failed to see any
solutions so far.

I killed off camserv and tried to use my mass storage stuff (fujicam
finepix1300)

pluging in doesn't wake up[ the usb stuff (suse 8.0).

tried to mount :

[.....] (scrolled off the screen. sorry)
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Request is for removed device
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
sdb: test WP failed, assume Write Enabled
 sdb: I/O error: dev 08:10, sector 0
 I/O error: dev 08:10, sector 0
 unable to read partition table
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Request is for removed device
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Request is for removed device
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Request is for removed device
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Request is for removed device
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Request is for removed device
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
sdb : READ CAPACITY failed.
sdb : status = 1, message = 00, host = 0, driver = 08
Info fld=0xa00 (nonstd), Current sd00:00: sense key Not Ready
sdb : block size assumed to be 512 bytes, disk size 1GB.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Request is for removed device
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
sdb: test WP failed, assume Write Enabled
 sdb: I/O error: dev 08:10, sector 0
 I/O error: dev 08:10, sector 0
 unable to read partition table

I will try to rmmod usb et al and reload. if that fails, I think the
only option left is to restart.

