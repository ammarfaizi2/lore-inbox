Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbUC0B3R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 20:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbUC0B3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 20:29:17 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:38784
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S261567AbUC0B3N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 20:29:13 -0500
Date: Fri, 26 Mar 2004 20:40:12 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: reiserfs oops
Message-ID: <20040326204012.A1682@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel vanilla 2.6.4 with cdrw packet writing patch.

OOPS:
ksymoops 2.4.9 on i686 2.6.4-packet.  Options used
     -v /usr/src/linux/vegeta/2.6.4-packet/vmlinux (specified)
     -k /proc/kallsyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.6.4-packet/ (default)
     -m /boot/System.map-2.6.4-packet (default)

Warning (read_ksyms): no kernel symbols in ksyms, is /proc/kallsyms a valid ksyms file?
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
kernel BUG at fs/reiserfs/prints.c:339!
invalid operand: 0000 [#1]
CPU:    1
EIP:    0060:[<f890cffd>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000024   ebx: f73f7e00   ecx: c02eecf4   edx: 000397ee
esi: fb2e4558   edi: 00000000   ebp: f73f7e00   esp: dc5fddbc
ds: 007b   es: 007b   ss: 0068
Stack: f8925bd4 f892c420 fb2e4558 f73f7e00 f89182e3 f73f7e00 f8922f80 00001000 
       fb2e40b8 00000003 00000006 00000004 00000000 e6f30660 0000000f f7c5f400 
       da554000 00000000 f891c665 f73f7e00 fb2e4558 00000001 00000006 00000000 
Call Trace:
 [<f89182e3>] flush_commit_list+0x2db/0x461 [reiserfs]
 [<f891c665>] do_journal_end+0x5d7/0xbdf [reiserfs]
 [<f891b9b3>] flush_old_commits+0x12f/0x1bf [reiserfs]
 [<c0176e7d>] sync_sb_inodes+0x1c5/0x252
 [<c01406a1>] pdflush+0x0/0x13
 [<f8909f4f>] reiserfs_write_super+0x7d/0x7f [reiserfs]
 [<c015e460>] sync_supers+0x99/0x9b
 [<c013ff5e>] wb_kupdate+0x36/0x114
 [<c011bf7e>] recalc_task_prio+0x90/0x1aa
 [<c011d793>] schedule+0x35a/0x625
 [<c01405bd>] __pdflush+0xc5/0x1a9
 [<c01406b0>] pdflush+0xf/0x13
 [<c013ff28>] wb_kupdate+0x0/0x114
 [<c01406a1>] pdflush+0x0/0x13
 [<c0133bcc>] kthread+0xb2/0xb8
 [<c0133b1a>] kthread+0x0/0xb8
 [<c0107269>] kernel_thread_helper+0x5/0xb
Code: 0f 0b 53 01 da 5b 92 f8 b8 ef 5b 92 f8 8d 93 24 01 00 00 85 


>>EIP; f890cffd <_end+38543fad/3fc34fb0>   <=====

>>ebx; f73f7e00 <_end+3702edb0/3fc34fb0>
>>ecx; c02eecf4 <console_sem+0/14>
>>esi; fb2e4558 <_end+3af1b508/3fc34fb0>
>>ebp; f73f7e00 <_end+3702edb0/3fc34fb0>
>>esp; dc5fddbc <_end+1c234d6c/3fc34fb0>

Trace; f89182e3 <_end+3854f293/3fc34fb0>
Trace; f891c665 <_end+38553615/3fc34fb0>
Trace; f891b9b3 <_end+38552963/3fc34fb0>
Trace; c0176e7d <sync_sb_inodes+1c5/252>
Trace; c01406a1 <pdflush+0/13>
Trace; f8909f4f <_end+38540eff/3fc34fb0>
Trace; c015e460 <sync_supers+99/9b>
Trace; c013ff5e <wb_kupdate+36/114>
Trace; c011bf7e <recalc_task_prio+90/1aa>
Trace; c011d793 <schedule+35a/625>
Trace; c01405bd <__pdflush+c5/1a9>
Trace; c01406b0 <pdflush+f/13>
Trace; c013ff28 <wb_kupdate+0/114>
Trace; c01406a1 <pdflush+0/13>
Trace; c0133bcc <kthread+b2/b8>
Trace; c0133b1a <kthread+0/b8>
Trace; c0107269 <kernel_thread_helper+5/b>

Code;  f890cffd <_end+38543fad/3fc34fb0>
00000000 <_EIP>:
Code;  f890cffd <_end+38543fad/3fc34fb0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  f890cfff <_end+38543faf/3fc34fb0>
   2:   53                        push   %ebx
Code;  f890d000 <_end+38543fb0/3fc34fb0>
   3:   01 da                     add    %ebx,%edx
Code;  f890d002 <_end+38543fb2/3fc34fb0>
   5:   5b                        pop    %ebx
Code;  f890d003 <_end+38543fb3/3fc34fb0>
   6:   92                        xchg   %eax,%edx
Code;  f890d004 <_end+38543fb4/3fc34fb0>
   7:   f8                        clc    
Code;  f890d005 <_end+38543fb5/3fc34fb0>
   8:   b8 ef 5b 92 f8            mov    $0xf8925bef,%eax
Code;  f890d00a <_end+38543fba/3fc34fb0>
   d:   8d 93 24 01 00 00         lea    0x124(%ebx),%edx
Code;  f890d010 <_end+38543fc0/3fc34fb0>
  13:   85 00                     test   %eax,(%eax)


1 warning issued.  Results may not be reliable.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
