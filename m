Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264695AbTFASRB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 14:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264696AbTFASRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 14:17:01 -0400
Received: from platane.lps.ens.fr ([129.199.121.28]:24977 "EHLO
	platane.lps.ens.fr") by vger.kernel.org with ESMTP id S264695AbTFASQ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 14:16:58 -0400
Date: Sun, 1 Jun 2003 20:30:22 +0200
From: =?iso-8859-1?Q?=C9ric?= Brunet <Eric.Brunet@lps.ens.fr>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Oops on a 2.5.70 boot
Message-ID: <20030601183022.GA27265@lps.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, all,

While booting a 2.5.70 kernel, I got:

------------------------------------------------------------------------
hdc: SAMSUNG CDRW/DVD SM-348B, ATAPI CD/DVD-ROM drive
 evevent-0286: *** Error: No installed handler for fixed event [00000000]
irq 9: nobody cared!
Call Trace: [<c010a77b>]  [<c010a927>]  [<c010914c>]  [<c01f007b>]  [<c0112b32>]  [<c01a6492>]  [<c020c94b>]  [<c02052b4>]  [<c020583a>]  [<c0205bab>]  [<c020dfa3>]  [<c020ca97>]  [<c0205d03>]  [<c02119fe>]  [<c0203544>]  [<c034abba>]  [<c034abf8>]  [<c034a986>]  [<c034a98d>]  [<c034a9c3>]  [<c033c6b3>]  [<c0126b09>]  [<c0105051>]  [<c010502c>]  [<c01071fd>]
handlers:
[<c01ace22>]
ide1 at 0x170-0x177,0x376 on irq 15
-------------------------------------------------------------------------

After decoding, it reads:

-------------------------------------------------------------------------
Trace; c010a77b <handle_IRQ_event+87/e5>
Trace; c010a927 <do_IRQ+72/c8>
Trace; c010914c <common_interrupt+18/20>
Trace; c01f007b <complement_pos+28/13a>
Trace; c0112b32 <delay_tsc+d/15>
Trace; c01a6492 <__delay+12/16>
Trace; c020c94b <ide_delay_50ms+18/22>
Trace; c02052b4 <do_probe+47/25c>
Trace; c020583a <hwif_register+133/180>
Trace; c0205bab <probe_hwif+324/457>
Trace; c020dfa3 <idedefault_attach+23/48>
Trace; c020ca97 <ata_attach+69/104>
Trace; c0205d03 <probe_hwif_init+25/7c>
Trace; c02119fe <ide_setup_pci_device+6f/77>
Trace; c0203544 <piix_init_one+31/37>
Trace; c034abba <ide_scan_pcidev+59/6b>
Trace; c034abf8 <ide_scan_pcibus+2c/8b>
Trace; c034a986 <probe_for_hwifs+20/22>
Trace; c034a98d <ide_init_builtin_drivers+5/f>
Trace; c034a9c3 <ide_init+2c/5b>
Trace; c033c6b3 <do_initcalls+27/93>
Trace; c0126b09 <init_workqueues+f/26>
Trace; c0105051 <init+25/140>
Trace; c010502c <init+0/140>
Trace; c01071fd <kernel_thread_helper+5/b>
handlers:
Trace; c01ace22 <acpi_irq+0/16>
--------------------------------------------------------------------------

Computer is a shuttle SB51G PC with an intel i845G/GL chipset.

------------ /proc/interrupts -------------------------
           CPU0
  0:     831798          XT-PIC  timer
  1:       1428          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:          0          XT-PIC  Intel 82801DB-ICH4
  8:          0          XT-PIC  rtc
  9:          1          XT-PIC  acpi, uhci-hcd
 10:       4482          XT-PIC  eth1
 11:          4          XT-PIC  uhci-hcd, ehci-hcd, eth0
 12:      35570          XT-PIC  uhci-hcd
 14:      10816          XT-PIC  ide0
 15:          4          XT-PIC  ide1
NMI:          0
ERR:          0
-----------------------------------------------------------

The only usb device currently plugged in is a mouse, and it uses irq 12.

Don't hesitate to ask if you need more info.

Regards,

	Éric Brunet
