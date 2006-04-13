Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbWDMRxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWDMRxp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 13:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbWDMRxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 13:53:45 -0400
Received: from MAIL.13thfloor.at ([212.16.62.50]:33429 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S932360AbWDMRxo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 13:53:44 -0400
Date: Thu, 13 Apr 2006 19:53:43 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Jes Sorensen <jes@sgi.com>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com, stern@rowland.harvard.edu, sekharan@us.ibm.com,
       akpm@osdl.org, David Chinner <dgc@sgi.com>
Subject: Re: notifier chain problem? (was Re: 2.6.17-rc1 did break XFS)
Message-ID: <20060413175342.GF6663@MAIL.13thfloor.at>
Mail-Followup-To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Jes Sorensen <jes@sgi.com>, Con Kolivas <kernel@kolivas.org>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>,
	linux-xfs@oss.sgi.com, xfs-masters@oss.sgi.com,
	stern@rowland.harvard.edu, sekharan@us.ibm.com, akpm@osdl.org,
	David Chinner <dgc@sgi.com>
References: <20060413052145.GA31435@MAIL.13thfloor.at> <20060413072325.GF2732@melbourne.sgi.com> <yq0k69tuauh.fsf@jaguar.mkp.net> <20060413135000.GB6663@MAIL.13thfloor.at> <Pine.LNX.4.61.0604131618350.17374@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0604131618350.17374@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 04:21:18PM +0200, Jan Engelhardt wrote:
> >> 
> >> Looks strange, the faulting address is in the same region as the
> >> eip. I am not that strong on x86 layouts, so I am not sure whether
> >> 0x78xxxxxx is the kernel's mapping or it's module space. Almost looks
> >> like something else had registered a notifier and then gone away
> >> without unregistering it.
> >
> >sorry, the essential data I didn't provide here is
> >probably that I configured the 2G/2G split, which for
> >unknown reasons actually is a 2.125/1.875 split and
> >starts at 0x78000000 (instead of 0x80000000)
> 
> That's how it is coded in arch/i386/Kconfig. It says 78 rather than 80.
> Maybe Con has an idea?

here is the same oops with 3/1 split and the bootup log

best,
Herbert


[42949372.960000] BIOS-provided physical RAM map:
[42949372.960000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[42949372.960000]  BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
[42949372.960000] 256MB LOWMEM available.
[42949372.960000] DMI not present or invalid.
[42949372.960000] Allocating PCI resources starting at 20000000 (gap: 10000000:f0000000)
[42949372.960000] Built 1 zonelists
[42949372.960000] Kernel command line: rw root=/dev/hda1
[42949372.960000] Local APIC disabled by BIOS -- you can enable it with "lapic"
[42949372.960000] Enabling fast FPU save and restore... done.
[42949372.960000] Enabling unmasked SIMD FPU exception support... done.
[42949372.960000] Initializing CPU#0
[42949372.960000] CPU 0 irqstacks, hard=c0585000 soft=c057d000
[42949372.960000] PID hash table entries: 2048 (order: 11, 8192 bytes)
[    0.000000] Detected 936.901 MHz processor.
[    2.311028] Using tsc for high-res timesource
[    2.313007] Console: colour dummy device 80x25
[    2.325933] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    2.330349] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    2.629401] Memory: 253808k/262144k available (3025k kernel code, 7948k reserved, 1312k data, 216k init, 0k highmem)
[    2.630294] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[    2.783776] Calibrating delay using timer specific routine.. 1892.22 BogoMIPS (lpj=9461109)
[    2.787996] Security Framework v1.0.0 initialized
[    2.789434] Capability LSM initialized
[    2.791515] Mount-cache hash table entries: 512
[    2.809314] CPU: L1 I cache: 8K
[    2.809737] CPU: L2 cache: 128K
[    2.811380] Checking 'hlt' instruction... OK.
[    2.846019] SMP alternatives: switching to UP code
[    2.849639] Freeing SMP alternatives: 16k freed
[    2.855731] CPU0: Intel Pentium II (Klamath) stepping 03
[    2.856731] SMP motherboard not detected.
[    2.857175] Local APIC not detected. Using dummy APIC emulation.
[    2.863283] Brought up 1 CPUs
[    2.865224] migration_cost=0
[    2.896344] NET: Registered protocol family 16
[    2.901885] PCI: PCI BIOS revision 2.10 entry at 0xf9ce0, last bus=0
[    2.916966] PCI: Probing PCI hardware
[    2.930880] PCI: Using IRQ router PIIX/ICH [8086/7000] at 0000:00:01.0
[    2.936121] Setting up standard PCI resources
[    2.945954] PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
[    2.977965] VFS: Disk quotas dquot_6.5.1
[    2.979416] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    2.988151] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[    2.996052] JFS: nTxBlock = 1983, nTxLock = 15864
[    3.031832] SGI XFS with no debug enabled
[    3.040916] SGI XFS Quota Management subsystem
[    3.042382] Initializing Cryptographic API
[    3.043276] io scheduler noop registered
[    3.044655] io scheduler anticipatory registered
[    3.045690] io scheduler deadline registered
[    3.047093] io scheduler cfq registered (default)
[    3.047950] PCI: PIIX3: Enabling Passive Release on 0000:00:01.0
[    3.048668] Limiting direct PCI/PCI transfers.
[    3.049154] Activating ISA DMA hang workarounds.
[    3.088622] Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled
[    3.091746] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16450
[    3.115241] FDC 0 is a S82078B
[    3.117966] ne2k-pci.c:v1.03 9/22/2003 D. Becker/P. Gortmaker
[    3.118048]   http://www.scyld.com/network/ne2k-pci.html
[    3.119679] PCI: Found IRQ 11 for device 0000:00:03.0
[    3.127097] eth0: RealTek RTL-8029 found at 0xc100, IRQ 11, 52:54:00:12:34:56.
[    3.135008] tun: Universal TUN/TAP device driver, 1.6
[    3.135605] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    3.136714] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[    3.137446] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[    3.583356] hda: QEMU HARDDISK, ATA DISK drive
[    3.584654] hda: IRQ probe failed (0xfffffffa)
[    4.202753] hdb: IRQ probe failed (0xfffffffa)
[    4.522363] hdb: IRQ probe failed (0xfffffffa)
[    5.021521] hdc: QEMU HARDDISK, ATA DISK drive
[    5.022536] hdc: IRQ probe failed (0xfffffffa)
[    5.641217] hdd: IRQ probe failed (0xfffffffa)
[    5.961917] hdd: IRQ probe failed (0xfffffffa)
[    6.021888] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    6.024569] ide1 at 0x170-0x177,0x376 on irq 15
[    6.030061] hda: max request size: 128KiB
[    6.031459] hda: 65537 sectors (33 MB) w/256KiB Cache, CHS=65/16/63
[    6.036961]  hda: hda1
[    6.057314] hdc: max request size: 128KiB
[    6.057862] hdc: 524289 sectors (268 MB) w/256KiB Cache, CHS=520/16/63
[    6.061617]  hdc: hdc1
[    6.072677] serio: i8042 AUX port at 0x60,0x64 irq 12
[    6.073751] serio: i8042 KBD port at 0x60,0x64 irq 1
[    6.084567] input: AT Translated Set 2 keyboard as /class/input/input0
[    6.089494] Netfilter messages via NETLINK v0.30.
[    6.092791] NET: Registered protocol family 2
[    6.183378] IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
[    6.191725] TCP established hash table entries: 8192 (order: 5, 163840 bytes)
[    6.195386] TCP bind hash table entries: 4096 (order: 4, 81920 bytes)
[    6.197587] TCP: Hash tables configured (established 8192 bind 4096)
[    6.198427] TCP reno registered
[    6.201833] ip_conntrack version 2.4 (2048 buckets, 16384 max) - 172 bytes per conntrack
[    6.294236] input: ImExPS/2 Generic Explorer Mouse as /class/input/input1
[    6.441466] TCP bic registered
[    6.442618] NET: Registered protocol family 1
[    6.443427] NET: Registered protocol family 17
[    6.447208] 802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
[    6.448011] All bugs added by David S. Miller <davem@redhat.com>
[    6.449111] Using IPI Shortcut mode
[    6.450683] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    6.503170] VFS: Mounted root (ext2 filesystem).
[    6.550982] Freeing unused kernel memory: 216k freed
Linux (none) 2.6.17-rc1 #2 SMP Thu Apr 13 19:18:48 CEST 2006 i686 unknown


xid related tests ...
[   66.670041] BUG: unable to handle kernel paging request at virtual address c056c380
[   66.671683]  printing eip:
[   66.672036] c0129430
[   66.672346] *pde = 005bf027
[   66.672697] *pte = 0056c000
[   66.673179] Oops: 0000 [#1]
[   66.673496] SMP DEBUG_PAGEALLOC
[   66.674011] Modules linked in:
[   66.674591] CPU:    0
[   66.674624] EIP:    0060:[<c0129430>]    Not tainted VLI
[   66.674664] EFLAGS: 00000286   (2.6.17-rc1 #2) 
[   66.676211] EIP is at notifier_chain_register+0x20/0x50
[   66.676802] eax: c056c378   ebx: cf95f3f8   ecx: 00000000   edx: c04bf9bc
[   66.677609] esi: cf95f3f8   edi: cf8eac00   ebp: cf95f800   esp: cf8ced5c
[   66.678304] ds: 007b   es: 007b   ss: 0068
[   66.678801] Process mount (pid: 50, threadinfo=cf8ce000 task=cff7e570)
[   66.679442] Stack: <0>c04bf9a0 c01295f4 c04bf9bc cf95f3f8 cf95f000 cf95f000 c0136997 c04bf9a0 
[   66.680764]        cf95f3f8 c02d43e6 cf95f3f8 00000404 cf95f000 cfd1e6a0 cf8eac00 c02d1813 
[   66.681929]        cf95f000 00000001 c02e5eaf 00000424 00000001 cf8eac00 cfd1e6a0 c02f2150 
[   66.683090] Call Trace:
[   66.683520]  <c01295f4> blocking_notifier_chain_register+0x54/0x90   <c0136997> register_cpu_notifier+0x17/0x20
[   66.684911]  <c02d43e6> xfs_icsb_init_counters+0x46/0xb0   <c02d1813> xfs_mount_init+0x23/0x160
[   66.686079]  <c02e5eaf> kmem_zalloc+0x1f/0x50   <c02f2150> bhv_insert_all_vfsops+0x10/0x50
[   66.687255]  <c02f1835> xfs_fs_fill_super+0x35/0x1f0   <c0313607> snprintf+0x27/0x30
[   66.688319]  <c01a2134> disk_name+0x64/0xc0   <c0168fbf> sb_set_blocksize+0x1f/0x50
[   66.689388]  <c0168909> get_sb_bdev+0x109/0x160   <c01034f2> common_interrupt+0x1a/0x20
[   66.690483]  <c02f1a20> xfs_fs_get_sb+0x30/0x40   <c02f1800> xfs_fs_fill_super+0x0/0x1f0
[   66.691552]  <c0168bb0> do_kern_mount+0xa0/0x160   <c0181467> do_new_mount+0x77/0xc0
[   66.692617]  <c0181b2f> do_mount+0x1bf/0x220   <c03f4178> iret_exc+0x3d4/0x6ab
[   66.693636]  <c0181913> copy_mount_options+0x63/0xc0   <c03f398f> lock_kernel+0x2f/0x50
[   66.694701]  <c0181f2f> sys_mount+0x9f/0xe0   <c0102b27> syscall_call+0x7/0xb
[   66.695739] Code: 90 90 90 90 90 90 90 90 90 90 90 53 8b 54 24 08 8b 5c 24 0c 8b 02 85 c0 74 31 8b 4b 08 8d b4 26 00 00 00 00 8d bc 27 00 00 00 00 <3b> 48 08 7f 1b 8d 50 04 8b 40 04 85 c0 75 f1 31 c0 eb 0d 90 90 
[   66.700163]  <3>BUG: sleeping function called from invalid context at include/linux/rwsem.h:43
[   66.701263] in_atomic():0, irqs_disabled():1
[   66.701764]  <c01189f4> __might_sleep+0xa4/0xb0   <c011de7a> exit_mm+0x3a/0x170
[   66.702792]  <c011e74c> do_exit+0xfc/0x420   <c011c217> printk+0x17/0x20
[   66.703722]  <c0103ef7> die+0x1e7/0x1f0   <c0112b34> do_page_fault+0x334/0x690
[   66.704792]  <c015c407> cache_grow+0x157/0x1a0   <c0112800> do_page_fault+0x0/0x690
[   66.705897]  <c0103627> error_code+0x4f/0x54   <c0129430> notifier_chain_register+0x20/0x50
[   66.707153]  <c01295f4> blocking_notifier_chain_register+0x54/0x90   <c0136997> register_cpu_notifier+0x17/0x20
[   66.708536]  <c02d43e6> xfs_icsb_init_counters+0x46/0xb0   <c02d1813> xfs_mount_init+0x23/0x160
[   66.709778]  <c02e5eaf> kmem_zalloc+0x1f/0x50   <c02f2150> bhv_insert_all_vfsops+0x10/0x50
[   66.710964]  <c02f1835> xfs_fs_fill_super+0x35/0x1f0   <c0313607> snprintf+0x27/0x30
[   66.712097]  <c01a2134> disk_name+0x64/0xc0   <c0168fbf> sb_set_blocksize+0x1f/0x50
[   66.713219]  <c0168909> get_sb_bdev+0x109/0x160   <c01034f2> common_interrupt+0x1a/0x20
[   66.714372]  <c02f1a20> xfs_fs_get_sb+0x30/0x40   <c02f1800> xfs_fs_fill_super+0x0/0x1f0
[   66.715522]  <c0168bb0> do_kern_mount+0xa0/0x160   <c0181467> do_new_mount+0x77/0xc0
[   66.716658]  <c0181b2f> do_mount+0x1bf/0x220   <c03f4178> iret_exc+0x3d4/0x6ab
[   66.717790]  <c0181913> copy_mount_options+0x63/0xc0   <c03f398f> lock_kernel+0x2f/0x50
[   66.718945]  <c0181f2f> sys_mount+0x9f/0xe0   <c0102b27> syscall_call+0x7/0xb

> Jan Engelhardt
> -- 
