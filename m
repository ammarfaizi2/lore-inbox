Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbUL3Gya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbUL3Gya (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 01:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbUL3Gya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 01:54:30 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:23991 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S261556AbUL3GyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 01:54:15 -0500
Date: Thu, 30 Dec 2004 07:54:14 +0100 (CET)
From: Folkert van Heusden <folkert@vanheusden.com>
X-X-Sender: <folkert@muur.intranet.vanheusden.com>
To: <linux-kernel@vger.kernel.org>
Subject: [2.6.9] kernel BUG at mm/rmap.c:474! (more details)
Message-ID: <Pine.LNX.4.33.0412300738530.17362-100000@muur.intranet.vanheusden.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This bug seems to repeat itself every night. Each time triggered by
check_snmp_storage. That process runs under the user 'nagios', so not root.

Kernel: 2.6.9

Processor:
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 1002.274

Memory:
MemTotal:       906620 kB
MemFree:        129248 kB
Buffers:        123112 kB
Cached:         341532 kB
SwapCached:          0 kB
Active:         467732 kB
Inactive:       180444 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       906620 kB
LowFree:        129248 kB
SwapTotal:      454600 kB
SwapFree:       454568 kB
Dirty:             228 kB
Writeback:           0 kB
Mapped:         205364 kB
Slab:           120032 kB
Committed_AS:   458140 kB
PageTables:       3456 kB
VmallocTotal:   122840 kB
VmallocUsed:      2352 kB
VmallocChunk:   120304 kB

Mobo: A-Open with VIA chipset:
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 16)
00:07.3 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 16)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 50)
00:09.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 24)
00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
00:0c.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2164W [Millennium II]

Disk:
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
Probing IDE interface ide0...
hda: QUANTUM FIREBALLP AS20.5, ATA DISK drive
hdb: HL-DT-ST CD-ROM GCR-8520B, ATAPI CD/DVD-ROM drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 40132503 sectors (20547 MB) w/1902KiB Cache, CHS=39813/16/63, UDMA(100)
hda: cache flushes not supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3

GCC: 3.3.3
Binutils: GNU ld version 2.15.90.0.1.1 20040303


kernel BUG at mm/rmap.c:474!
invalid operand: 0000 [#1]
Modules linked in: bttv video_buf i2c_algo_bit v4l2_common btcx_risc police
sch_ingress cls_u32 sch_sfq sch_cbq ipt_state ipt_REJECT ipt_MASQUERADE
ipt_TOS iptable_mangle audio pwc videodev iptable_filter bsd_comp
ip6table_filter ip6_tables via686a eeprom i2c_sensor i2c_isa soundcore
i2c_core usbhid uhci_hcd ide_cd cdrom button processor microcode nfsd
exportfs lockd sunrpc md5 ipv6 rtl8150 usbcore 3c59x iptable_nat
ip_conntrack ip_tables ppp_deflate zlib_deflate zlib_inflate ppp_async
crc_ccitt ppp_generic slip slhc rtc rd
CPU:    0
EIP:    0060:[<c013d886>]    Not tainted VLI
EFLAGS: 00010286   (2.6.9-exec-shield-pwc)
EIP is at page_remove_rmap+0x26/0x40
eax: ffffffff   ebx: 00193000   ecx: c10db2c0   edx: c10db2c0
esi: dadf7afc   edi: c10db2c0   ebp: 0029c000   esp: c9ae5dc8
ds: 007b   es: 007b   ss: 0068
Process check_snmp_stor (pid: 6996, threadinfo=c9ae4000 task=d5a2a560)
Stack: c0137bd6 d5a2a560 c0380668 c02dff64 c0291bdd 06d96067 0812c000 c038006c
       0852c000 ed70c084 083c8000 c038006c c0137d2b 0029c000 00000000 32c0eec0
       000f567f 0812c000 ed70c084 083c8000 c038006c c0137d8d 0029c000 00000000
Call Trace:
 [<c0137bd6>] zap_pte_range+0x136/0x240
 [<c0291bdd>] schedule+0x3d/0x470
 [<c0137d2b>] zap_pmd_range+0x4b/0x70
 [<c0137d8d>] unmap_page_range+0x3d/0x70
 [<c0137ebe>] unmap_vmas+0xfe/0x1b0
 [<c013be49>] exit_mmap+0x69/0x130
 [<c0111f80>] mmput+0x40/0x70
 [<c01158f2>] do_exit+0x122/0x320
 [<c011bd15>] __dequeue_signal+0xd5/0x170
 [<c0115b72>] do_group_exit+0x32/0x70
 [<c011d5c7>] get_signal_to_deliver+0x1e7/0x320
 [<c0103c4f>] do_signal+0x8f/0x110
 [<c0110a8b>] scheduler_tick+0x1b/0x430
 [<c011b1e7>] do_timer+0xc7/0xd0
 [<c0117919>] __do_softirq+0x79/0x90
 [<c0105f55>] do_IRQ+0xd5/0x110
 [<c010f3f0>] do_page_fault+0x0/0x578
 [<c0103d07>] do_notify_resume+0x37/0x3c
 [<c0103eae>] work_notifysig+0x13/0x15
Code: 90 8d 74 26 00 89 c2 8b 00 f6 c4 08 75 27 83 42 08 ff 0f 98 c0 84 c0
74 11 8b 42 08 40 78 0c 9c 58 fa ff 0d 90 3e 39 c0 50 9d c3 <0f> 0b da 01 7b
58 2a c0 eb ea 0f 0b d7 01 7b 58 2a c0 eb cf 8d
 <0>Bad page state at prep_new_page (in process 'mrtg', page c10db2c0)
flags:0x20000014 mapping:00000000 mapcount:-1 count:0
Backtrace:
 [<c012f550>] bad_page+0x70/0xa0
 [<c012f89c>] prep_new_page+0x2c/0x50
 [<c012fc15>] buffered_rmqueue+0xc5/0x150
 [<c012ffb7>] __alloc_pages+0x317/0x340
 [<c012ffff>] __get_free_pages+0x1f/0x40
 [<c015ba13>] sys_getcwd+0x13/0x1a0
 [<c0103e63>] syscall_call+0x7/0xb
Trying to fix it up, but a reboot is needed


Folkert van Heusden

Op zoek naar een IT of Finance baan? Mail me voor de mogelijkheden!
+------------------------------------------------------------------+
|UNIX admin? Then give MultiTail (http://vanheusden.com/multitail/)|
|a try, it brings monitoring logfiles to a different level! See    |
|http://vanheusden.com/multitail/features.html for a feature list. |
+------------------------------------------= www.unixsoftware.nl =-+

