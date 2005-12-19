Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbVLSSBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbVLSSBU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 13:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbVLSSBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 13:01:20 -0500
Received: from spc1-cosh5-3-0-cust36.cosh.broadband.ntl.com ([81.102.80.36]:30087
	"EHLO central.regress.homelinux.org") by vger.kernel.org with ESMTP
	id S932341AbVLSSBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 13:01:19 -0500
From: Grahame White <grahame@regress.homelinux.org>
Reply-To: grahame@regress.homelinux.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.12 (ubuntu 5.10 live cd) Oops on booting
Date: Mon, 19 Dec 2005 18:01:17 +0000
User-Agent: KMail/1.8.3
X-Face: 0Ziawa}xspG!GTK/bAR):WO~4;[}eXz^*`HIlzgaJES"@`:xa{JZ#mY`fB,+,=?utf-8?q?kBR=3B=5C=608jX=0A=09JH=5E2g9t=3A6Ol6wI=5C=7C=2E1-cn3yDHq8ebH3?=
 =?utf-8?q?=7BGFfrXkbE=2E=7Bd=240=3Bci=7BWddXcB?=,
 =?utf-8?q?Vuy*/xtN60p=5EcQ=0A=09h-?=
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512191801.17771.grahame@regress.homelinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting an intermittent OOPS with a winfast NF3250K8AA motherboard and 
sempron 2800+ CPU mostly during booting.

I've tried it with Knoppix 3.9 & 4.0.2 (default settings for both) and with 
Debian etch 2.6.12 kernel (This is the installation that is normally used 
on this box)

The following Oops are from my attempts with the Ubuntu 5.10 live cd. I'll 
post some oopses for the other systems once I manage to write them down.

---

First opps

Unable to handle kernel NULL pointer dereference at virtual address 
00000b01

Printing eip:
c01374db
*pde = 00000000
Oops: 0002 [#1]
modules linked in: amd74xx ide_core sata_nv libata scsi_mod echi_hcd 
ochi_hcd usbcore unix
CPU: 0
EIP: 0060:[<c01374db>] Not tainted VLI
EFLAGS: 00010282 (2.6.12-8-386)
EIP is at vma_prio_tree_add+0x77/0x8d
eax: ef977fbc  ebx: efeff2dc  ecx: efeff304  edx: 00000b01
esi: efcb743c  edi: 00000000  ebp: b7ef8000  esp: edda1e8c
ds: 007b  es: 007b  ss:0068

Process udev_run_hotplug (pid: 2874, threadinfo=edda0000 task=edf12aa0)
Stack:
efeff43c efeff2dc c013bodc efeff2dc efcb743c edda1f50 00000000 00000000
00000000 ed88d840 ee1f9c9c ee1f9c88 eeadc280 efeff59c efeff2dc bfef8000
00000000 c013c0d5 efeffcdc b7e4d000 b7ef8000 00000000 efeff59c efeff2dc

Call Trace:
  [<c013bodc>] vma_adjust+0x209/0x2b7
  [<c013c0d5>] split_vma+0xa6/0xb2
  [<c013c165>] do_munmap+0x84/0xf3
  [<c013b760>] do_mmap_pgoff+0x2f5/0x5f6
  [<c0107bbf>] old_mmap0xa8/0xd3
  [<c0102ef9>] syscall_call+0x7/0xb

Code: 28 86 56 28 8d 4e 28 89 42 04 89 53 28 89 48 04 89 46 28 eb 29 8b 46 
34 8d 4b 28 85 c0 74 13 83 c0 28 8b 50 04 89 43 28 89 48 04 <89> 0a 89 51 
04 eb 0c 89 4b 28 89 4b 2c 89 73 34 89 5e 34 5b 5e

---

Second Oops

Unable to handle kernel paging request at virtual address 0000254b

Printing eip:
*pde = 00000000
Oops: 0000 [#2]
Modules linked in: thermal processor fan usbhid amd74xx ide_core sata_nv 
libata scsi_mod echi_hcd ohci_hcd usbcore unix
CPU: 0
EIP is at inotify_inode_queue_event+0xd2/0xfd
eax: ef135f30  ebx: edf0d9e4  ecx: 00002543  edx: efe95f30
esi: 00002543  edi: 000025cc  ebp: efe95e1c  esp: ef295f58
ds: 007b  es: 007b  ss: 0068

Process cat (pid:3712, threadinfo=ef294000 task=ee2fcab0)
Stack:
00002543 edfod9e4 00000002 00000009 efe95e1c c0144f31 efe95e1c 00000002
00000000 00000000 eea76e00 fffffff7 bfb165e4 ef294000 c014500a eea76e00
bfb165e4 00000009 ef295fa4 00000000 00000000 00000000 00000001 00000009

Call Trace:
  [<c0144f31>] vfs_write+0xfe/0x139
  [<c014500a>] sys_write+0x3b/0x63
  [<c0102ef9>] syscall_call+0x7/0xb

Code: 73 3c e8 2d a2 fb ff 89 1c 24 e8 0e 2a fd ff 5f ff 76 18 e8 a2 6f ff 
ff 89 34 24 ff 35 3c 7c 37 c0 e8 6e 29 fd ff 5b 5e 8b 34 24 <8b> 46 08 8d 
56 08 83 08 89 04 24 8d 85 14 01 00 00 39 c2 e9

---


Grahame
