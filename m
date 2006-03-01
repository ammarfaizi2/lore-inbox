Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbWCAPGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbWCAPGt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 10:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWCAPGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 10:06:48 -0500
Received: from 213-140-2-71.ip.fastwebnet.it ([213.140.2.71]:18827 "EHLO
	aa004msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932372AbWCAPGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 10:06:47 -0500
Date: Wed, 1 Mar 2006 16:06:56 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Kernel BUG at mm/slab.c:2564 - 2.6.16-rc5-g7b14e3b5
Message-ID: <20060301160656.370e1ee0@localhost>
X-Mailer: Sylpheed-Claws 2.0.0-rc4 (GTK+ 2.8.8; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=MP_PQayyDA8g9+Ubge1JeGI78l
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_PQayyDA8g9+Ubge1JeGI78l
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

It's the first time I see this, I don't think it is reproducible...

I was emerging (Gentoo) something and working on a reiserfs partition
when this happened:


grep[21235]: segfault at 00000079ecf16039 rip 0000003cf6701274 rsp
00007fffffd95e80 error 4 slab: Internal list corruption detected in
cache 'anon_vma'(92), slabp ffff810000a07000(16). Hexdump:

000: 00 01 10 00 00 00 00 00 00 02 20 00 00 00 00 00
010: a0 01 00 00 00 00 00 00 a0 71 a0 00 00 81 ff ff
020: 10 00 00 00 10 00 00 00 00 00 00 00 00 00 00 00
030: fe ff ff ff fe ff ff ff fe ff ff ff fe ff ff ff
040: fe ff ff ff fe ff ff ff fe ff ff ff fe ff ff ff
050: fe ff ff ff fe ff ff ff fe ff ff ff fe ff ff ff
060: fe ff ff ff fe ff ff ff fe ff ff ff fe ff ff ff
070: 11 00 00 00 12 00 00 00 13 00 00 00 14 00 00 00
080: 15 00 00 00 16 00 00 00 17 00 00 00 18 00 00 00
090: 19 00 00 00 1a 00 00 00 1b 00 00 00 1c 00 00 00
0a0: 1d 00 00 00 1e 00 00 00 7f 00 00 00 20 00 00 00
0b0: 21 00 00 00 22 00 00 00 23 00 00 00 24 00 00 00
0c0: 25 00 00 00 26 00 00 00 27 00 00 00 28 00 00 00
0d0: 29 00 00 00 2a 00 00 00 2b 00 00 00 2c 00 00 00
0e0: 2d 00 00 00 2e 00 00 00 2f 00 00 00 30 00 00 00
0f0: 31 00 00 00 32 00 00 00 33 00 00 00 34 00 00 00
100: 35 00 00 00 36 00 00 00 37 00 00 00 38 00 00 00
110: 39 00 00 00 3a 00 00 00 3b 00 00 00 3c 00 00 00
120: 3d 00 00 00 3e 00 00 00 3f 00 00 00 40 00 00 00
130: 41 00 00 00 42 00 00 00 43 00 00 00 44 00 00 00
140: 45 00 00 00 46 00 00 00 47 00 00 00 48 00 00 00
150: 49 00 00 00 4a 00 00 00 4b 00 00 00 4c 00 00 00
160: 4d 00 00 00 4e 00 00 00 4f 00 00 00 50 00 00 00
170: 51 00 00 00 52 00 00 00
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at mm/slab.c:2564
invalid opcode: 0000 [1] 
CPU 0 
Modules linked in: xt_state ip_queue ip_conntrack iptable_filter
ip_tables Pid: 21232, comm: as Not tainted 2.6.16-rc5-g7b14e3b5 #7
RIP: 0010:[<ffffffff80156c5e>] <ffffffff80156c5e>{check_slabp+188}
RSP: 0018:ffff81000a2cbdc8  EFLAGS: 00010096
RAX: 0000000000000001 RBX: 0000000000000178 RCX: 0000000000003ee7
RDX: 00000000ffffff01 RSI: 0000000000003ee7 RDI: ffffffff803f24c0
RBP: ffff810000a07000 R08: 00000000fffffffe R09: ffff810000a07000
R10: 0000000000000046 R11: 0000000000000000 R12: ffff81001ff2cec0
R13: ffff810000a071a0 R14: 0000000000000000 R15: ffff81000a2cbee0
FS:  00002af4db709dc0(0000) GS:ffffffff804cb000(0000)
knlGS:00000000f6cd7bb0 CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000003cf698c600 CR3: 000000000c1a3000 CR4: 00000000000006e0
Process as (pid: 21232, threadinfo ffff81000a2ca000, task
ffff810017e7a100) Stack: ffff810000a07000 ffff81001ff2bf20
ffff81001ff2cec0 ffffffff80157763 ffff81001ff280a8 ffff810005f24000
0000000000000010 0000000000000010 ffff81001ff28098 ffff81001ff2bf20 
Call Trace: <ffffffff80157763>{free_block+154}
<ffffffff8015796c>{cache_flusharray+111}
<ffffffff80157585>{kmem_cache_free+78}
<ffffffff80148cac>{free_pgtables+45} <ffffffff8014e1fc>{exit_mmap+119}
<ffffffff8012210c>{mmput+27} <ffffffff801263d6>{do_exit+519}
<ffffffff801269d7>{sys_exit_group+0} <ffffffff8010a5b2>{system_call+126}

Code: 0f 0b 68 4f e6 38 80 c2 04 0a 5b 5d 41 5c c3 41 55 31 c0 48 
RIP <ffffffff80156c5e>{check_slabp+188} RSP <ffff81000a2cbdc8>
 <1>Fixing recursive fault but reboot is needed!


Full dmesg & config attached.


PS: the machine is still running and other messages are appearing:


slab: double free detected in cache 'anon_vma', objp ffff81000511ca38
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at mm/slab.c:2329
invalid opcode: 0000 [3] 
CPU 0 
Modules linked in: xt_state ip_queue ip_conntrack iptable_filter
ip_tables Pid: 21233, comm: bash Not tainted 2.6.16-rc5-g7b14e3b5 #7
RIP: 0010:[<ffffffff801577ca>] <ffffffff801577ca>{free_block+257}
RSP: 0018:ffff810000dc5c78  EFLAGS: 00010092
RAX: 0000000000000049 RBX: ffff81000511c000 RCX: ffffffff803f2490
RDX: ffffffff803f2490 RSI: 0000000000000001 RDI: 0000000100000000
RBP: ffff81001ff2bf20 R08: 000000003b9aca00 R09: 000000000000000f
R10: 0000000000000000 R11: ffff81001ff2bf20 R12: ffff81001ff2cec0
R13: ffff81000511ca38 R14: 0000000000000037 R15: ffff81000511c030
FS:  00002b9e31461e60(0000) GS:ffffffff804cb000(0000)
knlGS:00000000f77378e0 CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 000000000071359f CR3: 0000000000614000 CR4: 00000000000006e0
Process bash (pid: 21233, threadinfo ffff810000dc4000, task
ffff81001d018e60) Stack: ffff81001ff280a8 0000003700615065
0000000000000010 0000000000000010 ffff81001ff28098 ffff81001ff2bf20
ffff81001ff2cec0 0000000000000000 ffff810000dc5d70 ffffffff8015796c 
Call Trace: <ffffffff8015796c>{cache_flusharray+111}
       <ffffffff80157585>{kmem_cache_free+78}
<ffffffff80148cac>{free_pgtables+45} <ffffffff8014e1fc>{exit_mmap+119}
<ffffffff8012210c>{mmput+27} <ffffffff801263d6>{do_exit+519}
<ffffffff801269d7>{sys_exit_group+0}
<ffffffff8012deb3>{get_signal_to_deliver+1216}
<ffffffff80109aaa>{do_signal+110} <ffffffff8012d591>{kill_proc_info+41}
<ffffffff8012e601>{sys_kill+263}
<ffffffff8010a476>{sys_rt_sigreturn+654}
<ffffffff8010a82e>{int_signal+18}

Code: 0f 0b 68 4f e6 38 80 c2 19 09 8b 43 24 48 89 de 4c 89 e7 43 
RIP <ffffffff801577ca>{free_block+257} RSP <ffff810000dc5c78>
 <1>Fixing recursive fault but reboot is needed!
Unable to handle kernel paging request at 0000000000100108 RIP: 
<ffffffff80157748>{free_block+127}
PGD 0 
Oops: 0002 [4] 
CPU 0 
Modules linked in: xt_state ip_queue ip_conntrack iptable_filter
ip_tables Pid: 18669, comm: konsole Not tainted 2.6.16-rc5-g7b14e3b5 #7
RIP: 0010:[<ffffffff80157748>] <ffffffff80157748>{free_block+127}
RSP: 0018:ffff81001d60bde8  EFLAGS: 00010012
RAX: 0000000000100100 RBX: ffff81000511c000 RCX: ffff810001000000
RDX: 0000000000200200 RSI: ffff81000511c000 RDI: ffff81001ff2cec0
RBP: ffff81001ff2bf20 R08: ffff81001ff2eae8 R09: ffff8100169f1000
R10: 0000000000000212 R11: 00000000000000aa R12: ffff81001ff2cec0
R13: ffff81000511c5b0 R14: 0000000000000006 R15: ffff8100098ef030
FS:  00002b6843b30ce0(0000) GS:ffffffff804cb000(0000)
knlGS:00000000f77378e0 CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000100108 CR3: 000000000f55a000 CR4: 00000000000006e0
Process konsole (pid: 18669, threadinfo ffff81001d60a000, task
ffff81001e17b750) Stack: ffff81001ff28100 000000060513e000
0000000000000005 0000000000000010 ffff81001ff28098 ffff81001ff2bf20
ffff81001ff2cec0 0000000000000000 ffff81001d60bee0 ffffffff8015796c 
Call Trace: <ffffffff8015796c>{cache_flusharray+111}
       <ffffffff80157585>{kmem_cache_free+78}
<ffffffff80148cac>{free_pgtables+45} <ffffffff8014e1fc>{exit_mmap+119}
<ffffffff8012210c>{mmput+27} <ffffffff801263d6>{do_exit+519}
<ffffffff801269d7>{sys_exit_group+0} <ffffffff8010a5b2>{system_call+126}

Code: 48 89 50 08 48 89 02 48 c7 43 08 00 02 20 00 48 c7 03 00 01 
RIP <ffffffff80157748>{free_block+127} RSP <ffff81001d60bde8>
CR2: 0000000000100108
 <1>Fixing recursive fault but reboot is needed!
slab error in cache_alloc_debugcheck_after(): cache `anon_vma': double
free, or memory outside object was overwritten

Call Trace: <ffffffff80156d06>{cache_alloc_debugcheck_after+153}
       <ffffffff8014f939>{anon_vma_prepare+73}
<ffffffff80156e27>{kmem_cache_alloc+140}
<ffffffff8014f939>{anon_vma_prepare+73}
<ffffffff8014af5f>{__handle_mm_fault+899}
<ffffffff80117ee8>{do_page_fault+937}
<ffffffff801ddede>{prio_tree_insert+432}
<ffffffff801566a0>{check_poison_obj+48}
<ffffffff8010aee1>{error_exit+0} <ffffffff801e1896>{__clear_user+60}
<ffffffff801e187a>{__clear_user+32} <ffffffff80182b0d>{padzero+24}
<ffffffff80183b4c>{load_elf_binary+2866}
<ffffffff80163dd4>{search_binary_handler+110}
<ffffffff801640c7>{do_execve+375} <ffffffff8010a5b2>{system_call+126}
<ffffffff8010929c>{sys_execve+51} <ffffffff8010a9d6>{stub_execve+106}
ffff8100098efb78: redzone 1: 0x170fc2a5, redzone 2: 0x170fc2a5. slab
error in cache_alloc_debugcheck_after(): cache `anon_vma': double free,
or memory outside object was overwritten

Call Trace: <ffffffff80156d06>{cache_alloc_debugcheck_after+153}
       <ffffffff8014f939>{anon_vma_prepare+73}
<ffffffff80156e27>{kmem_cache_alloc+140}
<ffffffff8014f939>{anon_vma_prepare+73}
<ffffffff8014af5f>{__handle_mm_fault+899}
<ffffffff80117ee8>{do_page_fault+937}
<ffffffff80141857>{generic_file_aio_read+52}
<ffffffff801ddede>{prio_tree_insert+432}
<ffffffff8010aee1>{error_exit+0} <ffffffff801e1896>{__clear_user+60}
<ffffffff801e187a>{__clear_user+32} <ffffffff80182b0d>{padzero+24}
<ffffffff80182f2b>{load_elf_interp+803}
<ffffffff80183d87>{load_elf_binary+3437}
<ffffffff80163dd4>{search_binary_handler+110}
<ffffffff801640c7>{do_execve+375} <ffffffff8010a5b2>{system_call+126}
<ffffffff8010929c>{sys_execve+51} <ffffffff8010a9d6>{stub_execve+106}
ffff8100098ef970: redzone 1: 0x170fc2a5, redzone 2: 0x170fc2a5. slab
error in cache_alloc_debugcheck_after(): cache `anon_vma': double free,
or memory outside object was overwritten

Call Trace: <ffffffff80156d06>{cache_alloc_debugcheck_after+153}
       <ffffffff8014f939>{anon_vma_prepare+73}
<ffffffff80156e27>{kmem_cache_alloc+140}
<ffffffff8014f939>{anon_vma_prepare+73}
<ffffffff8014ad64>{__handle_mm_fault+392}
<ffffffff801566a0>{check_poison_obj+48}
<ffffffff80117ee8>{do_page_fault+937}
<ffffffff8014dc68>{do_mmap_pgoff+1507} <ffffffff8010aee1>{error_exit+0}
ffff8100098ef3d0: redzone 1: 0x170fc2a5, redzone 2: 0x170fc2a5. slab
error in cache_alloc_debugcheck_after(): cache `anon_vma': double free,
or memory outside object was overwritten

Call Trace: <ffffffff80156d06>{cache_alloc_debugcheck_after+153}
       <ffffffff8014f939>{anon_vma_prepare+73}
<ffffffff80156e27>{kmem_cache_alloc+140}
<ffffffff8014f939>{anon_vma_prepare+73}
<ffffffff8014af5f>{__handle_mm_fault+899}
<ffffffff80117ee8>{do_page_fault+937}
<ffffffff8014dc68>{do_mmap_pgoff+1507} <ffffffff8010aee1>{error_exit+0}
ffff8100098ef920: redzone 1: 0x170fc2a5, redzone 2: 0x170fc2a5. slab
error in cache_alloc_debugcheck_after(): cache `anon_vma': double free,
or memory outside object was overwritten

Call Trace: <ffffffff80156d06>{cache_alloc_debugcheck_after+153}
       <ffffffff8014f939>{anon_vma_prepare+73}
<ffffffff80156e27>{kmem_cache_alloc+140}
<ffffffff8014f939>{anon_vma_prepare+73}
<ffffffff8014ad64>{__handle_mm_fault+392}
<ffffffff801566a0>{check_poison_obj+48}
<ffffffff80117ee8>{do_page_fault+937}
<ffffffff8014dc68>{do_mmap_pgoff+1507} <ffffffff8010aee1>{error_exit+0}
ffff8100098ef808: redzone 1: 0x170fc2a5, redzone 2: 0x170fc2a5. slab
error in cache_alloc_debugcheck_after(): cache `anon_vma': double free,
or memory outside object was overwritten

Call Trace: <ffffffff80156d06>{cache_alloc_debugcheck_after+153}
       <ffffffff8014f939>{anon_vma_prepare+73}
<ffffffff80156e27>{kmem_cache_alloc+140}
<ffffffff8014f939>{anon_vma_prepare+73}
<ffffffff8014ad64>{__handle_mm_fault+392}
<ffffffff80117ee8>{do_page_fault+937} <ffffffff8014c436>{remove_vma+90}
<ffffffff8014d66a>{do_munmap+601} <ffffffff8010aee1>{error_exit+0}
ffff8100098eff10: redzone 1: 0x170fc2a5, redzone 2: 0x170fc2a5. slab
error in cache_alloc_debugcheck_after(): cache `anon_vma': double free,
or memory outside object was overwritten

Call Trace: <ffffffff80156d06>{cache_alloc_debugcheck_after+153}
       <ffffffff8014f939>{anon_vma_prepare+73}
<ffffffff80156e27>{kmem_cache_alloc+140}
<ffffffff8014f939>{anon_vma_prepare+73}
<ffffffff8014ad64>{__handle_mm_fault+392}
<ffffffff80117ee8>{do_page_fault+937} <ffffffff8016d5f8>{dput+59}
<ffffffff8015b791>{__fput+302} <ffffffff8010aee1>{error_exit+0}
ffff8100098ef718: redzone 1: 0x170fc2a5, redzone 2: 0x170fc2a5. slab
error in cache_alloc_debugcheck_after(): cache `anon_vma': double free,
or memory outside object was overwritten

Call Trace: <ffffffff80156d06>{cache_alloc_debugcheck_after+153}
       <ffffffff8014f939>{anon_vma_prepare+73}
<ffffffff80156e27>{kmem_cache_alloc+140}
<ffffffff8014f939>{anon_vma_prepare+73}
<ffffffff8014ad64>{__handle_mm_fault+392}
<ffffffff80117ee8>{do_page_fault+937}
<ffffffff8014dc68>{do_mmap_pgoff+1507} <ffffffff8010aee1>{error_exit+0}
ffff8100098ef740: redzone 1: 0x170fc2a5, redzone 2: 0x170fc2a5. slab
error in cache_alloc_debugcheck_after(): cache `anon_vma': double free,
or memory outside object was overwritten

Call Trace: <ffffffff80156d06>{cache_alloc_debugcheck_after+153}
       <ffffffff8014f939>{anon_vma_prepare+73}
<ffffffff80156e27>{kmem_cache_alloc+140}
<ffffffff8014f939>{anon_vma_prepare+73}
<ffffffff8014af5f>{__handle_mm_fault+899}
<ffffffff80117ee8>{do_page_fault+937}
<ffffffff801ddede>{prio_tree_insert+432}
<ffffffff801566a0>{check_poison_obj+48}
<ffffffff8010aee1>{error_exit+0} <ffffffff801e1896>{__clear_user+60}
<ffffffff801e187a>{__clear_user+32} <ffffffff80182b0d>{padzero+24}
<ffffffff80183b4c>{load_elf_binary+2866}
<ffffffff80163dd4>{search_binary_handler+110}
<ffffffff801640c7>{do_execve+375} <ffffffff8010a5b2>{system_call+126}
<ffffffff8010929c>{sys_execve+51} <ffffffff8010a9d6>{stub_execve+106}
ffff8100098ef858: redzone 1: 0x170fc2a5, redzone 2: 0x170fc2a5. slab
error in cache_alloc_debugcheck_after(): cache `anon_vma': double free,
or memory outside object was overwritten

Call Trace: <ffffffff80156d06>{cache_alloc_debugcheck_after+153}
       <ffffffff8014f939>{anon_vma_prepare+73}
<ffffffff80156e27>{kmem_cache_alloc+140}
<ffffffff8014f939>{anon_vma_prepare+73}
<ffffffff8014af5f>{__handle_mm_fault+899}
<ffffffff80117ee8>{do_page_fault+937}
<ffffffff80141857>{generic_file_aio_read+52}
<ffffffff801ddede>{prio_tree_insert+432}
<ffffffff8010aee1>{error_exit+0} <ffffffff801e1896>{__clear_user+60}
<ffffffff801e187a>{__clear_user+32} <ffffffff80182b0d>{padzero+24}
<ffffffff80182f2b>{load_elf_interp+803}
<ffffffff80183d87>{load_elf_binary+3437}
<ffffffff80163dd4>{search_binary_handler+110}
<ffffffff801640c7>{do_execve+375} <ffffffff8010a5b2>{system_call+126}
<ffffffff8010929c>{sys_execve+51} <ffffffff8010a9d6>{stub_execve+106}
ffff8100098ef768: redzone 1: 0x170fc2a5, redzone 2: 0x170fc2a5. slab
error in cache_alloc_debugcheck_after(): cache `anon_vma': double free,
or memory outside object was overwritten

Call Trace: <ffffffff80156d06>{cache_alloc_debugcheck_after+153}
       <ffffffff8014f939>{anon_vma_prepare+73}
<ffffffff80156e27>{kmem_cache_alloc+140}
<ffffffff8014f939>{anon_vma_prepare+73}
<ffffffff8014ad64>{__handle_mm_fault+392}
<ffffffff801566a0>{check_poison_obj+48}
<ffffffff80117ee8>{do_page_fault+937}
<ffffffff8014dc68>{do_mmap_pgoff+1507} <ffffffff8010aee1>{error_exit+0}
ffff8100098ef290: redzone 1: 0x170fc2a5, redzone 2: 0x170fc2a5.


I'm going to reboot ;)

-- 
	Paolo Ornati
	Linux 2.6.16-rc5-g7b14e3b5 on x86_64

--MP_PQayyDA8g9+Ubge1JeGI78l
Content-Type: application/x-gzip; name=DMESG.gz
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=DMESG.gz

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
6lC/Yr8ByKliG/JBAAA=

--MP_PQayyDA8g9+Ubge1JeGI78l
Content-Type: application/x-gzip; name=config.gz
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=config.gz

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

--MP_PQayyDA8g9+Ubge1JeGI78l--
