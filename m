Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261911AbTCVDOM>; Fri, 21 Mar 2003 22:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261929AbTCVDOM>; Fri, 21 Mar 2003 22:14:12 -0500
Received: from dsl-213-023-065-213.arcor-ip.net ([213.23.65.213]:6018 "EHLO
	neon.pearbough.net") by vger.kernel.org with ESMTP
	id <S261911AbTCVDOL>; Fri, 21 Mar 2003 22:14:11 -0500
Date: Sat, 22 Mar 2003 04:25:09 +0100
From: Axel Siebenwirth <axel@pearbough.net>
To: linux-kernel@vger.kernel.org
Subject: [2.5.65] Oops in process pdflush / do_journal_end (reiserfs)
Message-ID: <20030322032509.GA1109@neon.pearbough.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: pearbough.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

today I encountered the following oops in kernel 2.5.65. Looks like reiserfs
is involved in some way.

ksymoops 2.4.9 on i586 2.5.65.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.65/ (default)
     -m /boot/System.map-2.5.65 (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address 80c3eed0
c019f4f0
Oops: 0000
CPU:    0
EIP:    0060:[<c019f4f0>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010212
eax: 00000010   ebx: c10d7240   ecx: 00000004   edx: c3f21431
esi: 80c3eed0   edi: c3824000   ebp: c482e640   esp: c1b37e48
ds: 007b   es: 007b   ss: 0068
Stack: 00000282 3e7b41f8 00000004 00000002 00000000 0000000d 0000000d
00000001
       0000080b c2f72cd0 c2f727f0 c3c1e000 c35bf000 c482ed90 c1b37eb0
c3f21431
       c3f11600 3e7b41f9 c019e9b5 c1b37eb0 c3f11600 00000001 00000006
c1b37eb0
Call Trace: [<c019e9b5>]  [<c018e18a>]  [<c01417e1>]  [<c012ae8f>]
[<c0111e36>]  [<c012b472>]  [<c012b540>]  [<c012b54b>]  [<c012ae40>]
[<c0106f64>]  [<c0106f69>]
Code: f3 a5 a8 02 74 02 66 a5 a8 01 74 01 a4 8b 44 24 14 40 89 44


>>EIP; c019f4f0 <do_journal_end+490/be0>   <=====

Trace; c019e9b5 <flush_old_commits+105/180>
Trace; c018e18a <reiserfs_write_super+1a/20>
Trace; c01417e1 <sync_supers+71/80>
Trace; c012ae8f <wb_kupdate+4f/140>
Trace; c0111e36 <schedule+196/330>
Trace; c012b472 <__pdflush+b2/180>
Trace; c012b540 <pdflush+0/10>
Trace; c012b54b <pdflush+b/10>
Trace; c012ae40 <wb_kupdate+0/140>
Trace; c0106f64 <kernel_thread_helper+0/c>
Trace; c0106f69 <kernel_thread_helper+5/c>

Code;  c019f4f0 <do_journal_end+490/be0>
00000000 <_EIP>:
Code;  c019f4f0 <do_journal_end+490/be0>   <=====
   0:   f3 a5                     repz movsl %ds:(%esi),%es:(%edi)   <=====
Code;  c019f4f2 <do_journal_end+492/be0>
   2:   a8 02                     test   $0x2,%al
Code;  c019f4f4 <do_journal_end+494/be0>
   4:   74 02                     je     8 <_EIP+0x8> c019f4f8
<do_journal_end+498/be0>
Code;  c019f4f6 <do_journal_end+496/be0>
   6:   66 a5                     movsw  %ds:(%esi),%es:(%edi)
Code;  c019f4f8 <do_journal_end+498/be0>
   8:   a8 01                     test   $0x1,%al
Code;  c019f4fa <do_journal_end+49a/be0>
   a:   74 01                     je     d <_EIP+0xd> c019f4fd
<do_journal_end+49d/be0>
Code;  c019f4fc <do_journal_end+49c/be0>
   c:   a4                        movsb  %ds:(%esi),%es:(%edi)
Code;  c019f4fd <do_journal_end+49d/be0>
   d:   8b 44 24 14               mov    0x14(%esp,1),%eax
Code;  c019f501 <do_journal_end+4a1/be0>
  11:   40                        inc    %eax
Code;  c019f502 <do_journal_end+4a2/be0>
  12:   89 44 00 00               mov    %eax,0x0(%eax,%eax,1)


1 error issued.  Results may not be reliable.


Best regards,
Axel Siebenwirth
