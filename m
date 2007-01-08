Return-Path: <linux-kernel-owner+w=401wt.eu-S1422693AbXAHSNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422693AbXAHSNI (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 13:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422701AbXAHSNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 13:13:08 -0500
Received: from moutng.kundenserver.de ([212.227.126.179]:59253 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422693AbXAHSNF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 13:13:05 -0500
From: Torsten Kaiser <kernel@bardioc.dyndns.org>
To: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [BUG 2.6.20-rc3-mm1] raid1 mount blocks for ever
Date: Mon, 8 Jan 2007 19:11:45 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, Fengguang Wu <fengguang.wu@gmail.com>,
       linux-kernel@vger.kernel.org
References: <368051775.16914@ustc.edu.cn> <200701061130.07467.kernel@bardioc.dyndns.org> <20070108085245.GR11203@kernel.dk>
In-Reply-To: <20070108085245.GR11203@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701081911.46495.kernel@bardioc.dyndns.org>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:22445e7a21522a805aae47a273aa1695
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 January 2007 09:52, Jens Axboe wrote:
> --- a/block/ll_rw_blk.c
> +++ b/block/ll_rw_blk.c
> @@ -1542,7 +1542,7 @@ static inline void
> -	blk_unplug_current();
> +	blk_replug_current_nested();

Does not help. Dmesg follows:
[    0.000000] Linux version 2.6.20-rc3-mm1 (root@ariolc) (gcc version 
4.1.1 (Gentoo 4.1.1-r3)) #4 Mon Jan 8 18:23:37 CET 2007
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] sanitize start
[    0.000000] sanitize end
[    0.000000] copy_e820_map() start: 0000000000000000 size: 
000000000009fc00 end: 000000000009fc00 type: 1
[    0.000000] copy_e820_map() type is E820_RAM
[    0.000000] copy_e820_map() start: 000000000009fc00 size: 
0000000000000400 end: 00000000000a0000 type: 2
[    0.000000] copy_e820_map() start: 00000000000f0000 size: 
0000000000010000 end: 0000000000100000 type: 2
[    0.000000] copy_e820_map() start: 0000000000100000 size: 
000000001fef0000 end: 000000001fff0000 type: 1
[    0.000000] copy_e820_map() type is E820_RAM
[    0.000000] copy_e820_map() start: 000000001fff0000 size: 
0000000000003000 end: 000000001fff3000 type: 4
[    0.000000] copy_e820_map() start: 000000001fff3000 size: 
000000000000d000 end: 0000000020000000 type: 3
[    0.000000] copy_e820_map() start: 00000000ffff0000 size: 
0000000000010000 end: 0000000100000000 type: 2
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
[    0.000000]  BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
[    0.000000] 511MB LOWMEM available.
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   Normal       4096 ->   131056
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->   131056
[    0.000000] DMI 2.3 present.
[    0.000000] ACPI: PM-Timer IO Port: 0x4008
[    0.000000] Allocating PCI resources starting at 30000000 (gap: 
20000000:dfff0000)
[    0.000000] Detected 1002.314 MHz processor.
[   26.865802] Built 1 zonelists.  Total pages: 130033
[   26.865807] Kernel command line: root=/dev/sdb6 console=ttyS0,38400 
console=tty1 lapic rootflags=nobarrier
[   26.866203] Local APIC disabled by BIOS -- reenabling.
[   26.866209] Found and enabled local APIC!
[   26.866223] Enabling fast FPU save and restore... done.
[   26.866246] Initializing CPU#0
[   26.866401] PID hash table entries: 2048 (order: 11, 8192 bytes)
[   26.867677] Console: colour VGA+ 80x25
[   27.543779] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., 
Ingo Molnar
[   27.567001] ... MAX_LOCKDEP_SUBCLASSES:    8
[   27.579834] ... MAX_LOCK_DEPTH:          30
[   27.592407] ... MAX_LOCKDEP_KEYS:        2048
[   27.605501] ... CLASSHASH_SIZE:           1024
[   27.618853] ... MAX_LOCKDEP_ENTRIES:     8192
[   27.631946] ... MAX_LOCKDEP_CHAINS:      16384
[   27.645300] ... CHAINHASH_SIZE:          8192
[   27.658392]  memory used by lock dependency info: 1096 kB
[   27.674603]  per task-struct memory footprint: 1200 bytes
[   27.691602] Dentry cache hash table entries: 65536 (order: 6, 262144 
bytes)
[   27.713148] Inode-cache hash table entries: 32768 (order: 5, 131072 
bytes)
[   27.769004] Memory: 511896k/524224k available (3204k kernel code, 11796k 
reserved, 1352k data, 204k init, 0k highmem)
[   27.800844] virtual kernel memory layout:
[   27.800846]     fixmap  : 0xfffb7000 - 0xfffff000   ( 288 kB)
[   27.800849]     vmalloc : 0xe0800000 - 0xfffb5000   ( 503 MB)
[   27.800852]     lowmem  : 0xc0000000 - 0xdfff0000   ( 511 MB)
[   27.800855]       .init : 0xc0576000 - 0xc05a9000   ( 204 kB)
[   27.800857]       .data : 0xc04211a0 - 0xc05732ac   (1352 kB)
[   27.800860]       .text : 0xc0100000 - 0xc04211a0   (3204 kB)
[   27.916411] Checking if this processor honours the WP bit even in 
supervisor mode... Ok.
[   27.941129] Clock event device pit configured with caps set: 07
[   28.101036] Calibrating delay using timer specific routine.. 2006.70 
BogoMIPS (lpj=10033529)
[   28.126627] Security Framework v1.0.0 initialized
[   28.140835] Mount-cache hash table entries: 512
[   28.154789]
[   28.154792] =====================================
[   28.173440] [ BUG: bad unlock balance detected! ]
[   28.187571] -------------------------------------
[   28.201705] swapper/0 is trying to release lock (inode_lock) at:
[   28.219863] [<c0184738>] generic_sync_sb_inodes+0xa8/0x2d0
[   28.236411] but there are no more locks to release!
[   28.251063]
[   28.251064] other info that might help us debug this:
[   28.270756] 1 lock held by swapper/0:
[   28.281770]  #0:  (&type->s_umount_key){--..}, at: [<c0168fcc>] 
sget+0x1cc/0x370
[   28.304344]
[   28.304346] stack backtrace:
[   28.317492]  [<c0138274>] print_unlock_inbalance_bug+0x104/0x120
[   28.335598]  [<c0184738>] generic_sync_sb_inodes+0xa8/0x2d0
[   28.352405]  [<c013942a>] trace_hardirqs_on+0xba/0x160
[   28.367915]  [<c012d9a8>] __kernel_text_address+0x18/0x30
[   28.384203]  [<c0104f66>] dump_trace+0x56/0xa0
[   28.397634]  [<c010a4bc>] save_stack_trace+0x1c/0x40
[   28.412624]  [<c01378b0>] save_trace+0x40/0xa0
[   28.426055]  [<c013795b>] add_lock_to_list+0x4b/0xc0
[   28.441044]  [<c0184738>] generic_sync_sb_inodes+0xa8/0x2d0
[   28.457852]  [<c0184738>] generic_sync_sb_inodes+0xa8/0x2d0
[   28.474660]  [<c013abee>] lock_release+0x8e/0x180
[   28.488870]  [<c041fdb4>] _spin_unlock+0x14/0x20
[   28.502821]  [<c0184738>] generic_sync_sb_inodes+0xa8/0x2d0
[   28.519629]  [<c0184a03>] sync_inodes_sb+0x83/0xa0
[   28.534100]  [<c016917a>] __fsync_super+0xa/0x70
[   28.548050]  [<c01691e8>] fsync_super+0x8/0x20
[   28.561480]  [<c016922c>] do_remount_sb+0x2c/0x120
[   28.575949]  [<c01697f1>] get_sb_single+0x61/0xd0
[   28.590159]  [<c01a5540>] sysfs_fill_super+0x0/0xb0
[   28.604890]  [<c0169696>] vfs_kern_mount+0xb6/0x130
[   28.619619]  [<c01a5540>] sysfs_fill_super+0x0/0xb0
[   28.634349]  [<c0169723>] kern_mount+0x13/0x20
[   28.647780]  [<c058a22f>] sysfs_init+0x6f/0xb0
[   28.661211]  [<c05897b0>] mnt_init+0xc0/0x200
[   28.674382]  [<c0589387>] vfs_caches_init+0xd7/0x170
[   28.689372]  [<c0576a79>] start_kernel+0x1c9/0x380
[   28.703842]  [<c05764b0>] unknown_bootoption+0x0/0x260
[   28.719350]  =======================
[   28.730336] CPU: After generic identify, caps: 0183fbff c1c7fbff 
00000000 00000000 00000000 00000000 00000000
[   28.760723] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 
bytes/line)
[   28.782152] CPU: L2 Cache: 256K (64 bytes/line)
[   28.795765] CPU: After all inits, caps: 0183fbff c1c7fbff 00000000 
00000420 00000000 00000000 00000000
[   28.824358] Intel machine check architecture supported.
[   28.840059] Intel machine check reporting enabled on CPU#0.
[   28.856809] CPU: AMD Athlon(tm) Processor stepping 02
[   28.872195] Checking 'hlt' instruction... OK.
[   28.921952] ACPI: Core revision 20060707
[   28.943079] ACPI: setting ELCR to 0800 (from 0e20)
[   29.220314] Clock event device pit new caps set: 03
[   29.234973] Clock event device lapic configured with caps set: 04
[   29.253277] spurious 8259A interrupt: IRQ7.
[   29.375572] NET: Registered protocol family 16
[   29.389225] ACPI: bus type pci registered
[   29.434373] PCI: PCI BIOS revision 2.10 entry at 0xfb380, last bus=1
[   29.453460] PCI: Using configuration type 1
[   29.466033] Setting up standard PCI resources
[   29.504063] ACPI: Interpreter enabled
[   29.515113] ACPI: Using PIC for interrupt routing
[   29.538752] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   29.553487] ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
[   29.570517] Disabling VIA memory write queue (PCI ID 0305, rev 03): [55] 
81 & 1f -> 01
[   29.594653] PCI quirk: region 4000-40ff claimed by vt82c586 ACPI
[   29.613374] PCI quirk: region 6000-607f claimed by vt82c686 HW-mon
[   29.631984] PCI quirk: region 5000-500f claimed by vt82c686 SMB
[   29.650263] Boot video device is 0000:01:00.0
[   29.663437] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   29.715800] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 
14 15)
[   29.738915] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *10 11 12 
14 15)
[   29.761991] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 *5 6 7 10 11 12 
14 15)
[   29.785084] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 11 12 
14 15) *9
[   29.808583] Linux Plug and Play Support v0.97 (c) Adam Belay
[   29.825613] pnp: PnP ACPI init
[   29.834993] pnp: ACPI device : hid PNP0C01
[   29.847915] pnp: ACPI device : hid PNP0A03
[   29.860834] pnp: ACPI device : hid PNP0C02
[   29.873297] pnp: ACPI device : hid PNP0200
[   29.885719] pnp: ACPI device : hid PNP0B00
[   29.898143] pnp: ACPI device : hid PNP0800
[   29.910597] pnp: ACPI device : hid PNP0C04
[   29.923364] pnp: ACPI device : hid PNP0700
[   29.936220] pnp: ACPI device : hid PNP0501
[   29.949518] pnp: ACPI device : hid PNP0501
[   29.963065] pnp: ACPI device : hid PNP0400
[   29.976425] pnp: ACPI device : hid PNP0F13
[   29.988956] pnp: ACPI device : hid PNP0303
[   30.001387] pnp: PnP ACPI: found 13 devices
[   30.014097] Generic PHY: Registered new driver
[   30.027775] SCSI subsystem initialized
[   30.039143] libata version 2.00 loaded.
[   30.050884] usbcore: registered new interface driver usbfs
[   30.067443] usbcore: registered new interface driver hub
[   30.083529] usbcore: registered new device driver usb
[   30.098913] PCI: Using ACPI for IRQ routing
[   30.111510] PCI: If a device doesn't work, try "pci=routeirq".  If it 
helps, post a report
[   30.167247] pnp: the driver 'system' has been registered
[   30.183306] pnp: match found with the PnP device '00:00' and the 
driver 'system'
[   30.205530] pnp: match found with the PnP device '00:02' and the 
driver 'system'
[   30.228592] ieee1394: Initialized config rom entry `ip1394'
[   30.245662] PCI: Bridge: 0000:00:01.0
[   30.256705]   IO window: disabled.
[   30.266963]   MEM window: dc000000-ddffffff
[   30.279562]   PREFETCH window: d0000000-d7ffffff
[   30.293484] PCI: Setting latency timer of device 0000:00:01.0 to 64
[   30.312368] NET: Registered protocol family 2
[   30.419670] IP route cache hash table entries: 4096 (order: 2, 16384 
bytes)
[   30.440856] TCP established hash table entries: 16384 (order: 7, 655360 
bytes)
[   30.466123] TCP bind hash table entries: 8192 (order: 6, 360448 bytes)
[   30.487651] TCP: Hash tables configured (established 16384 bind 8192)
[   30.507010] TCP reno registered
[   30.541300] Total HugeTLB memory allocated, 0
[   30.554592] VFS: Disk quotas dquot_6.5.1
[   30.566462] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   30.586279] SGI XFS with ACLs, security attributes, no debug enabled
[   30.605606] SGI XFS Quota Management subsystem
[   30.619010] io scheduler noop registered
[   30.630911] io scheduler cfq registered (default)
[   30.645228] PCI: Disabling Via external APIC routing
[   30.660182] pci 0000:00:07.2: uhci_check_and_reset_hc: legsup = 0x2000
[   30.679772] pci 0000:00:07.2: Performing full reset
[   30.694439] pci 0000:00:07.3: uhci_check_and_reset_hc: legsup = 0x2000
[   30.714046] pci 0000:00:07.3: Performing full reset
[   30.729222] ACPI: CPU0 (power states: C1[C1] C2[C2])
[   30.744396] ACPI: Processor [CPU0] (supports 2 throttling states)
[   30.879757] Real Time Clock Driver v1.12ac
[   30.892497] Non-volatile memory driver v1.2
[   30.905198] Linux agpgart interface v0.101 (c) Dave Jones
[   30.921627] agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
[   30.946578] agpgart: AGP aperture is 64M @ 0xd8000000
[   30.961937] Serial: 8250/16550 driver $Revision: 1.90 $ 1 ports, IRQ 
sharing disabled
[   30.985769] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   31.004434] pnp: the driver 'serial' has been registered
[   31.020688] pnp: match found with the PnP device '00:08' and the 
driver 'serial'
[   31.043325] 00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   31.060502] pnp: match found with the PnP device '00:09' and the 
driver 'serial'
[   31.083212] pnp: Device 00:09 disabled.
[   31.095027] parport_pc: VIA 686A/8231 detected
[   31.108403] parport_pc: probing current configuration
[   31.123616] parport_pc: Current parallel port base: 0x378
[   31.139870] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]
[   31.239036] parport_pc: VIA parallel port: io=0x378, irq=7
[   31.255908] Floppy drive(s): fd0 is 1.44M
[   31.282607] FDC 0 is a post-1991 82077
[   31.295077] fealnx.c:v2.52 Sep-11-2006
[   31.307212] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
[   31.324489] PCI: setting IRQ 11 as level-triggered
[   31.338907] ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNKA] -> GSI 11 
(level, low) -> IRQ 11
[   31.365432] eth0: 100/10M Ethernet PCI Adapter at 0001ec00, 
00:02:2a:c0:86:2a, IRQ 11.
[   31.389969] Linux video capture interface: v2.00
[   31.403875] bttv: driver version 0.9.16 loaded
[   31.417260] bttv: using 8 buffers with 2080k (520 pages) each for 
capture
[   31.437767] bttv: Bt8xx card found (0).
[   31.450045] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
[   31.467312] PCI: setting IRQ 10 as level-triggered
[   31.481710] ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKB] -> GSI 10 
(level, low) -> IRQ 10
[   31.507986] bttv0: Bt878 (rev 17) at 0000:00:09.0, irq: 10, latency: 32, 
mmio: 0xdf001000
[   31.532663] bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID 
is 0070:13eb
[   31.556181] bttv0: using: Hauppauge (bt878) [card=10,autodetected]
[   31.574780] bttv0: gpio: en=00000000, out=00000000 in=00ffffdb [init]
[   31.596633] bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
[   31.644814] tveeprom 0-0050: Hauppauge model 61344, rev D421, serial# 
3902813
[   31.666259] tveeprom 0-0050: tuner model is Philips FM1216 (idx 21, type 
5)
[   31.687171] tveeprom 0-0050: TV standards PAL(B/G) (eeprom 0x04)
[   31.705226] tveeprom 0-0050: audio processor is MSP3415 (idx 6)
[   31.723019] tveeprom 0-0050: has radio
[   31.734286] bttv0: Hauppauge eeprom indicates model#61344
[   31.750506] bttv0: using tuner=5
[   31.760289] bttv0: registered device video0
[   31.772959] bttv0: registered device vbi0
[   31.785091] bttv0: registered device radio0
[   31.797703] bttv0: PLL: 28636363 => 35468950 .. ok
[   31.851224] input: i2c IR (Hauppauge) as /class/input/input0
[   31.868249] ir-kbd-i2c: i2c IR (Hauppauge) detected at i2c-0/0-0018/ir0 
[bt878 #0 [sw]]
[   31.899200] msp3400 0-0040: MSP3415D-B3 found @ 0x80 (bt878 #0 [sw])
[   31.918299] msp3400 0-0040: MSP3415D-B3 supports nicam, mode is 
autodetect
[   31.943906] tuner 0-0061: chip found @ 0xc2 (bt878 #0 [sw])
[   31.960744] tuner 0-0061: type set to 5 (Philips PAL_BG (FI1216 and 
compatibles))
[   31.983219] tuner 0-0061: type set to 5 (Philips PAL_BG (FI1216 and 
compatibles))
[   32.016366] pata_via 0000:00:07.1: version 0.2.0
[   32.030449] ata1: PATA max UDMA/66 cmd 0x1F0 ctl 0x3F6 bmdma 0xD000 irq 
14
[   32.051711] ata2: PATA max UDMA/66 cmd 0x170 ctl 0x376 bmdma 0xD008 irq 
15
[   32.072398] scsi0 : pata_via
[   32.259217] ata1.00: ATA-6, max UDMA/100, 39865392 sectors: LBA
[   32.277266] ata1.00: ata1: dev 0 multi count 16
[   32.308574] ata1.01: ATA-7, max UDMA/133, 490234752 sectors: LBA48
[   32.327402] ata1.01: ata1: dev 1 multi count 16
[   32.358529] ata1.00: configured for UDMA/66
[   32.408493] ata1.01: configured for UDMA/66
[   32.421091] scsi1 : pata_via
[   32.768278] ata2.00: ATAPI, max MWDMA2
[   32.958189] ata2.01: ATAPI, max MWDMA2
[   33.168005] ata2.00: configured for MWDMA2
[   33.357935] ata2.01: configured for MWDMA2
[   33.370512] scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG SV2042H  
PK10 PQ: 0 ANSI: 5
[   33.395582] SCSI device sda: 39865392 512-byte hdwr sectors (20411 MB)
[   33.415233] sda: Write Protect is off
[   33.426270] sda: Mode Sense: 00 3a 00 00
[   33.438126] SCSI device sda: write cache: enabled, read cache: enabled, 
doesn't support DPO or FUA
[   33.465128] SCSI device sda: 39865392 512-byte hdwr sectors (20411 MB)
[   33.484765] sda: Write Protect is off
[   33.495788] sda: Mode Sense: 00 3a 00 00
[   33.507640] SCSI device sda: write cache: enabled, read cache: enabled, 
doesn't support DPO or FUA
[   33.534514]  sda: sda1 sda2 < sda5 >
[   33.566247] sd 0:0:0:0: Attached scsi disk sda
[   33.579876] scsi 0:0:1:0: Direct-Access     ATA      Maxtor 6L250R0   
BAH4 PQ: 0 ANSI: 5
[   33.604355] SCSI device sdb: 490234752 512-byte hdwr sectors (251000 MB)
[   33.624516] sdb: Write Protect is off
[   33.635552] sdb: Mode Sense: 00 3a 00 00
[   33.647412] SCSI device sdb: write cache: enabled, read cache: enabled, 
doesn't support DPO or FUA
[   33.674415] SCSI device sdb: 490234752 512-byte hdwr sectors (251000 MB)
[   33.694566] sdb: Write Protect is off
[   33.705589] sdb: Mode Sense: 00 3a 00 00
[   33.717973] SCSI device sdb: write cache: enabled, read cache: enabled, 
doesn't support DPO or FUA
[   33.744860]  sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 >
[   33.806173] sd 0:0:1:0: Attached scsi disk sdb
[   33.820052] scsi 1:0:0:0: CD-ROM            SAMSUNG  DVD-ROM SD-612S  
SS06 PQ: 0 ANSI: 5
[   33.845084] scsi 1:0:1:0: CD-ROM            SAMSUNG  CD-R/RW SW-208B  
BS04 PQ: 0 ANSI: 5
[   33.870744] usbmon: debugfs is not available
[   33.883591] ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96
[   33.901728] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller 
(OHCI) Driver
[   33.924192] ohci_hcd: block sizes: ed 64 td 64
[   33.937634] USB Universal Host Controller Interface driver v3.0
[   33.956440] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
[   33.973722] ACPI: PCI Interrupt 0000:00:07.2[D] -> Link [LNKD] -> GSI 10 
(level, low) -> IRQ 10
[   34.000036] uhci_hcd 0000:00:07.2: UHCI Host Controller
[   34.015855] drivers/usb/core/inode.c: creating file 'devices'
[   34.033135] drivers/usb/core/inode.c: creating file '001'
[   34.049370] uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus 
number 1
[   34.071576] uhci_hcd 0000:00:07.2: detected 2 ports
[   34.086247] uhci_hcd 0000:00:07.2: uhci_check_and_reset_hc: cmd = 0x0000
[   34.106383] uhci_hcd 0000:00:07.2: Performing full reset
[   34.122381] uhci_hcd 0000:00:07.2: irq 10, io base 0x0000d400
[   34.139755] usb usb1: default language 0x0409
[   34.152864] usb usb1: new device found, idVendor=0000, idProduct=0000
[   34.172213] usb usb1: new device strings: Mfr=3, Product=2, 
SerialNumber=1
[   34.192864] usb usb1: Product: UHCI Host Controller
[   34.207542] usb usb1: Manufacturer: Linux 2.6.20-rc3-mm1 uhci_hcd
[   34.225850] usb usb1: SerialNumber: 0000:00:07.2
[   34.239776] usb usb1: uevent
[   34.249063] usb usb1: usb_probe_device
[   34.260535] usb usb1: configuration #1 chosen from 1 choice
[   34.277305] usb usb1: adding 1-0:1.0 (config #1, interface 0)
[   34.294598] usb 1-0:1.0: uevent
[   34.304139] hub 1-0:1.0: usb_probe_interface
[   34.317006] hub 1-0:1.0: usb_probe_interface - got id
[   34.332180] hub 1-0:1.0: USB hub found
[   34.343481] hub 1-0:1.0: 2 ports detected
[   34.355550] hub 1-0:1.0: standalone hub
[   34.367104] hub 1-0:1.0: no power switching (usb 1.0)
[   34.382291] hub 1-0:1.0: individual port over-current protection
[   34.400331] hub 1-0:1.0: power on to power good time: 2ms
[   34.416564] hub 1-0:1.0: local power source is good
[   34.431244] hub 1-0:1.0: trying to enable port power on non-switchable 
hub
[   34.556912] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[   34.573502] drivers/usb/core/inode.c: creating file '001'
[   34.589802] ACPI: PCI Interrupt 0000:00:07.3[D] -> Link [LNKD] -> GSI 10 
(level, low) -> IRQ 10
[   34.616094] uhci_hcd 0000:00:07.3: UHCI Host Controller
[   34.631847] uhci_hcd 0000:00:07.2: port 1 portsc 018a,00
[   34.647841] hub 1-0:1.0: port 1, status 0300, change 0003, 1.5 Mb/s
[   34.666699] drivers/usb/core/inode.c: creating file '002'
[   34.682944] uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus 
number 2
[   34.705169] uhci_hcd 0000:00:07.3: detected 2 ports
[   34.719838] uhci_hcd 0000:00:07.3: uhci_check_and_reset_hc: cmd = 0x0000
[   34.739963] uhci_hcd 0000:00:07.3: Performing full reset
[   34.755927] uhci_hcd 0000:00:07.3: irq 10, io base 0x0000d800
[   34.773289] usb usb2: default language 0x0409
[   34.786405] usb usb2: new device found, idVendor=0000, idProduct=0000
[   34.805748] usb usb2: new device strings: Mfr=3, Product=2, 
SerialNumber=1
[   34.826401] usb usb2: Product: UHCI Host Controller
[   34.841077] usb usb2: Manufacturer: Linux 2.6.20-rc3-mm1 uhci_hcd
[   34.859383] usb usb2: SerialNumber: 0000:00:07.3
[   34.873284] usb usb2: uevent
[   34.882575] usb usb2: usb_probe_device
[   34.893988] usb usb2: configuration #1 chosen from 1 choice
[   34.910742] usb usb2: adding 2-0:1.0 (config #1, interface 0)
[   34.928037] usb 2-0:1.0: uevent
[   34.937570] hub 2-0:1.0: usb_probe_interface
[   34.950416] hub 2-0:1.0: usb_probe_interface - got id
[   34.965587] hub 2-0:1.0: USB hub found
[   34.976891] hub 2-0:1.0: 2 ports detected
[   34.988967] hub 2-0:1.0: standalone hub
[   35.000525] hub 2-0:1.0: no power switching (usb 1.0)
[   35.015698] hub 2-0:1.0: individual port over-current protection
[   35.033734] hub 2-0:1.0: power on to power good time: 2ms
[   35.049983] hub 2-0:1.0: local power source is good
[   35.064640] hub 2-0:1.0: trying to enable port power on non-switchable 
hub
[   35.116494] hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms 
status 0x300
[   35.138708] uhci_hcd 0000:00:07.2: port 2 portsc 018a,00
[   35.154666] hub 1-0:1.0: port 2, status 0300, change 0003, 1.5 Mb/s
[   35.206599] drivers/usb/core/inode.c: creating file '001'
[   35.326357] hub 1-0:1.0: debounce: port 2: total 100ms stable 100ms 
status 0x300
[   35.348562] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[   35.365059] hub 2-0:1.0: state 7 ports 2 chg 0000 evt 0006
[   35.381562] uhci_hcd 0000:00:07.3: port 1 portsc 018a,00
[   35.397545] hub 2-0:1.0: port 1, status 0300, change 0003, 1.5 Mb/s
[   35.576194] hub 2-0:1.0: debounce: port 1: total 100ms stable 100ms 
status 0x300
[   35.598396] uhci_hcd 0000:00:07.3: port 2 portsc 018a,00
[   35.614379] hub 2-0:1.0: port 2, status 0300, change 0003, 1.5 Mb/s
[   35.786058] hub 2-0:1.0: debounce: port 2: total 100ms stable 100ms 
status 0x300
[   35.808274] hub 2-0:1.0: state 7 ports 2 chg 0000 evt 0000
[   35.824778] usbcore: registered new interface driver libusual
[   35.842057] pnp: the driver 'i8042 kbd' has been registered
[   35.858917] pnp: match found with the PnP device '00:0c' and the 
driver 'i8042 kbd'
[   35.881912] pnp: the driver 'i8042 aux' has been registered
[   35.898733] pnp: match found with the PnP device '00:0b' and the 
driver 'i8042 aux'
[   35.921737] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 
0x60,0x64 irq 1,12
[   35.945350] serio: i8042 KBD port at 0x60,0x64 irq 1
[   35.960290] serio: i8042 AUX port at 0x60,0x64 irq 12
[   35.975850] mice: PS/2 mouse device common for all mice
[   36.010751] input: AT Translated Set 2 keyboard as /class/input/input1
[   36.034199] input: PC Speaker as /class/input/input2
[   36.186876] input: GenPS/2 Genius Mouse as /class/input/input3
[   36.206971] i2c /dev entries driver
[   36.445627] usb usb1: suspend_rh (auto-stop)
[   36.458476] PM-Timer running at invalid rate: 142% of normal - aborting.
[   36.478648] Advanced Linux Sound Architecture Driver Version 1.0.14rc1 
(Wed Dec 20 08:11:48 2006 UTC).
[   36.507819] ACPI: PCI Interrupt 0000:00:09.1[A] -> Link [LNKB] -> GSI 10 
(level, low) -> IRQ 10
[   36.537183] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
[   36.554233] PCI: setting IRQ 5 as level-triggered
[   36.568388] ACPI: PCI Interrupt 0000:00:07.5[C] -> Link [LNKC] -> GSI 5 
(level, low) -> IRQ 5
[   36.594308] PCI: Setting latency timer of device 0000:00:07.5 to 64
[   36.935312] usb usb2: suspend_rh (auto-stop)
[   37.127203] ALSA device list:
[   37.136168]   #0: VIA 82C686A/B rev20 with STAC9721,23 at 0xdc00, irq 5
[   37.156033]   #1: Brooktree Bt878 at 0xdf002000, irq 10
[   37.171882] NET: Registered protocol family 1
[   37.185100] Testing NMI watchdog ... OK.
[   37.297665] Using IPI Shortcut mode
[   37.308285] ACPI: (supports<6>Time: tsc clocksource has been installed.
[   37.328255] Clock event device lapic disabled
[   37.341366] Clock event device pit configured with caps set: 08
[   37.359174] Switched to high resolution mode on CPU 0
[   37.374369] Time: pit clocksource has been installed.
[   37.394488]  S0 S1 S4 S5)
[   37.414706] XFS mounting filesystem sdb6
[   37.567380] Ending clean XFS mount for filesystem: sdb6
[   37.583482] VFS: Mounted root (xfs filesystem) readonly.
[    8.380000] Freeing unused kernel memory: 204k freed
[ 6575.070000] BUG: NMI Watchdog detected LOCKUP on CPU0, eip c0109cde, 
registers:
[ 6575.070000] Modules linked in:
[ 6575.070000] CPU:    0
[ 6575.070000] EIP:    0060:[<c0109cde>]    Not tainted VLI
[ 6575.070000] EFLAGS: 00000046   (2.6.20-rc3-mm1 #4)
[ 6575.070000] EIP is at pit_read+0x1e/0xa0
[ 6575.070000] eax: 00000079   ebx: 0004fb1c   ecx: 00000000   edx: 
00000082
[ 6575.070000] esi: 00099333   edi: e121b846   ebp: 0004fb1c   esp: 
c0575ec0
[ 6575.070000] ds: 007b   es: 007b   fs: 00d8  gs: 0000  ss: 0068
[ 6575.070000] Process swapper (pid: 0, ti=c0574000 task=c0527480 
task.ti=c0574000)
[ 6575.070000] Stack: 0004fb1c c0575ef0 c01244c1 c0575ef0 0004fb1c c0575ef0 
e121b846 000005fa
[ 6575.070000]        c0133081 00000000 c0575f24 c01330c6 45a2ac72 0a92f42e 
c052f130 80a5e194
[ 6575.070000]        c0133947 00000000 e17def7a 000005fa e121b846 000005fa 
c052f0e4 00000000
[ 6575.070000] Call Trace:
[ 6575.070000]  [<c01244c1>] getnstimeofday+0x31/0xc0
[ 6575.070000]  [<c0133081>] ktime_get_ts+0x11/0x40
[ 6575.070000]  [<c01330c6>] ktime_get+0x16/0x40
[ 6575.070000]  [<c0133947>] hrtimer_interrupt+0x37/0x1e0
[ 6575.070000]  [<c010744f>] timer_interrupt+0x2f/0x40
[ 6575.070000]  [<c0143c60>] handle_IRQ_event+0x20/0x50
[ 6575.070000]  [<c0145391>] handle_level_irq+0x81/0x110
[ 6575.070000]  [<c01067f6>] do_IRQ+0x46/0x80
[ 6575.070000]  [<c0104a96>] common_interrupt+0x2e/0x34
[ 6575.070000]  [<c0136080>] handle_noop+0x0/0x10
[ 6575.070000]  [<c028aecf>] acpi_processor_idle+0x1db/0x384
[ 6575.070000]  [<c028acf4>] acpi_processor_idle+0x0/0x384
[ 6575.070000]  [<c0102469>] cpu_idle+0x49/0x80
[ 6575.070000]  [<c0576b85>] start_kernel+0x2d5/0x380
[ 6575.070000]  [<c05764b0>] unknown_bootoption+0x0/0x260
[ 6575.070000]  =======================
[ 6575.070000] Code: e0 b7 52 c0 e9 34 66 31 00 8d 74 26 00 56 b8 e0 b7 52 
c0 53 e8 34 65 31 00 8b 35 20 e0 52 c0 89 c2 31 c0 e6 43 e6 80 e4 40 e6 80 
<0f> b6 d8 e4 40 e6 80 0f b6 c0 c1 e0 08 09 c3 8
[ 6575.070000]  [ 6575.070000]

Capslock and Scrolllock are blinking again, Sys+RQ still works.

After a soft-reboot the NMI trace changed to:
[   28.964111] XFS mounting filesystem sdb6
[   34.856030] BUG: NMI Watchdog detected LOCKUP on CPU0, eip c0109cdc, 
registers:
[   34.878060] Modules linked in:
[   34.887340] CPU:    0
[   34.887342] EIP:    0060:[<c0109cdc>]    Not tainted VLI
[   34.887344] EFLAGS: 00000046   (2.6.20-rc3-mm1 #4)
[   34.924555] EIP is at pit_read+0x1c/0xa0
[   34.936356] eax: 000000a9   ebx: 0005083a   ecx: 00000000   edx: 
00000086
[   34.956723] esi: 00092abe   edi: 9e741e83   ebp: 0005083a   esp: 
dff83a08
[   34.977091] ds: 007b   es: 007b   fs: 00d8  gs: 0000  ss: 0068
[   34.994600] Process swapper (pid: 1, ti=dff82000 task=dff81510 
task.ti=dff82000)
[   35.016264] Stack: 0005083a dff83a38 c01244c1 dff83a38 0005083a dff83a38 
9e741e83 000005bc
[   35.042007]        c0133081 00000000 dff83a6c c01330c6 45a2ac47 2d801ce0 
c052f130 80a5e194
[   35.067726]        c0133947 00000000 9e9d366d 000005bc 9e741e83 000005bc 
c052f0e4 00000000
[   35.093445] Call Trace:
[   35.101424]  [<c01244c1>] getnstimeofday+0x31/0xc0
[   35.115917]  [<c0133081>] ktime_get_ts+0x11/0x40
[   35.129869]  [<c01330c6>] ktime_get+0x16/0x40
[   35.143039]  [<c0133947>] hrtimer_interrupt+0x37/0x1e0
[   35.158550]  [<c010744f>] timer_interrupt+0x2f/0x40
[   35.173304]  [<c0143c60>] handle_IRQ_event+0x20/0x50
[   35.188294]  [<c0145391>] handle_level_irq+0x81/0x110
[   35.203542]  [<c01067f6>] do_IRQ+0x46/0x80
[   35.215933]  [<c011c4b1>] vprintk+0x201/0x2f0
[   35.229107]  [<c0104a96>] common_interrupt+0x2e/0x34
[   35.244096]  [<c023a88d>] cmn_err+0x9d/0xb0
[   35.256747]  [<c0420337>] _spin_unlock_irqrestore+0x47/0x60
[   35.273555]  [<c023a88d>] cmn_err+0x9d/0xb0
[   35.286207]  [<c0218218>] xfs_log_mount+0x48/0x5d0
[   35.300677]  [<c021fbbd>] xfs_mountfs+0xb1d/0xfa0
[   35.314886]  [<c041fe89>] _spin_lock+0x29/0x40
[   35.328316]  [<c0231e93>] xfs_setsize_buftarg_flags+0x33/0xc0
[   35.345645]  [<c0227391>] xfs_mount+0x641/0x9c0
[   35.359337]  [<c0226d50>] xfs_mount+0x0/0x9c0
[   35.372507]  [<c0239e92>] vfs_mount+0x22/0x30
[   35.385677]  [<c0239cb8>] xfs_fs_fill_super+0x78/0x1e0
[   35.401187]  [<c025cf8f>] snprintf+0x1f/0x30
[   35.414098]  [<c01a2222>] disk_name+0x92/0xc0
[   35.427269]  [<c0169bd4>] get_sb_bdev+0x104/0x140
[   35.441479]  [<c0238ed0>] xfs_fs_get_sb+0x20/0x30
[   35.455690]  [<c0239c40>] xfs_fs_fill_super+0x0/0x1e0
[   35.470938]  [<c0169696>] vfs_kern_mount+0xb6/0x130
[   35.486473]  [<c0169769>] do_kern_mount+0x39/0x60
[   35.500684]  [<c017ec5c>] do_mount+0x42c/0x700
[   35.514114]  [<c041fdb4>] _spin_unlock+0x14/0x20
[   35.528065]  [<c0258646>] _atomic_dec_and_lock+0x16/0x60
[   35.544094]  [<c014bdb1>] get_page_from_freelist+0x1e1/0x380
[   35.561162]  [<c014c27a>] __get_free_pages+0x1a/0x40
[   35.576150]  [<c017d4d0>] copy_mount_options+0x40/0x150
[   35.591920]  [<c017efa2>] sys_mount+0x72/0xb0
[   35.605090]  [<c0576e9e>] mount_block_root+0x8e/0x270
[   35.620340]  [<c0171d57>] sys_mknod+0x27/0x30
[   35.633511]  [<c05770d0>] mount_root+0x50/0x90
[   35.646942]  [<c0577222>] prepare_namespace+0x112/0x150
[   35.662710]  [<c016658f>] sys_access+0x1f/0x30
[   35.676142]  [<c0576842>] init+0x132/0x1a0
[   35.688533]  [<c0576710>] init+0x0/0x1a0
[   35.700406]  [<c0576710>] init+0x0/0x1a0
[   35.712251]  [<c0104c2f>] kernel_thread_helper+0x7/0x18

Next try: hang without the NMI triggering:
[   37.253929] XFS mounting filesystem sdb6
[   37.398376] Ending clean XFS mount for filesystem: sdb6
[   37.414462] VFS: Mounted root (xfs filesystem) readonly.
[    8.390000] Freeing unused kernel memory: 204k freed
-> Hangs here
Part of SysRQ-T:
[    8.880000]
[    8.880000]                          free                        sibling
[    8.880000]   task             PC    stack   pid father child younger 
older
[    8.880000] init          D DFD0D028     0     1      0     2               
(NOTLB)
[    8.880000]        dff83d28 00000082 c170b438 dfd0d028 00000046 00000000 
00000002 00000001
[    8.880000]        0000000a dff81510 114a0c00 00000002 00000000 dff8161c 
c04201c0 dfd5af04
[    8.880000]        c024ec06 00000001 c13f8ea0 dff83d64 dff83d34 c041dd52 
dff83d5c c1401110
[    8.880000] Call Trace:
[    8.880000]  [<c04201c0>] _spin_unlock_irq+0x20/0x30
[    8.880000]  [<c024ec06>] blk_unplug_current+0xc6/0xe0
[    8.880000]  [<c041dd52>] io_schedule+0x42/0x60
[    8.880000]  [<c01470f5>] sleep_on_page+0x5/0x10
[    8.880000]  [<c041dfcc>] __wait_on_bit_lock+0x3c/0x70
[    8.880000]  [<c01470f0>] sleep_on_page+0x0/0x10
[    8.880000]  [<c01470e3>] __lock_page+0x73/0x80
[    8.880000]  [<c012fb20>] wake_bit_function+0x0/0x60
[    8.880000]  [<c014798c>] do_generic_mapping_read+0x26c/0x590
[    8.880000]  [<c0149c8d>] generic_file_aio_read+0xfd/0x220
[    8.880000]  [<c0146df0>] file_read_actor+0x0/0x140
[    8.880000]  [<c02381c3>] xfs_read+0x1c3/0x340
[    8.880000]  [<c023480c>] xfs_file_aio_read+0x6c/0x80
[    8.880000]  [<c0167475>] do_sync_read+0xd5/0x120
[    8.880000]  [<c012fad0>] autoremove_wake_function+0x0/0x50
[    8.880000]  [<c01659ae>] fd_install+0x1e/0x40
[    8.880000]  [<c0167e0c>] vfs_read+0xbc/0x180
[    8.880000]  [<c01673a0>] do_sync_read+0x0/0x120
[    8.880000]  [<c0168271>] sys_read+0x41/0x70
[    8.880000]  [<c01040ac>] syscall_call+0x7/0xb
[    8.880000]  =======================
[    8.880000] xfsbufd       S FFFF8E78     0   887      5           888   
842 (L-TLB)
[    8.880000]        c17e3f70 00000086 c17e3f60 ffff8e78 c042023f 00000000 
00000046 c05d6cc0
[    8.880000]        00000009 c17deb00 abd85bd2 00000008 00000d05 c17dec0c 
c01252f4 00000000
[    8.880000]        00000282 c17e3f80 ffff8e78 dfd940d0 dfd940a0 c041deda 
c041d352 00000000
[    8.880000] Call Trace:
[    8.880000]  [<c042023f>] _spin_lock_irqsave+0x3f/0x50
[    8.880000]  [<c01252f4>] __mod_timer+0x84/0xa0
[    8.880000]  [<c041deda>] schedule_timeout+0x4a/0xc0
[    8.880000]  [<c041d352>] __sched_text_start+0x2e2/0x670
[    8.880000]  [<c0124960>] process_timeout+0x0/0x10
[    8.880000]  [<c0233aa5>] xfsbufd+0x65/0x1b0
[    8.880000]  [<c0233a40>] xfsbufd+0x0/0x1b0
[    8.880000]  [<c012f908>] kthread+0xa8/0xe0
[    8.880000]  [<c012f860>] kthread+0x0/0xe0
[    8.880000]  [<c0104c2f>] kernel_thread_helper+0x7/0x18
[    8.880000]  =======================
[    8.880000] xfssyncd      S FFFF99CF     0   888      5                 
887 (L-TLB)
[    8.880000]        dfdddf68 00000082 dfdddf58 ffff99cf c042023f 00000000 
b610b3ad 00000008
[    8.880000]        00000009 dff16090 b610c307 00000008 00001043 dff1619c 
0000067b 00000000
[    8.880000]        00000292 dfdddf78 ffff99cf c16bc3c0 00000bb8 c041deda 
c04201c0 c0527200
[    8.880000] Call Trace:
[    8.880000]  [<c042023f>] _spin_lock_irqsave+0x3f/0x50
[    8.880000]  [<c041deda>] schedule_timeout+0x4a/0xc0
[    8.880000]  [<c04201c0>] _spin_unlock_irq+0x20/0x30
[    8.880000]  [<c0124960>] process_timeout+0x0/0x10
[    8.880000]  [<c023967d>] xfssyncd+0x4d/0x180
[    8.880000]  [<c0239630>] xfssyncd+0x0/0x180
[    8.880000]  [<c012f908>] kthread+0xa8/0xe0
[    8.880000]  [<c012f860>] kthread+0x0/0xe0
[    8.880000]  [<c0104c2f>] kernel_thread_helper+0x7/0x18
[    8.880000]  =======================
[    8.880000] hotplug       D 00000046     0   890      4           891       
(NOTLB)
[    8.880000]        c162dd28 00000082 00000246 00000046 c140112c c162dd64 
00000002 00000046
[    8.880000]        0000000a dfe18ae0 114a0c00 00000002 00000000 dfe18bec 
c042023f 00000000
[    8.880000]        00000002 00000001 c13f8ea0 c162dd64 c162dd34 c041dd52 
c162dd5c c1401110
[    8.880000] Call Trace:
[    8.880000]  [<c042023f>] _spin_lock_irqsave+0x3f/0x50
[    8.880000]  [<c041dd52>] io_schedule+0x42/0x60
[    8.880000]  [<c01470f5>] sleep_on_page+0x5/0x10
[    8.880000]  [<c041dfcc>] __wait_on_bit_lock+0x3c/0x70
[    8.880000]  [<c01470f0>] sleep_on_page+0x0/0x10
[    8.880000]  [<c01470e3>] __lock_page+0x73/0x80
[    8.880000]  [<c012fb20>] wake_bit_function+0x0/0x60
[    8.880000]  [<c014798c>] do_generic_mapping_read+0x26c/0x590
[    8.880000]  [<c02372f0>] xfs_vn_follow_link+0x0/0x100
[    8.880000]  [<c0149c8d>] generic_file_aio_read+0xfd/0x220
[    8.880000]  [<c0146df0>] file_read_actor+0x0/0x140
[    8.880000]  [<c02381c3>] xfs_read+0x1c3/0x340
[    8.880000]  [<c023480c>] xfs_file_aio_read+0x6c/0x80
[    8.880000]  [<c0167475>] do_sync_read+0xd5/0x120
[    8.880000]  [<c012fad0>] autoremove_wake_function+0x0/0x50
[    8.880000]  [<c01659ae>] fd_install+0x1e/0x40
[    8.880000]  [<c0167e0c>] vfs_read+0xbc/0x180
[    8.880000]  [<c01673a0>] do_sync_read+0x0/0x120
[    8.880000]  [<c0168271>] sys_read+0x41/0x70
[    8.880000]  [<c01040ac>] syscall_call+0x7/0xb
[    8.880000]  =======================
[    8.880000] hotplug       D 00000046     0   891      4                 
890 (NOTLB)
[    8.880000]        c162fd28 00000082 00000246 00000046 c140112c c162fd64 
00000002 00000046
[    8.880000]        00000009 dfe18070 114a0c00 00000002 00000000 dfe1817c 
c042023f 00000000
[    8.880000]        00000002 00000001 c13f8ea0 c162fd64 c162fd34 c041dd52 
c162fd5c c1401110
[    8.880000] Call Trace:
[    8.880000]  [<c042023f>] _spin_lock_irqsave+0x3f/0x50
[    8.880000]  [<c041dd52>] io_schedule+0x42/0x60
[    8.880000]  [<c01470f5>] sleep_on_page+0x5/0x10
[    8.880000]  [<c041dfcc>] __wait_on_bit_lock+0x3c/0x70
[    8.880000]  [<c01470f0>] sleep_on_page+0x0/0x10
[    8.880000]  [<c01470e3>] __lock_page+0x73/0x80
[    8.880000]  [<c012fb20>] wake_bit_function+0x0/0x60
[    8.880000]  [<c014798c>] do_generic_mapping_read+0x26c/0x590
[    8.880000]  [<c02372f0>] xfs_vn_follow_link+0x0/0x100
[    8.880000]  [<c0149c8d>] generic_file_aio_read+0xfd/0x220
[    8.880000]  [<c0146df0>] file_read_actor+0x0/0x140
[    8.880000]  [<c02381c3>] xfs_read+0x1c3/0x340
[    8.880000]  [<c023480c>] xfs_file_aio_read+0x6c/0x80
[    8.880000]  [<c0167475>] do_sync_read+0xd5/0x120
[    8.880000]  [<c012fad0>] autoremove_wake_function+0x0/0x50
[    8.880000]  [<c01659ae>] fd_install+0x1e/0x40
[    8.880000]  [<c0167e0c>] vfs_read+0xbc/0x180
[    8.880000]  [<c01673a0>] do_sync_read+0x0/0x120
[    8.880000]  [<c0168271>] sys_read+0x41/0x70
[    8.880000]  [<c01040ac>] syscall_call+0x7/0xb
[    8.880000]  =======================
[    8.880000]
[    8.880000] Showing all locks held in the system:
[    8.880000]
[    8.880000] =============================================
[    8.880000]

 A try without rootfsflags=nobarrier:
Same hang:
[   36.070931] XFS mounting filesystem sdb6
[   36.207102] Ending clean XFS mount for filesystem: sdb6
[   36.223176] VFS: Mounted root (xfs filesystem) readonly.
[    8.750000] Freeing unused kernel memory: 204k freed
SysRq+T: Again no locks held, but init hangs this time at:
[    9.440000]                          free                        sibling
[    9.440000]   task             PC    stack   pid father child younger 
older
[    9.440000] init          D 00000046     0     1      0     2               
(NOTLB)
[    9.440000]        dff83e94 00000086 dff81510 00000046 c1400eec dff83ed0 
00000002 00000046
[    9.440000]        0000000a dff81510 32aaf800 00000002 00000000 dff8161c 
c042023f 00000000
[    9.440000]        00000002 00000000 dfcf3790 dff83ed0 dff83ea0 c041dd52 
dff83ec8 c1400ed0
[    9.440000] Call Trace:
[    9.440000]  [<c042023f>] _spin_lock_irqsave+0x3f/0x50
[    9.440000]  [<c041dd52>] io_schedule+0x42/0x60
[    9.440000]  [<c01470f5>] sleep_on_page+0x5/0x10
[    9.440000]  [<c041dfcc>] __wait_on_bit_lock+0x3c/0x70
[    9.440000]  [<c01470f0>] sleep_on_page+0x0/0x10
[    9.440000]  [<c01470e3>] __lock_page+0x73/0x80
[    9.440000]  [<c012fb20>] wake_bit_function+0x0/0x60
[    9.440000]  [<c0149a65>] filemap_nopage+0x2f5/0x420
[    9.440000]  [<c01545f1>] __handle_mm_fault+0x111/0x8b0
[    9.440000]  [<c0115dc9>] do_page_fault+0xb9/0x610
[    9.440000]  [<c0115e36>] do_page_fault+0x126/0x610
[    9.440000]  [<c0115d10>] do_page_fault+0x0/0x610
[    9.440000]  [<c0420424>] error_code+0x74/0x7c
[    9.440000]  =======================
xfsbufd, xfssyncd and two hotplugs in D-state all hang at 
_spin_lock_irqsave+0x3f/0x50

Last try: Also removing lapic from the commandline...
Same hang after Freeing unused kernel memory, but now not even SysRQ 
works...

Anything else I should/can try?

Torsten
