Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbTFYPRY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 11:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264544AbTFYPRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 11:17:23 -0400
Received: from pD9E4ECA4.dip.t-dialin.net ([217.228.236.164]:14322 "EHLO
	domino.nowhere") by vger.kernel.org with ESMTP id S264542AbTFYPRL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 11:17:11 -0400
From: Ralf Hoelzer <ralf@well.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 panic on CDRW Mount
Date: Wed, 25 Jun 2003 17:37:01 +0200
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200306251737.01070.ralf@well.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's some debug output from the crash after mounting my AOpen CD-RW drive 
using ide-scsi on 2.4.21 (Athlon XP 1800+ / NVidia nforce chipset).

------------------
relevant dmesg output:
------------------
Kernel command line: auto BOOT_IMAGE=linux-2.4.21 ro root=341 quiet 
devfs=mount hdd=ide-scsi
ide_setup: hdd=ide-scsi
CPU: AMD Athlon(tm) XP 1800+ stepping 02
hdc: DVD-ROM DDU1621, ATAPI CD/DVD-ROM drive
hdd: AOPEN CD-RW CRW2440, ATAPI CD/DVD-ROM drive
hdd: attached ide-scsi driver.
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: AOPEN     Model: CD-RW CRW2440     Rev: 2.08
  Type:   CD-ROM                             ANSI SCSI revision: 02

------------------
ksymoops output:
------------------

Unable to handle kernel NULL pointer dereference at virtual address 00000000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<00000000>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: c02aba54   ebx: c02abc40   ecx: 00000000   edx: 00000170
esi: dfecae00   edi: dfeb5580   ebp: db095b04   esp: db095adc
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 18884, stackpage=db095000)
Stack: e0feaad4 c02abc40 dfecae00 0000000c 00000000 000001f4 dfeb5580 c02abc40
       00000040 00000000 db095b38 c0195c8a c02abc40 dfecae00 00000000 00000088
       000001f4 db095b58 00000000 00000016 c02abc40 dfeeb280 d13f2e40 db095b5c
Call Trace:    [<e0feaad4>] [<c0195c8a>] [<c0195e00>] [<c01964af>] 
[<e0feb72c>]
               [<e0fd3634>] [<e0fd9350>] [<e0fd90c0>] [<e0fdad73>] 
[<e0fda255>] [<e0fda2d9>]
               [<e0fd3755>] [<e0fd30c0>] [<e101c580>] [<e101a995>] 
[<e101c580>] [<e101ac96>]
               [<e101ada5>] [<c01a2594>] [<e0fd3788>] [<e0fd30c0>] 
[<c01a24f2>] [<c013c481>]
               [<c012fd9a>] [<c013c50b>] [<c013b017>] [<c0120001>] 
[<e11a4850>] [<c013b413>]
               [<e11a4850>] [<c014cf09>] [<c014d1e3>] [<c014d058>] 
[<c014d5f2>] [<c010736f>]
Code:  Bad EIP value.

>>EIP; 00000000 Before first symbol
Trace; e0feaad4 <[ide-scsi]idescsi_transfer_pc+124/130>
Trace; c0195c8a <start_request+18a/200>
Trace; c0195e00 <ide_do_request+b0/190>
Trace; c01964af <ide_do_drive_cmd+af/8d0>
Trace; e0feb72c <[ide-scsi]idescsi_queue+19c/2c0>
Trace; e0fd3634 <[scsi_mod]scsi_dispatch_cmd+194/250>
Trace; e0fd9350 <[scsi_mod]scsi_old_done+0/620>
Trace; e0fd90c0 <[scsi_mod]scsi_old_times_out+0/140>
Trace; e0fdad73 <[scsi_mod]scsi_request_fn+1a3/350>
Trace; e0fda255 <[scsi_mod]__scsi_insert_special+55/80>
Trace; e0fda2d9 <[scsi_mod]scsi_insert_special_req+29/30>
Trace; e0fd3755 <[scsi_mod]scsi_wait_req+65/b0>
Trace; e0fd30c0 <[scsi_mod]scsi_wait_done+0/20>
Trace; e101c580 <[ac97_codec].data.end+739/1239>
Trace; e101a995 <[ac97_codec].text.end+5a/7e5>
Trace; e101c580 <[ac97_codec].data.end+739/1239>
Trace; e101ac96 <[ac97_codec].text.end+35b/7e5>
Trace; e101ada5 <[ac97_codec].text.end+46a/7e5>
Trace; c01a2594 <cdrom_open+114/5e0>
Trace; e0fd3788 <[scsi_mod]scsi_wait_req+98/b0>
Trace; e0fd30c0 <[scsi_mod]scsi_wait_done+0/20>
Trace; c01a24f2 <cdrom_open+72/5e0>
Trace; c013c481 <ioctl_by_bdev+171/1a0>
Trace; c012fd9a <__alloc_pages+4a/190>
Trace; c013c50b <blkdev_get+5b/60>
Trace; c013b017 <get_super+3b7/8e0>
Trace; c0120001 <dequeue_signal+231/4c0>
Trace; e11a4850 <.data.end+1b49/????>
Trace; c013b413 <get_super+7b3/8e0>
Trace; e11a4850 <.data.end+1b49/????>
Trace; c014cf09 <may_umount+979/16f0>
Trace; c014d1e3 <may_umount+c53/16f0>
Trace; c014d058 <may_umount+ac8/16f0>
Trace; c014d5f2 <may_umount+1062/16f0>
Trace; c010736f <__up_wakeup+12b7/1698>
