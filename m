Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261922AbVFQITi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbVFQITi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 04:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbVFQITe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 04:19:34 -0400
Received: from krusty.dt.E-Technik.uni-dortmund.de ([129.217.163.1]:55254 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261645AbVFQITT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 04:19:19 -0400
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: RESEND: sym53c8xx in 2.6.12-rc6: sleeping function called from invalid context at mm/slab.c:2093
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
Date: Fri, 17 Jun 2005 10:19:10 +0200
Message-ID: <m3hdfxfla9.fsf@merlin.emma.line.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the enclosed message didn't prompt any replies over at linux-scsi over
half a week, so I'm resending here, on linux-kernel, hope you don't mind.


I tried Linux 2.6.12-rc6 recently and got these messages "Debug:
sleeping function called from invalid context at mm/slab.c:2093
in_atomic():1, irqs_disabled():1" in dmesg (the current tree from git
also shows them, but the ones pasted below are from vanilla
rc6). 2.6.11.12 with the same configuration doesn't show these.

...
ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 16 (level, low) -> IRQ 16
sym0: <895> rev 0x1 at pci 0000:00:0d.0 irq 16
sym0: Tekram NVRAM, ID 7, Fast-40, LVD, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.2.0
  Vendor: COMPAQ    Model: BB018222B8        Rev: B016
  Type:   Direct-Access                      ANSI SCSI revision: 02
 target0:0:0: tagged command queuing enabled, command queue depth 32.
 target0:0:0: Beginning Domain Validation
Debug: sleeping function called from invalid context at mm/slab.c:2093
in_atomic():1, irqs_disabled():1
 [<c0103c4e>] dump_stack+0x1e/0x20
 [<c01166f4>] __might_sleep+0xa4/0xc0
 [<c014528a>] __kmalloc+0x8a/0x90
 [<c014531c>] kcalloc+0x3c/0x70
 [<e082ea9d>] sym_alloc_lcb_tags+0x7d/0x140 [sym53c8xx]
 [<e082e3fb>] sym_get_ccb+0x25b/0x2d0 [sym53c8xx]
 [<e0825ced>] sym_queue_command+0xbd/0xf0 [sym53c8xx]
 [<e0826142>] sym53c8xx_queue_command+0x72/0xa0 [sym53c8xx]
 [<c02b566a>] scsi_dispatch_cmd+0x19a/0x2d0
 [<c02bc232>] scsi_request_fn+0x1d2/0x4a0
 [<c028d97c>] blk_insert_request+0xbc/0x100
 [<c02bab4b>] scsi_insert_special_req+0x3b/0x40
 [<c02badee>] scsi_wait_req+0x6e/0xb0
 [<c02c10a8>] spi_wait_req+0x48/0x90
 [<c02c2525>] spi_dv_device_compare_inquiry+0xc5/0x130
 [<c02c285c>] spi_dv_device_internal+0x5c/0x330
 [<c02c2c1a>] spi_dv_device+0xea/0x160
 [<e0826a1b>] sym53c8xx_slave_configure+0x10b/0x110 [sym53c8xx]
 [<c02bdd20>] scsi_add_lun+0x340/0x370
 [<c02bde3a>] scsi_probe_and_add_lun+0xea/0x230
 [<c02be7b3>] scsi_scan_target+0xe3/0x170
 [<c02be8d7>] scsi_scan_channel+0x97/0xb0
 [<c02be995>] scsi_scan_host_selected+0xa5/0x120
 [<c02bea41>] scsi_scan_host+0x31/0x40
 [<e0827fab>] sym2_probe+0xfb/0x150 [sym53c8xx]
 [<c0222a3b>] pci_device_probe_static+0x4b/0x70
 [<c0222a9c>] __pci_device_probe+0x3c/0x50
 [<c0222adc>] pci_device_probe+0x2c/0x60
 [<c028596e>] driver_probe_device+0x2e/0x80
 [<c0285ad3>] driver_attach+0x53/0xa0
 [<c0286036>] bus_add_driver+0xa6/0xe0
 [<c0222d7d>] pci_register_driver+0x5d/0x90
 [<e0804032>] sym2_init+0x32/0x51 [sym53c8xx]
 [<c01361ea>] sys_init_module+0x18a/0x270
 [<c0102d95>] syscall_call+0x7/0xb
 target0:0:0: asynchronous.
WIDTH IS 1
 target0:0:0: wide asynchronous.
 target0:0:0: Domain Validation skipping write tests
 target0:0:0: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 31)
 target0:0:0: Ending Domain Validation
SCSI device sda: 35565080 512-byte hdwr sectors (18209 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 35565080 512-byte hdwr sectors (18209 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
  Vendor: PLEXTOR   Model: CD-ROM PX-32TS    Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target0:0:2: Beginning Domain Validation
 target0:0:2: asynchronous.
 target0:0:2: Domain Validation skipping write tests
 target0:0:2: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 15)
 target0:0:2: Ending Domain Validation
  Vendor: TANDBERG  Model:  TDC 4222         Rev: =07:
  Type:   Sequential-Access                  ANSI SCSI revision: 02
 target0:0:6: Beginning Domain Validation
 target0:0:6: asynchronous.
 target0:0:6: Domain Validation skipping write tests
 target0:0:6: FAST-5 SCSI 4.8 MB/s ST (208 ns, offset 8)
 target0:0:6: Ending Domain Validation
  Vendor: TANDBERG  Model: SLR6              Rev: 0404
  Type:   Sequential-Access                  ANSI SCSI revision: 02
 target0:0:8: Beginning Domain Validation
 target0:0:8: asynchronous.
WIDTH IS 1
 target0:0:8: wide asynchronous.
 target0:0:8: Domain Validation skipping write tests
 target0:0:8: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 15)
 target0:0:8: Ending Domain Validation
libata version 1.11 loaded.
sata_via version 1.1
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 20
sata_via(0000:00:0f.0): routed to hard irq line 0
...

-- 
Matthias Andree
