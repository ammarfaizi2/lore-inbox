Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276872AbRJHMzR>; Mon, 8 Oct 2001 08:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276875AbRJHMzI>; Mon, 8 Oct 2001 08:55:08 -0400
Received: from mail.compfort.com.pl ([195.117.140.101]:40824 "EHLO
	mail.compfort.com.pl") by vger.kernel.org with ESMTP
	id <S276872AbRJHMyr>; Mon, 8 Oct 2001 08:54:47 -0400
Message-ID: <004501c14ff9$13e60fe0$6f00000a@compfort>
From: "Terry Kendal" <kewl@compfort.pl>
To: <linux-kernel@vger.kernel.org>
Subject: kernel oops
Date: Mon, 8 Oct 2001 14:59:33 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
i am recently experiencing kernel errors with httpd process,
the software used:

apache 1.3.18 running in chroot environment,
self built kernel 2.4.10,
glibc 2.2.2, gcc version 2.96, binutils 2.10)

the problem is semi-repeatable, that is it happens almost always after a few
minutes of running
that httpd, but is triggered either by running CGI scripts or trigerring
apache 40x errors.

the hardware used is P200 MMX, 64 megz of ram, tx chipset

if you need any further information i will be happy to help,

ksymoops outputs:

Unable to handle kernel NULL pointer dereference at virtual address 0000000c
c011a112
*pde = 003a7067
Oops: 0000
CPU:    0
EIP:    0010:[<c011a112>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00000000   ebx: c3f58000   ecx: c0f5c220   edx: c1132000
esi: c0e1e000   edi: ffff0301   ebp: 0000000a   esp: c0e1fee4
ds: 0018   es: 0018   ss: 0018
Process httpd (pid: 4063, stackpage=c0e1f000)
Stack: 00005941 ffffffff 00005941 00000003 00000001 bffffc48 c011a74d
0000000a
       c0e1ff3c c3f58000 00000000 0009f8ab c0e1e000 c010f160 00005941
00000003
       00000001 bffffc48 c011aee9 0000000a c0e1ff3c 00005941 0000000a
00000000
Call Trace: [<c011a74d>] [<c010f160>] [<c011aee9>] [<c013dea0>] [<c0106ca3>]
Code: 8b 40 0c 8b 50 08 66 39 7a 30 75 0c 8b 41 28 39 42 28 0f 84

>>EIP; c011a112 <send_sig_info+e2/4d0>   <=====
Trace; c011a74c <kill_something_info+ec/100>
Trace; c010f160 <process_timeout+0/50>
Trace; c011aee8 <sys_kill+48/60>
Trace; c013dea0 <sys_select+480/490>
Trace; c0106ca2 <system_call+32/40>
Code;  c011a112 <send_sig_info+e2/4d0>
00000000 <_EIP>:
Code;  c011a112 <send_sig_info+e2/4d0>   <=====
   0:   8b 40 0c                  mov    0xc(%eax),%eax   <=====
Code;  c011a114 <send_sig_info+e4/4d0>
   3:   8b 50 08                  mov    0x8(%eax),%edx
Code;  c011a118 <send_sig_info+e8/4d0>
   6:   66 39 7a 30               cmp    %di,0x30(%edx)
Code;  c011a11c <send_sig_info+ec/4d0>
   a:   75 0c                     jne    18 <_EIP+0x18> c011a12a
<send_sig_info+fa/4d0>
Code;  c011a11e <send_sig_info+ee/4d0>
   c:   8b 41 28                  mov    0x28(%ecx),%eax
Code;  c011a120 <send_sig_info+f0/4d0>
   f:   39 42 28                  cmp    %eax,0x28(%edx)
Code;  c011a124 <send_sig_info+f4/4d0>
  12:   0f 84 00 00 00 00         je     18 <_EIP+0x18> c011a12a
<send_sig_info+fa/4d0>

the next one (diff with the above):
15d14
< Unable to handle kernel NULL pointer dereference at virtual address
0000000c
17c16
< *pde = 003a7067
---
> *pde = 014e2067
23,24c22,23
< eax: 00000000   ebx: c3f58000   ecx: c0f5c220   edx: c1132000
< esi: c0e1e000   edi: ffff0301   ebp: 0000000a   esp: c0e1fee4
---
> eax: 00000000   ebx: c0f58000   ecx: c0f5c220   edx: c1132000
> esi: c0722000   edi: ffff0301   ebp: 00000009   esp: c0723ee4
26,30c25,30
< Process httpd (pid: 4063, stackpage=c0e1f000)
< Stack: 00005941 ffffffff 00005941 00000003 00000001 bffffc48 c011a74d
0000000a
<        c0e1ff3c c3f58000 00000000 0009f8ab c0e1e000 c010f160 00005941
00000003
<        00000001 bffffc48 c011aee9 0000000a c0e1ff3c 00005941 0000000a
00000000
< Call Trace: [<c011a74d>] [<c010f160>] [<c011aee9>] [<c013dea0>]
[<c0106ca3>]
---
> Process httpd (pid: 31469, stackpage=c0723000)
> Stack: 0000044d ffffffff 0000044d 00000001 080ff6f0 bffffb74 c011a74d
00000009
>        c0723f3c c0f58000 c0d68960 0020cc8c 00000001 c11071a0 0000044d
00000001
>        080ff6f0 bffffb74 c011aee9 00000009 c0723f3c 0000044d 00000009
00000000
> Call Trace: [<c011a74d>] [<c011aee9>] [<c010f234>] [<c010f160>]
[<c0114ce0>]
>    [<c01197ce>] [<c0106ca3>]
35d34
< Trace; c010f160 <process_timeout+0/50>
37c36,39
< Trace; c013dea0 <sys_select+480/490>
---
> Trace; c010f234 <schedule_timeout+84/a0>
> Trace; c010f160 <process_timeout+0/50>
> Trace; c0114ce0 <sys_wait4+3b0/3c0>
> Trace; c01197ce <sys_nanosleep+10e/190>

and the last one (diff from the first):
17c17
< *pde = 003a7067
---
> *pde = 02562067
23,24c23,24
< eax: 00000000   ebx: c3f58000   ecx: c0f5c220   edx: c1132000
< esi: c0e1e000   edi: ffff0301   ebp: 0000000a   esp: c0e1fee4
---
> eax: 00000000   ebx: c19d6000   ecx: c0f5c220   edx: c1132000
> esi: c3730000   edi: ffff0301   ebp: 00000009   esp: c3731ee4
26,30c26,31
< Process httpd (pid: 4063, stackpage=c0e1f000)
< Stack: 00005941 ffffffff 00005941 00000003 00000001 bffffc48 c011a74d
0000000a
<        c0e1ff3c c3f58000 00000000 0009f8ab c0e1e000 c010f160 00005941
00000003
<        00000001 bffffc48 c011aee9 0000000a c0e1ff3c 00005941 0000000a
00000000
< Call Trace: [<c011a74d>] [<c010f160>] [<c011aee9>] [<c013dea0>]
[<c0106ca3>]
---
> Process httpd (pid: 29449, stackpage=c3731000)
> Stack: 00004afe ffffffff 00004afe 00000001 081129c0 bffffae0 c011a74d
00000009
>        c3731f3c c19d6000 c3b0a980 0020cc8c 00000001 c11071a0 00004afe
00000001
>        081129c0 bffffae0 c011aee9 00000009 c3731f3c 00004afe 00000009
00000000
> Call Trace: [<c011a74d>] [<c011aee9>] [<c010f234>] [<c010f160>]
[<c0114ce0>]
>    [<c01197ce>] [<c0106ca3>]
35d35
< Trace; c010f160 <process_timeout+0/50>
37c37,40
< Trace; c013dea0 <sys_select+480/490>
---
> Trace; c010f234 <schedule_timeout+84/a0>
> Trace; c010f160 <process_timeout+0/50>
> Trace; c0114ce0 <sys_wait4+3b0/3c0>
> Trace; c01197ce <sys_nanosleep+10e/190>

best regards,
terry


