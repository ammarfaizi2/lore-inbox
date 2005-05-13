Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262562AbVEMVJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbVEMVJe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 17:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262511AbVEMVIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 17:08:43 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:52425 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S262545AbVEMVDn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 17:03:43 -0400
Date: Fri, 13 May 2005 23:16:33 +0300
From: Costas Tavernarakis <taver@otenet.gr>
To: linux-kernel@vger.kernel.org
Cc: Costas Tavernarakis <taver@otenet.gr>
Subject: PROBLEM: strange oops, scheduling while atomic
Message-ID: <20050513201633.GA25710@noc.otenet.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I got a strange oops today (ksymoops output follows), accompannied with
a few "scheduling while atomic: " error messages. At the time of the OOPS,
the system had ~100 processes doing heavy NFS I/O on a remote server.

Can you read anything usefull out of this? Is there something i can
do - besides keeping the load presented to the system down - to
prevent this from happening again?

ver_linux output:

Linux stix 2.6.10 #1 SMP Tue Jan 25 19:26:24 EET 2005 i686 GNU/Linux

Gnu C                  3.3.5
Gnu make               3.80
binutils               2.15
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2-pre1
e2fsprogs              1.37
reiserfsprogs          line
reiser4progs           line
PPP                    2.4.3
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
Modules Loaded         bonding

ksymoops output:

ksymoops 2.4.9 on i686 2.6.10.  Options used
     -V (default)
     -k /proc/kallsyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.6.10/ (default)
     -m /boot/System.map-2.6.10 (specified)

Warning (read_ksyms): no kernel symbols in ksyms, is /proc/kallsyms a valid ksyms file?
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address bfe04f90
c0116e05
*pde = 8d51b067
Oops: 0002 [#1]
CPU:    1
EIP:    0060:[<c0116e05>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286   (2.6.10) 
eax: 7ffe4000   ebx: 9f86e163   ecx: bfe04f90   edx: 00000163
esi: c23f0dc0   edi: 00000003   ebp: e719fabc   esp: ccef5bb4
ds: 007b   es: 007b   ss: 0068
Stack: 00000000 c0149cef c23f0dc0 00000003 ccef4000 e719fabc fffe01fc fffe01fc 
       d777c080 ebefbbf4 c0149e60 e719fa80 ebefbbf4 fffe01fc d777c080 00000001 
       0807f000 c0383585 00000000 02a0af60 c0147e68 00000000 00000000 00000001 
Call Trace:
 [<c0149cef>] do_anonymous_page+0xbf/0x1d0
 [<c0149e60>] do_no_page+0x60/0x370
 [<c0383585>] rpc_clnt_sigunmask+0x45/0x70
 [<c0147e68>] pte_alloc_map+0xa8/0xe0
 [<c014a39e>] handle_mm_fault+0x10e/0x1b0
 [<c0115efc>] do_page_fault+0x19c/0x5b9
 [<c013d09d>] mempool_free+0x8d/0xa0
 [<c0388595>] rpc_default_free_task+0x25/0x50
 [<c0388783>] rpc_release_task+0x103/0x180
 [<c0387e5b>] __rpc_execute+0xcb/0x3d0
 [<c0170973>] dput+0x33/0x1d0
 [<c0131a30>] autoremove_wake_function+0x0/0x60
 [<c0115d60>] do_page_fault+0x0/0x5b9
 [<c0103b8f>] error_code+0x2b/0x30
 [<c016c011>] filldir64+0x71/0x100
 [<c01c140f>] nfs_do_filldir+0x8f/0x190
 [<c01c17d4>] nfs_readdir+0x2c4/0x6d0
 [<c016bfa0>] filldir64+0x0/0x100
 [<c0130006>] sys_timer_create+0x86/0x320
 [<c0147e68>] pte_alloc_map+0xa8/0xe0
 [<c014a39e>] handle_mm_fault+0x10e/0x1b0
 [<c0115efc>] do_page_fault+0x19c/0x5b9
 [<c01d0c20>] nfs3_decode_dirent+0x0/0x1d0
 [<c01632e7>] sys_fstat64+0x37/0x40
 [<c016bc99>] vfs_readdir+0x79/0xa0
 [<c016bfa0>] filldir64+0x0/0x100
 [<c016c10e>] sys_getdents64+0x6e/0xaa
 [<c016bfa0>] filldir64+0x0/0x100
 [<c0103073>] syscall_call+0x7/0xb
Code: ff ff 8d 4a 0b c1 e1 0c 29 c8 c1 e2 02 8b 0d d8 8d 4d c0 29 d1 8b 15 90 d6 4e c0 29 d3 8b 15 dc 8d 4d c0 c1 fb 05 c1 e3 0c 09 d3 <89> 19 0f 01 38 5b c3 8d 74 26 00 89 5c 24 08 5b e9 66 08 03 00 


>>EIP; c0116e05 <kmap_atomic+55/70>   <=====

>>esi; c23f0dc0 <pg0+1ed4dc0/3fae2400>
>>ebp; e719fabc <pg0+26c83abc/3fae2400>
>>esp; ccef5bb4 <pg0+c9d9bb4/3fae2400>

Trace; c0149cef <do_anonymous_page+bf/1d0>
Trace; c0149e60 <do_no_page+60/370>
Trace; c0383585 <rpc_clnt_sigunmask+45/70>
Trace; c0147e68 <pte_alloc_map+a8/e0>
Trace; c014a39e <handle_mm_fault+10e/1b0>
Trace; c0115efc <do_page_fault+19c/5b9>
Trace; c013d09d <mempool_free+8d/a0>
Trace; c0388595 <rpc_default_free_task+25/50>
Trace; c0388783 <rpc_release_task+103/180>
Trace; c0387e5b <__rpc_execute+cb/3d0>
Trace; c0170973 <dput+33/1d0>
Trace; c0131a30 <autoremove_wake_function+0/60>
Trace; c0115d60 <do_page_fault+0/5b9>
Trace; c0103b8f <error_code+2b/30>
Trace; c016c011 <filldir64+71/100>
Trace; c01c140f <nfs_do_filldir+8f/190>
Trace; c01c17d4 <nfs_readdir+2c4/6d0>
Trace; c016bfa0 <filldir64+0/100>
Trace; c0130006 <sys_timer_create+86/320>
Trace; c0147e68 <pte_alloc_map+a8/e0>
Trace; c014a39e <handle_mm_fault+10e/1b0>
Trace; c0115efc <do_page_fault+19c/5b9>
Trace; c01d0c20 <nfs3_decode_dirent+0/1d0>
Trace; c01632e7 <sys_fstat64+37/40>
Trace; c016bc99 <vfs_readdir+79/a0>
Trace; c016bfa0 <filldir64+0/100>
Trace; c016c10e <sys_getdents64+6e/aa>
Trace; c016bfa0 <filldir64+0/100>
Trace; c0103073 <syscall_call+7/b>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c0116dda <kmap_atomic+2a/70>
00000000 <_EIP>:
Code;  c0116dda <kmap_atomic+2a/70>
   0:   ff                        (bad)  
Code;  c0116ddb <kmap_atomic+2b/70>
   1:   ff 8d 4a 0b c1 e1         decl   0xe1c10b4a(%ebp)
Code;  c0116de1 <kmap_atomic+31/70>
   7:   0c 29                     or     $0x29,%al
Code;  c0116de3 <kmap_atomic+33/70>
   9:   c8 c1 e2 02               enter  $0xe2c1,$0x2
Code;  c0116de7 <kmap_atomic+37/70>
   d:   8b 0d d8 8d 4d c0         mov    0xc04d8dd8,%ecx
Code;  c0116ded <kmap_atomic+3d/70>
  13:   29 d1                     sub    %edx,%ecx
Code;  c0116def <kmap_atomic+3f/70>
  15:   8b 15 90 d6 4e c0         mov    0xc04ed690,%edx
Code;  c0116df5 <kmap_atomic+45/70>
  1b:   29 d3                     sub    %edx,%ebx
Code;  c0116df7 <kmap_atomic+47/70>
  1d:   8b 15 dc 8d 4d c0         mov    0xc04d8ddc,%edx
Code;  c0116dfd <kmap_atomic+4d/70>
  23:   c1 fb 05                  sar    $0x5,%ebx
Code;  c0116e00 <kmap_atomic+50/70>
  26:   c1 e3 0c                  shl    $0xc,%ebx
Code;  c0116e03 <kmap_atomic+53/70>
  29:   09 d3                     or     %edx,%ebx

This decode from eip onwards should be reliable

Code;  c0116e05 <kmap_atomic+55/70>
00000000 <_EIP>:
Code;  c0116e05 <kmap_atomic+55/70>   <=====
   0:   89 19                     mov    %ebx,(%ecx)   <=====
Code;  c0116e07 <kmap_atomic+57/70>
   2:   0f 01 38                  invlpg (%eax)
Code;  c0116e0a <kmap_atomic+5a/70>
   5:   5b                        pop    %ebx
Code;  c0116e0b <kmap_atomic+5b/70>
   6:   c3                        ret    
Code;  c0116e0c <kmap_atomic+5c/70>
   7:   8d 74 26 00               lea    0x0(%esi),%esi
Code;  c0116e10 <kmap_atomic+60/70>
   b:   89 5c 24 08               mov    %ebx,0x8(%esp)
Code;  c0116e14 <kmap_atomic+64/70>
   f:   5b                        pop    %ebx
Code;  c0116e15 <kmap_atomic+65/70>
  10:   e9 66 08 03 00            jmp    3087b <_EIP+0x3087b>

 [<c0394ea2>] schedule+0xc02/0xc10
 [<c0150d21>] free_pages_and_swap_cache+0x71/0xa0
 [<c01487ff>] unmap_vmas+0x1cf/0x210
 [<c014d14f>] exit_mmap+0x9f/0x190
 [<c011b3f8>] mmput+0x38/0xa0
 [<c011fc65>] do_exit+0x185/0x3d0
 [<c0104338>] die+0x188/0x190
 [<c0116043>] do_page_fault+0x2e3/0x5b9
 [<c0357fad>] inet_sendmsg+0x4d/0x60
 [<c031073a>] sock_sendmsg+0xda/0x100
 [<c013e1a0>] buffered_rmqueue+0x100/0x1f0
 [<c0388595>] rpc_default_free_task+0x25/0x50
 [<c0115d60>] do_page_fault+0x0/0x5b9
 [<c0103b8f>] error_code+0x2b/0x30
 [<c0116e05>] kmap_atomic+0x55/0x70
 [<c0149cef>] do_anonymous_page+0xbf/0x1d0
 [<c0149e60>] do_no_page+0x60/0x370
 [<c0383585>] rpc_clnt_sigunmask+0x45/0x70
 [<c0147e68>] pte_alloc_map+0xa8/0xe0
 [<c014a39e>] handle_mm_fault+0x10e/0x1b0
 [<c0115efc>] do_page_fault+0x19c/0x5b9
 [<c013d09d>] mempool_free+0x8d/0xa0
 [<c0388595>] rpc_default_free_task+0x25/0x50
 [<c0388783>] rpc_release_task+0x103/0x180
 [<c0387e5b>] __rpc_execute+0xcb/0x3d0
 [<c0170973>] dput+0x33/0x1d0
 [<c0131a30>] autoremove_wake_function+0x0/0x60
 [<c0115d60>] do_page_fault+0x0/0x5b9
 [<c0103b8f>] error_code+0x2b/0x30
 [<c016c011>] filldir64+0x71/0x100
 [<c01c140f>] nfs_do_filldir+0x8f/0x190
 [<c01c17d4>] nfs_readdir+0x2c4/0x6d0
 [<c016bfa0>] filldir64+0x0/0x100
 [<c0130006>] sys_timer_create+0x86/0x320
 [<c0147e68>] pte_alloc_map+0xa8/0xe0
 [<c014a39e>] handle_mm_fault+0x10e/0x1b0
 [<c0115efc>] do_page_fault+0x19c/0x5b9
 [<c01d0c20>] nfs3_decode_dirent+0x0/0x1d0
 [<c01632e7>] sys_fstat64+0x37/0x40
 [<c016bc99>] vfs_readdir+0x79/0xa0
 [<c016bfa0>] filldir64+0x0/0x100
 [<c016c10e>] sys_getdents64+0x6e/0xaa
 [<c016bfa0>] filldir64+0x0/0x100
 [<c0103073>] syscall_call+0x7/0xb
 [<c0394ea2>] schedule+0xc02/0xc10
 [<c03863c8>] xprt_transmit+0x2f8/0x4d0
 [<c0385f50>] xprt_timer+0x0/0xb0
 [<c0131900>] prepare_to_wait+0x20/0x70
 [<c0388039>] __rpc_execute+0x2a9/0x3d0
 [<c0131a30>] autoremove_wake_function+0x0/0x60
 [<c038992b>] rpcauth_bindcred+0x6b/0xe0
 [<c0131a30>] autoremove_wake_function+0x0/0x60
 [<c03885f6>] rpc_new_task+0x36/0xc0
 [<c0383620>] rpc_call_sync+0x70/0xb0
 [<c01cde64>] nfs3_rpc_wrapper+0x44/0x90
 [<c01ce07c>] nfs3_proc_getattr+0x5c/0xa0
 [<c01c5c35>] __nfs_revalidate_inode+0xf5/0x380
 [<c01cc130>] nfs_scan_commit+0x40/0x90
 [<c01cdc87>] nfs_commit_inode+0x97/0xa0
 [<c01cdd04>] nfs_sync_inode+0x74/0x90
 [<c01c382c>] nfs_file_flush+0x9c/0xd0
 [<c0158966>] filp_close+0x76/0x90
 [<c011ee84>] put_files_struct+0x64/0xd0
 [<c011fc94>] do_exit+0x1b4/0x3d0
 [<c0104338>] die+0x188/0x190
 [<c0116043>] do_page_fault+0x2e3/0x5b9
 [<c0357fad>] inet_sendmsg+0x4d/0x60
 [<c031073a>] sock_sendmsg+0xda/0x100
 [<c013e1a0>] buffered_rmqueue+0x100/0x1f0
 [<c0388595>] rpc_default_free_task+0x25/0x50
 [<c0115d60>] do_page_fault+0x0/0x5b9
 [<c0103b8f>] error_code+0x2b/0x30
 [<c0116e05>] kmap_atomic+0x55/0x70
 [<c0149cef>] do_anonymous_page+0xbf/0x1d0
 [<c0149e60>] do_no_page+0x60/0x370
 [<c0383585>] rpc_clnt_sigunmask+0x45/0x70
 [<c0147e68>] pte_alloc_map+0xa8/0xe0
 [<c014a39e>] handle_mm_fault+0x10e/0x1b0
 [<c0115efc>] do_page_fault+0x19c/0x5b9
 [<c013d09d>] mempool_free+0x8d/0xa0
 [<c0388595>] rpc_default_free_task+0x25/0x50
 [<c0388783>] rpc_release_task+0x103/0x180
 [<c0387e5b>] __rpc_execute+0xcb/0x3d0
 [<c0170973>] dput+0x33/0x1d0
 [<c0131a30>] autoremove_wake_function+0x0/0x60
 [<c0115d60>] do_page_fault+0x0/0x5b9
 [<c0103b8f>] error_code+0x2b/0x30
 [<c016c011>] filldir64+0x71/0x100
 [<c01c140f>] nfs_do_filldir+0x8f/0x190
 [<c01c17d4>] nfs_readdir+0x2c4/0x6d0
 [<c016bfa0>] filldir64+0x0/0x100
 [<c0130006>] sys_timer_create+0x86/0x320
 [<c0147e68>] pte_alloc_map+0xa8/0xe0
 [<c014a39e>] handle_mm_fault+0x10e/0x1b0
 [<c0115efc>] do_page_fault+0x19c/0x5b9
 [<c01d0c20>] nfs3_decode_dirent+0x0/0x1d0
 [<c01632e7>] sys_fstat64+0x37/0x40
 [<c016bc99>] vfs_readdir+0x79/0xa0
 [<c016bfa0>] filldir64+0x0/0x100
 [<c016c10e>] sys_getdents64+0x6e/0xaa
 [<c016bfa0>] filldir64+0x0/0x100
 [<c0103073>] syscall_call+0x7/0xb
 [<c0394ea2>] schedule+0xc02/0xc10
 [<c03863c8>] xprt_transmit+0x2f8/0x4d0
 [<c0385f50>] xprt_timer+0x0/0xb0
 [<c0131900>] prepare_to_wait+0x20/0x70
 [<c0388039>] __rpc_execute+0x2a9/0x3d0
 [<c0131a30>] autoremove_wake_function+0x0/0x60
 [<c038992b>] rpcauth_bindcred+0x6b/0xe0
 [<c0131a30>] autoremove_wake_function+0x0/0x60
 [<c03885f6>] rpc_new_task+0x36/0xc0
 [<c0383620>] rpc_call_sync+0x70/0xb0
 [<c01cde64>] nfs3_rpc_wrapper+0x44/0x90
 [<c01ce07c>] nfs3_proc_getattr+0x5c/0xa0
 [<c01c5c35>] __nfs_revalidate_inode+0xf5/0x380
 [<c01cdd04>] nfs_sync_inode+0x74/0x90
 [<c01cc130>] nfs_scan_commit+0x40/0x90
 [<c01cdc87>] nfs_commit_inode+0x97/0xa0
 [<c01cdd04>] nfs_sync_inode+0x74/0x90
 [<c01c382c>] nfs_file_flush+0x9c/0xd0
 [<c0158966>] filp_close+0x76/0x90
 [<c011ee84>] put_files_struct+0x64/0xd0
 [<c011fc94>] do_exit+0x1b4/0x3d0
 [<c0104338>] die+0x188/0x190
 [<c0116043>] do_page_fault+0x2e3/0x5b9
 [<c0357fad>] inet_sendmsg+0x4d/0x60
 [<c031073a>] sock_sendmsg+0xda/0x100
 [<c013e1a0>] buffered_rmqueue+0x100/0x1f0
 [<c0388595>] rpc_default_free_task+0x25/0x50
 [<c0115d60>] do_page_fault+0x0/0x5b9
 [<c0103b8f>] error_code+0x2b/0x30
 [<c0116e05>] kmap_atomic+0x55/0x70
 [<c0149cef>] do_anonymous_page+0xbf/0x1d0
 [<c0149e60>] do_no_page+0x60/0x370
 [<c0383585>] rpc_clnt_sigunmask+0x45/0x70
 [<c0147e68>] pte_alloc_map+0xa8/0xe0
 [<c014a39e>] handle_mm_fault+0x10e/0x1b0
 [<c0115efc>] do_page_fault+0x19c/0x5b9
 [<c013d09d>] mempool_free+0x8d/0xa0
 [<c0388595>] rpc_default_free_task+0x25/0x50
 [<c0388783>] rpc_release_task+0x103/0x180
 [<c0387e5b>] __rpc_execute+0xcb/0x3d0
 [<c0170973>] dput+0x33/0x1d0
 [<c0131a30>] autoremove_wake_function+0x0/0x60
 [<c0115d60>] do_page_fault+0x0/0x5b9
 [<c0103b8f>] error_code+0x2b/0x30
 [<c016c011>] filldir64+0x71/0x100
 [<c01c140f>] nfs_do_filldir+0x8f/0x190
 [<c01c17d4>] nfs_readdir+0x2c4/0x6d0
 [<c016bfa0>] filldir64+0x0/0x100
 [<c0130006>] sys_timer_create+0x86/0x320
 [<c0147e68>] pte_alloc_map+0xa8/0xe0
 [<c014a39e>] handle_mm_fault+0x10e/0x1b0
 [<c0115efc>] do_page_fault+0x19c/0x5b9
 [<c01d0c20>] nfs3_decode_dirent+0x0/0x1d0
 [<c01632e7>] sys_fstat64+0x37/0x40
 [<c016bc99>] vfs_readdir+0x79/0xa0
 [<c016bfa0>] filldir64+0x0/0x100
 [<c016c10e>] sys_getdents64+0x6e/0xaa
 [<c016bfa0>] filldir64+0x0/0x100
 [<c0103073>] syscall_call+0x7/0xb
 [<c0394ea2>] schedule+0xc02/0xc10
 [<c03863c8>] xprt_transmit+0x2f8/0x4d0
 [<c0385f50>] xprt_timer+0x0/0xb0
 [<c0131900>] prepare_to_wait+0x20/0x70
 [<c0388039>] __rpc_execute+0x2a9/0x3d0
 [<c0131a30>] autoremove_wake_function+0x0/0x60
 [<c038992b>] rpcauth_bindcred+0x6b/0xe0
 [<c0131a30>] autoremove_wake_function+0x0/0x60
 [<c03885f6>] rpc_new_task+0x36/0xc0
 [<c0383620>] rpc_call_sync+0x70/0xb0
 [<c01cde64>] nfs3_rpc_wrapper+0x44/0x90
 [<c01ce07c>] nfs3_proc_getattr+0x5c/0xa0
 [<c01c5c35>] __nfs_revalidate_inode+0xf5/0x380
 [<c01cc130>] nfs_scan_commit+0x40/0x90
 [<c01cdc87>] nfs_commit_inode+0x97/0xa0
 [<c01cdd04>] nfs_sync_inode+0x74/0x90
 [<c01c382c>] nfs_file_flush+0x9c/0xd0
 [<c0158966>] filp_close+0x76/0x90
 [<c011ee84>] put_files_struct+0x64/0xd0
 [<c011fc94>] do_exit+0x1b4/0x3d0
 [<c0104338>] die+0x188/0x190
 [<c0116043>] do_page_fault+0x2e3/0x5b9
 [<c0357fad>] inet_sendmsg+0x4d/0x60
 [<c031073a>] sock_sendmsg+0xda/0x100
 [<c013e1a0>] buffered_rmqueue+0x100/0x1f0
 [<c0388595>] rpc_default_free_task+0x25/0x50
 [<c0115d60>] do_page_fault+0x0/0x5b9
 [<c0103b8f>] error_code+0x2b/0x30
 [<c0116e05>] kmap_atomic+0x55/0x70
 [<c0149cef>] do_anonymous_page+0xbf/0x1d0
 [<c0149e60>] do_no_page+0x60/0x370
 [<c0383585>] rpc_clnt_sigunmask+0x45/0x70
 [<c0147e68>] pte_alloc_map+0xa8/0xe0
 [<c014a39e>] handle_mm_fault+0x10e/0x1b0
 [<c0115efc>] do_page_fault+0x19c/0x5b9
 [<c013d09d>] mempool_free+0x8d/0xa0
 [<c0388595>] rpc_default_free_task+0x25/0x50
 [<c0388783>] rpc_release_task+0x103/0x180
 [<c0387e5b>] __rpc_execute+0xcb/0x3d0
 [<c0170973>] dput+0x33/0x1d0
 [<c0131a30>] autoremove_wake_function+0x0/0x60
 [<c0115d60>] do_page_fault+0x0/0x5b9
 [<c0103b8f>] error_code+0x2b/0x30
 [<c016c011>] filldir64+0x71/0x100
 [<c01c140f>] nfs_do_filldir+0x8f/0x190
 [<c01c17d4>] nfs_readdir+0x2c4/0x6d0
 [<c016bfa0>] filldir64+0x0/0x100
 [<c0130006>] sys_timer_create+0x86/0x320
 [<c0147e68>] pte_alloc_map+0xa8/0xe0
 [<c014a39e>] handle_mm_fault+0x10e/0x1b0
 [<c0115efc>] do_page_fault+0x19c/0x5b9
 [<c01d0c20>] nfs3_decode_dirent+0x0/0x1d0
 [<c01632e7>] sys_fstat64+0x37/0x40
 [<c016bc99>] vfs_readdir+0x79/0xa0
 [<c016bfa0>] filldir64+0x0/0x100
 [<c016c10e>] sys_getdents64+0x6e/0xaa
 [<c016bfa0>] filldir64+0x0/0x100
 [<c0103073>] syscall_call+0x7/0xb

1 warning issued.  Results may not be reliable.

--
C.
