Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315179AbSGQOze>; Wed, 17 Jul 2002 10:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315198AbSGQOze>; Wed, 17 Jul 2002 10:55:34 -0400
Received: from boxer.fnal.gov ([131.225.80.86]:62360 "EHLO boxer.fnal.gov")
	by vger.kernel.org with ESMTP id <S315179AbSGQOzd>;
	Wed, 17 Jul 2002 10:55:33 -0400
Date: Wed, 17 Jul 2002 09:58:31 -0500 (CDT)
From: Steven Timm <timm@fnal.gov>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel panic during disk access:
Message-ID: <Pine.LNX.4.31.0207170948060.522-100000@boxer.fnal.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kernel 2.4.18-4smp released as errata kernel Redhat 7.3.  Supermicro
370DLE motherboard, 2x1GHZ Pentium III processors, 1 GB memory.
As far as I can tell, it's writing to disk drive /dev/hdc at the
time of the kernel panic, because after the panic all access to that
drive hangs, and the load goes up by one each time you try to access it,
with another hung process. (/dev/hdc is an IBM 40 GB disk drive,
model IC35L040AVER07-0). There is an identical /dev/hdd, and a 20 GB
/dev/hda.  We run them all with UltraDMA mode 2.

/dev/hdc:
 multcount    = 16 (on)
 I/O support  =  3 (32-bit w/sync)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 5005/255/63, sectors = 80418240, start = 0

I have seen this problem about six or seven times over the past two months
on four machines configured the same way, undergoing near-continuous disk
reads and writes.  The system never actually crashes, but just
holds up I/O to that one disk, and it takes a reboot to recover.

Any help is appreciated.

Steve Timm




Unable to handle kernel NULL pointer dereference at virtual address 00000008
 printing eip:
c016a0e9
*pde = 00000000
Oops: 0000
nfs lockd sunrpc autofs e1000 ipchains ide-cd cdrom usb-ohci usbcore
CPU:    1
EIP:    0010:[<c016a0e9>]    Tainted: P
EFLAGS: 00010202

EIP is at ext2_new_block [kernel] 0x589 (2.4.18-4smp)
eax: 00000000   ebx: 00001000   ecx: 0000000c   edx: ea5b9ba0
esi: 00000000   edi: f28a0000   ebp: 00002b2f   esp: f28a1d3c
ds: 0018   es: 0018   ss: 0018
Process AC++Dump_4.6.2 (pid: 1511, stackpage=f28a1000)
Stack: ea5b9ba0 00001000 00000000 00000000 c01e41df c5491c80 ef2473e0 f28a1d8c
       ef2473e0 f6ce3800 f897a792 00000001 eb94dd80 eb94dd80 f6d8c400 f6d8bc60
       f7ce1000 f6ce3800 00000063 ef2473e0 f6db7720 0000012b 1219c8a5 00000cdd
Call Trace: [<c01e41df>] nf_hook_slow [kernel] 0x10f
[<f897a792>] e1000_clean_rx_irq [e1000] 0x2b2
[<c016c793>] ext2_alloc_block [kernel] 0x73
[<c016c9c0>] ext2_alloc_branch [kernel] 0x30
[<c016c922>] ext2_get_branch [kernel] 0x52
[<c016cdb6>] ext2_get_block [kernel] 0x256
[<c0144c0f>] __block_prepare_write [kernel] 0x12f
[<c0144186>] balance_dirty [kernel] 0x6
[<c0144ee1>] __block_commit_write [kernel] 0xb1
[<c01455a2>] block_prepare_write [kernel] 0x22
[<c016cb60>] ext2_get_block [kernel] 0x0
[<c013285d>] generic_file_write [kernel] 0x4fd
[<c016cb60>] ext2_get_block [kernel] 0x0
[<c0127233>] sys_rt_sigaction [kernel] 0x93
[<c0141bf6>] sys_write [kernel] 0x96
[<c014190f>] sys_lseek [kernel] 0xbf
[<c0108c6b>] system_call [kernel] 0x33


Code: ff 50 08 83 c4 10 48 75 6a 8b 47 1c 85 c0 79 13 6a 3e 68 c0


------------------------------------------------------------------
Steven C. Timm (630) 840-8525  timm@fnal.gov  http://home.fnal.gov/~timm/
Fermilab Computing Division/Operating Systems Support
Scientific Computing Support Group--Computing Farms Operations

