Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbTGKNx3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 09:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbTGKNx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 09:53:29 -0400
Received: from f12.mail.ru ([194.67.57.42]:43016 "EHLO f12.mail.ru")
	by vger.kernel.org with ESMTP id S262273AbTGKNx0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 09:53:26 -0400
From: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?= <ia6432@inbox.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.4.22-pre3 and reiserfs problem (not boot)
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: unknown via proxy [81.89.69.194]
Date: Fri, 11 Jul 2003 18:08:08 +0400
Reply-To: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?= 
	  <ia6432@inbox.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E19ayZE-000Ipt-00.ia6432-inbox-ru@f12.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am not on the list so please CC me if replying...

After few hours of work with 2.4.22-pre3 (patched to solve mount problem) we got this (ksyms was unavailable):

Jul 10 06:25:41 host kernel: kernel BUG at prints.c:334!
Jul 10 06:25:41 host kernel: invalid operand: 0000
Jul 10 06:25:41 host kernel: CPU:    1
Jul 10 06:25:41 host kernel: EIP:    0010:[reiserfs_panic+41/96]    Not tainted
Jul 10 06:25:41 host kernel: EFLAGS: 00010286
Jul 10 06:25:41 host kernel: eax: 00000024   ebx: c02da700   ecx: 00000097   edx: 01000000
Jul 10 06:25:41 host kernel: esi: f7e57000   edi: 00000000   ebp: f7e57000   esp: f7ed7ecc
Jul 10 06:25:41 host kernel: ds: 0018   es: 0018   ss: 0018
Jul 10 06:25:41 host kernel: Process kupdated (pid: 7, stackpage=f7ed7000)
Jul 10 06:25:41 host kernel: Stack: c02d89fa c03bf920 c02da700 f7ed7ef0 f8b10110 00000073 c01bb1df f7e57000
Jul 10 06:25:41 host kernel:        c02da700 00000001 00000012 00000010 00000000 f8b10144 f8b10138 00000074
Jul 10 06:25:41 host kernel:        00000000 00000002 eea13500 c01beacb f7e57000 f8b10110 00000001 f7ed7f8c
Jul 10 06:25:41 host kernel: Call Trace:    [flush_commit_list+675/920] [do_journal_end+1955/2668] [flush_old_commits+286/308] [reiserfs_write_super+56/104] [sync_supers+250/340]
Jul 10 06:25:41 host kernel: Code: 0f 0b 4e 01 00 8a 2d c0 68 20 f9 3b c0 85 f6 74 16 0f b7 46
Using defaults from ksymoops -t elf32-i386 -a i386


>>ebx; c02da700 <tails+ea4/1ff4>
>>edx; 01000000 Before first symbol
>>esi; f7e57000 <END_OF_CODE+37a5e204/????>
>>ebp; f7e57000 <END_OF_CODE+37a5e204/????>
>>esp; f7ed7ecc <END_OF_CODE+37adf0d0/????>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a
Code;  00000002 Before first symbol
   2:   4e                        dec    %esi
Code;  00000003 Before first symbol
   3:   01 00                     add    %eax,(%eax)
Code;  00000005 Before first symbol
   5:   8a 2d c0 68 20 f9         mov    0xf92068c0,%ch
Code;  0000000b Before first symbol
   b:   3b c0                     cmp    %eax,%eax
Code;  0000000d Before first symbol
   d:   85 f6                     test   %esi,%esi
Code;  0000000f Before first symbol
   f:   74 16                     je     27 <_EIP+0x27> 00000027 Before first symbol
Code;  00000011 Before first symbol
  11:   0f b7 46 00               movzwl 0x0(%esi),%eax

Jul 11 06:25:41 host kernel: kernel BUG at prints.c:341!
Jul 11 06:25:41 host kernel: invalid operand: 0000
Jul 11 06:25:41 host kernel: CPU:    0
Jul 11 06:25:41 host kernel: EIP:    0010:[reiserfs_panic+52/104]    Not tainted
Jul 11 06:25:41 host kernel: EFLAGS: 00010286
Jul 11 06:25:41 host kernel: eax: 00000037   ebx: c02dc6a0   ecx: 00000002   edx: 02000000
Jul 11 06:25:41 host kernel: esi: f7e57000   edi: 00000000   ebp: f7e57000   esp: f7ed7eb8
Jul 11 06:25:41 host kernel: ds: 0018   es: 0018   ss: 0018
Jul 11 06:25:41 host kernel: Process kupdated (pid: 7, stackpage=f7ed7000)
Jul 11 06:25:41 host kernel: Stack: c02da97f c03c5c20 c03c1b80 00000841 c02dc6a0 f7ed7ee4 f8b1017c f7a10000
Jul 11 06:25:41 host kernel:        c01bc1fe f7e57000 c02dc6a0 00000002 00000012 00000010 00000000 f8b100b4
Jul 11 06:25:41 host kernel:        f8b101b0 f8b101a4 00000077 00000000 00000003 eefcf7a0 c01c01ad f7e57000 
Jul 11 06:25:41 host kernel: Call Trace:    [flush_commit_list+658/904] [do_journal_end+1989/2764] [journal_mark_dirty+490/792] [flush_old_commits+295/320] [reiserfs_write_super+56/108]
Jul 11 06:25:41 host kernel: Code: 0f 0b 55 01 92 a9 2d c0 68 20 5c 3c c0 85 f6 74 13 0f b7 46


>>ebx; c02dc6a0 <MAX_KEY+e40/3fb8>
>>edx; 02000000 Before first symbol
>>esi; f7e57000 <END_OF_CODE+37a5e204/????>
>>ebp; f7e57000 <END_OF_CODE+37a5e204/????>
>>esp; f7ed7eb8 <END_OF_CODE+37adf0bc/????>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a
Code;  00000002 Before first symbol
   2:   55                        push   %ebp
Code;  00000003 Before first symbol
   3:   01 92 a9 2d c0 68         add    %edx,0x68c02da9(%edx)
Code;  00000009 Before first symbol
   9:   20 5c 3c c0               and    %bl,0xffffffc0(%esp,%edi,1)
Code;  0000000d Before first symbol
   d:   85 f6                     test   %esi,%esi
Code;  0000000f Before first symbol
   f:   74 13                     je     24 <_EIP+0x24> 00000024 Before first symbol
Code;  00000011 Before first symbol
  11:   0f b7 46 00               movzwl 0x0(%esi),%eax

1 warning and 1 error issued.  Results may not be reliable.


