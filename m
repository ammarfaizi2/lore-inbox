Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbVIKMlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbVIKMlF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 08:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbVIKMlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 08:41:05 -0400
Received: from mailserv.aei.mpg.de ([194.94.224.6]:32687 "EHLO
	mailserv.aei.mpg.de") by vger.kernel.org with ESMTP
	id S1750736AbVIKMlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 08:41:04 -0400
From: Kasper Peeters <kasper.peeters@aei.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17188.9683.311780.197075@sbox13.aei.mpg.de>
Date: Sun, 11 Sep 2005 14:40:51 +0200
To: linux-kernel@vger.kernel.org
Subject: crash upon rmmod aic7xxx (pcmcia)
X-Mailer: VM 7.07 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since the early 2.6.x kernels, removing the aic7xxx module (either by
doing a 'rmmod' by hand or by ejecting the pcmcia aic7xxx card) locks
the system hard after about 2 seconds, leaving no trace in syslog. 
Just checked with kernel 2.6.13 (and pcmcia-tools 3.2.8).

Upon insertion of the pcmcia card, this appears in syslog:

Sep 11 14:36:05 whiteroom2 kernel: PCI: Enabling device 0000:03:00.0 (0000 -> 0003)
Sep 11 14:36:05 whiteroom2 kernel: ACPI: PCI Interrupt 0000:03:00.0[A] -> Link [LNKA] -> GSI 11 (level, low
) -> IRQ 11
Sep 11 14:36:05 whiteroom2 kernel: aic7xxx: PCI Device 3:0:0 failed memory mapped test.  Using PIO.
Sep 11 14:36:05 whiteroom2 kernel: ahc_pci:3:0:0: Host Adapter Bios disabled.  Using default SCSI device pa
rameters
Sep 11 14:36:05 whiteroom2 kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
Sep 11 14:36:05 whiteroom2 kernel:         <Adaptec 1480A Ultra SCSI adapter>
Sep 11 14:36:05 whiteroom2 kernel:         aic7860: Ultra Single Channel A, SCSI Id=7, 3/253 SCBs
Sep 11 14:36:05 whiteroom2 kernel: 
Sep 11 14:36:12 whiteroom2 kernel: scsi0: PCI error Interrupt at seqaddr = 0x8
Sep 11 14:36:12 whiteroom2 kernel: scsi0: Signaled a Target Abort
Sep 11 14:36:21 whiteroom2 kernel:   Vendor: HP        Model: CD-Writer+ 9200   Rev: 1.0c
Sep 11 14:36:21 whiteroom2 kernel:   Type:   CD-ROM                             ANSI SCSI revision: 04
Sep 11 14:36:21 whiteroom2 kernel:  target0:0:4: asynchronous.
Sep 11 14:36:21 whiteroom2 kernel:  target0:0:4: Beginning Domain Validation
Sep 11 14:36:21 whiteroom2 kernel:  target0:0:4: Domain Validation skipping write tests
Sep 11 14:36:21 whiteroom2 kernel:  target0:0:4: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
Sep 11 14:36:21 whiteroom2 kernel:  target0:0:4: Ending Domain Validation
Sep 11 14:36:21 whiteroom2 kernel: sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Sep 11 14:36:21 whiteroom2 kernel: Attached scsi generic sg0 at scsi0, channel 0, id 4, lun 0,  type 5
Sep 11 14:36:22 whiteroom2 scsi.agent[3014]: cdrom at /devices/pci0000:00/0000:00:1e.0/0000:02:0a.0/0000:03
:00.0/host0/target0:0:4/0:0:4:0


Can someone give me a hand pinning down this bug?

(Please CC replies to me directly).

Kasper

