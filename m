Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262272AbUEBIh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbUEBIh4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 04:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbUEBIh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 04:37:56 -0400
Received: from stud.fbi.fh-darmstadt.de ([141.100.40.65]:39100 "EHLO
	stud1.fbihome.de") by vger.kernel.org with ESMTP id S262272AbUEBIhw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 04:37:52 -0400
From: Sergio Vergata <vergata@stud.fbi.fh-darmstadt.de>
To: <linux-kernel@vger.kernel.org>
Subject: Problem with USB2.0 and USB-Storage writing to DVD+-R
Date: Sun, 2 May 2004 10:37:20 +0200
User-Agent: KMail/1.6.2
Cc: <linux-usb-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200405021037.34671.vergata@stud.fbi.fh-darmstadt.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi list,

I want to report a problem that occured to me.
I have an USB2.0 DVD Recorder attached to my Laptop.

ehci_hcd ist loaded and detect the new device!

usb 4-3: new high speed USB device using address 2
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: HL-DT-ST  Model: DVDRAM GSA-4081B  Rev: A100
  Type:   CD-ROM                             ANSI SCSI revision: 02
USB Mass Storage device found at 2
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
sr0: scsi3-mmc drive: 32x/32x writer dvd-ram cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0

I can also read the DVD or CD in the device, but writing to the recorder gets 
an error an after that the kernel oopses.

The RecorderDevice hangs up and remain in the writingoperation on the same 
position, in the writinglog there is a long wait at position 0,6% at this 
time the usb is resettet and could not be reinitialised, so the following 
error occures, after a while and a lot of rejecting I/O the kernel gets an 
Oops could be that it happens because of Preempt? 

What do you say ? 

Thanx Sergio

scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
Unable to handle kernel NULL pointer dereference at virtual address 00000034
 printing eip:
e190535a
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<e190535a>]    Tainted: P
EFLAGS: 00210246   (2.6.5)
EIP is at cdrom_release+0x4a/0x140 [cdrom]
eax: 00000000   ebx: df1e70d8   ecx: e19dc570   edx: 00000000
esi: dff50950   edi: 00000000   ebp: 00000000   esp: cf417f3c
ds: 007b   es: 007b   ss: 0068
Process growisofs (pid: 12858, threadinfo=cf416000 task=d058d980)
Stack: dff5090c c015ce59 dff50900 dff50950 da32b4c0 dff5090c c015e01a df1e70d8
       00000000 00000000 d3e2cf00 00000000 dff54280 dacef914 c015685a dff50900
       d3e2cf00 dcc899c0 d3e2cf00 00000000 d0f39900 cf416000 c0154eb9 d3e2cf00
Call Trace:
 [<c015ce59>] kill_bdev+0x39/0x50
 [<c015e01a>] blkdev_put+0x17a/0x1a0
 [<c015685a>] __fput+0x10a/0x120
 [<c0154eb9>] filp_close+0x59/0x90
 [<c0154f51>] sys_close+0x61/0xa0
 [<c010940b>] syscall_call+0x7/0xb

Code: f6 47 34 04 74 30 a1 cc d2 90 e1 85 c0 75 27 83 3d c8 d2 90



sergio@sandokan:~$ growisofs -dvd-compat -Z /dev/sr0=iso/DVD.iso
Executing 'builtin_dd if=iso/DVD.iso of=/dev/sr0 obs=32k seek=0'
/dev/sr0: "Current Write Speed" is 4.1x1385KBps.
   1245184/4126703616 ( 0.0%) @0.3x, remaining 331:18
   1245184/4126703616 ( 0.0%) @0.0x, remaining 496:58
   2686976/4126703616 ( 0.1%) @0.3x, remaining 332:32
  12386304/4126703616 ( 0.3%) @2.1x, remaining 88:34
  24510464/4126703616 ( 0.6%) @2.6x, remaining 52:59
  24510464/4126703616 ( 0.6%) @0.0x, remaining 64:09
.......................
  24510464/4126703616 ( 0.6%) @0.0x, remaining 72:31
  24510464/4126703616 ( 0.6%) @0.0x, remaining 407:15
  37552128/4126703616 ( 0.9%) @2.8x, remaining 270:25
.....................
4080861184/4126703616 (98.9%) @15.6x, remaining 0:03
builtin_dd: 2014992*2KB out @ average 8.7x1385KBps
/dev/sr0: flushing cache
/dev/sr0: closing track
/dev/sr0: closing disc
Segmentation fault


/var/log/syslog
May  1 15:34:33 sandokan kernel: scsi: Device offlined - not ready after error 
recovery: host 0 channel 0 id 0 lun 0
May  1 15:34:33 sandokan kernel: SCSI error : <0 0 0 0> return code = 0x50000
May  1 15:34:33 sandokan kernel: scsi0 (0:0): rejecting I/O to offline device
May  1 15:34:34 sandokan last message repeated 40 times
May  1 15:34:34 sandokan kernel: usb 4-3: USB disconnect, address 2
May  1 15:34:34 sandokan kernel: scsi0 (0:0): rejecting I/O to dead device


- -- 
Microsoft is to operating systems & security ....
             .... what McDonalds is to gourmet cooking

PGP-Key http://vergata.it/GPG/F17FDB2F.asc
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAlLNKVP5w5vF/2y8RAnF3AJ4w5mOQt8H0L595UfezA5qG5we44gCeLJrl
SHV5D9fmxHW0kLn3DPhaaNM=
=louG
-----END PGP SIGNATURE-----
