Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275075AbTHQH1a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 03:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275105AbTHQH1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 03:27:30 -0400
Received: from 200-63-154-224.speedy.com.ar ([200.63.154.224]:24794 "EHLO
	runa.sytes.net") by vger.kernel.org with ESMTP id S275075AbTHQH11
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 03:27:27 -0400
Date: Sun, 17 Aug 2003 04:27:51 -0300
From: Martin Sarsale <lists@runa.sytes.net>
To: linux-kernel@vger.kernel.org
Subject: segfault when unloading module loop in 2.6.0-test3+ck patches
Message-Id: <20030817042751.379428cf.lists@runa.sytes.net>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Dear all: I was playing with the crypto support, and when I tried to unload the module "loop" I got a segfault and after that lsmod hung

runa:/usr/src/linux-2.5.75# lsmod
Module                  Size  Used by
loop                   13736  0 
twofish                38272  0 
snd_ens1371            16868  1 
snd_rawmidi            20096  1 snd_ens1371
snd_ac97_codec         50724  1 snd_ens1371
nfsd                  154272  8 
exportfs                5024  1 nfsd
lockd                  58480  2 nfsd
sunrpc                118856  2 nfsd,lockd
rtc                    10260  1 
runa:/usr/src/linux-2.5.75# rmmod twofish
runa:/usr/src/linux-2.5.75# rmmod loop
Segmentation fault
runa:/usr/src/linux-2.5.75# lsmod
Module                  Size  Used by
(nothing)

dmesg says (I'll include the hda lines in case they've something to do):


hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete DataRequest }
blk: queue c15a8c00, I/O limit 4095Mb (mask 0xffffffff)
hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }

hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete DataRequest }
hda: CHECK for good STATUS
loop: loaded (max 8 devices)
Unable to handle kernel paging request at virtual address 010000bf
 printing eip:
c01d5564
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01d5564>]    Not tainted
EFLAGS: 00210202
EIP is at kobject_del+0x34/0x80
eax: 0100007f   ebx: d5c9f850   ecx: d5c9f850   edx: 0100007f
esi: d4f43960   edi: d4f43a24   ebp: 00000880   esp: cf401eec
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 27599, threadinfo=cf400000 task=caac72b0)
Stack: dbfe7ab8 00200282 d654d200 d5c9f850 c01d55c3 d5c9f850 d5c9f800 c023bb8a 
       d5c9f850 d5c9f800 c023f5de d5c9f800 d4f43960 c037b018 c0240523 d4f43960 
       d4f43960 d4f43960 c017fc0d d4f43960 00000000 00000000 c037b018 00000000 
Call Trace:
 [<c01d55c3>] kobject_unregister+0x13/0x30
 [<c023bb8a>] elv_unregister_queue+0x1a/0x40
 [<c023f5de>] blk_unregister_queue+0x1e/0x60
 [<c0240523>] unlink_gendisk+0x13/0x40
 [<c017fc0d>] del_gendisk+0x6d/0xe0
 [<dcb7a133>] cleanup_module+0x63/0x7e [loop]
 [<c012f6f9>] sys_delete_module+0x119/0x1a0
 [<c01427dc>] do_munmap+0x14c/0x190
 [<c010929b>] syscall_call+0x7/0xb

Code: 8b 52 40 85 d2 74 25 89 5c 24 08 8b 41 24 c7 04 24 a1 71 34 
 
