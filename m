Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291444AbSCDE4v>; Sun, 3 Mar 2002 23:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291406AbSCDE4m>; Sun, 3 Mar 2002 23:56:42 -0500
Received: from tomts11.bellnexxia.net ([209.226.175.55]:43444 "EHLO
	tomts11-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S291399AbSCDE4b>; Sun, 3 Mar 2002 23:56:31 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Christoph Hellwig <hch@caldera.de>
Subject: Re: [PATCH] radix-tree pagecache for 2.4.19-pre2-ac2
Date: Sun, 3 Mar 2002 23:55:57 -0500
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020303210346.A8329@caldera.de>
In-Reply-To: <20020303210346.A8329@caldera.de>
Cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020304045557.C1010BA9E@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 3, 2002 03:03 pm, Christoph Hellwig wrote:
> I have uploaded an updated version of the radix-tree pagecache patch
> against 2.4.19-pre2-ac2.  News in this release:
>
> * fix a deadlock when vmtruncate takes i_shared_lock twice by introducing
>   a new mapping->page_lock that mutexes mapping->page_tree. (akpm)
> * move setting of page->flags back out of move_to/from_swap_cache. (akpm)
> * put back lost page state settings in shmem_unuse_inode. (akpm)
> * get rid of remove_page_from_inode_queue - there was only one caller. (me)
> * replace add_page_to_inode_queue with ___add_to_page_cache. (me)
>
> Please give it some serious beating while I try to get 2.5 working and
> port the patch over 8)

Got this after a couple of hours with pre2-ac2+preempth+radixtree.

Reverted to pre2-ac2.

Hope this helps,

Ed Tomlinson

--------------------------------------------------------
ksymoops 2.4.3 on i586 2.4.19-pre2-ac2.  Options used
     -V (default)
     -k 20020303231146.ksyms (specified)
     -l 20020303231146.modules (specified)
     -o /lib/modules/2.4.19-pre2-ac2-prert (specified)
     -m /boot/System.map-2.4.19-pre2-ac2-prert (specified)

Warning: loading /lib/modules/2.4.19-pre2-ac2-prert/kernel/net/ipv4/netfilter/ipchains.o will taint the kernel: non-GPL license - BSD without advertisement clause
ac97_codec: AC97 Audio codec, id: 0x4352:0x5903 (Cirrus Logic CS4297)
kernel BUG at page_alloc.c:239!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012d247>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000020   ebx: c026a73c   ecx: ffffffdd   edx: d40e0000
esi: c13ca53c   edi: 00000001   ebp: d40e0000   esp: d40e1cb0
ds: 0018   es: 0018   ss: 0018
Process kdeinit (pid: 786, stackpage=d40e1000)
Stack: c022d19c 000000ef c026a73c c026a8f8 000001ff 00000000 c01117e4 d40e0000 
       000150d8 00000292 c026a77c 00000000 c026a73c c012d435 000000f0 c15b2b14 
       00000000 00007b9c 00007b9c 00000001 c026a8f4 000000f0 c012d2e6 00000003 
Call Trace: [<c01117e4>] [<c012d435>] [<c012d2e6>] [<c0124b23>] [<c0137c91>] 
   [<c0137f20>] [<c0135f37>] [<c0136124>] [<c0171f32>] [<c016df25>] [<c0136124>] 
   [<c015cfe1>] [<c015d568>] [<c015d68f>] [<c01467f7>] [<c013d940>] [<c013e2e9>] 
   [<c013d5fe>] [<c013e57a>] [<c013ea21>] [<c0132ba0>] [<c0106da3>] 
Code: 0f 0b 83 c4 08 8d 74 26 00 8b 46 14 a8 80 74 19 68 ef 00 00 

>>EIP; c012d246 <rmqueue+256/2e0>   <=====
Trace; c01117e4 <schedule+230/268>
Trace; c012d434 <__alloc_pages+70/2bc>
Trace; c012d2e6 <_alloc_pages+16/18>
Trace; c0124b22 <find_or_create_page+2a/d8>
Trace; c0137c90 <grow_dev_page+20/ac>
Trace; c0137f20 <grow_buffers+f4/13c>
Trace; c0135f36 <getblk+2a/40>
Trace; c0136124 <bread+18/bc>
Trace; c0171f32 <reiserfs_bread+16/24>
Trace; c016df24 <search_by_key+5c/d40>
Trace; c0136124 <bread+18/bc>
Trace; c015cfe0 <search_by_entry_key+1c/1c0>
Trace; c015d568 <reiserfs_find_entry+7c/134>
Trace; c015d68e <reiserfs_lookup+6e/e0>
Trace; c01467f6 <d_alloc+1a/194>
Trace; c013d940 <real_lookup+70/118>
Trace; c013e2e8 <link_path_walk+79c/a14>
Trace; c013d5fe <getname+5e/9c>
Trace; c013e57a <path_walk+1a/1c>
Trace; c013ea20 <__user_walk+34/50>
Trace; c0132ba0 <sys_access+94/128>
Trace; c0106da2 <system_call+32/40>
Code;  c012d246 <rmqueue+256/2e0>
00000000 <_EIP>:
Code;  c012d246 <rmqueue+256/2e0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012d248 <rmqueue+258/2e0>
   2:   83 c4 08                  add    $0x8,%esp
Code;  c012d24a <rmqueue+25a/2e0>
   5:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c012d24e <rmqueue+25e/2e0>
   9:   8b 46 14                  mov    0x14(%esi),%eax
Code;  c012d252 <rmqueue+262/2e0>
   c:   a8 80                     test   $0x80,%al
Code;  c012d254 <rmqueue+264/2e0>
   e:   74 19                     je     29 <_EIP+0x29> c012d26e <rmqueue+27e/2e0>
Code;  c012d256 <rmqueue+266/2e0>
  10:   68 ef 00 00 00            push   $0xef

 <1>Unable to handle kernel paging request at virtual address e5746608
c0129ece
*pde = 17423067
Oops: 0000
CPU:    0
EIP:    0010:[<c0129ece>]    Tainted: P 
EFLAGS: 00010082
eax: c906e0c0   ebx: f0415880   ecx: c158e2f0   edx: 00000007
esi: c158e2f0   edi: 00000246   ebp: 00000020   esp: d3a29de8
ds: 0018   es: 0018   ss: 0018
Process kdeinit (pid: 789, stackpage=d3a29000)
Stack: d495fb74 00000001 ffffffff 00000001 c0222fc5 c158e2f0 00000020 ffffffff 
       c1362970 d495fb74 00000000 c022304b d495fb74 00000001 d3a28000 c1362970 
       d495fb74 00000001 c02230f7 d495fb74 00000001 d3a29e40 c026a73c c01245d2 
Call Trace: [<c0222fc5>] [<c022304b>] [<c02230f7>] [<c01245d2>] [<c01246dc>] 
   [<c012474a>] [<c0125c7a>] [<c0121fad>] [<c0122263>] [<c01108bf>] [<c01107a8>] 
   [<c013b3fe>] [<c0106ef4>] 
Code: 8b 44 81 18 89 41 14 83 f8 ff 75 18 8b 41 04 8b 11 89 42 04 

>>EIP; c0129ece <kmem_cache_alloc+92/d4>   <=====
Trace; c0222fc4 <radix_tree_extend+54/9c>
Trace; c022304a <radix_tree_reserve+3e/d8>
Trace; c02230f6 <radix_tree_insert+12/2c>
Trace; c01245d2 <add_to_page_cache+32/ac>
Trace; c01246dc <page_cache_read+90/d8>
Trace; c012474a <read_cluster_nonblocking+26/40>
Trace; c0125c7a <filemap_nopage+12a/220>
Trace; c0121fac <do_no_page+70/250>
Trace; c0122262 <handle_mm_fault+d6/178>
Trace; c01108be <do_page_fault+116/42c>
Trace; c01107a8 <do_page_fault+0/42c>
Trace; c013b3fe <sys_fstat64+5a/6c>
Trace; c0106ef4 <error_code+34/40>
Code;  c0129ece <kmem_cache_alloc+92/d4>
00000000 <_EIP>:
Code;  c0129ece <kmem_cache_alloc+92/d4>   <=====
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax   <=====
Code;  c0129ed2 <kmem_cache_alloc+96/d4>
   4:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  c0129ed4 <kmem_cache_alloc+98/d4>
   7:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c0129ed8 <kmem_cache_alloc+9c/d4>
   a:   75 18                     jne    24 <_EIP+0x24> c0129ef2 <kmem_cache_alloc+b6/d4>
Code;  c0129eda <kmem_cache_alloc+9e/d4>
   c:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  c0129edc <kmem_cache_alloc+a0/d4>
   f:   8b 11                     mov    (%ecx),%edx
Code;  c0129ede <kmem_cache_alloc+a2/d4>
  11:   89 42 04                  mov    %eax,0x4(%edx)

 kernel BUG at page_alloc.c:239!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012d247>]    Tainted: P 
EFLAGS: 00013282
eax: 00000020   ebx: c026a73c   ecx: ffffffe0   edx: d8ce4000
esi: c13c541c   edi: 00000001   ebp: d8ce4000   esp: d8ce5e44
ds: 0018   es: 0018   ss: 0018
Process XFree86 (pid: 736, stackpage=d8ce5000)
Stack: c022d19c 000000ef c026a73c c026a918 000001ff 00000000 00003246 d8ce4000 
       00014f00 00003296 c026a77c 00000000 c026a73c c012d435 000001d2 c1002ccc 
       43b81000 d7420e04 d39d8d80 00000001 c026a914 000001d2 c012d2e6 d8ce4000 
Call Trace: [<c012d435>] [<c012d2e6>] [<c0121e6c>] [<c0121f72>] [<c0122263>] 
   [<c01108bf>] [<c01107a8>] [<c011b9b6>] [<c0118ace>] [<c0118a08>] [<c01187e1>] 
   [<c010826e>] [<c0106ef4>] 
Code: 0f 0b 83 c4 08 8d 74 26 00 8b 46 14 a8 80 74 19 68 ef 00 00 

>>EIP; c012d246 <rmqueue+256/2e0>   <=====
Trace; c012d434 <__alloc_pages+70/2bc>
Trace; c012d2e6 <_alloc_pages+16/18>
Trace; c0121e6c <do_anonymous_page+58/128>
Trace; c0121f72 <do_no_page+36/250>
Trace; c0122262 <handle_mm_fault+d6/178>
Trace; c01108be <do_page_fault+116/42c>
Trace; c01107a8 <do_page_fault+0/42c>
Trace; c011b9b6 <timer_bh+2e/2a4>
Trace; c0118ace <bh_action+26/70>
Trace; c0118a08 <tasklet_hi_action+5c/80>
Trace; c01187e0 <do_softirq+60/c8>
Trace; c010826e <do_IRQ+d6/e4>
Trace; c0106ef4 <error_code+34/40>
Code;  c012d246 <rmqueue+256/2e0>
00000000 <_EIP>:
Code;  c012d246 <rmqueue+256/2e0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012d248 <rmqueue+258/2e0>
   2:   83 c4 08                  add    $0x8,%esp
Code;  c012d24a <rmqueue+25a/2e0>
   5:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c012d24e <rmqueue+25e/2e0>
   9:   8b 46 14                  mov    0x14(%esi),%eax
Code;  c012d252 <rmqueue+262/2e0>
   c:   a8 80                     test   $0x80,%al
Code;  c012d254 <rmqueue+264/2e0>
   e:   74 19                     je     29 <_EIP+0x29> c012d26e <rmqueue+27e/2e0>
Code;  c012d256 <rmqueue+266/2e0>
  10:   68 ef 00 00 00            push   $0xef

 kernel BUG at inode.c:515!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0148076>]    Tainted: P 
EFLAGS: 00210282
eax: 0000001b   ebx: d4fa03a0   ecx: ffffffe5   edx: d5484000
esi: dd46f8e8   edi: dd46f800   ebp: d5129ac0   esp: d5485f2c
ds: 0018   es: 0018   ss: 0018
Process artsd (pid: 772, stackpage=d5485000)
Stack: c022f787 00000203 d4fa03a0 c0130256 d4fa03a0 c01301b8 d4fa03a0 c0148b16 
       d4fa03a0 d5484000 d5129ac0 d4fa03a0 c0146ca6 d4fa03a0 d5484000 00000000 
       d53253e0 c013fa8a d5129ac0 d5129ac0 d5129ac0 d1d49000 d5485fa4 c013fb65 
Call Trace: [<c0130256>] [<c01301b8>] [<c0148b16>] [<c0146ca6>] [<c013fa8a>] 
   [<c013fb65>] [<c0106da3>] 
Code: 0f 0b 83 c4 08 90 8d 74 26 00 f6 83 1c 01 00 00 10 75 17 68 

>>EIP; c0148076 <clear_inode+26/dc>   <=====
Trace; c0130256 <shmem_delete_inode+9e/a4>
Trace; c01301b8 <shmem_delete_inode+0/a4>
Trace; c0148b16 <iput+f2/220>
Trace; c0146ca6 <d_delete+6a/c8>
Trace; c013fa8a <vfs_unlink+15a/190>
Trace; c013fb64 <sys_unlink+a4/118>
Trace; c0106da2 <system_call+32/40>
Code;  c0148076 <clear_inode+26/dc>
00000000 <_EIP>:
Code;  c0148076 <clear_inode+26/dc>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0148078 <clear_inode+28/dc>
   2:   83 c4 08                  add    $0x8,%esp
Code;  c014807a <clear_inode+2a/dc>
   5:   90                        nop    
Code;  c014807c <clear_inode+2c/dc>
   6:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c0148080 <clear_inode+30/dc>
   a:   f6 83 1c 01 00 00 10      testb  $0x10,0x11c(%ebx)
Code;  c0148086 <clear_inode+36/dc>
  11:   75 17                     jne    2a <_EIP+0x2a> c01480a0 <clear_inode+50/dc>
Code;  c0148088 <clear_inode+38/dc>
  13:   68 00 00 00 00            push   $0x0

 kernel BUG at swap_state.c:141!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012db30>]    Tainted: P 
EFLAGS: 00010286
eax: 00000020   ebx: c13d8ab0   ecx: ffffffe0   edx: cb574000
esi: cb574000   edi: c13d8ab0   ebp: d66128f4   esp: cb575ecc
ds: 0018   es: 0018   ss: 0018
Process iceauth (pid: 4904, stackpage=cb575000)
Stack: c022d43d 0000008d 00003202 c012dd1b c13d8ab0 c13d8ab0 00000000 00000001 
       cb574000 c13d8ab0 00000000 d6612990 00000000 d66128fc c01306d5 c13d8ab0 
       00000000 d66128f4 d6612974 d6612840 cb575f6c d6612978 00003202 d66128f4 
Call Trace: [<c012dd1b>] [<c01306d5>] [<c01308cc>] [<c01311bc>] [<c01312bc>] 
   [<c0133bea>] [<c0106da3>] 
Code: 0f 0b 83 c4 08 b8 04 00 00 00 0f b3 43 14 53 e8 ac 60 ff ff 

>>EIP; c012db30 <__delete_from_swap_cache+38/58>   <=====
Trace; c012dd1a <move_from_swap_cache+6a/cc>
Trace; c01306d4 <shmem_getpage_locked+1b0/35c>
Trace; c01308cc <shmem_getpage+4c/94>
Trace; c01311bc <do_shmem_file_read+44/e8>
Trace; c01312bc <shmem_file_read+5c/74>
Trace; c0133bea <sys_read+8e/128>
Trace; c0106da2 <system_call+32/40>
Code;  c012db30 <__delete_from_swap_cache+38/58>
00000000 <_EIP>:
Code;  c012db30 <__delete_from_swap_cache+38/58>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012db32 <__delete_from_swap_cache+3a/58>
   2:   83 c4 08                  add    $0x8,%esp
Code;  c012db34 <__delete_from_swap_cache+3c/58>
   5:   b8 04 00 00 00            mov    $0x4,%eax
Code;  c012db3a <__delete_from_swap_cache+42/58>
   a:   0f b3 43 14               btr    %eax,0x14(%ebx)
Code;  c012db3e <__delete_from_swap_cache+46/58>
   e:   53                        push   %ebx
Code;  c012db3e <__delete_from_swap_cache+46/58>
   f:   e8 ac 60 ff ff            call   ffff60c0 <_EIP+0xffff60c0> c0123bf0 <__remove_inode_page+0/4c>

