Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289566AbSBKOFf>; Mon, 11 Feb 2002 09:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289386AbSBKOF1>; Mon, 11 Feb 2002 09:05:27 -0500
Received: from eomer.vianetworks.nl ([212.61.15.10]:26643 "HELO
	eomer.vianetworks.nl") by vger.kernel.org with SMTP
	id <S289551AbSBKOFR>; Mon, 11 Feb 2002 09:05:17 -0500
Date: Mon, 11 Feb 2002 15:05:15 +0100 (CET)
From: Ime Smits <ime@iaehv.iae.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.16 ext3 kjournald oops __remove_from_lru_list+25/96
Message-ID: <Pine.BSF.4.05.10202111451590.18799-100000@iaehv.iae.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I get an occasional oops in kjournald on my Toshiba laptop,
which cannot be reproduced but is destined to happen approx. once
a day (see below).

I already ruled out memory problems with a software DIMM
tester, ext2 on the same box is rock solid and fsck on the
partition always says its clean.

Any ideas, apart from trying 2.4.18-pre9 which I'll try later
today? I couldn't find anything relating in the CHANGELOG.

Cheers,

Ime

_                              \ | /
^                               0 0
............................oOO-(_)-OOo............................
ime@iae.nl - +31 654 310031 - icq 4690997 - http://iae.nl/users/ime



--

Feb 11 14:25:48 roambird kernel: Unable to handle kernel paging
request at virtual address 00c328e4
Feb 11 14:25:48 roambird kernel:  printing eip:
Feb 11 14:25:48 roambird kernel: c0132219
Feb 11 14:25:48 roambird kernel: *pde = 00000000
Feb 11 14:25:48 roambird kernel: Oops: 0002
Feb 11 14:25:48 roambird kernel: CPU:    0
Feb 11 14:25:48 roambird kernel: EIP:
0010:[__remove_from_lru_list+25/96]    Not tainted
Feb 11 14:25:48 roambird kernel: EIP:    0010:[<c0132219>]
Not tainted
Feb 11 14:25:48 roambird kernel: EFLAGS: 00010202
Feb 11 14:25:48 roambird kernel: eax: c4b3c200   ebx: c4c32860
ecx: 00c328c0   edx: 00000004
Feb 11 14:25:48 roambird kernel: esi: c4c32860   edi: d1f60640
ebp: c6e024c0   esp: d21c9e48
Feb 11 14:25:48 roambird kernel: ds: 0018   es: 0018   ss: 0018
Feb 11 14:25:48 roambird kernel: Process kjournald (pid: 139, 
stackpage=d21c9000)
Feb 11 14:25:48 roambird kernel: Stack: 00000000 c0132bb5
c4c32860 0000000e c4c32860 d1f60af0 c1506750 c4c32860 
Feb 11 14:25:48 roambird kernel:        d1f60af0 c0132bea
c4c32860 c015edd9 c4c32860 d1f60af0 d1f60af0 00000000 
Feb 11 14:25:48 roambird kernel:        00000000 00000000
00000000 d04f5ee0 c4f27680 cc21a8b0 37363534 42413938 
Feb 11 14:25:48 roambird kernel: Call Trace:
[__refile_buffer+53/96] [refile_buffer+10/16]
[journal_commit_transaction+905/4864] [kjournald+387/704]
[commit_timeout+0/16] 
Feb 11 14:25:48 roambird kernel: Call Trace: [<c0132bb5>]
[<c0132bea>] [<c015edd9>] [<c0161e03>] [<c0161c60>] 
Feb 11 14:25:48 roambird kernel:    [kernel_thread+38/48]
[kjournald+0/704] 
Feb 11 14:25:48 roambird kernel:    [<c0105516>] [<c0161c80>] 
Feb 11 14:25:48 roambird kernel: 
Feb 11 14:25:48 roambird kernel: Code: 89 41 24 39 9a 8c 6f 46
c0 75 0d 31 c0 39 d9 0f 44 c8 89 8a 

>>EIP; c0132219 <__remove_from_lru_list+19/60>   <=====
Trace; c0132bb5 <__refile_buffer+35/60>
Trace; c0132bea <refile_buffer+a/10>
Trace; c015edd9 <journal_commit_transaction+389/1300>
Trace; c0161e03 <kjournald+183/2c0>
Trace; c0161c60 <commit_timeout+0/10>
Trace; c0105516 <kernel_thread+26/30>
Trace; c0161c80 <kjournald+0/2c0>
Code;  c0132219 <__remove_from_lru_list+19/60>
00000000 <_EIP>:
Code;  c0132219 <__remove_from_lru_list+19/60>   <=====
   0:   89 41 24                  mov    %eax,0x24(%ecx) <=====
Code;  c013221c <__remove_from_lru_list+1c/60>
   3:   39 9a 8c 6f 46 c0         cmp    %ebx,0xc0466f8c(%edx)
Code;  c0132222 <__remove_from_lru_list+22/60>
   9:   75 0d                     jne    18 <_EIP+0x18> c0132231 <__remove_from_lru_list+31/60>
Code;  c0132224 <__remove_from_lru_list+24/60>
   b:   31 c0                     xor    %eax,%eax
Code;  c0132226 <__remove_from_lru_list+26/60>
   d:   39 d9                     cmp    %ebx,%ecx
Code;  c0132228 <__remove_from_lru_list+28/60>
   f:   0f 44 c8                  cmove  %eax,%ecx
Code;  c013222b <__remove_from_lru_list+2b/60>
  12:   89 8a 00 00 00 00         mov    %ecx,0x0(%edx)


