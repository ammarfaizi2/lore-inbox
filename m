Return-Path: <linux-kernel-owner+w=401wt.eu-S1753681AbWL0JAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681AbWL0JAH (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 04:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753734AbWL0JAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 04:00:07 -0500
Received: from bay0-omc2-s23.bay0.hotmail.com ([65.54.246.159]:10543 "EHLO
	bay0-omc2-s23.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753681AbWL0JAD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 04:00:03 -0500
X-Greylist: delayed 846 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Dec 2006 04:00:03 EST
Message-ID: <BAY103-DAV126C84F5C7B9CEA10A7973B2C00@phx.gbl>
X-Originating-IP: [85.36.106.198]
X-Originating-Email: [pupilla@hotmail.com]
From: "Marco Berizzi" <pupilla@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: kernel BUG at mm/slab.c:607 in 2.6.19.1
Date: Wed, 27 Dec 2006 09:45:51 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1123
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1123
X-OriginalArrivalTime: 27 Dec 2006 08:45:56.0062 (UTC) FILETIME=[6C802FE0:01C72993]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody.
This morning isc dhcpd 3.0.5 running on linux 2.6.19.1
(slackware 10.2 glibc 2.3.5 gcc 3.3.6) has been crashed
and this error was logged (I have also noticed that any
kernel message event are written to /var/log/syslog).
Is this a kernel or hardware problem?

root@Gemini:/tmp/KERNEL# dmesg
Linux version 2.6.19.1 (root@Gemini) (gcc version 3.3.6) #1 Wed Dec 13
12:10:53 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000a000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
160MB LOWMEM available.
Entering add_active_range(0, 0, 40960) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->    40960
early_node_map[1] active PFN ranges
    0:        0 ->    40960
On node 0 totalpages: 40960
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 288 pages used for memmap
  Normal zone: 36576 pages, LIFO batch:7
DMI 2.1 present.
ACPI: Unable to locate RSDP
Allocating PCI resources starting at 10000000 (gap: 0a000000:f5ff0000)
Detected 300.703 MHz processor.
Built 1 zonelists.  Total pages: 40640
Kernel command line: auto BOOT_IMAGE=Linux ro root=301
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01141000)
Enabling fast FPU save and restore... done.
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 4096 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 159076k/163840k available (1915k kernel code, 4336k reserved,
573k data, 160k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffb7000 - 0xfffff000   ( 288 kB)
    vmalloc : 0xca800000 - 0xfffb5000   ( 855 MB)
    lowmem  : 0xc0000000 - 0xca000000   ( 160 MB)
      .init : 0xc0372000 - 0xc039a000   ( 160 kB)
      .data : 0xc02dedc1 - 0xc036e494   ( 573 kB)
      .text : 0xc0100000 - 0xc02dedc1   (1915 kB)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Calibrating delay using timer specific routine.. 602.07 BogoMIPS
(lpj=1204148)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0183f9ff 00000000 00000000 00000000
00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU: After all inits, caps: 0183f9ff 00000000 00000000 00000040 00000000
00000000 00000000
CPU: Intel Celeron (Mendocino) stepping 00
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfda61, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter disabled.
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
* Found PM-Timer Bug on the chipset. Due to workarounds for a bug,
* this clock source is slow. Consider trying other clock sources
PCI quirk: region 6100-613f claimed by PIIX4 ACPI
PCI quirk: region 5f00-5f0f claimed by PIIX4 SMB
Boot video device is 0000:01:00.0
PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:07.0
PCI: setting IRQ 11 as level-triggered
PCI: Found IRQ 11 for device 0000:00:07.2
PCI: Sharing IRQ 11 with 0000:00:0b.0
PCI: Bridge: 0000:00:01.0
  IO window: b000-bfff
  MEM window: efe00000-efefffff
  PREFETCH window: e5c00000-e7cfffff
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 8192 bind 4096)
TCP reno registered
SGI XFS with no debug enabled
io scheduler noop registered
io scheduler deadline registered (default)
Limiting direct PCI/PCI transfers.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: QUANTUM FIREBALL EX3.2A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: MATSHITA CR-588, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 6306048 sectors (3228 MB) w/418KiB Cache, CHS=6256/16/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 >
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
ip_conntrack version 2.4 (1280 buckets, 10240 max) - 228 bytes per
conntrack
input: AT Translated Set 2 keyboard as /class/input/input0
ip_tables: (C) 2000-2006 Netfilter Core Team
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Using IPI Shortcut mode
Time: tsc clocksource has been installed.
Filesystem "hda1": Disabling barriers, not supported by the underlying
device
XFS mounting filesystem hda1
Ending clean XFS mount for filesystem: hda1
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 160k freed
Adding 209624k swap on /dev/hda9.  Priority:-1 extents:1 across:209624k
Filesystem "hda1": Disabling barriers, not supported by the underlying
device
Filesystem "hda1": Disabling barriers, not supported by the underlying
device
PCI: setting IRQ 9 as level-triggered
PCI: Found IRQ 9 for device 0000:00:09.0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:09.0: 3Com PCI 3c905B Cyclone 100baseTx at ca826f80.
PCI: setting IRQ 10 as level-triggered
PCI: Found IRQ 10 for device 0000:00:0a.0
0000:00:0a.0: 3Com PCI 3c905B Cyclone 100baseTx at ca828f00.
PCI: Found IRQ 11 for device 0000:00:0b.0
PCI: Sharing IRQ 11 with 0000:00:07.2
0000:00:0b.0: 3Com PCI 3c905B Cyclone 100baseTx at ca82ae80.
ip_conntrack_pptp version 3.1 loaded
ip_nat_pptp version 3.0 loaded
Filesystem "hda5": Disabling barriers, not supported by the underlying
device
XFS mounting filesystem hda5
Ending clean XFS mount for filesystem: hda5
Filesystem "hda6": Disabling barriers, not supported by the underlying
device
XFS mounting filesystem hda6
Ending clean XFS mount for filesystem: hda6
Filesystem "hda7": Disabling barriers, not supported by the underlying
device
XFS mounting filesystem hda7
Ending clean XFS mount for filesystem: hda7
Filesystem "hda8": Disabling barriers, not supported by the underlying
device
XFS mounting filesystem hda8
Ending clean XFS mount for filesystem: hda8
eth0:  setting full-duplex.
eth1:  setting full-duplex.
eth2:  setting full-duplex.
BUG: unable to handle kernel paging request at virtual address 132bc88a
 printing eip:
c014cfb5
*pde = 00000000
Oops: 0002 [#1]
Modules linked in: ip_nat_pptp ip_conntrack_pptp ip_nat_ftp
ip_conntrack_ftp 3c59x mii
CPU:    0
EIP:    0060:[<c014cfb5>]    Not tainted VLI
EFLAGS: 00010046   (2.6.19.1 #1)
EIP is at cache_alloc_refill+0xc5/0x1b0
eax: 132bc886   ebx: 0000000b   ecx: ffffffff   edx: c117dce0
esi: c2899000   edi: 00000004   ebp: c1177a00   esp: c987fbf4
ds: 007b   es: 007b   ss: 0068
Process syslogd (pid: 272, ti=c987e000 task=c1233050 task.ti=c987e000)
Stack: c117dce8 c117dce0 00000050 c1176f80 00000296 c1176f80 00001000
c1130580
       c014d29f 00000000 00000000 c017010d 00000000 c016daca 00000001
c1130580
       00000000 c1130580 c98c5630 c016e260 00000000 c1130580 c016e9fd
c0139776
Call Trace:
 [<c014d29f>] kmem_cache_alloc+0x3f/0x50
 [<c017010d>] alloc_buffer_head+0xd/0x30
 [<c016daca>] alloc_page_buffers+0x2a/0xb0
 [<c016e260>] create_empty_buffers+0x10/0x80
 [<c016e9fd>] __block_prepare_write+0x3cd/0x410
 [<c0139776>] get_page_from_freelist+0x96/0xc0
 [<c016f1d8>] block_prepare_write+0x28/0x40
 [<c01dd1d0>] xfs_get_blocks+0x0/0x30
 [<c01370b3>] generic_file_buffered_write+0x1d3/0x5d0
 [<c01dd1d0>] xfs_get_blocks+0x0/0x30
 [<c011a4a4>] __do_softirq+0x74/0x90
 [<c010504c>] do_IRQ+0x5c/0xa0
 [<c0119ea5>] current_fs_time+0x55/0x70
 [<c016210d>] file_update_time+0x3d/0xb0
 [<c01e41b6>] xfs_write+0x916/0xac0
 [<c015b841>] core_sys_select+0x261/0x350
 [<c01279f0>] autoremove_wake_function+0x0/0x50
 [<c01df8e8>] xfs_file_aio_write+0x78/0x90
 [<c01df870>] xfs_file_aio_write+0x0/0x90
 [<c0150187>] do_sync_readv_writev+0xc7/0x110
 [<c01279f0>] autoremove_wake_function+0x0/0x50
 [<c011da60>] getnstimeofday+0x40/0x110
 [<c02031ba>] copy_from_user+0x3a/0x80
 [<c0150296>] rw_copy_check_uvector+0x66/0xe0
 [<c01503aa>] do_readv_writev+0x9a/0x180
 [<c01df870>] xfs_file_aio_write+0x0/0x90
 [<c011db6f>] do_gettimeofday+0x3f/0x130
 [<c0150529>] vfs_writev+0x49/0x60
 [<c0150637>] sys_writev+0x47/0xb0
 [<c0102bc7>] syscall_call+0x7/0xb
 =======================
Code: 89 45 00 8b 44 24 0c e8 6a fd ff ff 89 44 9d 10 8b 54 24 0c 8b 42
1c 39 46 10 73 0a 4f 83 ff ff 75 d4 8d 74 26 00 8b 56 04 8b 06 <89> 50
04 89 02 83 7e 14 ff c7 06 00 01 10 00 c7 46 04 00 02 20
EIP: [<c014cfb5>] cache_alloc_refill+0xc5/0x1b0 SS:ESP 0068:c987fbf4
 <0>------------[ cut here ]------------
kernel BUG at mm/slab.c:607!
invalid opcode: 0000 [#2]
Modules linked in: ip_nat_pptp ip_conntrack_pptp ip_nat_ftp
ip_conntrack_ftp 3c59x mii
CPU:    0
EIP:    0060:[<c014d182>]    Not tainted VLI
EFLAGS: 00010046   (2.6.19.1 #1)
EIP is at free_block+0xe2/0x100
eax: 80000060   ebx: c1000000   ecx: c2f4a95f   edx: c105e940
esi: c117dce0   edi: 00000001   ebp: c1176f80   esp: c119bef0
ds: 007b   es: 007b   ss: 0068
Process events/0 (pid: 3, ti=c119a000 task=c118f030 task.ti=c119a000)
Stack: 00000000 00000003 c1177a10 c1177a10 c1177a00 00000003 c1176f80
c014d8c1
       00000000 c117dce0 c1176f80 c1180660 00000000 c014d92b 00000000
00000000
       c03b3e80 c03b3e80 00000282 c012456d 00000000 c118f13c 000047d7
c1180678
Call Trace:
 [<c014d8c1>] drain_array+0x91/0xb0
 [<c014d92b>] cache_reap+0x4b/0xf0
 [<c012456d>] run_workqueue+0x6d/0xe0
 [<c014d8e0>] cache_reap+0x0/0xf0
 [<c0124707>] worker_thread+0x127/0x150
 [<c0112a10>] default_wake_function+0x0/0x10
 [<c0112a57>] __wake_up_common+0x37/0x70
 [<c0112a10>] default_wake_function+0x0/0x10
 [<c01245e0>] worker_thread+0x0/0x150
 [<c0127696>] kthread+0xa6/0xb0
 [<c01275f0>] kthread+0x0/0xb0
 [<c010368f>] kernel_thread_helper+0x7/0x18
 =======================
Code: 5d c3 8d b4 26 00 00 00 00 8b 55 1c 29 d0 89 da 89 46 18 89 e8 e8
6f f1 ff ff eb d3 89 33 8b 46 04 89 5e 04 89 18 89 43 04 eb c4 <0f> 0b
5f 02 2e 8b 2f c0 e9 61 ff ff ff 8b 52 0c e9 4f ff ff ff
EIP: [<c014d182>] free_block+0xe2/0x100 SS:ESP 0068:c119bef0
 <1>BUG: unable to handle kernel paging request at virtual address
e9f75edf
 printing eip:
c016ff00
*pde = 00000000
Oops: 0002 [#3]
Modules linked in: ip_nat_pptp ip_conntrack_pptp ip_nat_ftp
ip_conntrack_ftp 3c59x mii
CPU:    0
EIP:    0060:[<c016ff00>]    Not tainted VLI
EFLAGS: 00010206   (2.6.19.1 #1)
EIP is at drop_buffers+0x70/0x100
eax: 326b106a   ebx: c2f4a827   ecx: c2f4a84b   edx: e9f75edb
esi: c2f4a827   edi: c2f4a827   ebp: c108b260   esp: c9879e3c
ds: 007b   es: 007b   ss: 0068
Process crond (pid: 608, ti=c9878000 task=c1248ab0 task.ti=c9878000)
Stack: c9879e98 00000000 c0161f91 c0331060 c9879e64 c108b260 c9879e8c
c9879eb4
       00000000 c016ffc3 00000000 c108b260 c9879e8c c01dcfcf c9879e88
00000000
       c57c06d8 00000000 00000001 00000000 00000000 00000001 00000000
00000001
Call Trace:
 [<c0161f91>] iput+0x31/0x70
 [<c016ffc3>] try_to_free_buffers+0x33/0x80
 [<c01dcfcf>] xfs_vm_releasepage+0xcf/0xe0
 [<c01dcf00>] xfs_vm_releasepage+0x0/0xe0
 [<c0137d05>] try_to_release_page+0x45/0x70
 [<c013c264>] do_invalidatepage+0x14/0x30
 [<c013c2be>] truncate_complete_page+0x3e/0x40
 [<c013c40b>] truncate_inode_pages_range+0xfb/0x2a0
 [<c013c5c7>] truncate_inode_pages+0x17/0x20
 [<c0161e05>] generic_delete_inode+0xa5/0xb0
 [<c0161fb3>] iput+0x53/0x70
 [<c015f478>] dput+0x98/0x120
 [<c0150cc3>] __fput+0x103/0x170
 [<c014f3e3>] filp_close+0x43/0x70
 [<c014f45e>] sys_close+0x4e/0x80
 [<c0102bc7>] syscall_call+0x7/0xb
 [<c02d007b>] xfrm_alloc_userspi+0x14b/0x190
 =======================
Code: 43 30 83 e2 06 09 d0 75 62 8b 5b 04 39 f3 75 cb 8d 74 26 00 8d bc
27 00 00 00 00 8b 53 24 8d 4b 24 8b 7b 04 39 ca 74 2b 8b 41 04 <89> 42
04 89 10 89 49 04 8b 53 2c 89 4b 24 85 d2 74 38 8b 03 f6
EIP: [<c016ff00>] drop_buffers+0x70/0x100 SS:ESP 0068:c9879e3c
 <1>BUG: unable to handle kernel NULL pointer dereference at virtual
address 00000004
 printing eip:
c016ff00
*pde = 00000000
Oops: 0002 [#4]
Modules linked in: ip_nat_pptp ip_conntrack_pptp ip_nat_ftp
ip_conntrack_ftp 3c59x mii
CPU:    0
EIP:    0060:[<c016ff00>]    Not tainted VLI
EFLAGS: 00010217   (2.6.19.1 #1)
EIP is at drop_buffers+0x70/0x100
eax: 00000000   ebx: c2f49f37   ecx: c2f49f5b   edx: 00000000
esi: c2f49f37   edi: c2f49f37   ebp: c11349c0   esp: c8e2be1c
ds: 007b   es: 007b   ss: 0068
Process dhcpd (pid: 787, ti=c8e2a000 task=c12bf570 task.ti=c8e2a000)
Stack: 00000ad2 c4c65760 458cac71 0d0bc6dd c8e2be44 c11349c0 c8e2be6c
c8e2be94
       00000000 c016ffc3 00000000 c11349c0 c8e2be6c c01dcfcf c8e2be68
00000000
       c0d73ab8 00000000 00000001 00000000 00000000 00000001 00000000
00000001
Call Trace:
 [<c016ffc3>] try_to_free_buffers+0x33/0x80
 [<c01dcfcf>] xfs_vm_releasepage+0xcf/0xe0
 [<c01dcf00>] xfs_vm_releasepage+0x0/0xe0
 [<c0137d05>] try_to_release_page+0x45/0x70
 [<c013c264>] do_invalidatepage+0x14/0x30
 [<c013c2be>] truncate_complete_page+0x3e/0x40
 [<c013c40b>] truncate_inode_pages_range+0xfb/0x2a0
 [<c0175e48>] inotify_inode_is_dead+0x18/0x80
 [<c015f3d2>] dentry_iput+0x92/0xa0
 [<c013c5c7>] truncate_inode_pages+0x17/0x20
 [<c0161e05>] generic_delete_inode+0xa5/0xb0
 [<c0161fb3>] iput+0x53/0x70
 [<c0158cb9>] do_unlinkat+0xb9/0x110
 [<c016c941>] do_fsync+0x81/0x90
 [<c0102bc7>] syscall_call+0x7/0xb
 =======================
Code: 43 30 83 e2 06 09 d0 75 62 8b 5b 04 39 f3 75 cb 8d 74 26 00 8d bc
27 00 00 00 00 8b 53 24 8d 4b 24 8b 7b 04 39 ca 74 2b 8b 41 04 <89> 42
04 89 10 89 49 04 8b 53 2c 89 4b 24 85 d2 74 38 8b 03 f6
EIP: [<c016ff00>] drop_buffers+0x70/0x100 SS:ESP 0068:c8e2be1c


root@Gemini:/tmp/KERNEL# dmesg  | ksymoops
ksymoops 2.4.11 on i686 2.6.19.1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.19.1/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod

* Found PM-Timer Bug on the chipset. Due to workarounds for a bug,
SGI XFS with no debug enabled
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:09.0: 3Com PCI 3c905B Cyclone 100baseTx at ca826f80.
0000:00:0a.0: 3Com PCI 3c905B Cyclone 100baseTx at ca828f00.
0000:00:0b.0: 3Com PCI 3c905B Cyclone 100baseTx at ca82ae80.
BUG: unable to handle kernel paging request at virtual address 132bc88a
c014cfb5
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c014cfb5>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046   (2.6.19.1 #1)
eax: 132bc886   ebx: 0000000b   ecx: ffffffff   edx: c117dce0
esi: c2899000   edi: 00000004   ebp: c1177a00   esp: c987fbf4
ds: 007b   es: 007b   ss: 0068
Stack: c117dce8 c117dce0 00000050 c1176f80 00000296 c1176f80 00001000
c1130580
       c014d29f 00000000 00000000 c017010d 00000000 c016daca 00000001
c1130580
       00000000 c1130580 c98c5630 c016e260 00000000 c1130580 c016e9fd
c0139776
Call Trace:
 [<c014d29f>] kmem_cache_alloc+0x3f/0x50
 [<c017010d>] alloc_buffer_head+0xd/0x30
 [<c016daca>] alloc_page_buffers+0x2a/0xb0
 [<c016e260>] create_empty_buffers+0x10/0x80
 [<c016e9fd>] __block_prepare_write+0x3cd/0x410
 [<c0139776>] get_page_from_freelist+0x96/0xc0
 [<c016f1d8>] block_prepare_write+0x28/0x40
 [<c01dd1d0>] xfs_get_blocks+0x0/0x30
 [<c01370b3>] generic_file_buffered_write+0x1d3/0x5d0
 [<c01dd1d0>] xfs_get_blocks+0x0/0x30
 [<c011a4a4>] __do_softirq+0x74/0x90
 [<c010504c>] do_IRQ+0x5c/0xa0
 [<c0119ea5>] current_fs_time+0x55/0x70
 [<c016210d>] file_update_time+0x3d/0xb0
 [<c01e41b6>] xfs_write+0x916/0xac0
 [<c015b841>] core_sys_select+0x261/0x350
 [<c01279f0>] autoremove_wake_function+0x0/0x50
 [<c01df8e8>] xfs_file_aio_write+0x78/0x90
 [<c01df870>] xfs_file_aio_write+0x0/0x90
 [<c0150187>] do_sync_readv_writev+0xc7/0x110
 [<c01279f0>] autoremove_wake_function+0x0/0x50
 [<c011da60>] getnstimeofday+0x40/0x110
 [<c02031ba>] copy_from_user+0x3a/0x80
 [<c0150296>] rw_copy_check_uvector+0x66/0xe0
 [<c01503aa>] do_readv_writev+0x9a/0x180
 [<c01df870>] xfs_file_aio_write+0x0/0x90
 [<c011db6f>] do_gettimeofday+0x3f/0x130
 [<c0150529>] vfs_writev+0x49/0x60
 [<c0150637>] sys_writev+0x47/0xb0
 [<c0102bc7>] syscall_call+0x7/0xb
Code: 89 45 00 8b 44 24 0c e8 6a fd ff ff 89 44 9d 10 8b 54 24 0c 8b 42
1c 39 46 10 73 0a 4f 83 ff ff 75 d4 8d 74 26 00 8b 56 04 8b 06 <89> 50
04 89 02 83 7e 14 ff c7 06 00 01 10 00 c7 46 04 00 02 20


>>EIP; c014cfb5 <cache_alloc_refill+c5/1b0>   <=====

>>eax; 132bc886 <phys_startup_32+131bc886/c0000000>

Trace; c014d29f <kmem_cache_alloc+3f/50>
Trace; c017010d <alloc_buffer_head+d/30>
Trace; c016daca <alloc_page_buffers+2a/b0>
Trace; c016e260 <create_empty_buffers+10/80>
Trace; c016e9fd <__block_prepare_write+3cd/410>
Trace; c0139776 <get_page_from_freelist+96/c0>
Trace; c016f1d8 <block_prepare_write+28/40>
Trace; c01dd1d0 <xfs_get_blocks+0/30>
Trace; c01370b3 <generic_file_buffered_write+1d3/5d0>
Trace; c01dd1d0 <xfs_get_blocks+0/30>
Trace; c011a4a4 <__do_softirq+74/90>
Trace; c010504c <do_IRQ+5c/a0>
Trace; c0119ea5 <current_fs_time+55/70>
Trace; c016210d <file_update_time+3d/b0>
Trace; c01e41b6 <xfs_write+916/ac0>
Trace; c015b841 <core_sys_select+261/350>
Trace; c01279f0 <autoremove_wake_function+0/50>
Trace; c01df8e8 <xfs_file_aio_write+78/90>
Trace; c01df870 <xfs_file_aio_write+0/90>
Trace; c0150187 <do_sync_readv_writev+c7/110>
Trace; c01279f0 <autoremove_wake_function+0/50>
Trace; c011da60 <getnstimeofday+40/110>
Trace; c02031ba <copy_from_user+3a/80>
Trace; c0150296 <rw_copy_check_uvector+66/e0>
Trace; c01503aa <do_readv_writev+9a/180>
Trace; c01df870 <xfs_file_aio_write+0/90>
Trace; c011db6f <do_gettimeofday+3f/130>
Trace; c0150529 <vfs_writev+49/60>
Trace; c0150637 <sys_writev+47/b0>
Trace; c0102bc7 <syscall_call+7/b>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c014cf8a <cache_alloc_refill+9a/1b0>
00000000 <_EIP>:
Code;  c014cf8a <cache_alloc_refill+9a/1b0>
   0:   89 45 00                  mov    %eax,0x0(%ebp)
Code;  c014cf8d <cache_alloc_refill+9d/1b0>
   3:   8b 44 24 0c               mov    0xc(%esp),%eax
Code;  c014cf91 <cache_alloc_refill+a1/1b0>
   7:   e8 6a fd ff ff            call   fffffd76 <_EIP+0xfffffd76>
Code;  c014cf96 <cache_alloc_refill+a6/1b0>
   c:   89 44 9d 10               mov    %eax,0x10(%ebp,%ebx,4)
Code;  c014cf9a <cache_alloc_refill+aa/1b0>
  10:   8b 54 24 0c               mov    0xc(%esp),%edx
Code;  c014cf9e <cache_alloc_refill+ae/1b0>
  14:   8b 42 1c                  mov    0x1c(%edx),%eax
Code;  c014cfa1 <cache_alloc_refill+b1/1b0>
  17:   39 46 10                  cmp    %eax,0x10(%esi)
Code;  c014cfa4 <cache_alloc_refill+b4/1b0>
  1a:   73 0a                     jae    26 <_EIP+0x26>
Code;  c014cfa6 <cache_alloc_refill+b6/1b0>
  1c:   4f                        dec    %edi
Code;  c014cfa7 <cache_alloc_refill+b7/1b0>
  1d:   83 ff ff                  cmp    $0xffffffff,%edi
Code;  c014cfaa <cache_alloc_refill+ba/1b0>
  20:   75 d4                     jne    fffffff6 <_EIP+0xfffffff6>
Code;  c014cfac <cache_alloc_refill+bc/1b0>
  22:   8d 74 26 00               lea    0x0(%esi),%esi
Code;  c014cfb0 <cache_alloc_refill+c0/1b0>
  26:   8b 56 04                  mov    0x4(%esi),%edx
Code;  c014cfb3 <cache_alloc_refill+c3/1b0>
  29:   8b 06                     mov    (%esi),%eax

This decode from eip onwards should be reliable

Code;  c014cfb5 <cache_alloc_refill+c5/1b0>
00000000 <_EIP>:
Code;  c014cfb5 <cache_alloc_refill+c5/1b0>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c014cfb8 <cache_alloc_refill+c8/1b0>
   3:   89 02                     mov    %eax,(%edx)
Code;  c014cfba <cache_alloc_refill+ca/1b0>
   5:   83 7e 14 ff               cmpl   $0xffffffff,0x14(%esi)
Code;  c014cfbe <cache_alloc_refill+ce/1b0>
   9:   c7 06 00 01 10 00         movl   $0x100100,(%esi)
Code;  c014cfc4 <cache_alloc_refill+d4/1b0>
   f:   c7                        .byte 0xc7
Code;  c014cfc5 <cache_alloc_refill+d5/1b0>
  10:   46                        inc    %esi
Code;  c014cfc6 <cache_alloc_refill+d6/1b0>
  11:   04 00                     add    $0x0,%al
Code;  c014cfc8 <cache_alloc_refill+d8/1b0>
  13:   02 20                     add    (%eax),%ah

EIP: [<c014cfb5>] cache_alloc_refill+0xc5/0x1b0 SS:ESP 0068:c987fbf4
kernel BUG at mm/slab.c:607!
CPU:    0
EIP:    0060:[<c014d182>]    Not tainted VLI
EFLAGS: 00010046   (2.6.19.1 #1)
eax: 80000060   ebx: c1000000   ecx: c2f4a95f   edx: c105e940
esi: c117dce0   edi: 00000001   ebp: c1176f80   esp: c119bef0
ds: 007b   es: 007b   ss: 0068
Stack: 00000000 00000003 c1177a10 c1177a10 c1177a00 00000003 c1176f80
c014d8c1
       00000000 c117dce0 c1176f80 c1180660 00000000 c014d92b 00000000
00000000
       c03b3e80 c03b3e80 00000282 c012456d 00000000 c118f13c 000047d7
c1180678
Call Trace:
 [<c014d8c1>] drain_array+0x91/0xb0
 [<c014d92b>] cache_reap+0x4b/0xf0
 [<c012456d>] run_workqueue+0x6d/0xe0
 [<c014d8e0>] cache_reap+0x0/0xf0
 [<c0124707>] worker_thread+0x127/0x150
 [<c0112a10>] default_wake_function+0x0/0x10
 [<c0112a57>] __wake_up_common+0x37/0x70
 [<c0112a10>] default_wake_function+0x0/0x10
 [<c01245e0>] worker_thread+0x0/0x150
 [<c0127696>] kthread+0xa6/0xb0
 [<c01275f0>] kthread+0x0/0xb0
 [<c010368f>] kernel_thread_helper+0x7/0x18
Code: 5d c3 8d b4 26 00 00 00 00 8b 55 1c 29 d0 89 da 89 46 18 89 e8 e8
6f f1 ff ff eb d3 89 33 8b 46 04 89 5e 04 89 18 89 43 04 eb c4 <0f> 0b
5f 02 2e 8b 2f c0 e9 61 ff ff ff 8b 52 0c e9 4f ff ff ff


>>EIP; c014cfb5 <cache_alloc_refill+c5/1b0>   <=====
>>EIP; c014d182 <free_block+e2/100>   <=====

>>eax; 80000060 <phys_startup_32+7ff00060/c0000000>

Trace; c014d8c1 <drain_array+91/b0>
Trace; c014d92b <cache_reap+4b/f0>
Trace; c012456d <run_workqueue+6d/e0>
Trace; c014d8e0 <cache_reap+0/f0>
Trace; c0124707 <worker_thread+127/150>
Trace; c0112a10 <default_wake_function+0/10>
Trace; c0112a57 <__wake_up_common+37/70>
Trace; c0112a10 <default_wake_function+0/10>
Trace; c01245e0 <worker_thread+0/150>
Trace; c0127696 <kthread+a6/b0>
Trace; c01275f0 <kthread+0/b0>
Trace; c010368f <kernel_thread_helper+7/18>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c014d157 <free_block+b7/100>
00000000 <_EIP>:
Code;  c014d157 <free_block+b7/100>
   0:   5d                        pop    %ebp
Code;  c014d158 <free_block+b8/100>
   1:   c3                        ret
Code;  c014d159 <free_block+b9/100>
   2:   8d b4 26 00 00 00 00      lea    0x0(%esi),%esi
Code;  c014d160 <free_block+c0/100>
   9:   8b 55 1c                  mov    0x1c(%ebp),%edx
Code;  c014d163 <free_block+c3/100>
   c:   29 d0                     sub    %edx,%eax
Code;  c014d165 <free_block+c5/100>
   e:   89 da                     mov    %ebx,%edx
Code;  c014d167 <free_block+c7/100>
  10:   89 46 18                  mov    %eax,0x18(%esi)
Code;  c014d16a <free_block+ca/100>
  13:   89 e8                     mov    %ebp,%eax
Code;  c014d16c <free_block+cc/100>
  15:   e8 6f f1 ff ff            call   fffff189 <_EIP+0xfffff189>
Code;  c014d171 <free_block+d1/100>
  1a:   eb d3                     jmp    ffffffef <_EIP+0xffffffef>
Code;  c014d173 <free_block+d3/100>
  1c:   89 33                     mov    %esi,(%ebx)
Code;  c014d175 <free_block+d5/100>
  1e:   8b 46 04                  mov    0x4(%esi),%eax
Code;  c014d178 <free_block+d8/100>
  21:   89 5e 04                  mov    %ebx,0x4(%esi)
Code;  c014d17b <free_block+db/100>
  24:   89 18                     mov    %ebx,(%eax)
Code;  c014d17d <free_block+dd/100>
  26:   89 43 04                  mov    %eax,0x4(%ebx)
Code;  c014d180 <free_block+e0/100>
  29:   eb c4                     jmp    ffffffef <_EIP+0xffffffef>

This decode from eip onwards should be reliable

Code;  c014d182 <free_block+e2/100>
00000000 <_EIP>:
Code;  c014d182 <free_block+e2/100>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c014d184 <free_block+e4/100>
   2:   5f                        pop    %edi
Code;  c014d185 <free_block+e5/100>
   3:   02 2e                     add    (%esi),%ch
Code;  c014d187 <free_block+e7/100>
   5:   8b 2f                     mov    (%edi),%ebp
Code;  c014d189 <free_block+e9/100>
   7:   c0 e9 61                  shr    $0x61,%cl
Code;  c014d18c <free_block+ec/100>
   a:   ff                        (bad)
Code;  c014d18d <free_block+ed/100>
   b:   ff                        (bad)
Code;  c014d18e <free_block+ee/100>
   c:   ff 8b 52 0c e9 4f         decl   0x4fe90c52(%ebx)
Code;  c014d194 <free_block+f4/100>
  12:   ff                        (bad)
Code;  c014d195 <free_block+f5/100>
  13:   ff                        (bad)
Code;  c014d196 <free_block+f6/100>
  14:   ff                        .byte 0xff

EIP: [<c014d182>] free_block+0xe2/0x100 SS:ESP 0068:c119bef0
 <1>BUG: unable to handle kernel paging request at virtual address
e9f75edf
c016ff00
*pde = 00000000
Oops: 0002 [#3]
CPU:    0
EIP:    0060:[<c016ff00>]    Not tainted VLI
EFLAGS: 00010206   (2.6.19.1 #1)
eax: 326b106a   ebx: c2f4a827   ecx: c2f4a84b   edx: e9f75edb
esi: c2f4a827   edi: c2f4a827   ebp: c108b260   esp: c9879e3c
ds: 007b   es: 007b   ss: 0068
Stack: c9879e98 00000000 c0161f91 c0331060 c9879e64 c108b260 c9879e8c
c9879eb4
       00000000 c016ffc3 00000000 c108b260 c9879e8c c01dcfcf c9879e88
00000000
       c57c06d8 00000000 00000001 00000000 00000000 00000001 00000000
00000001
Call Trace:
 [<c0161f91>] iput+0x31/0x70
 [<c016ffc3>] try_to_free_buffers+0x33/0x80
 [<c01dcfcf>] xfs_vm_releasepage+0xcf/0xe0
 [<c01dcf00>] xfs_vm_releasepage+0x0/0xe0
 [<c0137d05>] try_to_release_page+0x45/0x70
 [<c013c264>] do_invalidatepage+0x14/0x30
 [<c013c2be>] truncate_complete_page+0x3e/0x40
 [<c013c40b>] truncate_inode_pages_range+0xfb/0x2a0
 [<c013c5c7>] truncate_inode_pages+0x17/0x20
 [<c0161e05>] generic_delete_inode+0xa5/0xb0
 [<c0161fb3>] iput+0x53/0x70
 [<c015f478>] dput+0x98/0x120
 [<c0150cc3>] __fput+0x103/0x170
 [<c014f3e3>] filp_close+0x43/0x70
 [<c014f45e>] sys_close+0x4e/0x80
 [<c0102bc7>] syscall_call+0x7/0xb
 [<c02d007b>] xfrm_alloc_userspi+0x14b/0x190
Code: 43 30 83 e2 06 09 d0 75 62 8b 5b 04 39 f3 75 cb 8d 74 26 00 8d bc
27 00 00 00 00 8b 53 24 8d 4b 24 8b 7b 04 39 ca 74 2b 8b 41 04 <89> 42
04 89 10 89 49 04 8b 53 2c 89 4b 24 85 d2 74 38 8b 03 f6


>>EIP; c014d182 <free_block+e2/100>   <=====
>>EIP; c016ff00 <drop_buffers+70/100>   <=====

>>eax; 326b106a <phys_startup_32+325b106a/c0000000>

Trace; c0161f91 <iput+31/70>
Trace; c016ffc3 <try_to_free_buffers+33/80>
Trace; c01dcfcf <xfs_vm_releasepage+cf/e0>
Trace; c01dcf00 <xfs_vm_releasepage+0/e0>
Trace; c0137d05 <try_to_release_page+45/70>
Trace; c013c264 <do_invalidatepage+14/30>
Trace; c013c2be <truncate_complete_page+3e/40>
Trace; c013c40b <truncate_inode_pages_range+fb/2a0>
Trace; c013c5c7 <truncate_inode_pages+17/20>
Trace; c0161e05 <generic_delete_inode+a5/b0>
Trace; c0161fb3 <iput+53/70>
Trace; c015f478 <dput+98/120>
Trace; c0150cc3 <__fput+103/170>
Trace; c014f3e3 <filp_close+43/70>
Trace; c014f45e <sys_close+4e/80>
Trace; c0102bc7 <syscall_call+7/b>
Trace; c02d007b <xfrm_alloc_userspi+14b/190>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c016fed5 <drop_buffers+45/100>
00000000 <_EIP>:
Code;  c016fed5 <drop_buffers+45/100>
   0:   43                        inc    %ebx
Code;  c016fed6 <drop_buffers+46/100>
   1:   30 83 e2 06 09 d0         xor    %al,0xd00906e2(%ebx)
Code;  c016fedc <drop_buffers+4c/100>
   7:   75 62                     jne    6b <_EIP+0x6b>
Code;  c016fede <drop_buffers+4e/100>
   9:   8b 5b 04                  mov    0x4(%ebx),%ebx
Code;  c016fee1 <drop_buffers+51/100>
   c:   39 f3                     cmp    %esi,%ebx
Code;  c016fee3 <drop_buffers+53/100>
   e:   75 cb                     jne    ffffffdb <_EIP+0xffffffdb>
Code;  c016fee5 <drop_buffers+55/100>
  10:   8d 74 26 00               lea    0x0(%esi),%esi
Code;  c016fee9 <drop_buffers+59/100>
  14:   8d bc 27 00 00 00 00      lea    0x0(%edi),%edi
Code;  c016fef0 <drop_buffers+60/100>
  1b:   8b 53 24                  mov    0x24(%ebx),%edx
Code;  c016fef3 <drop_buffers+63/100>
  1e:   8d 4b 24                  lea    0x24(%ebx),%ecx
Code;  c016fef6 <drop_buffers+66/100>
  21:   8b 7b 04                  mov    0x4(%ebx),%edi
Code;  c016fef9 <drop_buffers+69/100>
  24:   39 ca                     cmp    %ecx,%edx
Code;  c016fefb <drop_buffers+6b/100>
  26:   74 2b                     je     53 <_EIP+0x53>
Code;  c016fefd <drop_buffers+6d/100>
  28:   8b 41 04                  mov    0x4(%ecx),%eax

This decode from eip onwards should be reliable

Code;  c016ff00 <drop_buffers+70/100>
00000000 <_EIP>:
Code;  c016ff00 <drop_buffers+70/100>   <=====
   0:   89 42 04                  mov    %eax,0x4(%edx)   <=====
Code;  c016ff03 <drop_buffers+73/100>
   3:   89 10                     mov    %edx,(%eax)
Code;  c016ff05 <drop_buffers+75/100>
   5:   89 49 04                  mov    %ecx,0x4(%ecx)
Code;  c016ff08 <drop_buffers+78/100>
   8:   8b 53 2c                  mov    0x2c(%ebx),%edx
Code;  c016ff0b <drop_buffers+7b/100>
   b:   89 4b 24                  mov    %ecx,0x24(%ebx)
Code;  c016ff0e <drop_buffers+7e/100>
   e:   85 d2                     test   %edx,%edx
Code;  c016ff10 <drop_buffers+80/100>
  10:   74 38                     je     4a <_EIP+0x4a>
Code;  c016ff12 <drop_buffers+82/100>
  12:   8b 03                     mov    (%ebx),%eax
Code;  c016ff14 <drop_buffers+84/100>
  14:   f6                        .byte 0xf6

EIP: [<c016ff00>] drop_buffers+0x70/0x100 SS:ESP 0068:c9879e3c
 <1>BUG: unable to handle kernel NULL pointer dereference at virtual
address 00000004
c016ff00
*pde = 00000000
Oops: 0002 [#4]
CPU:    0
EIP:    0060:[<c016ff00>]    Not tainted VLI
EFLAGS: 00010217   (2.6.19.1 #1)
eax: 00000000   ebx: c2f49f37   ecx: c2f49f5b   edx: 00000000
esi: c2f49f37   edi: c2f49f37   ebp: c11349c0   esp: c8e2be1c
ds: 007b   es: 007b   ss: 0068
Stack: 00000ad2 c4c65760 458cac71 0d0bc6dd c8e2be44 c11349c0 c8e2be6c
c8e2be94
       00000000 c016ffc3 00000000 c11349c0 c8e2be6c c01dcfcf c8e2be68
00000000
       c0d73ab8 00000000 00000001 00000000 00000000 00000001 00000000
00000001
Call Trace:
 [<c016ffc3>] try_to_free_buffers+0x33/0x80
 [<c01dcfcf>] xfs_vm_releasepage+0xcf/0xe0
 [<c01dcf00>] xfs_vm_releasepage+0x0/0xe0
 [<c0137d05>] try_to_release_page+0x45/0x70
 [<c013c264>] do_invalidatepage+0x14/0x30
 [<c013c2be>] truncate_complete_page+0x3e/0x40
 [<c013c40b>] truncate_inode_pages_range+0xfb/0x2a0
 [<c0175e48>] inotify_inode_is_dead+0x18/0x80
 [<c015f3d2>] dentry_iput+0x92/0xa0
 [<c013c5c7>] truncate_inode_pages+0x17/0x20
 [<c0161e05>] generic_delete_inode+0xa5/0xb0
 [<c0161fb3>] iput+0x53/0x70
 [<c0158cb9>] do_unlinkat+0xb9/0x110
 [<c016c941>] do_fsync+0x81/0x90
 [<c0102bc7>] syscall_call+0x7/0xb
Code: 43 30 83 e2 06 09 d0 75 62 8b 5b 04 39 f3 75 cb 8d 74 26 00 8d bc
27 00 00 00 00 8b 53 24 8d 4b 24 8b 7b 04 39 ca 74 2b 8b 41 04 <89> 42
04 89 10 89 49 04 8b 53 2c 89 4b 24 85 d2 74 38 8b 03 f6


>>EIP; c016ff00 <drop_buffers+70/100>   <=====
>>EIP; c016ff00 <drop_buffers+70/100>   <=====

Trace; c016ffc3 <try_to_free_buffers+33/80>
Trace; c01dcfcf <xfs_vm_releasepage+cf/e0>
Trace; c01dcf00 <xfs_vm_releasepage+0/e0>
Trace; c0137d05 <try_to_release_page+45/70>
Trace; c013c264 <do_invalidatepage+14/30>
Trace; c013c2be <truncate_complete_page+3e/40>
Trace; c013c40b <truncate_inode_pages_range+fb/2a0>
Trace; c0175e48 <inotify_inode_is_dead+18/80>
Trace; c015f3d2 <dentry_iput+92/a0>
Trace; c013c5c7 <truncate_inode_pages+17/20>
Trace; c0161e05 <generic_delete_inode+a5/b0>
Trace; c0161fb3 <iput+53/70>
Trace; c0158cb9 <do_unlinkat+b9/110>
Trace; c016c941 <do_fsync+81/90>
Trace; c0102bc7 <syscall_call+7/b>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c016fed5 <drop_buffers+45/100>
00000000 <_EIP>:
Code;  c016fed5 <drop_buffers+45/100>
   0:   43                        inc    %ebx
Code;  c016fed6 <drop_buffers+46/100>
   1:   30 83 e2 06 09 d0         xor    %al,0xd00906e2(%ebx)
Code;  c016fedc <drop_buffers+4c/100>
   7:   75 62                     jne    6b <_EIP+0x6b>
Code;  c016fede <drop_buffers+4e/100>
   9:   8b 5b 04                  mov    0x4(%ebx),%ebx
Code;  c016fee1 <drop_buffers+51/100>
   c:   39 f3                     cmp    %esi,%ebx
Code;  c016fee3 <drop_buffers+53/100>
   e:   75 cb                     jne    ffffffdb <_EIP+0xffffffdb>
Code;  c016fee5 <drop_buffers+55/100>
  10:   8d 74 26 00               lea    0x0(%esi),%esi
Code;  c016fee9 <drop_buffers+59/100>
  14:   8d bc 27 00 00 00 00      lea    0x0(%edi),%edi
Code;  c016fef0 <drop_buffers+60/100>
  1b:   8b 53 24                  mov    0x24(%ebx),%edx
Code;  c016fef3 <drop_buffers+63/100>
  1e:   8d 4b 24                  lea    0x24(%ebx),%ecx
Code;  c016fef6 <drop_buffers+66/100>
  21:   8b 7b 04                  mov    0x4(%ebx),%edi
Code;  c016fef9 <drop_buffers+69/100>
  24:   39 ca                     cmp    %ecx,%edx
Code;  c016fefb <drop_buffers+6b/100>
  26:   74 2b                     je     53 <_EIP+0x53>
Code;  c016fefd <drop_buffers+6d/100>
  28:   8b 41 04                  mov    0x4(%ecx),%eax

This decode from eip onwards should be reliable

Code;  c016ff00 <drop_buffers+70/100>
00000000 <_EIP>:
Code;  c016ff00 <drop_buffers+70/100>   <=====
   0:   89 42 04                  mov    %eax,0x4(%edx)   <=====
Code;  c016ff03 <drop_buffers+73/100>
   3:   89 10                     mov    %edx,(%eax)
Code;  c016ff05 <drop_buffers+75/100>
   5:   89 49 04                  mov    %ecx,0x4(%ecx)
Code;  c016ff08 <drop_buffers+78/100>
   8:   8b 53 2c                  mov    0x2c(%ebx),%edx
Code;  c016ff0b <drop_buffers+7b/100>
   b:   89 4b 24                  mov    %ecx,0x24(%ebx)
Code;  c016ff0e <drop_buffers+7e/100>
   e:   85 d2                     test   %edx,%edx
Code;  c016ff10 <drop_buffers+80/100>
  10:   74 38                     je     4a <_EIP+0x4a>
Code;  c016ff12 <drop_buffers+82/100>
  12:   8b 03                     mov    (%ebx),%eax
Code;  c016ff14 <drop_buffers+84/100>
  14:   f6                        .byte 0xf6

EIP: [<c016ff00>] drop_buffers+0x70/0x100 SS:ESP 0068:c8e2be1c
Warning (Oops_read): Code line not seen, dumping what data is available


>>EIP; c016ff00 <drop_buffers+70/100>   <=====


2 warnings and 1 error issued.  Results may not be reliable.


