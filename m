Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbVEIRqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbVEIRqs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 13:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVEIRqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 13:46:48 -0400
Received: from www.x-cellent.com ([212.121.145.100]:50408 "EHLO
	mail.x-cellent.com") by vger.kernel.org with ESMTP id S261457AbVEIRpi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 13:45:38 -0400
Subject: [OOPS]  2.6.11.7 in reiserfs ?
From: Stefan Majer <stefan@x-cellent.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: x-cellent technologies GmbH
Date: Mon, 09 May 2005 18:44:58 +0200
Message-Id: <1115657098.2128.6.camel@dom2>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Late nite i had my first oops on my central backups server after years
without any problems. I upgraded recently from 2.6.9 to 2.6.11.7

I dont know what triggers the oops but probably this was due the fact,
that i enlarged the pressure towards filesystem and tape because i have
no 4 times more clients backuped in parallel than before.


This is the OOPS:
Unable to handle kernel paging request at virtual address ffffffff
 printing eip:
c012dbf8
*pde = 00001067
*pte = 00000000
Oops: 0000 [#1]
Modules linked in: aic7xxx
CPU:    0
EIP:    0060:[<c012dbf8>]    Not tainted VLI
EFLAGS: 00010286   (2.6.11.7) 
EIP is at test_clear_page_writeback+0x98/0xd0
eax: 00000004   ebx: cb56928c   ecx: 00000086   edx: ffffffff
esi: ffffffff   edi: c1136040   ebp: 00000282   esp: cf689d30
ds: 007b   es: 007b   ss: 0068
Process pdflush (pid: 7, threadinfo=cf688000 task=cf663a40)
Stack: 00000004 ffffffff 00000282 c1136040 ce8922cc ce8922cc 00000000
c0127b69 
       c1136040 ce8922cc c018567e c1136040 0000000e cf689d6c 00000001
ce126200 
       00000000 00000000 cb5691ec cf689f38 c0127e77 cb569290 cf689e08
00000000 
Call Trace:
 [<c0127b69>] end_page_writeback+0x29/0x50
 [<c018567e>] reiserfs_write_full_page+0x1de/0x420
 [<c0127e77>] find_get_pages_tag+0x37/0x70
 [<c0185906>] reiserfs_writepage+0x26/0x40
 [<c0165292>] mpage_writepages+0x262/0x3d0
 [<c01858e0>] reiserfs_writepage+0x0/0x40
 [<c012d6fd>] do_writepages+0x3d/0x50
 [<c01639d6>] __sync_single_inode+0x56/0x1f0
 [<c0163bd7>] __writeback_single_inode+0x67/0x130
 [<c012dec0>] pdflush+0x0/0x30
 [<c019fcc4>] journal_end_sync+0x54/0xa0
 [<c018d6e3>] reiserfs_sync_fs+0x63/0x70
 [<c0163e3c>] sync_sb_inodes+0x19c/0x280
 [<c012dec0>] pdflush+0x0/0x30
 [<c0163fb6>] writeback_inodes+0x96/0xa0
 [<c012d4cb>] wb_kupdate+0x8b/0x100
 [<c012de0f>] __pdflush+0x8f/0x140
 [<c012dee8>] pdflush+0x28/0x30
 [<c012d440>] wb_kupdate+0x0/0x100
 [<c012dec0>] pdflush+0x0/0x30
 [<c01217e5>] kthread+0xa5/0xb0
 [<c0121740>] kthread+0x0/0xb0
 [<c01006b1>] kernel_thread_helper+0x5/0x14
Code: 0c 8b 7c 24 14 8b 74 24 10 8b 6c 24 18 83 c4 1c c3 8b 47 0c eb cc
c7 44 24 04 ff ff ff ff c7 04 24 04 00 00 00 e8 59 eb ff ff eb <a6> 8d
b4 26 00 00 00 00 0f
 ba 37 0d 19 db 85 db 75 04 89 de eb 
 <7>spurious 8259A interrupt: IRQ15.
Unable to handle kernel paging request at virtual address ffffffff
c012dbf8
*pde = 00001067
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c012dbf8>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286   (2.6.11.7) 
eax: 00000004   ebx: cb56928c   ecx: 00000086   edx: ffffffff
esi: ffffffff   edi: c1136040   ebp: 00000282   esp: cf689d30
ds: 007b   es: 007b   ss: 0068
Stack: 00000004 ffffffff 00000282 c1136040 ce8922cc ce8922cc 00000000
c0127b69 
       c1136040 ce8922cc c018567e c1136040 0000000e cf689d6c 00000001
ce126200 
       00000000 00000000 cb5691ec cf689f38 c0127e77 cb569290 cf689e08
00000000 
Call Trace:
 [<c0127b69>] end_page_writeback+0x29/0x50
 [<c018567e>] reiserfs_write_full_page+0x1de/0x420
 [<c0127e77>] find_get_pages_tag+0x37/0x70
 [<c0185906>] reiserfs_writepage+0x26/0x40
 [<c0165292>] mpage_writepages+0x262/0x3d0
 [<c01858e0>] reiserfs_writepage+0x0/0x40
 [<c012d6fd>] do_writepages+0x3d/0x50
 [<c01639d6>] __sync_single_inode+0x56/0x1f0
 [<c0163bd7>] __writeback_single_inode+0x67/0x130
 [<c012dec0>] pdflush+0x0/0x30
 [<c019fcc4>] journal_end_sync+0x54/0xa0
 [<c018d6e3>] reiserfs_sync_fs+0x63/0x70
 [<c0163e3c>] sync_sb_inodes+0x19c/0x280
 [<c012dec0>] pdflush+0x0/0x30
 [<c0163fb6>] writeback_inodes+0x96/0xa0
 [<c012d4cb>] wb_kupdate+0x8b/0x100
 [<c012de0f>] __pdflush+0x8f/0x140
 [<c012dee8>] pdflush+0x28/0x30
 [<c012d440>] wb_kupdate+0x0/0x100
 [<c012dec0>] pdflush+0x0/0x30
 [<c01217e5>] kthread+0xa5/0xb0
 [<c0121740>] kthread+0x0/0xb0
 [<c01006b1>] kernel_thread_helper+0x5/0x14
Code: 0c 8b 7c 24 14 8b 74 24 10 8b 6c 24 18 83 c4 1c c3 8b 47 0c eb cc
c7 44 24 04 ff ff ff ff c7 04 24 04 00 00 00 e8 59 eb ff ff eb <a6> 8d
b4 26 00 00 00 00 0f


>>EIP; c012dbf8 <__set_page_dirty_nobuffers+88/110>   <=====

>>ebx; cb56928c <pg0+b18b28c/3fc20400>
>>edx; ffffffff <__kernel_rt_sigreturn+1bbf/????>
>>esi; ffffffff <__kernel_rt_sigreturn+1bbf/????>
>>edi; c1136040 <pg0+d58040/3fc20400>
>>esp; cf689d30 <pg0+f2abd30/3fc20400>

Trace; c0127b69 <kallsyms_release+29/40>
Trace; c018567e <reiserfs_prepare_file_region_for_write+42e/910>
Trace; c0127e77 <wait_on_page_writeback_range+d7/150>
Trace; c0185906 <reiserfs_prepare_file_region_for_write+6b6/910>
Trace; c0165292 <sys_io_destroy+2/30>
Trace; c01858e0 <reiserfs_prepare_file_region_for_write+690/910>
Trace; c012d6fd <background_writeout+5d/b0>
Trace; c01639d6 <__blockdev_direct_IO+96/2ab>
Trace; c0163bd7 <__blockdev_direct_IO+297/2ab>
Trace; c012dec0 <test_clear_page_writeback+10/b0>
Trace; c019fcc4 <direntry_create_vi+154/190>
Trace; c018d6e3 <prepare_error_buf+183/190>
Trace; c0163e3c <aio_setup_ring+dc/220>
Trace; c012dec0 <test_clear_page_writeback+10/b0>
Trace; c0163fb6 <ioctx_alloc+36/160>
Trace; c012d4cb <get_dirty_limits+7b/d0>
Trace; c012de0f <clear_page_dirty_for_io+3f/60>
Trace; c012dee8 <test_clear_page_writeback+38/b0>
Trace; c012d440 <get_writeback_state+40/50>
Trace; c012dec0 <test_clear_page_writeback+10/b0>
Trace; c01217e5 <param_array+55/e0>
Trace; c0121740 <param_get_invbool+0/50>
Trace; c01006b1 <huft_build+271/4c0>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c012dbcd <__set_page_dirty_nobuffers+5d/110>
00000000 <_EIP>:
Code;  c012dbcd <__set_page_dirty_nobuffers+5d/110>
   0:   0c 8b                     or     $0x8b,%al
Code;  c012dbcf <__set_page_dirty_nobuffers+5f/110>
   2:   7c 24                     jl     28 <_EIP+0x28>
Code;  c012dbd1 <__set_page_dirty_nobuffers+61/110>
   4:   14 8b                     adc    $0x8b,%al
Code;  c012dbd3 <__set_page_dirty_nobuffers+63/110>
   6:   74 24                     je     2c <_EIP+0x2c>
Code;  c012dbd5 <__set_page_dirty_nobuffers+65/110>
   8:   10 8b 6c 24 18 83         adc    %cl,0x8318246c(%ebx)
Code;  c012dbdb <__set_page_dirty_nobuffers+6b/110>
   e:   c4 1c c3                  les    (%ebx,%eax,8),%ebx
Code;  c012dbde <__set_page_dirty_nobuffers+6e/110>
  11:   8b 47 0c                  mov    0xc(%edi),%eax
Code;  c012dbe1 <__set_page_dirty_nobuffers+71/110>
  14:   eb cc                     jmp    ffffffe2 <_EIP+0xffffffe2>
Code;  c012dbe3 <__set_page_dirty_nobuffers+73/110>
  16:   c7 44 24 04 ff ff ff      movl   $0xffffffff,0x4(%esp)
Code;  c012dbea <__set_page_dirty_nobuffers+7a/110>
  1d:   ff 
Code;  c012dbeb <__set_page_dirty_nobuffers+7b/110>
  1e:   c7 04 24 04 00 00 00      movl   $0x4,(%esp)
Code;  c012dbf2 <__set_page_dirty_nobuffers+82/110>
  25:   e8 59 eb ff ff            call   ffffeb83 <_EIP+0xffffeb83>
Code;  c012dbf7 <__set_page_dirty_nobuffers+87/110>
  2a:   eb                        .byte 0xeb

This decode from eip onwards should be reliable

Code;  c012dbf8 <__set_page_dirty_nobuffers+88/110>
00000000 <_EIP>:
Code;  c012dbf8 <__set_page_dirty_nobuffers+88/110>   <=====
   0:   a6                        cmpsb  %es:(%edi),%ds:(%esi)   <=====
Code;  c012dbf9 <__set_page_dirty_nobuffers+89/110>
   1:   8d b4 26 00 00 00 00      lea    0x0(%esi),%esi
Code;  c012dc00 <__set_page_dirty_nobuffers+90/110>
   8:   0f 00 00                  sldtl  (%eax)

Linux castor 2.6.11.7 #1 Sun May 1 12:33:32 CEST 2005 i686 AMD Duron(tm)
AuthenticAMD GNU/Linux
 
Gnu C                  3.3.4
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12i
mount                  2.12i
module-init-tools      3.0
e2fsprogs              1.35
reiserfsprogs          3.6.19
reiser4progs           line
nfs-utils              1.0.6
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Procps                 3.2.4
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
scripts/ver_linux: line 90: udevinfo: command not found
Modules Loaded         aic7xxx

Im willing to test fixes on demand. Downtime of this machine is no
problem.

-- 
Stefan Majer <stefan@x-cellent.com>
x-cellent technologies GmbH

