Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932677AbVKBTic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932677AbVKBTic (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 14:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965192AbVKBTic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 14:38:32 -0500
Received: from agmk.net ([217.73.31.34]:34577 "EHLO mail.agmk.net")
	by vger.kernel.org with ESMTP id S932677AbVKBTib (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 14:38:31 -0500
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@agmk.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rt4 (ide_core / busybox)
Date: Wed, 2 Nov 2005 20:38:22 +0100
User-Agent: KMail/1.8.3
Cc: Ingo Molnar <mingo@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511022038.23137.pluto@agmk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The 2.6.14-rt4 works fine but debug code prints warnings:

(...)
RAMDISK: Compressed image found at block 0
VFS: Mounted root (romfs filesystem) readonly.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
BUG: nonzero lock count 10 at exit time?
         busybox:  738 [c15e7180, 118]
 [<c010418a>] dump_stack+0x1a/0x20 (20)
 [<c0138902>] check_no_held_locks+0x382/0x390 (36)
 [<c01212ab>] do_exit+0x25b/0x490 (44)
 [<c012150f>] sys_exit+0xf/0x10 (8)
 [<c01032a5>] syscall_call+0x7/0xb (-8116)
---------------------------
| preempt count: 00000000 ]
| 0-level deep critical section nesting:
----------------------------------------

------------------------------
| showing all locks held by: |  (busybox/738 [c15e7180, 118]):
------------------------------

#001:             [e08429e8] {(struct semaphore *)(&hwif->gendev_rel_sem)}
... acquired at:               init_hwif_data+0x8f/0x190 [ide_core]

#002:             [e08434f8] {(struct semaphore *)(&hwif->gendev_rel_sem)}
... acquired at:               init_hwif_data+0x8f/0x190 [ide_core]

#003:             [e0844008] {(struct semaphore *)(&hwif->gendev_rel_sem)}
... acquired at:               init_hwif_data+0x8f/0x190 [ide_core]

#004:             [e0844b18] {(struct semaphore *)(&hwif->gendev_rel_sem)}
... acquired at:               init_hwif_data+0x8f/0x190 [ide_core]

#005:             [e0845628] {(struct semaphore *)(&hwif->gendev_rel_sem)}
... acquired at:               init_hwif_data+0x8f/0x190 [ide_core]

#006:             [e0846138] {(struct semaphore *)(&hwif->gendev_rel_sem)}
... acquired at:               init_hwif_data+0x8f/0x190 [ide_core]

#007:             [e0846c48] {(struct semaphore *)(&hwif->gendev_rel_sem)}
... acquired at:               init_hwif_data+0x8f/0x190 [ide_core]

#008:             [e0847758] {(struct semaphore *)(&hwif->gendev_rel_sem)}
... acquired at:               init_hwif_data+0x8f/0x190 [ide_core]

#009:             [e0848268] {(struct semaphore *)(&hwif->gendev_rel_sem)}
... acquired at:               init_hwif_data+0x8f/0x190 [ide_core]

#010:             [e0848d78] {(struct semaphore *)(&hwif->gendev_rel_sem)}
... acquired at:               init_hwif_data+0x8f/0x190 [ide_core]

BUG: busybox/738, lock held at task exit time!
 [e08429e8] {(struct semaphore *)(&hwif->gendev_rel_sem)}
.. held by:           busybox:  738 [c15e7180, 118]
... acquired at:               init_hwif_data+0x8f/0x190 [ide_core]
BUG: busybox/738, lock held at task exit time!
 [e08434f8] {(struct semaphore *)(&hwif->gendev_rel_sem)}
.. held by:           busybox:  738 [c15e7180, 118]
... acquired at:               init_hwif_data+0x8f/0x190 [ide_core]
BUG: busybox/738, lock held at task exit time!
 [e0844008] {(struct semaphore *)(&hwif->gendev_rel_sem)}
.. held by:           busybox:  738 [c15e7180, 118]
... acquired at:               init_hwif_data+0x8f/0x190 [ide_core]
BUG: busybox/738, lock held at task exit time!
 [e0844b18] {(struct semaphore *)(&hwif->gendev_rel_sem)}
.. held by:           busybox:  738 [c15e7180, 118]
... acquired at:               init_hwif_data+0x8f/0x190 [ide_core]
BUG: busybox/738, lock held at task exit time!
 [e0845628] {(struct semaphore *)(&hwif->gendev_rel_sem)}
.. held by:           busybox:  738 [c15e7180, 118]
... acquired at:               init_hwif_data+0x8f/0x190 [ide_core]
BUG: busybox/738, lock held at task exit time!
 [e0846138] {(struct semaphore *)(&hwif->gendev_rel_sem)}
.. held by:           busybox:  738 [c15e7180, 118]
... acquired at:               init_hwif_data+0x8f/0x190 [ide_core]
BUG: busybox/738, lock held at task exit time!
 [e0846c48] {(struct semaphore *)(&hwif->gendev_rel_sem)}
.. held by:           busybox:  738 [c15e7180, 118]
... acquired at:               init_hwif_data+0x8f/0x190 [ide_core]
BUG: busybox/738, lock held at task exit time!
 [e0847758] {(struct semaphore *)(&hwif->gendev_rel_sem)}
.. held by:           busybox:  738 [c15e7180, 118]
... acquired at:               init_hwif_data+0x8f/0x190 [ide_core]
BUG: busybox/738, lock held at task exit time!
 [e0848268] {(struct semaphore *)(&hwif->gendev_rel_sem)}
.. held by:           busybox:  738 [c15e7180, 118]
... acquired at:               init_hwif_data+0x8f/0x190 [ide_core]
BUG: busybox/738, lock held at task exit time!
 [e0848d78] {(struct semaphore *)(&hwif->gendev_rel_sem)}
.. held by:           busybox:  738 [c15e7180, 118]
... acquired at:               init_hwif_data+0x8f/0x190 [ide_core]
VP_IDE: IDE controller at PCI slot 0000:00:07.1
PCI: Via IRQ fixup for 0000:00:07.1, from 255 to 0
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c596b (rev 23) IDE UDMA66 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: ST3160023A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: _NEC DVD_RW ND-3540A, ATAPI CD/DVD-ROM drive
hdd: TEAC CD-552E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
JFS: nTxBlock = 4028, nTxLock = 32227
(...)

-- 
The only thing necessary for the triumph of evil
  is for good men to do nothing.
                                           - Edmund Burke
