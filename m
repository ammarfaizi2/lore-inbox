Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316043AbSFPJJ7>; Sun, 16 Jun 2002 05:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316051AbSFPJJ6>; Sun, 16 Jun 2002 05:09:58 -0400
Received: from ppp15.atlas-iap.es ([194.224.1.15]:51424 "EHLO
	antoli.gallimedina.net") by vger.kernel.org with ESMTP
	id <S316043AbSFPJJ5>; Sun, 16 Jun 2002 05:09:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: linux-kernel@vger.kernel.org
Subject: BUG: 2.4.18 invalid operand: 0000
Date: Sun, 16 Jun 2002 11:09:51 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17JW2i-0000Gp-00@antoli.gallimedina.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has happened on a Linux 2.4.18 with lowlatency+pre-empt applied 
(and the latest nvidia propietary module, but I guess it didn't affect, 
X was idle at 6:30 in the morning). 

It didnt have problem until this morning after 60 days. After the errors the 
system, when I tried to logout from the X session the system locked.

The first time I saw the error was when I was testing the "big-font" bug in 
Mozilla/X, which exhausted the memory and started OOM killer:

VM: killing process XFree86
invalid operand: 0000
CPU:    0
EIP:    0010:[rmqueue+415/484]    Tainted: P
EFLAGS: 00010202
eax: 0000004c   ebx: c02d4bc0   ecx: c02d4ba8   edx: 00012736
esi: c149cd80   edi: 00000000   ebp: 00000001   esp: df667e20
ds: 0018   es: 0018   ss: 0018
Process soffice.bin (pid: 32543, stackpage=df667000)
Stack: c02d4d1c 000001ff 00000256 00000000 df666000 00011736 00000286 00000000
       c02d4ba8 c012dc8f 000001d2 dca76710 00000256 00000000 c02d4ba8 c02d4d18
       000001d2 c0198134 c012daee df666000 c01269fe 00000256 00000001 00000908
Call Trace: [__alloc_pages+51/356] [reiserfs_get_block+0/3564] [_alloc_pages+22/24] [page_cache_read+154/244] [read_cluster_nonblocking+38/64]
   [filemap_nopage+267/504] [do_no_page+109/364] [handle_mm_fault+93/240] [do_page_fault+388/1204] [do_page_fault+0/1204] [process_timeout+0/104]
   [do_timer+63/108] [bh_action+38/112] [schedule+803/856] [error_code+52/64]

Code: 0f 0b 8b 46 18 a8 80 74 02 0f 0b 89 f0 eb 2b 47 83 c5 0c 83


Then, at 6:30 in the morning, when the machine was "idle" (at least the interactive processes), syslogd reported:



 invalid operand: 0000
CPU:    0
EIP:    0010:[__free_pages_ok+40/500]    Tainted: P
EFLAGS: 00010286
eax: 00000000   ebx: c1834000   ecx: c149cd80   edx: d9c0a530
esi: c149cd80   edi: 00000000   ebp: c149cd80   esp: c1835f2c
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c1835000)
Stack: c1834000 c149cd9c c1834000 c149cd80 000001d0 c1834000 c149cd9c c012cfb4
       c012de17 c012cff9 00000020 000001d0 00000020 00000006 000001fb 000019d0
       000001d0 c02d4ba8 0000001c c012d292 00000006 0000001a 00000006 000001d0
Call Trace: [shrink_cache+584/1000] [__free_pages+27/28] [shrink_cache+653/1000] [shrink_caches+86/124] [try_to_free_pages+55/88]
   [kswapd_balance_pgdat+67/140] [kswapd_balance+18/40] [kswapd+153/188] [kernel_thread+40/56]

Code: 0f 0b 89 f0 2b 05 4c ef 32 c0 c1 f8 06 3b 05 40 ef 32 c0 72
 invalid operand: 0000
CPU:    0
EIP:    0010:[__free_pages_ok+40/500]    Tainted: P
EFLAGS: 00010282
eax: 00000000   ebx: da4ea000   ecx: c154b900   edx: c02d4a80
esi: c154b900   edi: 00000000   ebp: c154b900   esp: da4ebd0c
ds: 0018   es: 0018   ss: 0018
Process find (pid: 2656, stackpage=da4eb000)
Stack: da4ea000 c154b91c da4ea000 c154b900 000001f0 da4ea000 c154b91c c012cfb4
       c012de17 c012cff9 00000020 000001f0 00000020 00000006 000001f8 00001a28
       000001f0 c02d4ba8 00000015 c012d292 00000006 00000018 00000006 000001f0 
Call Trace: [shrink_cache+584/1000] [__free_pages+27/28] [shrink_cache+653/1000] [shrink_caches+86/124] [try_to_free_pages+55/88]
   [balance_classzone+78/364] [is_tree_node+55/76] [__alloc_pages+262/356] [_alloc_pages+22/24] [__get_free_pages+10/24] [kmem_cache_grow+179/560]
   [kmem_cache_alloc+157/172] [get_new_inode+24/436] [iget4+242/252] [reiserfs_find_actor+0/24] [reiserfs_iget+39/108] [reiserfs_find_actor+0/24] 
   [reiserfs_lookup+148/204] [real_lookup+108/264] [link_path_walk+1442/2056] [getname+93/156] [path_walk+26/28] [__user_walk+53/80]
   [sys_lstat64+25/112] [sys_close+91/132] [system_call+51/56]

Code: 0f 0b 89 f0 2b 05 4c ef 32 c0 c1 f8 06 3b 05 40 ef 32 c0 72
 invalid operand: 0000
CPU:    0
EIP:    0010:[__free_pages_ok+40/500]    Tainted: P
EFLAGS: 00010282
eax: 00000000   ebx: c8140000   ecx: c151e400   edx: c02d4a80
esi: c151e400   edi: 00000000   ebp: c151e400   esp: c8141dd4
ds: 0018   es: 0018   ss: 0018
Process sort (pid: 2657, stackpage=c8141000)
Stack: c8140000 c151e41c c8140000 c151e400 000001d2 c8140000 c151e41c c012cfb4
       c012de17 c012cff9 00000020 000001d2 00000020 00000006 00000200 00001a3f 
       000001d2 c02d4ba8 00000020 c012d292 00000006 00000018 00000006 000001d2
Call Trace: [shrink_cache+584/1000] [__free_pages+27/28] [shrink_cache+653/1000] [shrink_caches+86/124] [try_to_free_pages+55/88]
   [balance_classzone+78/364] [__alloc_pages+262/356] [_alloc_pages+22/24] [do_anonymous_page+76/224] [do_no_page+51/364] [handle_mm_fault+93/240]
   [do_page_fault+388/1204] [do_page_fault+0/1204] [old_mmap+234/288] [error_code+52/64]

Code: 0f 0b 89 f0 2b 05 4c ef 32 c0 c1 f8 06 3b 05 40 ef 32 c0 72 
 invalid operand: 0000
CPU:    0
EIP:    0010:[__free_pages_ok+40/500]    Tainted: P 
EFLAGS: 00010282
eax: 00000000   ebx: c8140000   ecx: c150a5c0   edx: c02d4a80
esi: c150a5c0   edi: 00000000   ebp: c150a5c0   esp: c8141d9c
ds: 0018   es: 0018   ss: 0018
Process awk (pid: 2664, stackpage=c8141000)
Stack: c8140000 c150a5dc c8140000 c150a5c0 000001d2 c8140000 c150a5dc c012cfb4 
       c012de17 c012cff9 00000020 000001d2 00000020 00000006 00000200 00001a2d
       000001d2 c02d4ba8 00000020 c012d292 00000006 00000018 00000006 000001d2 
Call Trace: [shrink_cache+584/1000] [__free_pages+27/28] [shrink_cache+653/1000] [shrink_caches+86/124] [try_to_free_pages+55/88]
   [balance_classzone+78/364] [__alloc_pages+262/356] [reiserfs_get_block+0/3564] [_alloc_pages+22/24] [page_cache_read+154/244] [read_cluster_nonblocking+38/64] 
   [filemap_nopage+267/504] [do_no_page+109/364] [handle_mm_fault+93/240] [do_page_fault+388/1204] [do_page_fault+0/1204] [unmap_fixup+98/364]
   [do_munmap+495/604] [do_munmap+589/604] [sys_munmap+53/84] [error_code+52/64] 

Code: 0f 0b 89 f0 2b 05 4c ef 32 c0 c1 f8 06 3b 05 40 ef 32 c0 72 
 invalid operand: 0000
CPU:    0
EIP:    0010:[__free_pages_ok+40/500]    Tainted: P
EFLAGS: 00010282
eax: 00000000   ebx: caffc000   ecx: c11b6380   edx: c02d4a80
esi: c11b6380   edi: 00000000   ebp: c11b6380   esp: caffddfc
ds: 0018   es: 0018   ss: 0018
Process savelog (pid: 2671, stackpage=caffd000)
Stack: caffc000 c11b639c caffc000 c11b6380 000001d2 caffc000 c11b639c c012cfb4
       c012de17 c012cff9 00000020 000001d2 00000020 00000006 00000200 00001a2d 
       000001d2 c02d4ba8 00000020 c012d292 00000006 00000018 00000006 000001d2



-- 
  ricardo galli
       A paperless office has about as much a chance as a paperless bathroom
