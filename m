Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284615AbRLPOE6>; Sun, 16 Dec 2001 09:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284613AbRLPOEs>; Sun, 16 Dec 2001 09:04:48 -0500
Received: from mx04.nexgo.de ([151.189.8.80]:27912 "EHLO mx04.nexgo.de")
	by vger.kernel.org with ESMTP id <S284608AbRLPOEd>;
	Sun, 16 Dec 2001 09:04:33 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Jan Tim Schueszler <Jan.Tim.Schueszler@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: [Kernel 2.4.17-pre8] two kernel-oops
Date: Sun, 16 Dec 2001 12:45:14 +0000
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01121612451400.00682@erde>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today, i noticed two kernel-oops on my 2.4.17-pre8-kernel, while 
building an X-Server from CVS-Sources.

Dec 16 11:41:15 erde kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000044
Dec 16 11:41:15 erde kernel: c0131218
Dec 16 11:41:15 erde kernel: *pde = 00000000
Dec 16 11:41:15 erde kernel: Oops: 0000
Dec 16 11:41:15 erde kernel: CPU:    0
Dec 16 11:41:15 erde kernel: EIP:    0010:[get_hash_table+104/144]  
  Not tainted
Dec 16 11:41:15 erde kernel: EFLAGS: 00010202
Dec 16 11:41:15 erde kernel: eax: 00001020   ebx: 00000002   ecx: 
00000040   edx: 00000040
Dec 16 11:41:15 erde kernel: esi: 00000008   edi: 0000080b   ebp: 
0000142d   esp: c66a9e8c
Dec 16 11:41:15 erde kernel: ds: 0018   es: 0018   ss: 0018
Dec 16 11:41:15 erde kernel: Process cpp (pid: 5263, 
stackpage=c66a9000)
Dec 16 11:41:15 erde kernel: Stack: 00000000 c66a9ee4 c0a21040 
00000000 000037d4 c0131eb8 0000080b 0000142d
Dec 16 11:41:15 erde kernel:        00001000 00000000 c01320cb 
c9a155c0 00000000 c1377340 c0a21040 ce9a3600
Dec 16 11:41:15 erde kernel:        cddcd000 c9a155c0 00001000 
0000001d 00001000 c9a155c0 00000000 ce9a3614
Dec 16 11:41:15 erde kernel: Call Trace: 
[unmap_underlying_metadata+24/96] [__block_prepare_write+187/512] 
[block_prepare_write+34/64] [ext3_get_block+0/96] 
[ext3_prepare_write+149/336]
Dec 16 11:41:15 erde kernel: Code: 39 6a 04 75 f3 0f b7 42 08 3b 44 
24 20 75 e9 66 39 7a 0c 75

Code;  d0d373f1 <END_OF_CODE+40db41/????>
00000000 <_EIP>:
Code;  d0d373f1 <END_OF_CODE+40db41/????>
   0:   39 6a 04                  cmp    %ebp,0x4(%edx)
Code;  d0d373f4 <END_OF_CODE+40db44/????>
   3:   75 f3                     jne    fffffff8 <_EIP+0xfffffff8> 
d0d373e9 <END_OF_CODE+40db39/????>
Code;  d0d373f6 <END_OF_CODE+40db46/????>
   5:   0f b7 42 08               movzwl 0x8(%edx),%eax
Code;  d0d373fa <END_OF_CODE+40db4a/????>
   9:   3b 44 24 20               cmp    0x20(%esp,1),%eax
Code;  d0d373fe <END_OF_CODE+40db4e/????>
   d:   75 e9                     jne    fffffff8 <_EIP+0xfffffff8> 
d0d373e9 <END_OF_CODE+40db39/????>
Code;  d0d37400 <END_OF_CODE+40db50/????>
   f:   66 39 7a 0c               cmp    %di,0xc(%edx)
Code;  d0d37404 <END_OF_CODE+40db54/????>
  13:   75 00                     jne    15 <_EIP+0x15> d0d37406 
<END_OF_CODE+40db56/????>

Dec 16 11:44:18 erde kernel:  <1>Unable to handle kernel NULL 
pointer dereference at virtual address 00000014
Dec 16 11:44:18 erde kernel: c012367d
Dec 16 11:44:18 erde kernel: *pde = 00000000
Dec 16 11:44:18 erde kernel: Oops: 0000
Dec 16 11:44:18 erde kernel: CPU:    0
Dec 16 11:44:18 erde kernel: EIP:    0010:[exit_mmap+93/272]    Not 
tainted
Dec 16 11:44:18 erde kernel: EFLAGS: 00010202
Dec 16 11:44:18 erde kernel: eax: 00000010   ebx: c7737340   ecx: 
c7737000   edx: 00000019
Dec 16 11:44:18 erde kernel: esi: c8c21440   edi: 40ee3000   ebp: 
00001000   esp: c773ff84
Dec 16 11:44:18 erde kernel: ds: 0018   es: 0018   ss: 0018
Dec 16 11:44:18 erde kernel: Process kmail (pid: 1341, 
stackpage=c773f000)
Dec 16 11:44:18 erde kernel: Stack: c8c21440 c773e000 0000ff00 
bfffeb54 c77373c0 c0113a59 c8c21440 c8c21440
Dec 16 11:44:18 erde kernel:        c0117a46 c8c21440 c773e000 
4108b9b0 ffffffff c0117bce 0000ff00 c0106c3f
Dec 16 11:44:18 erde kernel:        ffffffff 00001000 4108cad8 
4108b9b0 ffffffff bfffeb54 00000001 0000002b
Dec 16 11:44:18 erde kernel: Call Trace: [mmput+57/96] 
[do_exit+134/480] [sys_exit+14/16] [system_call+51/56] 
Dec 16 11:44:18 erde kernel: Code: 8b 40 04 85 c0 74 06 53 ff d0 83 
c4 04 ff 4e 18 53 e8 0d ee

Code;  d0d373f1 <END_OF_CODE+40db41/????>
00000000 <_EIP>:
Code;  d0d373f1 <END_OF_CODE+40db41/????>
   0:   8b 40 04                  mov    0x4(%eax),%eax
Code;  d0d373f4 <END_OF_CODE+40db44/????>
   3:   85 c0                     test   %eax,%eax
Code;  d0d373f6 <END_OF_CODE+40db46/????>
   5:   74 06                     je     d <_EIP+0xd> d0d373fe 
<END_OF_CODE+40db4e/????>
Code;  d0d373f8 <END_OF_CODE+40db48/????>
   7:   53                        push   %ebx
Code;  d0d373f9 <END_OF_CODE+40db49/????>
   8:   ff d0                     call   *%eax
Code;  d0d373fb <END_OF_CODE+40db4b/????>
   a:   83 c4 04                  add    $0x4,%esp
Code;  d0d373fe <END_OF_CODE+40db4e/????>
   d:   ff 4e 18                  decl   0x18(%esi)
Code;  d0d37401 <END_OF_CODE+40db51/????>
  10:   53                        push   %ebx
Code;  d0d37402 <END_OF_CODE+40db52/????>
  11:   e8 0d ee 00 00            call   ee23 <_EIP+0xee23> 
d0d46214 <END_OF_CODE+41c964/????>


1 warning and 1 error issued.  Results may not be reliable.

Don´t hesitate to contact me for further information.

Jan Tim Schüszler
