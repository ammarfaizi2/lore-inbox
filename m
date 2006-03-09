Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932683AbWCIFUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932683AbWCIFUm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 00:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932680AbWCIFUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 00:20:41 -0500
Received: from mx2.mail.ru ([194.67.23.122]:46707 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S932136AbWCIFUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 00:20:41 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-acpi@vger.kernel.org
Subject: [2.6.15.6][suspend] sleeping function called from invalid context on swsusp resume from STR
Date: Thu, 9 Mar 2006 08:20:36 +0300
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603090820.36867.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I get this when resuming from swsup STR. I wonder if this may possibly account 
for hard lockups I have been experiencing with acpi_cpufreq (see "System 
completely hangs using acpi_cpufreq").

This is vanilla 2.6.15.6 (except WiFi driver - *not* binary one :), please let 
me know if any more information is needed.

regards

- -andrey

ACPI: PCI interrupt for device 0000:00:06.0 disabled
ACPI: PCI interrupt for device 0000:00:0a.0 disabled
e100: Intel(R) PRO/100 Network Driver, 3.4.14-k4-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> 
IRQ 11
e100: eth0: e100_probe: addr 0xf7efd000, irq 11, MAC addr 00:00:39:D7:14:A1
pccard: card ejected from slot 0
PM: Preparing system for mem sleep
Stopping tasks: ===========================================|
ACPI: PCI interrupt for device 0000:00:11.1 disabled
ACPI: PCI interrupt for device 0000:00:11.0 disabled
ACPI: PCI interrupt for device 0000:00:10.0 disabled
ACPI: PCI interrupt for device 0000:00:0a.0 disabled
ACPI: PCI interrupt for device 0000:00:02.0 disabled
PM: Entering mem sleep
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Back to C!
Debug: sleeping function called from invalid context 
at /home/bor/src/linux-git/mm/slab.c:2472
in_atomic():0, irqs_disabled():1
 [<c010400e>] dump_stack+0x1e/0x20
 [<c0119812>] __might_sleep+0xa2/0xc0
 [<c014cc2e>] kmem_cache_alloc+0x5e/0x80
 [<c01fb8f3>] acpi_os_acquire_object+0x11/0x41
 [<c0210b74>] acpi_ut_allocate_object_desc_dbg+0xf/0x4c
 [<c0210a02>] acpi_ut_create_internal_object_dbg+0x16/0x6a
 [<c020cdc5>] acpi_rs_set_srs_method_data+0x3f/0xba
 [<c020c30f>] acpi_set_current_resources+0x23/0x2e
 [<c02144f8>] acpi_pci_link_set+0x113/0x18f
 [<c02149c1>] acpi_pci_link_resume+0x23/0x2b
 [<c02149e9>] irqrouter_resume+0x20/0x42
 [<c0240f5b>] __sysdev_resume+0x1b/0x90
 [<c0241278>] sysdev_resume+0x48/0x68
 [<c0246828>] device_power_up+0x8/0xf
 [<c013a9e5>] suspend_enter+0x55/0x60
 [<c013aadf>] enter_state+0xaf/0xe0
 [<c013ac8a>] state_store+0x9a/0xa8
 [<c01a74be>] subsys_attr_store+0x2e/0x30
 [<c01a7747>] flush_write_buffer+0x37/0x40
 [<c01a77bd>] sysfs_write_file+0x6d/0xa0
 [<c0163458>] vfs_write+0xa8/0x190
 [<c01635f7>] sys_write+0x47/0x70
 [<c010313f>] sysenter_past_esp+0x54/0x75
PM: Finishing wakeup.
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKG] -> GSI 11 (level, low) -> 
IRQ 11
ACPI: PCI Interrupt 0000:00:04.0[A]: no GSI
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKC] -> GSI 11 (level, low) -> 
IRQ 11
pccard: PCMCIA card inserted into slot 0
pcmcia: registering new device pcmcia0.0
eth1: PRI 31 variant 2 version 9.48
eth1: NIC 5 variant 2 version 1.02
eth1: Wireless, io_addr 0x100, irq 11, mac_address 00:02:2D:26:95:6C
ACPI: PCI Interrupt 0000:00:11.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> 
IRQ 11
ACPI: PCI Interrupt 0000:00:11.1[B] -> Link [LNKB] -> GSI 11 (level, low) -> 
IRQ 11
Restarting tasks... done
eth1: PRI 31 variant 2 version 9.48
eth1: NIC 5 variant 2 version 1.02
eth1: PRI 31 variant 2 version 9.48
eth1: NIC 5 variant 2 version 1.02
eth1: PRI 31 variant 2 version 9.48
eth1: NIC 5 variant 2 version 1.02
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: starting 90-second grace period
NET: Registered protocol family 23
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LNKH] -> GSI 11 (level, low) -> 
IRQ 11
Probing IDE interface ide1...
hdc: TOSHIBA DVD-ROM SD-C2502, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 24X DVD-ROM drive, 128kB Cache
nfsd: last server has exited
nfsd: unexporting all filesystems
ACPI: PCI interrupt for device 0000:00:06.0 disabled
ACPI: PCI interrupt for device 0000:00:0a.0 disabled
e100: Intel(R) PRO/100 Network Driver, 3.4.14-k4-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> 
IRQ 11
e100: eth0: e100_probe: addr 0xf7efd000, irq 11, MAC addr 00:00:39:D7:14:A1
pccard: card ejected from slot 0
PM: Preparing system for mem sleep
Stopping tasks: ===========================================|
ACPI: PCI interrupt for device 0000:00:11.1 disabled
ACPI: PCI interrupt for device 0000:00:11.0 disabled
ACPI: PCI interrupt for device 0000:00:10.0 disabled
ACPI: PCI interrupt for device 0000:00:0a.0 disabled
ACPI: PCI interrupt for device 0000:00:02.0 disabled
PM: Entering mem sleep
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Back to C!
Debug: sleeping function called from invalid context 
at /home/bor/src/linux-git/mm/slab.c:2472
in_atomic():0, irqs_disabled():1
 [<c010400e>] dump_stack+0x1e/0x20
 [<c0119812>] __might_sleep+0xa2/0xc0
 [<c014cc2e>] kmem_cache_alloc+0x5e/0x80
 [<c01fb8f3>] acpi_os_acquire_object+0x11/0x41
 [<c0210b74>] acpi_ut_allocate_object_desc_dbg+0xf/0x4c
 [<c0210a02>] acpi_ut_create_internal_object_dbg+0x16/0x6a
 [<c020cdc5>] acpi_rs_set_srs_method_data+0x3f/0xba
 [<c020c30f>] acpi_set_current_resources+0x23/0x2e
 [<c02144f8>] acpi_pci_link_set+0x113/0x18f
 [<c02149c1>] acpi_pci_link_resume+0x23/0x2b
 [<c02149e9>] irqrouter_resume+0x20/0x42
 [<c0240f5b>] __sysdev_resume+0x1b/0x90
 [<c0241278>] sysdev_resume+0x48/0x68
 [<c0246828>] device_power_up+0x8/0xf
 [<c013a9e5>] suspend_enter+0x55/0x60
 [<c013aadf>] enter_state+0xaf/0xe0
 [<c013ac8a>] state_store+0x9a/0xa8
 [<c01a74be>] subsys_attr_store+0x2e/0x30
 [<c01a7747>] flush_write_buffer+0x37/0x40
 [<c01a77bd>] sysfs_write_file+0x6d/0xa0
 [<c0163458>] vfs_write+0xa8/0x190
 [<c01635f7>] sys_write+0x47/0x70
 [<c010313f>] sysenter_past_esp+0x54/0x75
PM: Finishing wakeup.
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKG] -> GSI 11 (level, low) -> 
IRQ 11
ACPI: PCI Interrupt 0000:00:04.0[A]: no GSI
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKC] -> GSI 11 (level, low) -> 
IRQ 11
pccard: PCMCIA card inserted into slot 0
pcmcia: registering new device pcmcia0.0
eth1: PRI 31 variant 2 version 9.48
eth1: NIC 5 variant 2 version 1.02
eth1: Wireless, io_addr 0x100, irq 11, mac_address 00:02:2D:26:95:6C
ACPI: PCI Interrupt 0000:00:11.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> 
IRQ 11
ACPI: PCI Interrupt 0000:00:11.1[B] -> Link [LNKB] -> GSI 11 (level, low) -> 
IRQ 11
Restarting tasks... done
eth1: PRI 31 variant 2 version 9.48
eth1: NIC 5 variant 2 version 1.02
eth1: PRI 31 variant 2 version 9.48
eth1: NIC 5 variant 2 version 1.02
eth1: PRI 31 variant 2 version 9.48
eth1: NIC 5 variant 2 version 1.02
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: starting 90-second grace period
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LNKH] -> GSI 11 (level, low) -> 
IRQ 11
Probing IDE interface ide1...
hdc: TOSHIBA DVD-ROM SD-C2502, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 24X DVD-ROM drive, 128kB Cache
input: AT Translated Set 2 keyboard as /class/input/input14


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQFED7skR6LMutpd94wRAjz+AKCfvasJJ2cZ1XQJ9ATG7EF/kXGYHQCfVxRd
uLkcblP3xcmIWRBqDRQa26c=
=tET+
-----END PGP SIGNATURE-----
