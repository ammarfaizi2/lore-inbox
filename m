Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbUBVRq0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 12:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbUBVRqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 12:46:25 -0500
Received: from [212.28.208.94] ([212.28.208.94]:2822 "HELO dewire.com")
	by vger.kernel.org with SMTP id S261710AbUBVRqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 12:46:17 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Badness in pci_find_subsys
Date: Sun, 22 Feb 2004 18:46:14 +0100
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402221846.15010.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is a regular error (2.6.1,2.6.2) that locks up my X although I don't know if it has anything to
do with X per se other than that after every lockup i find an error in syslog.

Feb 22 18:23:25 h6n2fls33o811 kernel: Badness in pci_find_subsys at drivers/pci/search.c:167
Feb 22 18:23:25 h6n2fls33o811 kernel: Call Trace:
Feb 22 18:23:25 h6n2fls33o811 kernel:  [pci_find_subsys+215/224] pci_find_subsys+0xd7/0xe0
Feb 22 18:23:25 h6n2fls33o811 kernel:  [<c01c5897>] pci_find_subsys+0xd7/0xe0
Feb 22 18:23:25 h6n2fls33o811 kernel:  [pci_find_device+24/32] pci_find_device+0x18/0x20
Feb 22 18:23:25 h6n2fls33o811 kernel:  [<c01c58b8>] pci_find_device+0x18/0x20
Feb 22 18:23:25 h6n2fls33o811 kernel:  [pci_find_slot+26/96] pci_find_slot+0x1a/0x60
Feb 22 18:23:25 h6n2fls33o811 kernel:  [<c01c56fa>] pci_find_slot+0x1a/0x60
Feb 22 18:23:25 h6n2fls33o811 kernel:  [__crc___lock_sock+2862576/4902775] 0xe1301876
	:
	:
Feb 22 18:23:25 h6n2fls33o811 kernel:  [__crc___lock_sock+2854065/4902775] 0xe12ff737
Feb 22 18:23:25 h6n2fls33o811 kernel:  [<e12ff737>] 0xe12ff737
Feb 22 18:23:25 h6n2fls33o811 kernel:  [tasklet_action+57/112] tasklet_action+0x39/0x70
Feb 22 18:23:25 h6n2fls33o811 kernel:  [<c0126559>] tasklet_action+0x39/0x70
Feb 22 18:23:25 h6n2fls33o811 kernel:  [do_softirq+97/192] do_softirq+0x61/0xc0
Feb 22 18:23:25 h6n2fls33o811 kernel:  [<c0126321>] do_softirq+0x61/0xc0
Feb 22 18:23:25 h6n2fls33o811 kernel:  [do_IRQ+229/256] do_IRQ+0xe5/0x100
Feb 22 18:23:25 h6n2fls33o811 kernel:  [<c010d855>] do_IRQ+0xe5/0x100
Feb 22 18:23:25 h6n2fls33o811 kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Feb 22 18:23:25 h6n2fls33o811 kernel:  [<c010bf38>] common_interrupt+0x18/0x20

The stack dump comes out twice with the same time stamp (same in dmesg so I assume the
error occurs twice).

My hardware  is a Dell Dimension XPS T700 and lspci

-[00]-+-00.0  Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
      +-01.0-[01]----00.0  nVidia Corporation NV10 [GeForce 256 SDR]
      +-07.0  Intel Corp. 82371AB/EB/MB PIIX4 ISA
      +-07.1  Intel Corp. 82371AB/EB/MB PIIX4 IDE
      +-07.2  Intel Corp. 82371AB/EB/MB PIIX4 USB
      +-07.3  Intel Corp. 82371AB/EB/MB PIIX4 ACPI
      +-0d.0  3Com Corporation 3c905C-TX/TX-M [Tornado]
      +-0e.0  Brooktree Corporation Bt878 Video Capture
      +-0e.1  Brooktree Corporation Bt878 Audio Capture
      +-0f.0  Artop Electronic Corp AEC6712D SCSI
      +-10.0  Creative Labs SB Live! EMU10k1
      \-10.1  Creative Labs SB Live! MIDI/Game Port

More info @ http://qa.mandrakesoft.com/show_bug.cgi?id=6856

-- robin
