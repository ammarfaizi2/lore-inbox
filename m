Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbTFJKfl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 06:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbTFJKfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 06:35:41 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:33286 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id S261741AbTFJKfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 06:35:39 -0400
Date: Tue, 10 Jun 2003 12:49:14 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: reiserfs / 2.5.70-bk13 oops
Message-ID: <20030610104914.GA955@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is on a single-cpu Athlon XP system with CONFIG_PREEMPT on
and running 2.5.70-bk13:

ksymoops 2.4.8 on i686 2.5.70.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.70-bk13/ (specified)
     -m ./System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Jun 10 11:54:31 middle kernel: c0203d9d
Jun 10 11:54:31 middle kernel: Oops: 0000 [#1]
Jun 10 11:54:31 middle kernel: CPU:    0
Jun 10 11:54:31 middle kernel: EIP:    0060:[<c0203d9d>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jun 10 11:54:31 middle kernel: EFLAGS: 00010212
Jun 10 11:54:31 middle kernel: eax: fafc9000   ebx: 000007b1   ecx: f5c8de00   edx: 00005173
Jun 10 11:54:31 middle kernel: esi: 00005173   edi: fafb20c0   ebp: e6869b90   esp: e6869b80
Jun 10 11:54:31 middle kernel: ds: 007b   es: 007b   ss: 0068
Jun 10 11:54:31 middle kernel: Stack: 00001000 e6869f20 00000000 f5c8de00 e6869bb4 c020832f f5c8de00 03d8d173
Jun 10 11:54:31 middle kernel:        fafb20c0 e6869bac e6869f20 03d8d173 dd281ffc e6869bd0 c01e3c85 e6869f20
Jun 10 11:54:31 middle kernel:        f5c8de00 03d8d173 03d8d173 00000000 e6869c44 c0200744 e6869f20 03d8d173
Jun 10 11:54:31 middle kernel: Call Trace:
Jun 10 11:54:31 middle kernel:  [<c020832f>] journal_mark_freed+0xdf/0x240
Jun 10 11:54:31 middle kernel:  [<c01e3c85>] reiserfs_free_block+0x25/0x40
Jun 10 11:54:31 middle kernel:  [<c0200744>] prepare_for_delete_or_cut+0x514/0x6e0
Jun 10 11:54:31 middle kernel:  [<c020154d>] reiserfs_cut_from_item+0xad/0x4c0
Jun 10 11:54:31 middle kernel:  [<c01195f7>] schedule+0x197/0x390
Jun 10 11:54:31 middle kernel:  [<c0201c15>] reiserfs_do_truncate+0x255/0x4f0
Jun 10 11:54:31 middle kernel:  [<c02010ac>] reiserfs_delete_object+0x3c/0x70
Jun 10 11:54:31 middle kernel:  [<c01eae50>] reiserfs_delete_inode+0xd0/0x120
Jun 10 11:54:31 middle kernel:  [<c01ead80>] reiserfs_delete_inode+0x0/0x120
Jun 10 11:54:31 middle kernel:  [<c01656dc>] generic_delete_inode+0x6c/0x110
Jun 10 11:54:31 middle kernel:  [<c0165953>] iput+0x63/0x80
Jun 10 11:54:31 middle kernel:  [<c015c0f2>] sys_unlink+0xf2/0x120
Jun 10 11:54:31 middle kernel:  [<c01091ef>] syscall_call+0x7/0xb
Jun 10 11:54:31 middle kernel: Code: 8b 14 98 85 d2 74 1c 8b 04 98 8b 40 04 0f ab 30 8b 7d fc 8b


>>EIP; c0203d9d <set_bit_in_list_bitmap+2d/70>   <=====

>>eax; fafc9000 <_end+3aa88598/3fabd598>
>>ecx; f5c8de00 <_end+3574d398/3fabd598>
>>edi; fafb20c0 <_end+3aa71658/3fabd598>
>>ebp; e6869b90 <_end+26329128/3fabd598>
>>esp; e6869b80 <_end+26329118/3fabd598>

Trace; c020832f <journal_mark_freed+df/240>
Trace; c01e3c85 <reiserfs_free_block+25/40>
Trace; c0200744 <prepare_for_delete_or_cut+514/6e0>
Trace; c020154d <reiserfs_cut_from_item+ad/4c0>
Trace; c01195f7 <schedule+197/390>
Trace; c0201c15 <reiserfs_do_truncate+255/4f0>
Trace; c02010ac <reiserfs_delete_object+3c/70>
Trace; c01eae50 <reiserfs_delete_inode+d0/120>
Trace; c01ead80 <reiserfs_delete_inode+0/120>
Trace; c01656dc <generic_delete_inode+6c/110>
Trace; c0165953 <iput+63/80>
Trace; c015c0f2 <sys_unlink+f2/120>
Trace; c01091ef <syscall_call+7/b>

Code;  c0203d9d <set_bit_in_list_bitmap+2d/70>
00000000 <_EIP>:
Code;  c0203d9d <set_bit_in_list_bitmap+2d/70>   <=====
   0:   8b 14 98                  mov    (%eax,%ebx,4),%edx   <=====
Code;  c0203da0 <set_bit_in_list_bitmap+30/70>
   3:   85 d2                     test   %edx,%edx
Code;  c0203da2 <set_bit_in_list_bitmap+32/70>
   5:   74 1c                     je     23 <_EIP+0x23>
Code;  c0203da4 <set_bit_in_list_bitmap+34/70>
   7:   8b 04 98                  mov    (%eax,%ebx,4),%eax
Code;  c0203da7 <set_bit_in_list_bitmap+37/70>
   a:   8b 40 04                  mov    0x4(%eax),%eax
Code;  c0203daa <set_bit_in_list_bitmap+3a/70>
   d:   0f ab 30                  bts    %esi,(%eax)
Code;  c0203dad <set_bit_in_list_bitmap+3d/70>
  10:   8b 7d fc                  mov    0xfffffffc(%ebp),%edi
Code;  c0203db0 <set_bit_in_list_bitmap+40/70>
  13:   8b 00                     mov    (%eax),%eax

Jurriaan
-- 
Windows NT indeed has very low Total Cost of Ownership. Trouble is,
Microsoft _owns_ Windows NT. You just licensed it.
	Jens Benecke
Debian (Unstable) GNU/Linux 2.5.70-bk13 4112 bogomips load av: 0.00 0.16 0.28
