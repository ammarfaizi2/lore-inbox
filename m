Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266498AbUGPJQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266498AbUGPJQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 05:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266499AbUGPJQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 05:16:26 -0400
Received: from 23-88.ipact.nl ([82.210.88.23]:47240 "EHLO vt.shuis.tudelft.nl")
	by vger.kernel.org with ESMTP id S266498AbUGPJPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 05:15:51 -0400
From: Remon Sijrier <remon@vt.shuis.tudelft.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: Losing interrupts
Date: Fri, 16 Jul 2004 11:16:38 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_2z59AKh/nfOPE0e"
Message-Id: <200407161116.38493.remon@vt.shuis.tudelft.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_2z59AKh/nfOPE0e
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

First, thanks a lot for the work done and still done for tackling the latency 
issues in the kernel.

I'm interested in this area, and want to do some testing as well.
Lee Revel, could you please sent me the changes you made for measuring 
interrupt times to me?


I've collected as well some preempt stuff, here it goes: (I've send them also 
to Andrew)

While compiling a program:

9ms non-preemptible critical section violated 2 ms preempt threshold starting 
at __find_get_block+0x2a/0x110 and ending at __find_get_block+0x4f/0x110
 [<c0158f2f>] __find_get_block+0x4f/0x110
 [<c011a9f8>] dec_preempt_count+0x118/0x120
 [<c0158f2f>] __find_get_block+0x4f/0x110
 [<c0158f2f>] __find_get_block+0x4f/0x110
 [<c013a6b7>] mempool_alloc+0x87/0x190
 [<c0159027>] __getblk+0x37/0x80
 [<c01590f7>] __bread+0x27/0x50
 [<c01c65d2>] ext3_get_branch+0x72/0xf0
 [<c01c6cdb>] ext3_get_block_handle+0xbb/0x390
 [<c011ae30>] autoremove_wake_function+0x0/0x60
 [<c01c7015>] ext3_get_block+0x65/0xc0
 [<c01790a8>] do_mpage_readpage+0x148/0x4a0
 [<c0284d02>] pci_bus_write_config_byte+0x52/0x80
 [<c013714e>] add_to_page_cache+0x9e/0xc0
 [<c011a932>] dec_preempt_count+0x52/0x120
 [<c027e949>] radix_tree_preload+0x19/0xb0
 [<c027ebad>] radix_tree_insert+0xed/0x110
 [<c013714e>] add_to_page_cache+0x9e/0xc0
 [<c017954b>] mpage_readpages+0x14b/0x180
 [<c01c6fb0>] ext3_get_block+0x0/0xc0
 [<c02f88a6>] lba_28_rw_disk+0x86/0x90
 [<c013b9bb>] buffered_rmqueue+0x14b/0x1a0
 [<c011a932>] dec_preempt_count+0x52/0x120
 [<c013ea88>] read_pages+0x138/0x150
 [<c01c6fb0>] ext3_get_block+0x0/0xc0
 [<c013bd30>] __alloc_pages+0x320/0x390
 [<c013ed7c>] do_page_cache_readahead+0xcc/0x1c0
 [<c011a932>] dec_preempt_count+0x52/0x120
 [<c013edcf>] do_page_cache_readahead+0x11f/0x1c0
 [<c013f010>] page_cache_readahead+0x1a0/0x200
 [<c0137a74>] do_generic_mapping_read+0x104/0x4f0
 [<c0138175>] __generic_file_aio_read+0x205/0x240
 [<c0137e60>] file_read_actor+0x0/0x110
 [<c013820b>] generic_file_aio_read+0x5b/0x80
 [<c0155e80>] do_sync_read+0x80/0xb0
 [<c0172bfa>] __inode_dir_notify+0x4a/0xc0
 [<c0155f9d>] vfs_read+0xed/0x160
 [<c037cd05>] schedule+0x255/0x4a0
 [<c0156262>] sys_read+0x42/0x70
 [<c0106167>] syscall_call+0x7/0xb
printk: 1 messages suppressed.
7ms non-preemptible critical section violated 2 ms preempt threshold starting 
at drain_cpu_caches+0x21/0x70 and ending at drain_cpu_caches+0x2e/0x70
 [<c013fc6e>] drain_cpu_caches+0x2e/0x70
 [<c011a9f8>] dec_preempt_count+0x118/0x120
 [<c013fc6e>] drain_cpu_caches+0x2e/0x70
 [<c013fc6e>] drain_cpu_caches+0x2e/0x70
 [<c013fcc3>] __cache_shrink+0x13/0xc0
 [<c026f9a4>] xfs_inode_shake+0x14/0x30
 [<c0142728>] shrink_slab+0x78/0x190
 [<c0143cd4>] balance_pgdat+0x1c4/0x210
 [<c0143df2>] kswapd+0xd2/0xf0
 [<c011ae30>] autoremove_wake_function+0x0/0x60
 [<c0106032>] ret_from_fork+0x6/0x14
 [<c011ae30>] autoremove_wake_function+0x0/0x60
 [<c0143d20>] kswapd+0x0/0xf0
 [<c01042ad>] kernel_thread_helper+0x5/0x18
printk: 2 messages suppressed.
8ms non-preemptible critical section violated 2 ms preempt threshold starting 
at sys_ioctl+0x61/0x2c0 and ending at sys_ioctl+0xed/0x2c0
 [<c016953d>] sys_ioctl+0xed/0x2c0
 [<c011a9f8>] dec_preempt_count+0x118/0x120
 [<c016953d>] sys_ioctl+0xed/0x2c0
 [<c016953d>] sys_ioctl+0xed/0x2c0
 [<c0106167>] syscall_call+0x7/0xb
printk: 5 messages suppressed.
9ms non-preemptible critical section violated 2 ms preempt threshold starting 
at schedule+0x65/0x4a0 and ending at schedule+0x255/0x4a0
 [<c037cd05>] schedule+0x255/0x4a0
 [<c011a9f8>] dec_preempt_count+0x118/0x120
 [<c037cd05>] schedule+0x255/0x4a0
 [<c037cd05>] schedule+0x255/0x4a0
 [<d0b42adb>] snd_pcm_playback_poll+0xdb/0x140 [snd_pcm]
 [<c011a932>] dec_preempt_count+0x52/0x120
 [<c037d4a5>] schedule_timeout+0xb5/0xc0
 [<c016a76b>] do_pollfd+0x5b/0xa0
 [<c016a858>] do_poll+0xa8/0xd0
 [<c016a9e1>] sys_poll+0x161/0x240
 [<c0169d10>] __pollwait+0x0/0xd0
 [<c0106167>] syscall_call+0x7/0xb


While starting openoffice.org:

8ms non-preemptible critical section violated 2 ms preempt threshold starting 
at __find_get_block+0x2a/0x110 and ending at __find_get_block+0x4f/0x110
 [<c0158f2f>] __find_get_block+0x4f/0x110
 [<c011a9f8>] dec_preempt_count+0x118/0x120
 [<c0158f2f>] __find_get_block+0x4f/0x110
 [<c0158f2f>] __find_get_block+0x4f/0x110
 [<c0157450>] bh_wake_function+0x0/0x40
 [<c0159027>] __getblk+0x37/0x80
 [<c01c94c0>] ext3_get_inode_loc+0x60/0x270
 [<c01c9765>] ext3_read_inode+0x35/0x300
 [<c0171272>] iget_locked+0xa2/0xe0
 [<c01cb9aa>] ext3_lookup+0x9a/0xd0
 [<c01642b5>] real_lookup+0xd5/0x100
 [<c0164566>] do_lookup+0x96/0xb0
 [<c0164b03>] link_path_walk+0x583/0xb00
 [<c0165320>] path_lookup+0x80/0x150
 [<c011a932>] dec_preempt_count+0x52/0x120
 [<c0161300>] open_exec+0x30/0x100
 [<c013b914>] buffered_rmqueue+0xa4/0x1a0
 [<c0137523>] find_get_page+0x33/0x60
 [<c0162360>] do_execve+0x20/0x290
 [<c0137523>] find_get_page+0x33/0x60
 [<c01387e7>] filemap_nopage+0x217/0x3b0
 [<c0147470>] do_no_page+0x190/0x350
 [<c011a932>] dec_preempt_count+0x52/0x120
 [<c0147470>] do_no_page+0x190/0x350
 [<c0147830>] handle_mm_fault+0xe0/0x190
 [<c0117f0c>] do_page_fault+0x36c/0x55e
 [<c0281ac8>] copy_to_user+0x48/0x60
 [<c012933a>] sys_rt_sigaction+0xaa/0xc0
 [<c0281703>] strncpy_from_user+0x43/0x70
 [<c0163e28>] getname+0x98/0xd0
 [<c0104c52>] sys_execve+0x42/0x80
 [<c0106167>] syscall_call+0x7/0xb


With xrun_debug = 2


XRUN: pcmC0D0p
 [<d0b458a7>] snd_pcm_period_elapsed+0x2d7/0x430 [snd_pcm]
 [<c0124444>] update_process_times+0x44/0x50
 [<d0b557ca>] snd_ice1712_interrupt+0x1da/0x270 [snd_ice1712]
 [<c0108419>] handle_IRQ_event+0x49/0x80
 [<c01087c3>] do_IRQ+0x93/0x130
 [<c0106a78>] common_interrupt+0x18/0x20
 [<c0111e84>] delay_pmtmr+0x14/0x20
 [<c027ef32>] __delay+0x12/0x20
 [<c030abbc>] atkbd_sendbyte+0x4c/0x90
 [<c030add9>] atkbd_command+0x1d9/0x1f0
 [<c030b051>] atkbd_event+0x261/0x2f0
 [<c0308bed>] input_event+0x14d/0x410
 [<c02bbbb8>] kbd_bh+0xa8/0x190
 [<c01207d0>] ksoftirqd+0x0/0xe0
 [<c01206a6>] tasklet_action+0x46/0x70
 [<c012048b>] __do_softirq+0x7b/0x80
 [<c01204b7>] do_softirq+0x27/0x30
 [<c012084a>] ksoftirqd+0x7a/0xe0
 [<c012f22a>] kthread+0xaa/0xb0
 [<c012f180>] kthread+0x0/0xb0
 [<c01042ad>] kernel_thread_helper+0x5/0x18
39ms non-preemptible critical section violated 2 ms preempt threshold starting 
at ksoftirqd+0x75/0xe0 and ending at ksoftirqd+0x7f/0xe0
 [<c012084f>] ksoftirqd+0x7f/0xe0
 [<c0119b09>] dec_preempt_count+0x119/0x120
 [<c012084f>] ksoftirqd+0x7f/0xe0
 [<c01207d0>] ksoftirqd+0x0/0xe0
 [<c012084f>] ksoftirqd+0x7f/0xe0
 [<c012f22a>] kthread+0xaa/0xb0
 [<c012f180>] kthread+0x0/0xb0
 [<c01042ad>] kernel_thread_helper+0x5/0x18
XRUN: pcmC0D0p
 [<d0b458a7>] snd_pcm_period_elapsed+0x2d7/0x430 [snd_pcm]
 [<c0124444>] update_process_times+0x44/0x50
 [<d0b557ca>] snd_ice1712_interrupt+0x1da/0x270 [snd_ice1712]
 [<c0108419>] handle_IRQ_event+0x49/0x80
 [<c01087c3>] do_IRQ+0x93/0x130
 [<c0106a78>] common_interrupt+0x18/0x20
 [<c0111e84>] delay_pmtmr+0x14/0x20
 [<c027ef32>] __delay+0x12/0x20
 [<c030abbc>] atkbd_sendbyte+0x4c/0x90
 [<c030add9>] atkbd_command+0x1d9/0x1f0
 [<c030b051>] atkbd_event+0x261/0x2f0
 [<c0308bed>] input_event+0x14d/0x410
 [<c02bbbb8>] kbd_bh+0xa8/0x190
 [<c01207d0>] ksoftirqd+0x0/0xe0
 [<c01206a6>] tasklet_action+0x46/0x70
 [<c012048b>] __do_softirq+0x7b/0x80
 [<c01204b7>] do_softirq+0x27/0x30
 [<c012084a>] ksoftirqd+0x7a/0xe0
 [<c012f22a>] kthread+0xaa/0xb0
 [<c012f180>] kthread+0x0/0xb0
 [<c01042ad>] kernel_thread_helper+0x5/0x18
39ms non-preemptible critical section violated 2 ms preempt threshold starting 
at ksoftirqd+0x75/0xe0 and ending at ksoftirqd+0x7f/0xe0
 [<c012084f>] ksoftirqd+0x7f/0xe0
 [<c0119b09>] dec_preempt_count+0x119/0x120
 [<c012084f>] ksoftirqd+0x7f/0xe0
 [<c01207d0>] ksoftirqd+0x0/0xe0
 [<c012084f>] ksoftirqd+0x7f/0xe0
 [<c012f22a>] kthread+0xaa/0xb0
 [<c012f180>] kthread+0x0/0xb0
 [<c01042ad>] kernel_thread_helper+0x5/0x18
XRUN: pcmC0D0p
 [<d0b458a7>] snd_pcm_period_elapsed+0x2d7/0x430 [snd_pcm]
 [<c0124444>] update_process_times+0x44/0x50
 [<d0b557ca>] snd_ice1712_interrupt+0x1da/0x270 [snd_ice1712]
 [<c0108419>] handle_IRQ_event+0x49/0x80
 [<c01087c3>] do_IRQ+0x93/0x130
 [<c0106a78>] common_interrupt+0x18/0x20
 [<c0111e86>] delay_pmtmr+0x16/0x20
 [<c027ef32>] __delay+0x12/0x20
 [<c030abbc>] atkbd_sendbyte+0x4c/0x90
 [<c030add9>] atkbd_command+0x1d9/0x1f0
 [<c030b051>] atkbd_event+0x261/0x2f0
 [<c0308bed>] input_event+0x14d/0x410
 [<c02bbbb8>] kbd_bh+0xa8/0x190
 [<c01207d0>] ksoftirqd+0x0/0xe0
 [<c01206a6>] tasklet_action+0x46/0x70
 [<c012048b>] __do_softirq+0x7b/0x80
 [<c01204b7>] do_softirq+0x27/0x30
 [<c012084a>] ksoftirqd+0x7a/0xe0
 [<c012f22a>] kthread+0xaa/0xb0
 [<c012f180>] kthread+0x0/0xb0
 [<c01042ad>] kernel_thread_helper+0x5/0x18
40ms non-preemptible critical section violated 2 ms preempt threshold starting 
at ksoftirqd+0x75/0xe0 and ending at ksoftirqd+0x7f/0xe0
 [<c012084f>] ksoftirqd+0x7f/0xe0
 [<c0119b09>] dec_preempt_count+0x119/0x120
 [<c012084f>] ksoftirqd+0x7f/0xe0
 [<c01207d0>] ksoftirqd+0x0/0xe0
 [<c012084f>] ksoftirqd+0x7f/0xe0
 [<c012f22a>] kthread+0xaa/0xb0
 [<c012f180>] kthread+0x0/0xb0
 [<c01042ad>] kernel_thread_helper+0x5/0x18
XRUN: pcmC0D0p
 [<d0b458a7>] snd_pcm_period_elapsed+0x2d7/0x430 [snd_pcm]
 [<c0124444>] update_process_times+0x44/0x50
 [<d0b557ca>] snd_ice1712_interrupt+0x1da/0x270 [snd_ice1712]
 [<c0108419>] handle_IRQ_event+0x49/0x80
 [<c01087c3>] do_IRQ+0x93/0x130
 [<c0106a78>] common_interrupt+0x18/0x20
 [<c037007b>] xfrm_state_find+0x56b/0xad0
 [<c0111e86>] delay_pmtmr+0x16/0x20
 [<c027ef32>] __delay+0x12/0x20
 [<c030abbc>] atkbd_sendbyte+0x4c/0x90
 [<c030add9>] atkbd_command+0x1d9/0x1f0
 [<c030b051>] atkbd_event+0x261/0x2f0
 [<c0308bed>] input_event+0x14d/0x410
 [<c02bbbb8>] kbd_bh+0xa8/0x190
 [<c01206a6>] tasklet_action+0x46/0x70
 [<c012048b>] __do_softirq+0x7b/0x80
 [<c01204b7>] do_softirq+0x27/0x30
 [<c0114955>] smp_apic_timer_interrupt+0xc5/0x100
 [<c0106a9a>] apic_timer_interrupt+0x1a/0x20

And these I'm getting the most frequently and most often:

7ms non-preemptible critical section violated 2 ms preempt threshold starting 
at ksoftirqd+0x75/0xe0 and ending at ksoftirqd+0x7f/0xe0
 [<c01217af>] ksoftirqd+0x7f/0xe0
 [<c011a9f8>] dec_preempt_count+0x118/0x120
 [<c01217af>] ksoftirqd+0x7f/0xe0
 [<c0121730>] ksoftirqd+0x0/0xe0
 [<c01217af>] ksoftirqd+0x7f/0xe0
 [<c013022a>] kthread+0xaa/0xb0
 [<c0130180>] kthread+0x0/0xb0
 [<c01042ad>] kernel_thread_helper+0x5/0x18


I've used the voluntary_preempt patch, but it looks like there's no 
difference. Both with/without kernel preempt and with/without 
voluntary_preempt I'm getting the same results.
I used ck6 which includes all patches from Andrew as well.

I don't know if it is usefull, but I attached the startup dmesg log.

Thanks a lot, and hopefully you can do something with this information.

Remon

--Boundary-00=_2z59AKh/nfOPE0e
Content-Type: text/x-log;
  charset="us-ascii";
  name="dmesg_startup.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg_startup.log"

Linux version 2.6.8-rc1-ck6 (root@lute) (gcc versie 3.3.4 (Debian)) #1 Thu Jul 15 19:41:59 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ffeb000 (usable)
 BIOS-e820: 000000000ffeb000 - 000000000ffef000 (ACPI data)
 BIOS-e820: 000000000ffef000 - 000000000ffff000 (reserved)
 BIOS-e820: 000000000ffff000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
255MB LOWMEM available.
On node 0 totalpages: 65515
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61419 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f7b10
ACPI: RSDT (v001 ASUS   CUSL2    0x30303031 MSFT 0x31313031) @ 0x0ffeb000
ACPI: FADT (v001 ASUS   CUSL2    0x30303031 MSFT 0x31313031) @ 0x0ffeb080
ACPI: BOOT (v001 ASUS   CUSL2    0x30303031 MSFT 0x31313031) @ 0x0ffeb040
ACPI: DSDT (v001   ASUS CUSL2    0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: PM-Timer IO Port: 0xe408
Built 1 zonelists
Kernel command line: BOOT_IMAGE=Linux root=210c preempt_threshold=1 elevator=cfq
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 808.139 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 254996k/262060k available (2554k kernel code, 6332k reserved, 868k data, 172k init, 0k highmem, 0k BadRAM)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1601.53 BogoMIPS
Security Scaffold v1.0.0 initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  0383fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU: After all inits, caps:        0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Celeron (Coppermine) stepping 0a
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
Generic cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 807.0799 MHz.
..... host bus clock speed is 100.0974 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0df0, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Level Trigger.
    ACPI-0165: *** Error: No object was returned from [\_SB_.PCI0.PX40.UAR2._STA] (Node cff46220), AE_NOT_EXIST
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbe20
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbe50, dseg 0xf0000
pnp: 00:12: ioport range 0x3f0-0x3f1 has been reserved
pnp: 00:12: ioport range 0xe400-0xe47f has been reserved
pnp: 00:12: ioport range 0xec00-0xec3f has been reserved
PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:1f.2[D] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:1f.4[C] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 9
ACPI: PCI interrupt 0000:02:0a.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 9
ACPI: PCI interrupt 0000:02:0c.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI interrupt 0000:02:0e.0[A] -> GSI 5 (level, low) -> IRQ 5
Simple Boot Flag at 0x3a set to 0x1
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
SGI XFS with ACLs, security attributes, realtime, large block numbers, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Using cfq io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller at PCI slot 0000:00:1f.1
ICH2: chipset revision 1
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x7800-0x7807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x7808-0x780f, BIOS settings: hdc:DMA, hdd:pio
hda: Hewlett-Packard CD-Writer Plus 8200a, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: LITEON DVD-ROM LTD-165H, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
HPT370: IDE controller at PCI slot 0000:02:0a.0
ACPI: PCI interrupt 0000:02:0a.0[A] -> GSI 9 (level, low) -> IRQ 9
HPT370: chipset revision 3
HPT37X: using 33MHz PCI clock
HPT370: 100% native mode on irq 9
    ide2: BM-DMA at 0xa400-0xa407, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xa408-0xa40f, BIOS settings: hdg:pio, hdh:pio
hde: ST380023A, ATA DISK drive
ide2 at 0xb800-0xb807,0xb402 on irq 9
hde: max request size: 128KiB
hde: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
 /dev/ide/host2/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 p10 p11 p12 >
hda: ATAPI 32X CD-ROM CD-R/RW drive, 4096kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdc: ATAPI 48X DVD-ROM drive, 256kB Cache, UDMA(33)
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 8
NET: Registered protocol family 20
ACPI: (supports S0 S1 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 172k freed
NET: Registered protocol family 1
Adding 497972k swap on /dev/hde8.  Priority:-1 extents:1
EXT3 FS on hde12, internal journal
Real Time Clock Driver v1.12
input: PS2++ Logitech Wheel Mouse on isa0060/serio1
mice: PS/2 mouse device common for all mice
ts: Compaq touchscreen protocol output
ReiserFS: hde10: found reiserfs format "3.6" with standard journal
ReiserFS: hde10: using ordered data mode
ReiserFS: hde10: journal params: device hde10, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hde10: checking transaction log (hde10)
ReiserFS: hde10: Using r5 hash to sort names
ReiserFS: hde5: found reiserfs format "3.6" with standard journal
ReiserFS: hde5: using ordered data mode
ReiserFS: hde5: journal params: device hde5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hde5: checking transaction log (hde5)
ReiserFS: hde5: Using r5 hash to sort names
XFS mounting filesystem hde9
Ending clean XFS mount for filesystem: hde9
end_request: I/O error, dev fd0, sector 0
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
lp0: using parport0 (interrupt-driven).
via-rhine.c:v1.10-LK1.1.20-2.6 May-23-2004 Written by Donald Becker
ACPI: PCI interrupt 0000:02:0c.0[A] -> GSI 9 (level, low) -> IRQ 9
eth0: VIA Rhine II at 0xa000, 00:05:5d:de:e4:9d, IRQ 9.
eth0: MII PHY found at address 8, status 0x782d advertising 01e1 Link 45e1.
SCSI subsystem initialized
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i815 Chipset, but could not find the secondary device.
agpgart: Detected an Intel i815 Chipset.
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 64M @ 0xf8000000
cpci_hotplug: CompactPCI Hot Plug Core version: 0.2
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
pciehp: acpi_pciehprm:\_SB_.PCI0 evaluate _BBN fail=0x5
pciehp: acpi_pciehprm:get_device PCI ROOT HID fail=0x5
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
hw_random hardware driver 1.0.0 loaded
pciehp: acpi_pciehprm:\_SB_.PCI0 evaluate _BBN fail=0x5
pciehp: acpi_pciehprm:get_device PCI ROOT HID fail=0x5
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1f.2[D] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:1f.2: Intel Corp. 82801BA/BAM USB (Hub #1)
PCI: Setting latency timer of device 0000:00:1f.2 to 64
uhci_hcd 0000:00:1f.2: irq 9, io base 00007400
uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1f.4[C] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:1f.4: Intel Corp. 82801BA/BAM USB (Hub #2)
PCI: Setting latency timer of device 0000:00:1f.4 to 64
uhci_hcd 0000:00:1f.4: irq 9, io base 00007000
uhci_hcd 0000:00:1f.4: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb 2-2: new full speed USB device using address 2
hub 2-2:1.0: USB hub found
hub 2-2:1.0: 4 ports detected
ACPI: PCI interrupt 0000:02:0e.0[A] -> GSI 5 (level, low) -> IRQ 5
eth0: Setting full-duplex based on MII #8 link partner capability of 45e1.
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
Intel ISA PCIC probe: not found.
Device 'i823650' does not have a release() function, it is broken and must be fixed.
Badness in device_release at drivers/base/core.c:85
 [<c027e168>] kobject_cleanup+0x98/0xa0
 [<c02cfeeb>] platform_device_unregister+0x1b/0x60
 [<d0aa53d3>] init_i82365+0x1c3/0x1d9 [i82365]
 [<c0134619>] sys_init_module+0x109/0x230
 [<c0106167>] syscall_call+0x7/0xb
NET: Registered protocol family 10
Disabled Privacy Extensions on device c0419120(lo)
IPv6 over IPv4 tunneling driver
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc Radeon R200 QL [Radeon 8500 LE]
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[drm] Loading R200 Microcode
eth0: no IPv6 routers present
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide2: reset: success

--Boundary-00=_2z59AKh/nfOPE0e--
