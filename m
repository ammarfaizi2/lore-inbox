Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130037AbRBYLih>; Sun, 25 Feb 2001 06:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130038AbRBYLiS>; Sun, 25 Feb 2001 06:38:18 -0500
Received: from trillke4.rz.uni-hildesheim.de ([147.172.19.204]:58610 "EHLO
	nova.trillke") by vger.kernel.org with ESMTP id <S130037AbRBYLiJ>;
	Sun, 25 Feb 2001 06:38:09 -0500
Date: Sun, 25 Feb 2001 12:37:57 +0100 (CET)
From: holger@prim.han.de
Reply-To: holger@prim.han.de
To: linux-kernel@vger.kernel.org
Subject: oops in kmem_cache_free
Message-ID: <Pine.LNX.4.21.0102251231230.28710-100000@nova.trillke>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

got a series of oops (see below) while stress-testing my machine:

Linux 2.4.2, Epox-EP8KTA2 Athlon 1GHZ, 512 MBram, IBM-30GB-IDE-drives, latest debian-woody

the machine was copying files between two ide-drives, compiling two software packages, 
and stuff like "find /" was running. Machine was not using much swap.

All of them seemed to relate to kmem_cache_free, excerpts from trace follow,
and after that you find the disassembled kmem_cache_free-function.

PLEASE EMAIL me DIRECTLY as i am not following the kernel list actively.

Hope it Helps (contact me for further infos), 

    Holger

Feb 24 21:37:08 nova kernel:  printing eip:
Feb 24 21:37:08 nova kernel: c0126ca3
Feb 24 21:37:08 nova kernel: Oops: 0002
Feb 24 21:37:08 nova kernel: CPU:    0
Feb 24 21:37:08 nova kernel: EIP:    0010:[kmem_cache_free+99/176]
Feb 24 21:37:08 nova kernel: EFLAGS: 00010006
Feb 24 21:37:08 nova kernel: eax: cd580000   ebx: cc08e000   ecx: daf63000   edx: ffffffff
Feb 24 21:37:08 nova kernel: esi: c188be08   edi: 00000246   ebp: 000003f9   esp: ca9fff2c
Feb 24 21:37:08 nova kernel: ds: 0018   es: 0018   ss: 0018
Feb 24 21:37:08 nova kernel: Process rm (pid: 498, stackpage=ca9ff000)
Feb 24 21:37:08 nova kernel: Stack: cc08ef40 daf63ec0 00000000 000003f9 c013f8a6 c188be08 daf63ec0 cc08ef40 
Feb 24 21:37:08 nova kernel:        d53444f0 cc08ef40 d5344480 c013fb1d 00000402 cc08ef40 c01398f7 cc08ef40 
Feb 24 21:37:08 nova kernel:        d53444f0 c0139a31 cc08ef40 cc08ef40 cc08ef40 d1c30000 ca9fffa4 c0139b8f 
Feb 24 21:37:08 nova kernel: Call Trace: [prune_dcache+278/336] [shrink_dcache_parent+13/32] [d_unhash+55/96] [vfs_rmdir+273/432] [sys_rmdir+191/256] [system_call+51/56] 
Feb 24 21:37:08 nova kernel: 
Feb 24 21:37:08 nova kernel: Code: 89 42 04 89 10 8b 43 04 89 4b 04 89 19 89 41 04 89 08 eb 27 
Feb 24 21:37:08 nova kernel:  printing eip:
Feb 24 21:37:08 nova kernel: c0126b45
Feb 24 21:37:08 nova kernel: Oops: 0000
Feb 24 21:37:08 nova kernel: CPU:    0
Feb 24 21:37:08 nova kernel: EIP:    0010:[kmem_cache_alloc+21/96]
Feb 24 21:37:08 nova kernel: EFLAGS: 00010002
Feb 24 21:37:08 nova kernel: eax: c188be08   ebx: c188be08   ecx: 00000009   edx: ffffffff
Feb 24 21:37:08 nova kernel: esi: 00000286   edi: 00000007   ebp: dffe11c0   esp: c2b09f20
Feb 24 21:37:08 nova kernel: ds: 0018   es: 0018   ss: 0018
Feb 24 21:37:08 nova kernel: Process g++ (pid: 529, stackpage=c2b09000)
Feb 24 21:37:08 nova kernel: Stack: c28ce880 dc92f440 c2b09f7e c013fb78 c188be08 00000007 c28ce880 dc92f440 
Feb 24 21:37:08 nova kernel:        c2b09f7e dc92f8c0 c0137b21 c0137b55 dffe11c0 c2b09f94 c2b08000 c2b09fb8 
Feb 24 21:37:08 nova kernel:        bffff4a4 bffff4b4 00000004 00000003 fffffff4 3138335b 30363730 c012005d 
Feb 24 21:37:08 nova kernel: Call Trace: [d_alloc+24/400] [do_pipe+129/640] [do_pipe+181/640] [do_no_page+29/192] [sys_pipe+21/96] [system_call+51/56] 
Feb 24 21:37:08 nova kernel: 
Feb 24 21:37:08 nova kernel: Code: 8b 42 14 ff 42 10 89 c1 0f af 4b 0c 03 4a 0c 8b 44 82 18 89 
Feb 24 21:37:08 nova kernel:  printing eip:
Feb 24 21:37:08 nova kernel: c0126ca8
Feb 24 21:37:08 nova kernel: Oops: 0000
Feb 24 21:37:08 nova kernel: CPU:    0
Feb 24 21:37:08 nova kernel: EIP:    0010:[kmem_cache_free+104/176]
Feb 24 21:37:08 nova kernel: EFLAGS: 00010093
Feb 24 21:37:08 nova kernel: eax: d5c03000   ebx: ffffffff   ecx: c5380000   edx: d38a2000
Feb 24 21:37:08 nova kernel: esi: c188be08   edi: 00000246   ebp: c5380b40   esp: c2b0bf28
Feb 24 21:37:08 nova kernel: ds: 0018   es: 0018   ss: 0018
Feb 24 21:37:08 nova kernel: Process make (pid: 31062, stackpage=c2b0b000)
Feb 24 21:37:08 nova kernel: Stack: c5380b40 dffe11c0 df0ee980 c5380b40 c013f607 c188be08 c5380b40 c61e20c0 
Feb 24 21:37:08 nova kernel:        dffe7640 c012ee54 c5380b40 c61e20c0 00000000 c26e2580 00000001 c012dffc 
Feb 24 21:37:08 nova kernel:        c61e20c0 c26e2580 00000000 c61e20c0 00000000 00000001 00000004 c0115f88 
Feb 24 21:37:08 nova kernel: Call Trace: [dput+295/336] [fput+116/208] [filp_close+92/112] [put_files_struct+88/192] [do_exit+182/544] [sys_exit+14/16] [system_call+51/56] 
Feb 24 21:37:08 nova kernel: 
Feb 24 21:37:08 nova kernel: Code: 8b 43 04 89 4b 04 89 19 89 41 04 89 08 eb 27 8b 46 08 8b 51 
Feb 24 21:37:09 nova kernel:  printing eip:
Feb 24 21:37:09 nova kernel: c0126c78
Feb 24 21:37:09 nova kernel: Oops: 0002
Feb 24 21:37:09 nova kernel: CPU:    0
Feb 24 21:37:09 nova kernel: EIP:    0010:[kmem_cache_free+56/176]
Feb 24 21:37:09 nova kernel: EFLAGS: 00010012
Feb 24 21:37:09 nova kernel: eax: ffffffff   ebx: 01ffffff   ecx: d9431000   edx: 00000000
Feb 24 21:37:09 nova kernel: esi: c188be08   edi: 00000246   ebp: bffffa94   esp: cf47ff64
Feb 24 21:37:09 nova kernel: ds: 0018   es: 0018   ss: 0018
Feb 24 21:37:09 nova kernel: Process top (pid: 14333, stackpage=cf47f000)
Feb 24 21:37:09 nova kernel: Stack: d9431040 dffe1240 400217a0 bffffa94 c013f607 c188be08 d9431040 cf47ffa4 
Feb 24 21:37:09 nova kernel:        00000000 c0137fed d9431040 cf47ffa4 c01359d4 cf47ffa4 cf47e000 40021740 
Feb 24 21:37:09 nova kernel:        d9431040 c19fabc0 c012e19c cf47e000 bffff990 00000009 00000001 c0108fab 
Feb 24 21:37:09 nova kernel: Call Trace: [dput+295/336] [path_release+13/64] [sys_newstat+100/112] [sys_lseek+108/128] [system_call+51/56] 
Feb 24 21:37:09 nova kernel: 
Feb 24 21:37:09 nova kernel: Code: 89 44 99 18 89 59 14 8b 56 14 8b 41 10 ff 49 10 39 d0 74 08 
Feb 24 21:37:30 nova kernel:  printing eip:
Feb 24 21:37:30 nova kernel: c0126c78
Feb 24 21:37:30 nova kernel: Oops: 0002
Feb 24 21:37:30 nova kernel: CPU:    0
Feb 24 21:37:30 nova kernel: EIP:    0010:[kmem_cache_free+56/176]
Feb 24 21:37:30 nova kernel: EFLAGS: 00010012
Feb 24 21:37:30 nova kernel: eax: ffffffff   ebx: 01ffffff   ecx: dc5fb000   edx: 00000000
Feb 24 21:37:30 nova kernel: esi: c188be08   edi: 00000246   ebp: dc5fb040   esp: ccb0ff54
Feb 24 21:37:30 nova kernel: ds: 0018   es: 0018   ss: 0018
Feb 24 21:37:30 nova kernel: Process as (pid: 570, stackpage=ccb0f000)
Feb 24 21:37:30 nova kernel: Stack: dc5fb040 dffe11c0 ca93aac0 dc5fb040 c013f607 c188be08 dc5fb040 dad1a340 
Feb 24 21:37:30 nova kernel:        dffe7640 c012ee54 dc5fb040 dad1a340 00000000 0000002e bffff7a4 c012dffc 
Feb 24 21:37:30 nova kernel:        dad1a340 c26e2c80 00000000 dad1a340 00000000 dad1a340 401413c0 c012e053 
Feb 24 21:37:30 nova kernel: Call Trace: [dput+295/336] [fput+116/208] [filp_close+92/112] [sys_close+67/96] [system_call+51/56] 
Feb 24 21:37:30 nova kernel: 
Feb 24 21:37:30 nova kernel: Code: 89 44 99 18 89 59 14 8b 56 14 8b 41 10 ff 49 10 39 d0 74 08 
Feb 24 21:37:30 nova kernel:  printing eip:
Feb 24 21:37:30 nova kernel: c0126c78
Feb 24 21:37:30 nova kernel: Oops: 0002
Feb 24 21:37:30 nova kernel: CPU:    0
Feb 24 21:37:30 nova kernel: EIP:    0010:[kmem_cache_free+56/176]
Feb 24 21:37:30 nova kernel: EFLAGS: 00010012
Feb 24 21:37:30 nova kernel: eax: ffffffff   ebx: 01ffffff   ecx: df3fe000   edx: 00000000
Feb 24 21:37:30 nova kernel: esi: c188be08   edi: 00000246   ebp: df3fe040   esp: c5059f54
Feb 24 21:37:30 nova kernel: ds: 0018   es: 0018   ss: 0018
Feb 24 21:37:30 nova kernel: Process make (pid: 571, stackpage=c5059000)
Feb 24 21:37:30 nova kernel: Stack: df3fe040 dffe11c0 df0ee980 df3fe040 c013f607 c188be08 df3fe040 c928c740 
Feb 24 21:37:30 nova kernel:        dffe7640 c012ee54 df3fe040 c928c740 00000000 400ef8a0 bfffdbb4 c012dffc 
Feb 24 21:37:30 nova kernel:        c928c740 c317f580 00000000 c928c740 00000000 c928c740 08070ad8 c012e053 
Feb 24 21:37:30 nova kernel: Call Trace: [dput+295/336] [fput+116/208] [filp_close+92/112] [sys_close+67/96] [system_call+51/56] 
Feb 24 21:37:30 nova kernel: 
Feb 24 21:37:30 nova kernel: Code: 89 44 99 18 89 59 14 8b 56 14 8b 41 10 ff 49 10 39 d0 74 08 
Feb 24 21:37:30 nova kernel:  printing eip:
Feb 24 21:37:30 nova kernel: c0126c78
Feb 24 21:37:30 nova kernel: Oops: 0002
Feb 24 21:37:30 nova kernel: CPU:    0
Feb 24 21:37:30 nova kernel: EIP:    0010:[kmem_cache_free+56/176]
Feb 24 21:37:30 nova kernel: EFLAGS: 00010012
Feb 24 21:37:30 nova kernel: eax: ffffffff   ebx: 01ffffff   ecx: dde97000   edx: 00000000
Feb 24 21:37:30 nova kernel: esi: c188be08   edi: 00000246   ebp: dde97040   esp: c5059f54
Feb 24 21:37:30 nova kernel: ds: 0018   es: 0018   ss: 0018
Feb 24 21:37:30 nova kernel: Process make (pid: 573, stackpage=c5059000)
Feb 24 21:37:30 nova kernel: Stack: dde97040 dffe11c0 df0ee980 dde97040 c013f607 c188be08 dde97040 c61e24c0 
Feb 24 21:37:30 nova kernel:        dffe7640 c012ee54 dde97040 c61e24c0 00000000 400ef8a0 bfffdb94 c012dffc 
Feb 24 21:37:30 nova kernel:        c61e24c0 c317f580 00000000 c61e24c0 00000000 c61e24c0 08070940 c012e053 
Feb 24 21:37:30 nova kernel: Call Trace: [dput+295/336] [fput+116/208] [filp_close+92/112] [sys_close+67/96] [system_call+51/56] 
Feb 24 21:37:30 nova kernel: 
Feb 24 21:37:30 nova kernel: Code: 89 44 99 18 89 59 14 8b 56 14 8b 41 10 ff 49 10 39 d0 74 08 
Feb 24 21:37:45 nova kernel:  printing eip:
Feb 24 21:37:45 nova kernel: c0126c78
Feb 24 21:37:45 nova kernel: Oops: 0002
Feb 24 21:37:45 nova kernel: CPU:    0
Feb 24 21:37:45 nova kernel: EIP:    0010:[kmem_cache_free+56/176]
Feb 24 21:37:45 nova kernel: EFLAGS: 00010012
Feb 24 21:37:45 nova kernel: eax: ffffffff   ebx: 01ffffff   ecx: dc89d000   edx: 00000000
Feb 24 21:37:45 nova kernel: esi: c188be08   edi: 00000246   ebp: dc89d040   esp: cb12ff54
Feb 24 21:37:45 nova kernel: ds: 0018   es: 0018   ss: 0018
Feb 24 21:37:45 nova kernel: Process top (pid: 576, stackpage=cb12f000)
Feb 24 21:37:45 nova kernel: Stack: dc89d040 c1920040 c39973c0 dc89d040 c013f607 c188be08 dc89d040 d5c9cd40 
Feb 24 21:37:45 nova kernel:        c19fabc0 c012ee54 dc89d040 d5c9cd40 00000000 00000007 bffffa84 c012dffc 
Feb 24 21:37:45 nova kernel:        d5c9cd40 c317f900 00000000 d5c9cd40 00000000 d5c9cd40 000000c0 c012e053 
Feb 24 21:37:45 nova kernel: Call Trace: [dput+295/336] [fput+116/208] [filp_close+92/112] [sys_close+67/96] [system_call+51/56] 
Feb 24 21:37:45 nova kernel: 
Feb 24 21:37:45 nova kernel: Code: 89 44 99 18 89 59 14 8b 56 14 8b 41 10 ff 49 10 39 d0 74 08 
Feb 24 21:37:45 nova kernel:  printing eip:
Feb 24 21:37:45 nova kernel: c0126c78
Feb 24 21:37:45 nova kernel: Oops: 0002
Feb 24 21:37:45 nova kernel: CPU:    0
Feb 24 21:37:45 nova kernel: EIP:    0010:[kmem_cache_free+56/176]
Feb 24 21:37:45 nova kernel: EFLAGS: 00010012
Feb 24 21:37:45 nova kernel: eax: ffffffff   ebx: 01ffffff   ecx: dcfa0000   edx: 00000000
Feb 24 21:37:45 nova kernel: esi: c188be08   edi: 00000246   ebp: dcfa0040   esp: cb12fdd4
Feb 24 21:37:45 nova kernel: ds: 0018   es: 0018   ss: 0018
Feb 24 21:37:45 nova kernel: Process top (pid: 576, stackpage=cb12f000)
Feb 24 21:37:45 nova kernel: Stack: dcfa0040 dffe1240 ca93aac0 dcfa0040 c013f607 c188be08 dcfa0040 c2543240 
Feb 24 21:37:45 nova kernel:        c19fabc0 c012ee54 dcfa0040 c2543240 00000000 c317f900 00000001 c012dffc 
Feb 24 21:37:45 nova kernel:        c2543240 c317f900 00000000 c2543240 00000000 00000003 00000005 c0115f88 
Feb 24 21:37:45 nova kernel: Call Trace: [dput+295/336] [fput+116/208] [filp_close+92/112] [put_files_struct+88/192] [do_exit+182/544] [<e489d014>] [die+66/80] 
Feb 24 21:37:45 nova kernel:        [do_page_fault+791/1024] [do_page_fault+0/1024] [error_code+52/60] [kmem_cache_free+56/176] [dput+295/336] [fput+116/208] [filp_close+92/112] [sys_close+67/96] 
Feb 24 21:37:45 nova kernel:        [system_call+51/56] 
Feb 24 21:37:45 nova kernel: 
Feb 24 21:37:45 nova kernel: Code: 89 44 99 18 89 59 14 8b 56 14 8b 41 10 ff 49 10 39 d0 74 08 
Feb 24 21:37:51 nova kernel:  printing eip:
Feb 24 21:37:51 nova kernel: c0126c78
Feb 24 21:37:51 nova kernel: Oops: 0002
Feb 24 21:37:51 nova kernel: CPU:    0
Feb 24 21:37:51 nova kernel: EIP:    0010:[kmem_cache_free+56/176]
Feb 24 21:37:51 nova kernel: EFLAGS: 00010012
Feb 24 21:37:51 nova kernel: eax: ffffffff   ebx: 01ffffff   ecx: d8568000   edx: 00000000
Feb 24 21:37:51 nova kernel: esi: c188be08   edi: 00000246   ebp: d8568040   esp: cb12ff54
Feb 24 21:37:51 nova kernel: ds: 0018   es: 0018   ss: 0018
Feb 24 21:37:51 nova kernel: Process top (pid: 579, stackpage=cb12f000)
Feb 24 21:37:51 nova kernel: Stack: d8568040 dffe1240 df0ee980 d8568040 c013f607 c188be08 d8568040 cb674cc0 
Feb 24 21:37:51 nova kernel:        c19fabc0 c012ee54 d8568040 cb674cc0 00000000 bfffdc1c bfffdb50 c012dffc 
Feb 24 21:37:51 nova kernel:        cb674cc0 c317f740 00000000 cb674cc0 00000000 cb674cc0 08056250 c012e053 
Feb 24 21:37:51 nova kernel: Call Trace: [dput+295/336] [fput+116/208] [filp_close+92/112] [sys_close+67/96] [system_call+51/56] 
Feb 24 21:37:51 nova kernel: 
Feb 24 21:37:51 nova kernel: Code: 89 44 99 18 89 59 14 8b 56 14 8b 41 10 ff 49 10 39 d0 74 08 
Feb 24 21:37:52 nova kernel:  printing eip:
Feb 24 21:37:52 nova kernel: c0126c78
Feb 24 21:37:52 nova kernel: Oops: 0002
Feb 24 21:37:52 nova kernel: CPU:    0
Feb 24 21:37:52 nova kernel: EIP:    0010:[kmem_cache_free+56/176]
Feb 24 21:37:52 nova kernel: EFLAGS: 00010012
Feb 24 21:37:52 nova kernel: eax: ffffffff   ebx: 01ffffff   ecx: dc417000   edx: 00000000
Feb 24 21:37:52 nova kernel: esi: c188be08   edi: 00000246   ebp: dc417040   esp: cb12ff54
Feb 24 21:37:52 nova kernel: ds: 0018   es: 0018   ss: 0018
Feb 24 21:37:52 nova kernel: Process top (pid: 580, stackpage=cb12f000)
Feb 24 21:37:52 nova kernel: Stack: dc417040 dffe10c0 c3997bc0 dc417040 c013f607 c188be08 dc417040 da558cc0 
Feb 24 21:37:52 nova kernel:        dffe7540 c012ee54 dc417040 da558cc0 00000000 401398a0 bffff8dc c012dffc 
Feb 24 21:37:52 nova kernel:        da558cc0 c317f740 00000000 da558cc0 00000000 da558cc0 00000007 c012e053 
Feb 24 21:37:52 nova kernel: Call Trace: [dput+295/336] [fput+116/208] [filp_close+92/112] [sys_close+67/96] [system_call+51/56] 
Feb 24 21:37:52 nova kernel: 
Feb 24 21:37:52 nova kernel: Code: 89 44 99 18 89 59 14 8b 56 14 8b 41 10 ff 49 10 39 d0 74 08 
Feb 24 21:37:52 nova kernel:  printing eip:
Feb 24 21:37:52 nova kernel: c0126c78
Feb 24 21:37:52 nova kernel: Oops: 0002
Feb 24 21:37:52 nova kernel: CPU:    0
Feb 24 21:37:52 nova kernel: EIP:    0010:[kmem_cache_free+56/176]
Feb 24 21:37:52 nova kernel: EFLAGS: 00010012
Feb 24 21:37:52 nova kernel: eax: ffffffff   ebx: 01ffffff   ecx: dd9e3000   edx: 00000000
Feb 24 21:37:52 nova kernel: esi: c188be08   edi: 00000246   ebp: dd9e3040   esp: cb12fdd4
Feb 24 21:37:52 nova kernel: ds: 0018   es: 0018   ss: 0018
Feb 24 21:37:52 nova kernel: Process top (pid: 580, stackpage=cb12f000)
Feb 24 21:37:52 nova kernel: Stack: dd9e3040 dffe1240 df0ee980 dd9e3040 c013f607 c188be08 dd9e3040 c928c940 
Feb 24 21:37:52 nova kernel:        c19fabc0 c012ee54 dd9e3040 c928c940 00000000 c317f740 00000001 c012dffc 
Feb 24 21:37:52 nova kernel:        c928c940 c317f740 00000000 c928c940 00000000 0000000f 00000003 c0115f88 
Feb 24 21:37:52 nova kernel: Call Trace: [dput+295/336] [fput+116/208] [filp_close+92/112] [put_files_struct+88/192] [do_exit+182/544] [<e4417014>] [die+66/80] 
Feb 24 21:37:52 nova kernel:        [do_page_fault+791/1024] [do_page_fault+0/1024] [sk_free+57/64] [unix_release_sock+464/496] [unix_stream_connect+817/864] [sys_connect+106/128] [error_code+52/60] [kmem_cache_free+56/176] 
Feb 24 21:37:52 nova kernel:        [dput+295/336] [fput+116/208] [filp_close+92/112] [sys_close+67/96] [system_call+51/56] 
Feb 24 21:37:52 nova kernel: 
Feb 24 21:37:52 nova kernel: Code: 89 44 99 18 89 59 14 8b 56 14 8b 41 10 ff 49 10 39 d0 74 08 
Feb 24 21:37:53 nova kernel:  printing eip:
Feb 24 21:37:53 nova kernel: c0126c78
Feb 24 21:37:53 nova kernel: Oops: 0002
Feb 24 21:37:53 nova kernel: CPU:    0
Feb 24 21:37:53 nova kernel: EIP:    0010:[kmem_cache_free+56/176]
Feb 24 21:37:53 nova kernel: EFLAGS: 00010012
Feb 24 21:37:53 nova kernel: eax: ffffffff   ebx: 01ffffff   ecx: d9e3d000   edx: 00000000
Feb 24 21:37:53 nova kernel: esi: c188be08   edi: 00000246   ebp: d9e3d040   esp: cb12ff54
Feb 24 21:37:53 nova kernel: ds: 0018   es: 0018   ss: 0018
Feb 24 21:37:53 nova kernel: Process top (pid: 581, stackpage=cb12f000)
Feb 24 21:37:53 nova kernel: Stack: d9e3d040 c1920040 c3997bc0 d9e3d040 c013f607 c188be08 d9e3d040 d86b2ac0 
Feb 24 21:37:53 nova kernel:        c19fabc0 c012ee54 d9e3d040 d86b2ac0 00000000 00000007 bffffa84 c012dffc 
Feb 24 21:37:53 nova kernel:        d86b2ac0 c317f580 00000000 d86b2ac0 00000000 d86b2ac0 00000017 c012e053 
Feb 24 21:37:53 nova kernel: Call Trace: [dput+295/336] [fput+116/208] [filp_close+92/112] [sys_close+67/96] [system_call+51/56] 
Feb 24 21:37:53 nova kernel: 
Feb 24 21:37:53 nova kernel: Code: 89 44 99 18 89 59 14 8b 56 14 8b 41 10 ff 49 10 39 d0 74 08 
Feb 24 21:37:55 nova kernel:  printing eip:
Feb 24 21:37:55 nova kernel: c0126c78
Feb 24 21:37:55 nova kernel: Oops: 0002
Feb 24 21:37:55 nova kernel: CPU:    0
Feb 24 21:37:55 nova kernel: EIP:    0010:[kmem_cache_free+56/176]
Feb 24 21:37:55 nova kernel: EFLAGS: 00010012
Feb 24 21:37:55 nova kernel: eax: ffffffff   ebx: 01ffffff   ecx: dabf9000   edx: 00000000
Feb 24 21:37:55 nova kernel: esi: c188be08   edi: 00000246   ebp: cb12ffa4   esp: cb12ff5c
Feb 24 21:37:55 nova kernel: ds: 0018   es: 0018   ss: 0018
Feb 24 21:37:55 nova kernel: Process su (pid: 582, stackpage=cb12f000)
Feb 24 21:37:55 nova kernel: Stack: dabf9040 c2aad040 000001ff cb12ffa4 c013f607 c188be08 dabf9040 cb12ffa4 
Feb 24 21:37:55 nova kernel:        0000000a c0137fed dabf9040 c8ae7440 c0135c0d cb12ffa4 cb12e000 bffff6e4 
Feb 24 21:37:55 nova kernel:        bffff633 bffff704 dabf9040 c19fabc0 c013bb63 cb12e000 bffff5a8 00000008 
Feb 24 21:37:55 nova kernel: Call Trace: [dput+295/336] [path_release+13/64] [sys_readlink+141/160] [sys_ioctl+371/384] [system_call+51/56] 
Feb 24 21:37:55 nova kernel: 
Feb 24 21:37:55 nova kernel: Code: 89 44 99 18 89 59 14 8b 56 14 8b 41 10 ff 49 10 39 d0 74 08 
Feb 24 21:38:01 nova kernel:  printing eip:
Feb 24 21:38:01 nova kernel: c0126c78
Feb 24 21:38:01 nova kernel: Oops: 0002
Feb 24 21:38:01 nova kernel: CPU:    0
Feb 24 21:38:01 nova kernel: EIP:    0010:[kmem_cache_free+56/176]
Feb 24 21:38:01 nova kernel: EFLAGS: 00010012
Feb 24 21:38:01 nova kernel: eax: ffffffff   ebx: 01ffffff   ecx: dd50c000   edx: 00000000
Feb 24 21:38:01 nova kernel: esi: c188be08   edi: 00000246   ebp: dd50c040   esp: decc5f54
Feb 24 21:38:01 nova kernel: ds: 0018   es: 0018   ss: 0018
Feb 24 21:38:01 nova kernel: Process cron (pid: 583, stackpage=decc5000)
Feb 24 21:38:01 nova kernel: Stack: dd50c040 dffe11c0 c8ae7c40 dd50c040 c013f607 c188be08 dd50c040 d5c9cf40 
Feb 24 21:38:01 nova kernel:        dffe7640 c012ee54 dd50c040 d5c9cf40 00000000 00000000 bffff3c4 c012dffc 
Feb 24 21:38:01 nova kernel:        d5c9cf40 c317f580 00000000 d5c9cf40 00000000 d5c9cf40 080508c0 c012e053 
Feb 24 21:38:01 nova kernel: Call Trace: [dput+295/336] [fput+116/208] [filp_close+92/112] [sys_close+67/96] [system_call+51/56] 
Feb 24 21:38:01 nova kernel: 
Feb 24 21:38:01 nova kernel: Code: 89 44 99 18 89 59 14 8b 56 14 8b 41 10 ff 49 10 39 d0 74 08 
Feb 24 21:38:06 nova kernel:  printing eip:
Feb 24 21:38:06 nova kernel: c0126c78
Feb 24 21:38:06 nova kernel: Oops: 0002
Feb 24 21:38:06 nova kernel: CPU:    0
Feb 24 21:38:06 nova kernel: EIP:    0010:[kmem_cache_free+56/176]
Feb 24 21:38:06 nova kernel: EFLAGS: 00010012
Feb 24 21:38:06 nova kernel: eax: ffffffff   ebx: 01ffffff   ecx: db1fa000   edx: 00000000
Feb 24 21:38:06 nova kernel: esi: c188be08   edi: 00000246   ebp: db1fa040   esp: decc5f54
Feb 24 21:38:06 nova kernel: ds: 0018   es: 0018   ss: 0018
Feb 24 21:38:06 nova kernel: Process sshd (pid: 588, stackpage=decc5000)
Feb 24 21:38:06 nova kernel: Stack: db1fa040 dffe10c0 c8ae7c40 db1fa040 c013f607 c188be08 db1fa040 cb674440 
Feb 24 21:38:06 nova kernel:        dffe7540 c012ee54 db1fa040 cb674440 00000000 00000000 bfffa494 c012dffc 
Feb 24 21:38:06 nova kernel:        cb674440 c317f580 00000000 cb674440 00000000 cb674440 080699e8 c012e053 
Feb 24 21:38:06 nova kernel: Call Trace: [dput+295/336] [fput+116/208] [filp_close+92/112] [sys_close+67/96] [system_call+51/56] 
Feb 24 21:38:06 nova kernel: 
Feb 24 21:38:06 nova kernel: Code: 89 44 99 18 89 59 14 8b 56 14 8b 41 10 ff 49 10 39 d0 74 08 


Dump of assembler code for function kmem_cache_free:
0xc0126c40 <kmem_cache_free>:	push   %ebp
0xc0126c41 <kmem_cache_free+1>:	push   %edi
0xc0126c42 <kmem_cache_free+2>:	push   %esi
0xc0126c43 <kmem_cache_free+3>:	push   %ebx
0xc0126c44 <kmem_cache_free+4>:	mov    0x14(%esp,1),%esi
0xc0126c48 <kmem_cache_free+8>:	mov    0x18(%esp,1),%ebx
0xc0126c4c <kmem_cache_free+12>:	pushf  
0xc0126c4d <kmem_cache_free+13>:	pop    %edi
0xc0126c4e <kmem_cache_free+14>:	cli    
0xc0126c4f <kmem_cache_free+15>:	lea    0x40000000(%ebx),%edx
0xc0126c55 <kmem_cache_free+21>:	mov    0xc02df418,%ecx
0xc0126c5b <kmem_cache_free+27>:	shr    $0xc,%edx
0xc0126c5e <kmem_cache_free+30>:	mov    %edx,%eax
0xc0126c60 <kmem_cache_free+32>:	shl    $0x4,%eax
0xc0126c63 <kmem_cache_free+35>:	add    %edx,%eax
0xc0126c65 <kmem_cache_free+37>:	mov    0x4(%ecx,%eax,4),%ecx
0xc0126c69 <kmem_cache_free+41>:	sub    0xc(%ecx),%ebx
0xc0126c6c <kmem_cache_free+44>:	mov    %ebx,%eax
0xc0126c6e <kmem_cache_free+46>:	xor    %edx,%edx
0xc0126c70 <kmem_cache_free+48>:	div    0xc(%esi),%eax
0xc0126c73 <kmem_cache_free+51>:	mov    %eax,%ebx
0xc0126c75 <kmem_cache_free+53>:	mov    0x14(%ecx),%eax
0xc0126c78 <kmem_cache_free+56>:	mov    %eax,0x18(%ecx,%ebx,4)
0xc0126c7c <kmem_cache_free+60>:	mov    %ebx,0x14(%ecx)
0xc0126c7f <kmem_cache_free+63>:	mov    0x14(%esi),%edx
0xc0126c82 <kmem_cache_free+66>:	mov    0x10(%ecx),%eax
0xc0126c85 <kmem_cache_free+69>:	decl   0x10(%ecx)
0xc0126c88 <kmem_cache_free+72>:	cmp    %edx,%eax
0xc0126c8a <kmem_cache_free+74>:	je     0xc0126c94 <kmem_cache_free+84>
0xc0126c8c <kmem_cache_free+76>:	cmpl   $0x0,0x10(%ecx)
0xc0126c90 <kmem_cache_free+80>:	je     0xc0126cb7 <kmem_cache_free+119>
0xc0126c92 <kmem_cache_free+82>:	jmp    0xc0126cde <kmem_cache_free+158>
0xc0126c94 <kmem_cache_free+84>:	mov    0x8(%esi),%ebx
0xc0126c97 <kmem_cache_free+87>:	mov    %ecx,0x8(%esi)
0xc0126c9a <kmem_cache_free+90>:	mov    (%ecx),%edx
0xc0126c9c <kmem_cache_free+92>:	cmp    %ebx,%edx
0xc0126c9e <kmem_cache_free+94>:	je     0xc0126cde <kmem_cache_free+158>
0xc0126ca0 <kmem_cache_free+96>:	mov    0x4(%ecx),%eax
0xc0126ca3 <kmem_cache_free+99>:	mov    %eax,0x4(%edx)
0xc0126ca6 <kmem_cache_free+102>:	mov    %edx,(%eax)
0xc0126ca8 <kmem_cache_free+104>:	mov    0x4(%ebx),%eax
0xc0126cab <kmem_cache_free+107>:	mov    %ecx,0x4(%ebx)
0xc0126cae <kmem_cache_free+110>:	mov    %ebx,(%ecx)
0xc0126cb0 <kmem_cache_free+112>:	mov    %eax,0x4(%ecx)
0xc0126cb3 <kmem_cache_free+115>:	mov    %ecx,(%eax)
0xc0126cb5 <kmem_cache_free+117>:	jmp    0xc0126cde <kmem_cache_free+158>
0xc0126cb7 <kmem_cache_free+119>:	mov    0x8(%esi),%eax
0xc0126cba <kmem_cache_free+122>:	mov    0x4(%ecx),%edx
0xc0126cbd <kmem_cache_free+125>:	mov    0x4(%eax),%ebx
0xc0126cc0 <kmem_cache_free+128>:	mov    (%ecx),%eax
0xc0126cc2 <kmem_cache_free+130>:	mov    %edx,0x4(%eax)
0xc0126cc5 <kmem_cache_free+133>:	mov    %eax,(%edx)
0xc0126cc7 <kmem_cache_free+135>:	mov    0x4(%esi),%eax
0xc0126cca <kmem_cache_free+138>:	mov    %ecx,0x4(%esi)
0xc0126ccd <kmem_cache_free+141>:	mov    %esi,(%ecx)
0xc0126ccf <kmem_cache_free+143>:	mov    %eax,0x4(%ecx)
0xc0126cd2 <kmem_cache_free+146>:	mov    %ecx,(%eax)
0xc0126cd4 <kmem_cache_free+148>:	cmp    %ecx,0x8(%esi)
0xc0126cd7 <kmem_cache_free+151>:	jne    0xc0126cde <kmem_cache_free+158>
0xc0126cd9 <kmem_cache_free+153>:	mov    (%ebx),%eax
0xc0126cdb <kmem_cache_free+155>:	mov    %eax,0x8(%esi)
0xc0126cde <kmem_cache_free+158>:	push   %edi
0xc0126cdf <kmem_cache_free+159>:	popf   
0xc0126ce0 <kmem_cache_free+160>:	pop    %ebx
0xc0126ce1 <kmem_cache_free+161>:	pop    %esi
0xc0126ce2 <kmem_cache_free+162>:	pop    %edi
0xc0126ce3 <kmem_cache_free+163>:	pop    %ebp
0xc0126ce4 <kmem_cache_free+164>:	ret    
0xc0126ce5 <kmem_cache_free+165>:	lea    0x0(%esi,1),%esi
0xc0126ce9 <kmem_cache_free+169>:	lea    0x0(%edi,1),%edi

