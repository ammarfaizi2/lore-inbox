Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263626AbUGFLZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbUGFLZa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 07:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263790AbUGFLZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 07:25:30 -0400
Received: from av3-1-sn1.fre.skanova.net ([81.228.11.109]:21180 "EHLO
	av3-1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S263626AbUGFLZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 07:25:27 -0400
Mime-Version: 1.0 (Apple Message framework v618)
Content-Transfer-Encoding: 7bit
Message-Id: <2CAE0EA7-CF3F-11D8-B1D3-00039364C5D8@titv.se>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-1?Q?Jens_B=E4ckman?= <jens.backman@titv.se>
Subject: ReiserFS panic (faulty hardware?)
Date: Tue, 6 Jul 2004 13:25:24 +0200
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, hackers.

So our server decided to stop being useful an hour ago, right when my
vacation had begun. A quick 'dmesg' told me that a ReiserFS panic had
occurred. I fed this thing through ksymoops, but got no wiser from the
result. Maybe you can read something more out of this. Any pointers
(even 'faulty RAM, replace' or a simple 'sod off' in Viro style) are 
welcome.

journal-715: flush_journal_list, length is 9633792, list number 63
  (device md(9,1))
kernel BUG at prints.c:341!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0199168>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000058   ebx: f7d3e800   ecx: f7eea000   edx: f7cbbf7c
esi: 00930000   edi: 000010bc   ebp: 00001198   esp: f7eebe24
ds: 0018   es: 0018   ss: 0018
Process kupdated (pid: 6, stackpage=f7eeb000)
Stack: c028c48e c0324780 c03226c0 f7d3e800 c01a52cb f7d3e800 c0294de0 
00930000
        0000003f 0000000b 00000009 f7d3e800 00000000 f7d3e800 000010bc 
000010bc
        000010bc c01a914a f7d3e800 f893e198 00000001 00000006 f880bc48 
00002000
Call Trace:    [<c01a52cb>] [<c01a914a>] [<c01a814e>] [<c019606e>] 
[<c013c7e2>]
   [<c013bc8c>] [<c013bf55>] [<c0107182>] [<c013be80>] [<c0105000>] 
[<c010570b>]
   [<c013be80>]
Code: 0f 0b 55 01 a1 c4 28 c0 85 db b8 aa c4 28 c0 74 0c 0f b7 43


 >>EIP; c0199168 <reiserfs_panic+48/80>   <=====

 >>ebx; f7d3e800 <_end+379fe0bc/385ba93c>
 >>ecx; f7eea000 <_end+37ba98bc/385ba93c>
 >>edx; f7cbbf7c <_end+3797b838/385ba93c>
 >>esp; f7eebe24 <_end+37bab6e0/385ba93c>

Trace; c01a52cb <flush_journal_list+42b/430>
Trace; c01a914a <do_journal_end+86a/b80>
Trace; c01a814e <flush_old_commits+11e/1b0>
Trace; c019606e <reiserfs_write_super+2e/30>
Trace; c013c7e2 <sync_supers+b2/140>
Trace; c013bc8c <sync_old_buffers+1c/60>
Trace; c013bf55 <kupdate+d5/160>
Trace; c0107182 <ret_from_fork+6/20>
Trace; c013be80 <kupdate+0/160>
Trace; c0105000 <_stext+0/0>
Trace; c010570b <arch_kernel_thread+2b/40>
Trace; c013be80 <kupdate+0/160>

Code;  c0199168 <reiserfs_panic+48/80>
00000000 <_EIP>:
Code;  c0199168 <reiserfs_panic+48/80>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c019916a <reiserfs_panic+4a/80>
    2:   55                        push   %ebp
Code;  c019916b <reiserfs_panic+4b/80>
    3:   01 a1 c4 28 c0 85         add    %esp,0x85c028c4(%ecx)
Code;  c0199171 <reiserfs_panic+51/80>
    9:   db b8 aa c4 28 c0         fstpt  0xc028c4aa(%eax)
Code;  c0199177 <reiserfs_panic+57/80>
    f:   74 0c                     je     1d <_EIP+0x1d>
Code;  c0199179 <reiserfs_panic+59/80>
   11:   0f b7 43 00               movzwl 0x0(%ebx),%eax

