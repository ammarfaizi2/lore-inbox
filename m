Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262178AbSJASz0>; Tue, 1 Oct 2002 14:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262196AbSJASz0>; Tue, 1 Oct 2002 14:55:26 -0400
Received: from tux.creighton.edu ([147.134.5.192]:18847 "EHLO tux.obix.com")
	by vger.kernel.org with ESMTP id <S262178AbSJASyb>;
	Tue, 1 Oct 2002 14:54:31 -0400
Message-ID: <3D99F0AB.3030800@tux.obix.com>
Date: Tue, 01 Oct 2002 13:59:55 -0500
From: Phil Brutsche <phil@tux.obix.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.40: Multiple OOPSen (long!)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got these message while booting 2.5.40 on a 2x PIII-450 I have here (tweaked 
slightly to make the message wrap right); I included some of the lines 
around the oopses to provide some context:

After activating the CPUs:

Bringing up 1
cpu: 1, clocks: 99720, slice: 3021
CPU1<T0:99712,T1:93664,D:6,S:3021,C:99720>
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
bad: scheduling while atomic!
c12e5f00 c0114f32 c0258960 c12e4000 c12e5f70 c12e5f78 00000000 00000000
      00000000 00000000 00000000 c12e5f78 c12e4000 c12e5f78 c01155c8 c03194a0
      00000000 c12e4000 c12e4000 c12e5fa4 00000000 c12e3060 c0115378 00000000
Call Trace:
  [<c0114f32>]schedule+0x3e/0x43c
  [<c01155c8>]wait_for_completion+0xb4/0x11c
  [<c0115378>]default_wake_function+0x0/0x2c
  [<c0115378>]default_wake_function+0x0/0x2c
  [<c0116aa6>]set_cpus_allowed+0x186/0x1a8
  [<c0116b18>]migration_thread+0x50/0x35c
  [<c0116ac8>]migration_thread+0x0/0x35c
  [<c0105539>]kernel_thread_helper+0x5/0xc

bad: scheduling while atomic!
c12e1f1c c0114f32 c0258960 c12e0000 c12e1f8c c12e1f94 00000000 00000000
      00000000 00000000 00000000 c12e1f94 c12e0000 c12e1f94 c01155c8 c03194a0
      00000000 c12e0000 c12e0000 c12e1fc0 00000000 c12e3780 c0115378 00000000
Call Trace:
  [<c0114f32>]schedule+0x3e/0x43c
  [<c01155c8>]wait_for_completion+0xb4/0x11c
  [<c0115378>]default_wake_function+0x0/0x2c
  [<c0115378>]default_wake_function+0x0/0x2c
  [<c0116aa6>]set_cpus_allowed+0x186/0x1a8
  [<c011ee75>]ksoftirqd+0x51/0xe0
  [<c011ee24>]ksoftirqd+0x0/0xe0
  [<c0105539>]kernel_thread_helper+0x5/0xc
CPUS done 4294967295
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket

And this during probing the IDE bus:

hda: WDC WD205AA, ATA DISK drive
hdb: IC35L040AVER07-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: ATAPI CDROM, ATAPI CD/DVD-ROM drive
Debug: sleeping function called from illegal context at slab.c:1374
c12f1e98 c0116ee5 c0258b00 c025d430 0000055e 00000000 c01343e5 c025d430
      0000055e c03b8e10 c03b8dd8 c139ad40 00000000 00000046 c01b3740 c139fc14
      000001d0 c03b8dd8 c03b8dc8 c139ad40 00000000 00000000 c01b37d1 c03b8dd8
Call Trace:
  [<c0116ee5>]__might_sleep+0x55/0x59
  [<c01343e5>]kmem_cache_alloc+0x25/0x19c
  [<c01b3740>]blk_init_free_list+0x4c/0xd0
  [<c01b37d1>]blk_init_queue+0xd/0xe8
  [<c01bd5f4>]ide_init_queue+0x28/0x68
  [<c01c4040>]do_ide_request+0x0/0x18
  [<c01bd8f8>]init_irq+0x2c4/0x37c
  [<c01bdc76>]hwif_init+0x10a/0x258
  [<c01bd51c>]probe_hwif_init+0x1c/0x70
  [<c01ca847>]ide_setup_pci_device+0x77/0x80
  [<c01b8e7f>]piix_init_one+0x37/0x40
  [<c01050b6>]init+0x4e/0x1c8
  [<c0105068>]init+0x0/0x1c8
  [<c0105539>]kernel_thread_helper+0x5/0xc

ide1 at 0x170-0x177,0x376 on irq 15

And yet another!

Freeing unused kernel memory: 96k freed
Debug: sleeping function called from illegal context at 
/usr/src/linux-2.5.39/include/asm/semaphore.h:119
cff6bf7c c0116ee5 c0258b00 c028cd60 00000077 c1399640 c01de8fa c028cd60
      00000077 cff6a000 cff6a000 00000001 cff6bfdc c011c85c 00000202 c1399668
      cff6a000 00000001 cff6bfdc c01debad c01deb7c 00000000 00000000 00000000
Call Trace:
  [<c0116ee5>]__might_sleep+0x55/0x59
  [<c01de8fa>]usb_hub_events+0x6e/0x2f0
  [<c011c85c>]reparent_to_init+0x120/0x168
  [<c01debad>]usb_hub_thread+0x31/0xd8
  [<c01deb7c>]usb_hub_thread+0x0/0xd8
  [<c0115378>]default_wake_function+0x0/0x2c
  [<c0105539>]kernel_thread_helper+0x5/0xc

hub.c: new USB device 00:07.2-2, assigned address 2

That last OOPS seems to have rendered my USB mouse useless.

Finally, this one, while modprobe'ing the pdc202xx_old driver:

PDC20262: IDE controller at PCI slot 00:08.0
PDC20262: chipset revision 1
PDC20262: not 100% native mode: will probe irqs later
PDC20262: ROM enabled at 0xe7000000
PDC20262: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
     ide2: BM-DMA at 0xe400-0xe407, BIOS settings: hde:DMA, hdf:DMA
     ide3: BM-DMA at 0xe408-0xe40f, BIOS settings: hdg:DMA, hdh:pio
hde: ST313021A, ATA DISK drive
Debug: sleeping function called from illegal context at slab.c:1374
c34add60 c0116ee5 c0258b00 c025d430 0000055e 00000000 c01343e5 c025d430
      0000055e c03b93ec c03b93b4 c83dea80 00000000 c0112ad2 c01b3740 c139fc14
      000001d0 c03b93b4 c03b93a4 c83dea80 00000000 00000000 c01b37d1 c03b93b4
Call Trace:
  [<c0116ee5>]__might_sleep+0x55/0x59
  [<c01343e5>]kmem_cache_alloc+0x25/0x19c
  [<c0112ad2>]startup_level_ioapic_irq+0xa/0x10
  [<c01b3740>]blk_init_free_list+0x4c/0xd0
  [<c01b37d1>]blk_init_queue+0xd/0xe8
  [<c01bd5f4>]ide_init_queue+0x28/0x68
  [<c01c4040>]do_ide_request+0x0/0x18
  [<c01bd8f8>]init_irq+0x2c4/0x37c
  [<c01bdc76>]hwif_init+0x10a/0x258
  [<c01bd51c>]probe_hwif_init+0x1c/0x70
  [<d08ee050>]pdc202xx_chipsets+0x30/0x120 [pdc202xx_old]
  [<c01ca817>]ide_setup_pci_device+0x47/0x80
  [<d08ecb02>]init_setup_pdc202ata4+0x92/0x9c [pdc202xx_old]
  [<d08ee050>]pdc202xx_chipsets+0x30/0x120 [pdc202xx_old]
  [<d08ecb9b>]pdc202xx_init_one+0x37/0x40 [pdc202xx_old]
  [<d08ee050>]pdc202xx_chipsets+0x30/0x120 [pdc202xx_old]
  [<d08ee228>]driver+0x28/0x80 [pdc202xx_old]
  [<c0198d81>]pci_device_probe+0x41/0x5c
  [<d08ee160>]pdc202xx_pci_tbl+0x1c/0xbc [pdc202xx_old]
  [<d08ee228>]driver+0x28/0x80 [pdc202xx_old]
  [<d08ee228>]driver+0x28/0x80 [pdc202xx_old]
  [<d08ee200>]driver+0x0/0x80 [pdc202xx_old]
  [<c019a068>]probe+0x18/0x24
  [<c019a0fb>]found_match+0x27/0x58
  [<d08ee228>]driver+0x28/0x80 [pdc202xx_old]
  [<d08ee228>]driver+0x28/0x80 [pdc202xx_old]
  [<c019a20f>]do_driver_attach+0x37/0x44
  [<d08ee228>]driver+0x28/0x80 [pdc202xx_old]
  [<c019ad8f>]bus_for_each_dev+0x8f/0x118
  [<d08ee228>]driver+0x28/0x80 [pdc202xx_old]
  [<d08ee23c>]driver+0x3c/0x80 [pdc202xx_old]
  [<d08ee228>]driver+0x28/0x80 [pdc202xx_old]
  [<d08eb06d>]pdc202xx_info+0xd/0xa88 [pdc202xx_old]
  [<c019a22f>]driver_attach+0x13/0x18
  [<d08ee228>]driver+0x28/0x80 [pdc202xx_old]
  [<c019a1d8>]do_driver_attach+0x0/0x44
  [<c019b2e1>]driver_register+0x99/0xa8
  [<d08ee228>]driver+0x28/0x80 [pdc202xx_old]
  [<d08ee228>]driver+0x28/0x80 [pdc202xx_old]
  [<d08ee200>]driver+0x0/0x80 [pdc202xx_old]
  [<c0198e6e>]pci_register_driver+0x36/0x44
  [<d08ee228>]driver+0x28/0x80 [pdc202xx_old]
  [<c01ca95d>]ide_pci_register_driver+0x15/0x48
  [<d08ee200>]driver+0x0/0x80 [pdc202xx_old]
  [<d08ecbae>]pdc202xx_ide_init+0xa/0x10 [pdc202xx_old]
  [<d08ee200>]driver+0x0/0x80 [pdc202xx_old]
  [<c011aaad>]sys_init_module+0x525/0x604
  [<d08eb060>]pdc202xx_info+0x0/0xa88 [pdc202xx_old]
  [<c01072b7>]syscall_call+0x7/0xb

ide2 at 0xd400-0xd407,0xd802 on irq 16
hde: host protected area => 1
hde: 25434228 sectors (13022 MB) w/512KiB Cache, CHS=25232/16/63, UDMA(66)
  /dev/ide/host2/bus0/target0/lun0: p1 p2 p3

The hardware:
   2x PIII-450MHz
   256MB RAM
   440BX chipset - PIIX4 IDE
   Promise Ultra66 IDE controller
   20GB WD IDE at /dev/hda
   40GB IBM IDE at /dev/hdb
   IDE CDROM at /dev/hdc
   13GB Seagate IDE /dev/hde

Kernel config available on request.


Phil
phil@tux.obix.com

