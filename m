Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131191AbRDWFOs>; Mon, 23 Apr 2001 01:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131219AbRDWFOk>; Mon, 23 Apr 2001 01:14:40 -0400
Received: from mailman.techspan.com ([4.21.76.5]:45840 "EHLO
	mailman.techspan.com") by vger.kernel.org with ESMTP
	id <S131191AbRDWFOX>; Mon, 23 Apr 2001 01:14:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Mark Swanson <swansma@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: ALI 1541,K6,AGP 2.4.3-ac12 instability
Date: Mon, 23 Apr 2001 05:14:06 -0400
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01042305140601.02063@test.home2.mark>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When I enable AGP on my ALI system 2D seems to work fine but 3D causes
kernel oops messages. (Ran through ksymoops) It looks like it could be
an NVidia driver problem, but I doubt it as I run this with AGP at work with
no problems. I'm wondering if anyone else has AGP working with the
(new?) ALI AGP code.

Linux 2.4.3-ac12
NVidia 0.9-769 drivers
XFree86-4.0.3
Ali 1541
TNT2 rev 11 SGRAM 32MB
(Recompiled the NVidia drivers to only use 1x AGP, and no ssb, and that
didn't help. Also compiled in NVidia AGP code but this code didn't seem
to understand what an ALI 1541 was and disabled AGP.)

Will test patches to help make this work if it is an ALI/Linux problem.

Thanks.

***** 1st *******
Apr 23 04:20:13 test kernel: Unable to handle kernel NULL pointer dereference 
at virtual address 00000000
Apr 23 04:20:13 test kernel: d898ef58
Apr 23 04:20:13 test kernel: Oops: 0000
Apr 23 04:20:13 test kernel: CPU:    0
Apr 23 04:20:13 test kernel: EIP:    0010:[<d898ef58>]
Using defaults from ksymoops -t elf32-i386 -a i386
Apr 23 04:20:13 test kernel: EFLAGS: 00010056
Apr 23 04:20:13 test kernel: eax: 00000000   ebx: 00000000   ecx: 00000000   
edx: cc5a8824
Apr 23 04:20:13 test kernel: esi: 00000101   edi: 00000000   ebp: cc5bdbe8   
esp: cc5bdbd4
Apr 23 04:20:13 test kernel: ds: 0018   es: 0018   ss: 0018
Apr 23 04:20:13 test kernel: Process kmorph3d.kss (pid: 1706, 
stackpage=cc5bd000)
Apr 23 04:20:13 test kernel: Stack: 00000000 00000101 dda21004 00004000 
00000000 cc5bdc10 d898f2fb dda21004
Apr 23 04:20:13 test kernel:        00000101 cc5bdc08 ffffffff d8a08ac0 
cc5a87e0 0000c26a cc5a8824 cc5bdc3c
Apr 23 04:20:13 test kernel:        d89873b0 dda21004 cc5bde70 00000101 
00000041 cc5bdcac 00000002 00002100
Apr 23 04:20:13 test kernel: Call Trace: [<dda21004>] [<d898f2fb>] 
[<dda21004>] [<d8a08ac0>] [<d89873b0>]
Apr 23 04:20:13 test kernel:    [<dda21004>] [<d8a08a20>] [<d898b70b>] 
[<dda21004>] [<d898b4c0>] [<dda21004>]
Apr 23 04:20:13 test kernel:    [<d8a08ac0>] [<dda21004>] [<d8988974>] 
[<d8a08ac0>] [<dda21004>] [update_process_times+35/144]
Apr 23 04:20:13 test kernel:    [<d8a08ac0>] [<dda21004>] [<d8988974>] 
[<d8a08ac0>] [<dda21004>] [<c0119b53>]
Apr 23 04:20:13 test kernel:    [<c01109f0>] [<c0119e33>] [<c012935b>] 
[<c01e7117>] [<c016956d>] [<c01b1f3b>]
Apr 23 04:20:13 test kernel:    [<c01b2098>] [<c012154e>] [<c012935b>] 
[<d893a404>] [<d893a004>] [<d8a08ac0>]
Apr 23 04:20:13 test kernel:    [<d8985937>] [insert_vm_struct+25/64] 
[do_mmap_pgoff+922/1104] [<d8985d3d>] [<d8a08ac0>] [<ffff0001>]
Apr 23 04:20:13 test kernel:    [<d8985937>] [<c0121619>] [<c012072a>] 
[<d8985d3d>] [<d8a08ac0>] [<ffff0001>]
Apr 23 04:20:13 test kernel:    [<c010b8b0>] [<c012f3a1>] [<c013bf76>] 
[<c0106ce3>]
Apr 23 04:20:13 test kernel: Code: 80 3c 38 00 75 08 83 c3 07 e9 8a 00 00 00 
89 d8 c1 e8 03 8b

>>EIP; d898ef58 <[NVdriver]_nv_rmsym_01050+14/40>   <=====
Trace; dda21004 <[NVdriver].bss.end+5024385/5051381>
Trace; d898f2fb <[NVdriver]_nv_rmsym_01064+2b/50>
Trace; dda21004 <[NVdriver].bss.end+5024385/5051381>
Trace; d8a08ac0 <[NVdriver].bss.end+be41/5051381>
Trace; d89873b0 <[NVdriver]dacSetFlatPanelBrightness+60/f8>
Trace; dda21004 <[NVdriver].bss.end+5024385/5051381>
Trace; d8a08a20 <[NVdriver].bss.end+bda1/5051381>
Trace; d898b70b <[NVdriver]DevinitProcessBip2+1df/32c>
Trace; dda21004 <[NVdriver].bss.end+5024385/5051381>
Trace; d898b4c0 <[NVdriver]DevinitGetBMPControlBlock+50/bc>
Trace; dda21004 <[NVdriver].bss.end+5024385/5051381>
Trace; d8a08ac0 <[NVdriver].bss.end+be41/5051381>
Trace; dda21004 <[NVdriver].bss.end+5024385/5051381>
Trace; d8988974 <[NVdriver]edidReadDevEDID+58/1d0>
Trace; d8a08ac0 <[NVdriver].bss.end+be41/5051381>
Trace; dda21004 <[NVdriver].bss.end+5024385/5051381>
Trace; d8a08ac0 <[NVdriver].bss.end+be41/5051381>
Trace; dda21004 <[NVdriver].bss.end+5024385/5051381>
Trace; d8988974 <[NVdriver]edidReadDevEDID+58/1d0>
Trace; d8a08ac0 <[NVdriver].bss.end+be41/5051381>
Trace; dda21004 <[NVdriver].bss.end+5024385/5051381>
Trace; c0119b53 <update_process_times+23/90>
Trace; c01109f0 <process_timeout+0/50>
Trace; c0119e33 <timer_bh+223/270>
Trace; c012935b <__alloc_pages+6b/250>
Trace; c01e7117 <unix_write_space+37/70>
Trace; c016956d <search_by_key+82d/c50>
Trace; c01b1f3b <kfree_skbmem+b/60>
Trace; c01b2098 <__kfree_skb+108/110>
Trace; c012154e <__insert_vm_struct+de/190>
Trace; c012935b <__alloc_pages+6b/250>
Trace; d893a404 <[lp]lp_write+174/1f0>
Trace; d893a004 <[ipt_LOG].data.end+344d/34a9>
Trace; d8a08ac0 <[NVdriver].bss.
