Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315203AbSD3UFv>; Tue, 30 Apr 2002 16:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315213AbSD3UFu>; Tue, 30 Apr 2002 16:05:50 -0400
Received: from tonib-gw-old.customer.0rbitel.net ([195.24.39.218]:49163 "EHLO
	mail.ludost.net") by vger.kernel.org with ESMTP id <S315203AbSD3UFt>;
	Tue, 30 Apr 2002 16:05:49 -0400
Date: Tue, 30 Apr 2002 23:05:44 +0300 (EEST)
From: Vasil Kolev <lnxkrnl@mail.ludost.net>
X-X-Sender: <lnxkrnl@doom.bastun.net>
To: <linux-kernel@vger.kernel.org>
Subject: oops in 2.4.18
Message-ID: <Pine.LNX.4.33.0204302304230.9113-100000@doom.bastun.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following oops running 2.4.18 today:
(The machine is dual P3/866 ,1G ram, using LVM and reiserfs,more info on
req.)


Unable to handle kernel NULL pointer dereference at virtual address
00000028
c022a4d1
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c022a4d1>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: ef4cbf80   ebx: df2afb60   ecx: 00000000   edx: 00000000
esi: ef4cbf80   edi: ef4cbf48   ebp: ddafe940   esp: ef4cbf14
ds: 0018   es: 0018   ss: 0018
Process apache (pid: 2642, stackpage=ef4cb000)
Stack: df2afb60 ef4cbf80 000000bf ef4cbf48 c01eab25 ddafe940 ef4cbf80
000000bf
       ef4cbf48 00000000 000000bf ddafe940 000000bf 00000a52 00000378
00000378
       00000000 00000000 c01ead5e ddafe940 ef4cbf80 000000bf 00000000
c41da8e0
Call Trace: [<c01eab25>] [<c01ead5e>] [<c0135c27>] [<c0106e5b>]
Code: 8b 42 28 ff d0 83 c4 0c 5b c3 90 83 ec 04 55 57 56 53 8b 44


>>EIP; c022a4d1 <inet_sendmsg+35/40>   <=====

>>eax; ef4cbf80 <END_OF_CODE+2f193644/????>
>>ebx; df2afb60 <END_OF_CODE+1ef77224/????>
>>esi; ef4cbf80 <END_OF_CODE+2f193644/????>
>>edi; ef4cbf48 <END_OF_CODE+2f19360c/????>
>>ebp; ddafe940 <END_OF_CODE+1d7c6004/????>
>>esp; ef4cbf14 <END_OF_CODE+2f1935d8/????>

Trace; c01eab25 <sock_sendmsg+69/88>
Trace; c01ead5e <sock_write+b2/bc>
Trace; c0135c27 <sys_write+8f/100>
Trace; c0106e5b <system_call+33/38>

Code;  c022a4d1 <inet_sendmsg+35/40>
00000000 <_EIP>:
Code;  c022a4d1 <inet_sendmsg+35/40>   <=====
   0:   8b 42 28                  mov    0x28(%edx),%eax   <=====
Code;  c022a4d4 <inet_sendmsg+38/40>
   3:   ff d0                     call   *%eax
Code;  c022a4d6 <inet_sendmsg+3a/40>
   5:   83 c4 0c                  add    $0xc,%esp
Code;  c022a4d9 <inet_sendmsg+3d/40>
   8:   5b                        pop    %ebx
Code;  c022a4da <inet_sendmsg+3e/40>
   9:   c3                        ret
Code;  c022a4db <inet_sendmsg+3f/40>
   a:   90                        nop
Code;  c022a4dc <inet_shutdown+0/1e0>
   b:   83 ec 04                  sub    $0x4,%esp
Code;  c022a4df <inet_shutdown+3/1e0>
   e:   55                        push   %ebp
Code;  c022a4e0 <inet_shutdown+4/1e0>
   f:   57                        push   %edi
Code;  c022a4e1 <inet_shutdown+5/1e0>
  10:   56                        push   %esi
Code;  c022a4e2 <inet_shutdown+6/1e0>
  11:   53                        push   %ebx
Code;  c022a4e3 <inet_shutdown+7/1e0>
  12:   8b 44 00 00               mov    0x0(%eax,%eax,1),%eax



