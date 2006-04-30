Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbWD3DWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbWD3DWv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 23:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbWD3DWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 23:22:51 -0400
Received: from nproxy.gmail.com ([64.233.182.190]:21371 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750815AbWD3DWu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 23:22:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=N4bJevP8mh+iSw5xwWXoEBJmz24F00izSx5kiD8WqiFBvrbnlhFpmAQBkvgsKyp1eDmfTM/BI01/aX07Po6NFQfQPBC9ZW2NiFnQJ8tSPUT17Tam1DR5fA59lQ/eRIMUGSfEPH2n1zjz1dmuDlAYzzlxY9luXVMXP7/5nqHDZkY=
Message-ID: <be2dacd50604292022i276adae4yfb5877b71a23c87@mail.gmail.com>
Date: Sat, 29 Apr 2006 22:22:48 -0500
From: "Noah Watkins" <noah.lkml@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.6.15-rt16 __cache_alloc at mm/slab.c
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.15-rt16 compiled w/o SMP support has been working fine. On the
same hardware (dual p3) with SMP compiled in I am getting BUGS.

The computer boots fine, and the following (trace at end of email)
occurs after I log into the computer over SSH. Specifically I am
prompted for my password and immediately after I submit my password to
SSH the box goes crazy.

Hardware
--------------
$ lspci
00:00.0 Host bridge: Broadcom (formerly ServerWorks) CNB20LE Host
Bridge (rev 06)
00:00.1 Host bridge: Broadcom (formerly ServerWorks) CNB20LE Host
Bridge (rev 06)
00:03.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
00:04.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro
100] (rev 08)
00:06.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro
100] (rev 08)
00:0f.0 ISA bridge: Broadcom (formerly ServerWorks) OSB4 South Bridge (rev 51)
00:0f.1 IDE interface: Broadcom (formerly ServerWorks) OSB4 IDE Controller
00:0f.2 USB Controller: Broadcom (formerly ServerWorks) OSB4/CSB5 OHCI
USB Controller (rev 04)
01:03.0 SCSI storage controller: Adaptec AIC-7892P U160/m (rev 02)

Modules
-------------
$ lsmod
Module                  Size  Used by
md5                     4352  1
ipv6                  240352  14
nfs                   106992  5
lockd                  59400  2 nfs
nfs_acl                 3200  1 nfs
sunrpc                136380  4 nfs,lockd,nfs_acl
ohci_hcd               16516  0
floppy                 59716  0
aic7xxx               173012  0

Config
------------
http://www.ittc.ku.edu/~nwatkins/configs/config-2.6.15-rt16-lkml-042906


Trace
--------

[    0.000000] Linux version 2.6.15-rt16y (nwatkins@kusp.ittc.ku.edu)
(gcc version 3.4.4 20050721 (Red Hat 3.4.4-2)) #1 SMP PREEMPT Sat Apr
29 21:32:32 CDT 2006
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
[    0.000000]  BIOS-e820: 000000003fff0000 - 000000003ffff000 (ACPI data)
[    0.000000]  BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec02000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
[    0.000000] 127MB HIGHMEM available.
[    0.000000] 896MB LOWMEM available.
[    0.000000] found SMP MP-table at 000ff780
[    0.000000] DMI 2.3 present.
[    0.000000] Intel MultiProcessor Specification v1.4
[    0.000000]     Virtual Wire compatibility mode.
[    0.000000] OEM ID: AMI      Product ID: CNB30LE      APIC at: 0xFEE00000
[    0.000000] Processor #0 6:11 APIC version 17
[    0.000000] Processor #1 6:11 APIC version 17
[    0.000000] I/O APIC #4 Version 17 at 0xFEC00000.
[    0.000000] I/O APIC #5 Version 17 at 0xFEC01000.
[    0.000000] Enabling APIC mode:  Flat.  Using 2 I/O APICs
[    0.000000] Processors: 2
[    0.000000] Allocating PCI resources starting at 50000000 (gap:
40000000:bec00000)
[    0.000000] Detected 1399.473 MHz processor.
[   58.037486] Real-Time Preemption Support (C) 2004-2005 Ingo Molnar
[   58.037518] Built 1 zonelists
[   58.037615] Kernel command line: ro root=LABEL=/1 acpi=off
netconsole=4444@129.237.127.64/eth0,9954@129.237.127.197/00:07:E9:C6:35:E2
[   58.037678] netconsole: local port 4444
[   58.037683] netconsole: local IP 129.237.127.64
[   58.037686] netconsole: interface eth0
[   58.037689] netconsole: remote port 9954
[   58.037693] netconsole: remote IP 129.237.127.197
[   58.037700] netconsole: remote ethernet address 00:07:e9:c6:35:e2
[   58.037958] Initializing CPU#0
[   58.037968] WARNING: experimental RCU implementation.
[   58.038030] CPU 0 irqstacks, hard=c0446000 soft=c043e000
[   58.038036] PID hash table entries: 4096 (order: 12, 65536 bytes)
[   58.987221] Event source pit installed with caps set: 01
[   58.988764] Console: colour VGA+ 80x25
[   58.991681] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[   58.993629] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[   59.105194] Memory: 1018228k/1048512k available (2315k kernel code,
29896k reserved, 761k data, 208k init, 131008k highmem)
[   59.105265] Checking if this processor honours the WP bit even in
supervisor mode... Ok.
[   59.183026] Calibrating delay using timer specific routine..
2799.71 BogoMIPS (lpj=5599428)
[   59.183186] Security Framework v1.0.0 initialized
[   59.183241] SELinux:  Initializing.
[   59.183376] SELinux:  Starting in permissive mode
[   59.183424] selinux_register_security:  Registering secondary
module capability
[   59.183478] Capability LSM initialized as secondary
[   59.183566] Mount-cache hash table entries: 512
[   59.184011] CPU: L1 I cache: 16K, L1 D cache: 16K
[   59.184081] CPU: L2 cache: 512K
[   59.184135] Intel machine check architecture supported.
[   59.184181] Intel machine check reporting enabled on CPU#0.
[   59.184240] mtrr: v2.0 (20020519)
[   59.184286] Enabling fast FPU save and restore... done.
[   65.458156] hda: HDS722580VLAT20, ATA DISK drive
[   66.129825] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   66.864782] hdc: MATSHITA CR-177, ATAPI CD/DVD-ROM drive
[   67.200710] ide1 at 0x170-0x177,0x376 on irq 15
[   67.210381] hda: max request size: 1024KiB
[   67.217389] hda: 160836480 sectors (82348 MB) w/1794KiB Cache,
CHS=16383/255/63, (U)DMA
[   67.217885] hda: cache flushes supported
[   67.218265]  hda: hda1 hda2 hda3
[   67.234106] hdc: ATAPI 24X CD-ROM drive, 128kB Cache, (U)DMA
[   67.234350] Uniform CD-ROM driver Revision: 3.20
[   67.237830] ide-floppy driver 0.99.newide
[   67.244889] mice: PS/2 mouse device common for all mice
[   67.245069] Netfilter messages via NETLINK v0.30.
[   67.245421] NET: Registered protocol family 2
[   67.256439] IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
[   67.257325] TCP established hash table entries: 32768 (order: 9,
2359296 bytes)
[   67.267550] TCP bind hash table entries: 32768 (order: 9, 2228224 bytes)
[   67.277958] TCP: Hash tables configured (established 32768 bind 32768)
[   67.278053] TCP reno registered
[   67.278483] TCP bic registered
[   67.278586] Initializing IPsec netlink socket
[   67.278674] NET: Registered protocol family 1
[   67.278740] NET: Registered protocol family 17
[   67.278795] ieee80211: 802.11 data/management/control stack, git-1.1.7
[   67.278843] ieee80211: Copyright (C) 2004-2005 Intel Corporation
<jketreno@linux.intel.com>
[   67.278927] Starting balanced_irq
[   67.279066] Using IPI Shortcut mode
[   67.279202] *****************************************************************************
[   67.279263] *                                                      
                    *
[   67.279397] *  REMINDER, the following debugging option is turned
on in your .config:   *
[   67.280663] *                                                      
                    *
[   67.280722] *        CONFIG_DEBUG_DEADLOCKS                        
                    *
[   67.280780] *                                                      
                    *
[   67.280838] *  it may increase runtime overhead and latencies.     
                    *
[   67.280895] *                                                      
                    *
[   67.280955] *****************************************************************************
[   67.281472] Freeing unused kernel memory: 208k freed
[   67.299303] Time: tsc clocksource has been installed.
[   67.300225] hrtimers: Switched to high resolution mode CPU 1
[   67.303289] hrtimers: Switched to high resolution mode CPU 0
[   67.317158] input: AT Translated Set 2 keyboard as /class/input/input0
[   67.571682] scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
[   67.571687]         <Adaptec aic7892 Ultra160 SCSI adapter>
[   67.571689]         aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
[   67.571691]
[   67.868326] input: ImExPS/2 Generic Explorer Mouse as /class/input/input1
[   86.533387] kjournald starting.  Commit interval 5 seconds
[   86.533473] EXT3-fs: mounted filesystem with ordered data mode.
[   86.865487] SELinux:  Disabled at runtime.
[   86.865554] SELinux:  Unregistering netfilter hooks
[  107.074578]  [<c0111226>] [<c0111226>] smp_error_interrupt+0x56/0x60 (8)
[  107.074602]  [<c0103b6c>] error_interrupt+0x1c/0x24 (20)
[  107.074611]  [<c034007b>] _raw_spin_unlock+0x1b/0x20 (36)
[  107.074619]  [<c0341354>] do_page_fault+0x64/0x530 (8)
[  107.074628]  [<c015d9e7>]swapper/0[CPU#1]: BUG in __cache_alloc at
mm/slab.c:2196
[  107.074639]  sys_brk+0xf7/0x120 (64)
[  107.074643]  [<c011fb76>] [<c03412f0>] do_page_fault+0x0/0x530 (20)
[  107.074654]  [<c0103bef>] error_code+0x4f/0x54 (8)
[  107.074659]  __WARN_ON+0x66/0x90 (8)
[  107.074665] ------------------------------
[  107.074669]  [<c016b3b0>]| showing all locks held by: | 
(egrep/1294 [f7c04e10, 118]):
[  107.074680]  kmem_cache_alloc+0xd0/0xe0------------------------------
[  107.074686]  (48)
[  107.074690]
[  107.074693]  [<c02c6ed0>] __alloc_skb+0x30/0x150 (24)
[  107.074708]  [<c02d912f>] find_skb+0x2f/0xf0 (28)
[  107.074721]  [<c02d934c>] netpoll_send_udp+0x2c/0x210 (32)
 107.087948]  [<c011f01b>] call_console_drivers+0xfb/0x120 (20)
[  107.087954]  [<c0272320>] write_msg+0x0/0xd0 (4)
[  107.087959]  [<c011ee70>] __call_console_drivers+0x40/0x60 (8)
[  107.087965]  [<c011f4f9>] release_console_sem+0x29/0xe0 (20)
[  107.087971]  [<c011f2fc>] vprintk+0x1ac/0x2c0 (20)
[  107.087980]  [<c0111226>] smp_error_interrupt+0x56/0x60 (100)
[  107.087986]  [<c011f147>] printk+0x17/0x20 (12)
[  107.087992]  [<c0103e50>] show_trace+0x50/0xb0 (12)
[  107.087997]  [<c0111226>] smp_error_interrupt+0x56/0x60 (8)
[  107.088003]  [<c0103f53>] dump_stack+0x13/0x20 (24)
[  107.088008]  [<c0111226>] smp_error_interrupt+0x56/0x60 (8)
[  107.088014]  [<c0103b6c>] error_interrupt+0x1c/0x24 (20)
[  107.088021]  [<c0100e45>] default_idle+0x55/0x90 (44)
[  107.088026]  [<c0100f23>] cpu_idle+0x83/0xd0 (12)
[  107.088033] ------------------------------
[  107.088036] | showing all locks held by: |  (swapper/0 [f7fff200, 140]):
[  107.101186] ------------------------------
[  107.101188]
[  107.101189] #001:             [c039c504] {console_sem.lock}
[  107.101193] ... acquired at:               vprintk+0x175/0x2c0
[  107.101198]
[  107.101201] swapper/0[CPU#1]: BUG in __cache_alloc at mm/slab.c:2196
[  107.101205]  [<c011fb76>] __WARN_ON+0x66/0x90 (8)
[  107.101212]  [<c016b4fe>] __kmalloc+0xee/0x110 (48)
[  107.101217]  [<c02c6eed>] __alloc_skb+0x4d/0x150 (24)
[  107.101223]  [<c02d90d9>] zap_completion_queue+0xf9/0x120 (4)
[  107.101230]  [<c02d912f>] find_skb+0x2f/0xf0 (24)
[  107.101236]  [<c02d934c>] netpoll_send_udp+0x2c/0x210 (32)
[  107.101243]  [<c0272391>] write_msg+0x71/0xd0 (32)
[  107.101248]  [<c0272320>] write_msg+0x0/0xd0 (12)
[  107.101253]  [<c011ee70>] __call_console_drivers+0x40/0x60 (8)
[  107.101260]  [<c011f01b>] call_console_drivers+0xfb/0x120 (20)
[  107.101266]  [<c0272320>] write_msg+0x0/0xd0 (4)
)
<4>[  107.113999]  [<c02d90d9>] zap_completion_queue+0xf9/0x120 (4)
[  107.114006]  [<c02d912f>] find_skb+0x2f/0xf0 (24)
[  107.114012]  [<c02d934c>] netpoll_send_udp+0x2c/0x210 (32)
[  107.114018]  [<c0272391>] write_msg+0x71/0xd0 (32)
[  107.114024]  [<c0272320>] write_msg+0x0/0xd0 (12)
[  107.114029]  [<c011ee70>] __call_console_drivers+0x40/0x60 (8)
[  107.114036]  [<c011f01b>] call_console_drivers+0xfb/0x120 (20)
[  107.114042]  [<c0272320>] write_msg+0x0/0xd0 (4)
[  107.114047]  [<c011ee70>] __call_console_drivers+0x40/0x60 (8)
[  107.114053]  [<c011f4f9>] release_console_sem+0x29/0xe0 (20)
[  107.114060]  [<c011f2fc>] vprintk+0x1ac/0x2c0 (20)
[  107.114068]  [<c0111226>] smp_error_interrupt+0x56/0x60 (100)
[  107.114074]  [<c011f147>] printk+0x17/0x20 (12)
[  107.114080]  [<c0103e50>] show_trace+0x50/0xb0 (12)
[  107.114085]  [<c0111226>] smp_error_interrupt+0x56/0x60 (8)
[  107.114092]  [<c0103f53>] dump_stack+0x13/0x20 (24)
107.126816]  [<c011ee70>] __call_console_drivers+0x40/0x60 (8)
[  107.126823]  [<c011f4f9>] release_console_sem+0x29/0xe0 (20)
[  107.126829]  [<c011f2fc>] vprintk+0x1ac/0x2c0 (20)
[  107.126837]  [<c0111226>] smp_error_interrupt+0x56/0x60 (100)
[  107.126844]  [<c011f147>] printk+0x17/0x20 (12)
[  107.126850]  [<c0103e50>] show_trace+0x50/0xb0 (12)
[  107.126855]  [<c0111226>] smp_error_interrupt+0x56/0x60 (8)
[  107.126861]  [<c0103f53>] dump_stack+0x13/0x20 (24)
[  107.126866]  [<c0111226>] smp_error_interrupt+0x56/0x60 (8)
[  107.126873]  [<c0103b6c>] error_interrupt+0x1c/0x24 (20)
[  107.126879]  [<c0100e45>] default_idle+0x55/0x90 (44)
[  107.126884]  [<c0100f23>] cpu_idle+0x83/0xd0 (12)
[  107.126892] ------------------------------
[  107.126894] | showing all locks held by: |  (swapper/0 [f7fff200, 140]):
[  107.126899] ------------------------------
[  107.126902]
7.139595]  [<c0103f53>] dump_stack+0x13/0x20 (24)
<4>[  107.139601]  [<c0111226>] smp_error_interrupt+0x56/0x60 (8)
[  107.139607]  [<c0103b6c>] error_interrupt+0x1c/0x24 (20)
[  107.139613]  [<c0100e45>] default_idle+0x55/0x90 (44)
[  107.139619]  [<c0100f23>] cpu_idle+0x83/0xd0 (12)
[  107.139626] ------------------------------
[  107.139628] | showing all locks held by: |  (swapper/0 [f7fff200, 140]):
[  107.139633] ------------------------------
[  107.139636]
[  107.139637] #001:             [c039c504] {console_sem.lock}
[  107.139641] ... acquired at:               vprintk+0x175/0x2c0
[  107.139646]
[  107.139691] swapper/0[CPU#1]: BUG in __cache_alloc at mm/slab.c:2196
[  107.139695]  [<c011fb76>] __WARN_ON+0x66/0x90 (8)
[  107.139702]  [<c016b3b0>] kmem_cache_alloc+0xd0/0xe0 (48)
[  107.139708]  [<c02c6ed0>] __alloc_skb+0x30/0x150 (24)
[  107.139714]  [<c02d90d9>] zap_completion_queue+0xf9/0x120 (4)

<4>[  107.153537]
<4>[  107.153538] #001:             [c039c504] {console_sem.lock}
[  107.153542] ... acquired at:               vprintk+0x175/0x2c0
[  107.153547]
[  107.153552] swapper/0[CPU#1]: BUG in __cache_alloc at mm/slab.c:2196
[  107.153555]  [<c011fb76>] __WARN_ON+0x66/0x90 (8)
[  107.153562]  [<c016b3b0>] kmem_cache_alloc+0xd0/0xe0 (48)
[  107.153568]  [<c016ab4c>] alloc_slabmgmt+0x4c/0x60 (24)
[  107.153574]  [<c016ad7a>] cache_grow+0xda/0x260 (12)
[  107.153580]  [<c016b0df>] cache_alloc_refill+0x1df/0x250 (52)
[  107.153587]  [<c016b50c>] __kmalloc+0xfc/0x110 (56)
[  107.153593]  [<c02c6eed>] __alloc_skb+0x4d/0x150 (24)
[  107.153599]  [<c02d90d9>] zap_completion_queue+0xf9/0x120 (4)
[  107.153605]  [<c02d912f>] find_skb+0x2f/0xf0 (24)
[  107.153611]  [<c02d934c>] netpoll_send_udp+0x2c/0x210 (32)
[  107.153618]  [<c0272391>] write_msg+0x71/0xd0 (32)
/0 [f7fff200, 140]):
<4>[  107.166310] ------------------------------
[  107.166313]
[  107.166314] #001:             [c039c504] {console_se<4>[ 
107.168440] swapper/0[CPU#1]: BUG in __cache_alloc at mm/slab.c:2196
[  107.168444]  [<c011fb76>] __WARN_ON+0x66/0x90 (8)
[  107.168451]  [<c016b3b0>] kmem_cache_alloc+0xd0/0xe0 (48)
[  107.168456]  [<c02c6ed0>] __alloc_skb+0x30/0x150 (24)
[  107.168462]  [<c02d90d9>] zap_completion_queue+0xf9/0x120 (4)
[  107.168469]  [<c02d912f>] find_skb+0x2f/0xf0 (24)
[  107.168475]  [<c02d934c>] netpoll_send_udp+0x2c/0x210 (32)
[  107.168481]  [<c0272391>] write_msg+0x71/0xd0 (32)
[  107.168487]  [<c0272320>] write_msg+0x0/0xd0 (12)
[  107.168492]  [<c011ee70>] __call_console_drivers+0x40/0x60 (8)
[  107.168498]  [<c011f01b>] call_console_drivers+0xfb/0x120 (20)
[  107.168504]  [<c0272320>] write_msg+0x0/0xd0 (4)
[  107.168509]  [<c011ee70>] __call_console_drivers+0x40/0x60 (8)
[  107.168516]  [<c011f4f9>] release_console_sem+0x29/0xe0 (20)
[  107.168522]  [<c011f2fc>] vprintk+0x1ac/0x2c0 (20)
7.181097]  [<c0272391>] write_msg+0x71/0xd0 (32)
<4>[  107.181103]  [<c0272320>] write_msg+0x0/0xd0 (12)
[  107.181108]  [<c011ee70>] __call_console_drivers+0x40/0x60 (8)
[  107.181115]  [<c011f01b>] call_console_drivers+0xfb/0x120 (20)
[  107.181121]  [<c0272320>] write_msg+0x0/0xd0 (4)
[  107.181126]  [<c011ee70>] __call_console_drivers+0x40/0x60 (8)
[  107.181132]  [<c011f4f9>] release_console_sem+0x29/0xe0 (20)
[  107.181139]  [<c011f2fc>] vprintk+0x1ac/0x2c0 (20)
[  107.181147]  [<c0111226>] smp_error_interrupt+0x56/0x60 (100)
[  107.181153]  [<c011f147>] printk+0x17/0x20 (12)
[  107.181159]  [<c0103e50>] show_trace+0x50/0xb0 (12)
[  107.181164]  [<c0111226>] smp_error_interrupt+0x56/0x60 (8)
[  107.181170]  [<c0103f53>] dump_stack+0x13/0x20 (24)
printk+0x1ac/0x2c0 (20)
7.277558]  [<c0100e45>] default_idle+0x55/0x90 (44)
<4>[  107.277563]  [<c0100f23>] cpu_idle+0x83/0xd0 (12)
[  107.277570] ------------------------------
[  107.277573] | showing all locks held by: |  (swapper/0 [f7fff200, 140]):
[  107.277577] ------------------------------
[  107.277580]
[  107.277581] #001:             [c039c504] {console_sem.lock}
[  107.277585] ... acquired at:               vprintk+0x175/0x2c0
[  107.277590]
[  107.277594] swapper/0[CPU#1]: BUG in __cache_alloc at mm/slab.c:2209
[  107.277597]  [<c011fb76>] __WARN_ON+0x66/0x90 (8)
[  107.277604]  [<c016b38d>] kmem_cache_alloc+0xad/0xe0 (48)
[  107.277610]  [<c02c6ed0>] __alloc_skb+0x30/0x150 (24)
[  107.277616]  [<c02d90d9>] zap_completion_queue+0xf9/0x120 (4)
[  107.277622]  [<c02d912f>] find_skb+0x2f/0xf0 (24)
[  107.277628]  [<c02d934c>] netpoll_send_udp+0x2c/0x210 (32)
[  107.277635]  [<c0272391>] write_msg+0x71/0xd0 (32)
[  107.277640]  [<c0272320>] write_msg+0x0/0xd0 (12)
4>[  107.290396]  [<c0103e50>] show_trace+0x50/0xb0 (12)
<4>[  107.290402]  [<c0111226>] smp_error_interrupt+0x56/0x60 (8)
[  107.290408]  [<c0103f53>] dump_stack+0x13/0x20 (24)
[  107.290413]  [<c0111226>] smp_error_interrupt+0x56/0x60 (8)
[  107.290420]  [<c0103b6c>] error_interrupt+0x1c/0x24 (20)
[  107.290426]  [<c0100e45>] default_idle+0x55/0x90 (44)
[  107.290431]  [<c0100f23>] cpu_idle+0x83/0xd0 (12)
[  107.290439] ------------------------------
[  107.290441] | showing all locks held by: |  (swapper/0 [f7fff200, 140]):
[  107.290446] ------------------------------
[  107.290448]
[  107.290450] #001:             [c039c504] {console_sem.lock}
[  107.290453] ... acquired at:               vprintk+0x175/0x2c0
[  107.290458]
[  107.290462] swapper/0[CPU#1]: BUG in __cache_alloc at mm/slab.c:2209
[  107.290465]  [<c011fb76>] __WARN_ON+0x66/0x90 (8)
[  107.290472]  [<c016b38d>] kmem_cache_alloc+0xad/0xe0 (48)
[  107.290478]  [<c02c6ed0>] __alloc_skb+0x30/0x150 (24)
30]  [<c011ee70>] __call_console_drivers+0x40/0x60 (8)
<4>[  107.303237]  [<c011f4f9>] release_console_sem+0x29/0xe0 (20)
[  107.303243]  [<c011f2fc>] vprintk+0x1ac/0x2c0 (20)
[  107.303251]  [<c0111226>] smp_error_interrupt+0x56/0x60 (100)
[  107.303258]  [<c011f147>] printk+0x17/0x20 (12)
[  107.303263]  [<c0103e50>] show_trace+0x50/0xb0 (12)
[  107.303269]  [<c0111226>] smp_error_interrupt+0x56/0x60 (8)
[  107.303275]  [<c0103f53>] dump_stack+0x13/0x20 (24)
[  107.303280]  [<c0111226>] smp_error_interrupt+0x56/0x60 (8)
[  107.303286]  [<c0103b6c>] error_interrupt+0x1c/0x24 (20)
[  107.303293]  [<c0100e45>] default_idle+0x55/0x90 (44)
[  107.303298]  [<c0100f23>] cpu_idle+0x83/0xd0 (12)
[  107.303305] ------------------------------
[  107.303308] | showing all locks held by: |  (swapper/0 [f7fff200, 140]):
[  107.303313] ------------------------------
[  107.303315]
[  107.303317] #001:             [c039c504] {console_sem.lock}
[  107.303320] ... acquired at:               vprintk+0x175/0x2c0
/0xd0 (32)
<4>[  107.316071]  [<c0272320>] write_msg+0x0/0xd0 (12)
[  107.316076]  [<c011ee70>] __call_console_drivers+0x40/0x60 (8)
[  107.316083]  [<c011f01b>] call_console_drivers+0xfb/0x120 (20)
[  107.316089]  [<c0272320>] write_msg+0x0/0xd0 (4)
[  107.316094]  [<c011ee70>] __call_console_drivers+0x40/0x60 (8)
[  107.316100]  [<c011f4f9>] release_console_sem+0x29/0xe0 (20)
[  107.316107]  [<c011f2fc>] vprintk+0x1ac/0x2c0 (20)
[  107.316115]  [<c0111226>] smp_error_interrupt+0x56/0x60 (100)
[  107.316121]  [<c011f147>] printk+0x17/0x20 (12)
[  107.316127]  [<c0103e50>] show_trace+0x50/0xb0 (12)
[  107.316132]  [<c0111226>] smp_error_interrupt+0x56/0x60 (8)
[  107.316139]  [<c0103f53>] dump_stack+0x13/0x20 (24)
[  107.316144]  [<c0111226>] smp_error_interrupt+0x56/0x60 (8)
[  107.316150]  [<c0103b6c>] error_interrupt+0x1c/0x24 (20)
[  107.316157]  [<c0100e45>] default_idle+0x55/0x90 (44)
[  107.316162]  [<c0100f23>] cpu_idle+0x83/0xd0 (12)
[  107.316169] ------------------------------
908]  [<c02c6ed0>] __alloc_skb+0x30/0x150 (24)
<4>[  107.328914]  [<c02d90d9>] zap_completion_queue+0xf9/0x120 (4)
[  107.328921]  [<c02d912f>] find_skb+0x2f/0xf0 (24)
[  107.328927]  [<c02d934c>] netpoll_send_udp+0x2c/0x210 (32)
[  107.328933]  [<c0272391>] write_msg+0x71/0xd0 (32)
[  107.328939]  [<c0272320>] write_msg+0x0/0xd0 (12)
[  107.328944]  [<c011ee70>] __call_console_drivers+0x40/0x60 (8)
[  107.328951]  [<c011f01b>] call_console_drivers+0xfb/0x120 (20)
[  107.328957]  [<c0272320>] write_msg+0x0/0xd0 (4)
[  107.328962]  [<c011ee70>] __call_console_drivers+0x40/0x60 (8)
[  107.328968]  [<c011f4f9>] release_console_sem+0x29/0xe0 (20)
[  107.328975]  [<c011f2fc>] vprintk+0x1ac/0x2c0 (20)
[  107.328983]  [<c0111226>] smp_error_interrupt+0x56/0x60 (100)
[  107.328989]  [<c011f147>] printk+0x17/0x20 (12)
[  107.328995]  [<c0103e50>] show_trace+0x50/0xb0 (12)
[  107.329000]  [<c0111226>] smp_error_interrupt+0x56/0x60 (8)
[  107.329007]  [<c0103f53>] dump_stack+0x13/0x20 (24)
>[  107.341709] ... acquired at:               vprintk+0x175/0x2c0
[  107.341714]
[  107.341755] swapper/0[CPU#1]: BUG in __cache_alloc at mm/slab.c:2196
[  107.341758]  [<c011fb76>] __WARN_ON+0x66/0x90 (8)
[  107.341765]  [<c016b3b0>] kmem_cache_alloc+0xd0/0xe0 (48)
[  107.341771]  [<c02c6ed0>] __alloc_skb+0x30/0x150 (24)
[  107.341777]  [<c02d90d9>] zap_completion_queue+0xf9/0x120 (4)
[  107.341784]  [<c02d912f>] find_skb+0x2f/0xf0 (24)
[  107.341790]  [<c02d934c>] netpoll_send_udp+0x2c/0x210 (32)
[  107.341796]  [<c0272391>] write_msg+0x71/0xd0 (32)
[  107.341802]  [<c0272320>] write_msg+0x0/0xd0 (12)
[  107.341807]  [<c011ee70>] __call_console_drivers+0x40/0x60 (8)
[  107.341814]  [<c011f01b>] call_console_drivers+0xfb/0x120 (20)
[  107.341820]  [<c0272320>] write_msg+0x0/0xd0 (4)
[  107.341825]  [<c011ee70>] __call_console_drivers+0x40/0x60 (8)
[  107.341831]  [<c011f4f9>] release_console_sem+0x29/0xe0 (20)
[  107.341838]  [<c011f2fc>] vprintk+0x1ac/0x2c0 (20)
[  107.354564]  [<c0111226>] smp_error_interrupt+0x56/0x60 (100)
[  107.354571]  [<c011f147>] printk+0x17/0x20 (12)
[  107.354576]  [<c0103e50>] show_trace+0x50/0xb0 (12)
[  107.354582]  [<c0111226>] smp_error_interrupt+0x56/0x60 (8)
[  107.354588]  [<c0103f53>] dump_stack+0x13/0x20 (24)
[  107.354593]  [<c0111226>] smp_error_interrupt+0x56/0x60 (8)
[  107.354599]  [<c0103b6c>] error_interrupt+0x1c/0x24 (20)
[  107.354606]  [<c0100e45>] default_idle+0x55/0x90 (44)
[  107.354611]  [<c0100f23>] cpu_idle+0x83/0xd0 (12)
[  107.354618] ------------------------------
[  107.354621] | showing all locks held by: |  (swapper/0 [f7fff200, 140]):
[  107.354625] ------------------------------
[  107.354628]
[  107.354629] #001:             [c039c504] {console_sem.lock}
[  107.354633] ... acquired at:               vprintk+0x175/0x2c0
[  107.354638]
[  107.354641] swapper/0[CPU#1]: BUG in __cache_alloc at mm/slab.c:2196
0x90 (44)
<4>[  107.368525]  [<c0100f23>] cpu_idle+0x83/0xd0 (12)
[  107.368532] ------------------------------
x56/0x60 (8)
[  107.452314]  [<c0103f53>] dump_stack+0x13/0x20 (24)
[  107.452320]  [<c0111226>] smp_error_interrupt+0x56/0x60 (8)
[  107.452326]  [<c0103b6c>] error_interrupt+0x1c/0x24 (20)
[  107.452332]  [<c0100e45>] default_idle+0x55/0x90 (44)
[  107.452338]  [<c0100f23>] cpu_idle+0x83/0xd0 (12)
[  107.452345] ------------------------------
[  107.452347] | showing all locks held by: |  (swapper/0 [f7fff200, 140]):
[  107.452352] ------------------------------
[  107.452355]
[  107.452356] #001:             [c039c504] {console_sem.lock}
[  107.452360] ... acquired at:               vprintk+0x175/0x2c0
[  107.452365]
l_send_udp+0x2c/0x210 (32)
<4>[  107.464972]  [<c0272391>] write_msg+0x71/0xd0 (32)
[  107.464977]  [<c0272320>] write_msg+0x0/0xd0 (12)
[  107.464983]  [<c011ee70>] __call_console_drivers+0x40/0x60 (8)
[  107.464989]  [<c011f01b>] call_console_drivers+0xfb/0x120 (20)
[  107.464995]  [<c0272320>] write_msg+0x0/0xd0 (4)
[  107.465000]  [<c011ee70>] __call_console_drivers+0x40/0x60 (8)
[  107.465007]  [<c011f4f9>] release_console_sem+0x29/0xe0 (20)
[  107.465013]  [<c011f2fc>] vprintk+0x1ac/0x2c0 (20)
[  107.465021]  [<c0111226>] smp_error_interrupt+0x56/0x60 (100)
[  107.465028]  [<c011f147>] printk+0x17/0x20 (12)
[  107.465033]  [<c0103e50>] show_trace+0x50/0xb0 (12)
[  107.465039]  [<c0111226>] smp_error_interrupt+0x56/0x60 (8)
[  107.465045]  [<c0103f53>] dump_stack+0x13/0x20 (24)
[  107.465050]  [<c0111226>] smp_error_interrupt+0x56/0x60 (8)
[  107.465056]  [<c0103b6c>] error_interrupt+0x1c/0x24 (20)
[  107.465063]  [<c0100e45>] default_idle+0x55/0x90 (44)
[  107.465068]  [<c0100f23>] cpu_idle+0x83/0xd0 (12)
d>] kmem_cache_alloc+0xad/0xe0 (48)
<4>[  107.477804]  [<c02c6ed0>] __alloc_skb+0x30/0x150 (24)
[  107.477811]  [<c02d90d9>] zap_completion_queue+0xf9/0x120 (4)
[  107.477817]  [<c02d912f>] find_skb+0x2f/0xf0 (24)
[  107.477823]  [<c02d934c>] netpoll_send_udp+0x2c/0x210 (32)
[  107.477829]  [<c0272391>] write_msg+0x71/0xd0 (32)
[  107.477835]  [<c0272320>] write_msg+0x0/0xd0 (12)
[  107.477840]  [<c011ee70>] __call_console_drivers+0x40/0x60 (8)
[  107.477847]  [<c011f01b>] call_console_drivers+0xfb/0x120 (20)
[  107.477853]  [<c0272320>] write_msg+0x0/0xd0 (4)
[  107.477858]  [<c011ee70>] __call_console_drivers+0x40/0x60 (8)
[  107.477864]  [<c011f4f9>] release_console_sem+0x29/0xe0 (20)
[  107.477871]  [<c011f2fc>] vprintk+0x1ac/0x2c0 (20)
[  107.477879]  [<c0111226>] smp_error_interrupt+0x56/0x60 (100)
[  107.477885]  [<c011f147>] printk+0x17/0x20 (12)
[  107.477891]  [<c0103e50>] show_trace+0x50/0xb0 (12)
[  107.477896]  [<c0111226>] smp_error_interrupt+0x56/0x60 (8)
[  107.477903]  [<c0103f53>] dump_stack+0x13/0x20 (24)
>[  107.490655] ... acquired at:               vprintk+0x175/0x2c0
[  107.490660]
[  107.490663] swapper/0[CPU#1]: BUG in __cache_alloc at mm/slab.c:2209
[  107.490667]  [<c011fb76>] __WARN_ON+0x66/0x90 (8)
[  107.490674]  [<c016b38d>] kmem_cache_alloc+0xad/0xe0 (48)
[  107.490680]  [<c02c6ed0>] __alloc_skb+0x30/0x150 (24)
[  107.490686]  [<c02d90d9>] zap_completion_queue+0xf9/0x120 (4)
[  107.490692]  [<c02d912f>] find_skb+0x2f/0xf0 (24)
[  107.490698]  [<c02d934c>] netpoll_send_udp+0x2c/0x210 (32)
[  107.490705]  [<c0272391>] write_msg+0x71/0xd0 (32)
[  107.490710]  [<c0272320>] write_msg+0x0/0xd0 (12)
[  107.490715]  [<c011ee70>] __call_console_drivers+0x40/0x60 (8)
[  107.490722]  [<c011f01b>] call_console_drivers+0xfb/0x120 (20)
[  107.490728]  [<c0272320>] write_msg+0x0/0xd0 (4)
[  107.490733]  [<c011ee70>] __call_console_drivers+0x40/0x60 (8)
[  107.490739]  [<c011f4f9>] release_console_sem+0x29/0xe0 (20)
[  107.490746]  [<c011f2fc>] vprintk+0x1ac/0x2c0 (20)
]  [<c0100f23>] cpu_idle+0x83/0xd0 (12)

----------- CUT -----------------
