Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbUBHVOw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 16:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUBHVOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 16:14:52 -0500
Received: from mid-1.inet.it ([213.92.5.18]:61170 "EHLO mid-1.inet.it")
	by vger.kernel.org with ESMTP id S264095AbUBHVOt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 16:14:49 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: linux-kernel@vger.kernel.org
Subject: SATA / IRQ ICH5 problems
Date: Sun, 8 Feb 2004 22:14:40 +0100
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200402082214.40149.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure if this has been reported earlier, I've googled a little 
bit but no luck.
I've recently installed a SATA drive (maxtor 160G) on a abit ic7-g 
(i875p ICH5 MoBo) and I've tried to use it with 2.6.2-mm1 kernel; I've
already in place a normal 60 Gb HD and a DVD burner on standard ide
controllers.
The first thing I've noticed is that when I enable from bios menu the 
SATA controller, the internal nic stops working, reporting errors like
this:

======================================
Feb  7 16:16:36 kefk kernel: e1000: eth0 NIC Link is Up 100 Mbps Full
Duplex
Feb  7 16:16:41 kefk kernel: NETDEV WATCHDOG: eth0: transmit timed out
Feb  7 16:16:43 kefk kernel: e1000: eth0 NIC Link is Up 100 Mbps Full
Duplex
======================================

Looking at syslog, I've seen this:

======================================
Feb  7 16:14:49 kefk kernel: hub 1-0:1.0: debounce: port 3: delay 100ms
stable 4 status 0x501
Feb  7 16:14:49 kefk kernel: irq 18: nobody cared!
Feb  7 16:14:49 kefk kernel: Call Trace:
Feb  7 16:14:49 kefk kernel:  [<c010b8b0>] __report_bad_irq+0x24/0x81
Feb  7 16:14:49 kefk kernel:  [<c010b7c1>] do_IRQ+0x12f/0x1fa
Feb  7 16:14:49 kefk kernel:  [<c032c840>] common_interrupt+0x18/0x20
Feb  7 16:14:49 kefk kernel:  [<c032007b>] .text.lock.xfrm_policy+0x9c/0xc9
Feb  7 16:14:49 kefk kernel:
Feb  7 16:14:49 kefk kernel: handlers:
Feb  7 16:14:49 kefk kernel: [<c02b8db7>] (usb_hcd_irq+0x0/0x67)
Feb  7 16:14:49 kefk kernel: Disabling IRQ #18
======================================

If I turn off SATA controller from bios all works just fine, and IRQ 18 is
assigned  uhci_hcd, eth0

If I try to modprobe ata_piix and libata, I get this on syslog:

======================================
Feb  7 16:19:15 kefk kernel: PCI: Setting latency timer of device
0000:00:1f.2 to 64
Feb  7 16:19:15 kefk kernel: ata1: SATA max UDMA/133 cmd 0xC000 ctl 0xC402
bmdma 0xD000 irq 18
Feb  7 16:19:15 kefk kernel: ata2: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02
bmdma 0xD008 irq 18
Feb  7 16:19:15 kefk kernel: ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09
84:4003 85:7c69 86:3e01 87:4003 88:207f
Feb  7 16:19:15 kefk kernel: ata1: dev 0 ATA, max UDMA/133, 320173056
sectors (lba48)
Feb  7 16:19:15 kefk kernel: ata1: dev 0 configured for UDMA/133
Feb  7 16:19:15 kefk kernel: scsi1 : ata_piix
Feb  7 16:19:15 kefk kernel: ata2: SATA port disabled. ignoring.
Feb  7 16:19:15 kefk kernel: ata2: thread exiting
Feb  7 16:19:15 kefk kernel: scsi2 : ata_piix
Feb  7 16:19:15 kefk kernel:   Vendor: ATA       Model: Maxtor 6Y160M0
Rev: 0.81
Feb  7 16:19:15 kefk kernel:   Type:   Direct-Access
ANSI SCSI revision: 05
Feb  7 16:19:15 kefk kernel: SCSI device sda: 320173056 512-byte hdwr
sectors (163929 MB)
Feb  7 16:19:15 kefk kernel: SCSI device sda: drive cache: write through
Feb  7 16:19:15 kefk scsi.agent[2951]: how to add device type= at
/devices/pci0000:00/0000:00:1f.2/host1/1:0
:0:0 ??
======================================

but modprobe never returns control to the shell ad remains unkillable.
I've seen this behaviour also on 2.6.2-rc3-mm1
Of course I can make any needed test to narrow the problem, just let me
know.

Details:
2.6.2-mm1 #1 SMP (SMT)
i875p/P4 2.8GHz HT
gcc (GCC) 3.3.1 (Mandrake Linux 9.2 3.3.1-2mdk)
SATA drive: Maxtor 6Y160M0


-- 
Fabio Coatti       http://www.ferrara.linux.it/members/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
