Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272264AbRI0Jtt>; Thu, 27 Sep 2001 05:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272270AbRI0Jtk>; Thu, 27 Sep 2001 05:49:40 -0400
Received: from mail.compfort.com.pl ([195.117.140.101]:44406 "helo
	mail.compfort.com.pl") by vger.kernel.org with SMTP
	id <S272264AbRI0JtZ>; Thu, 27 Sep 2001 05:49:25 -0400
From: <kewl@compfort.pl>
subject: kernel oops
Message-Id: <20010927094934Z272264-760+17574@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Date: Thu, 27 Sep 2001 05:49:25 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

i am recently experiencing kernel errors with httpd process,
the software used:

apache 1.3.18 running in chroot environment,
self built kernel 2.4.10,
glibc 2.2.2, gcc version 2.96, binutils 2.10)

the problem is semi-repeatable, that is it happens almost always after a few minutes of running
that httpd, but is triggered either by running CGI scripts or trigerring apache 40x errors.

the hardware used is P200 MMX, 64 megz of ram, tx chipset

if you need any further information i will be happy to help,

below find ksymoops outputs (2 slightly different ones):

the first one:

Unable to handle kernel NULL pointer dereference at virtual address 0000000c
c011a112
*pde = 0128d067
Oops: 0000
CPU:    0
EIP:    0010:[<c011a112>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00000000   ebx: c3462000   ecx: c37ad620   edx: c1132000
esi: c1e24000   edi: ffff0301   ebp: 0000000a   esp: c1e25ee4
ds: 0018   es: 0018   ss: 0018
Process httpd (pid: 27196, stackpage=c1e25000)
Stack: 000023ad ffffffff 000023ad 00000003 00000001 bffff808 c011a74d 0000000a
       c1e25f3c c3462000 00000000 005fd4a5 c1e24000 c010f160 000023ad 00000003
       00000001 bffff808 c011aee9 0000000a c1e25f3c 000023ad 0000000a 00000000
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
   a:   75 0c                     jne    18 <_EIP+0x18> c011a12a <send_sig_info+fa/4d0>
Code;  c011a11e <send_sig_info+ee/4d0>
   c:   8b 41 28                  mov    0x28(%ecx),%eax
Code;  c011a120 <send_sig_info+f0/4d0>
   f:   39 42 28                  cmp    %eax,0x28(%edx)
Code;  c011a124 <send_sig_info+f4/4d0>
  12:   0f 84 00 00 00 00         je     18 <_EIP+0x18> c011a12a <send_sig_info+fa/4d0>

and the other one:

Unable to handle kernel NULL pointer dereference at virtual address 0000000c
c011a112
*pde = 02410067
Oops: 0000
CPU:    0
EIP:    0010:[<c011a112>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00000000   ebx: c3850000   ecx: c37ad620   edx: c1132000
esi: c2412000   edi: ffff0301   ebp: 0000000a   esp: c2413ee4
ds: 0018   es: 0018   ss: 0018
Process httpd (pid: 4325, stackpage=c2413000)
Stack: 00002a7c ffffffff 00002a7c 00000003 00000001 bffffc48 c011a74d 0000000a
       c2413f3c c3850000 00000000 0001c089 c2412000 c010f160 00002a7c 00000003
       00000001 bffffc48 c011aee9 0000000a c2413f3c 00002a7c 0000000a 00000000
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
   a:   75 0c                     jne    18 <_EIP+0x18> c011a12a <send_sig_info+fa/4d0>
Code;  c011a11e <send_sig_info+ee/4d0>
   c:   8b 41 28                  mov    0x28(%ecx),%eax
Code;  c011a120 <send_sig_info+f0/4d0>
   f:   39 42 28                  cmp    %eax,0x28(%edx)
Code;  c011a124 <send_sig_info+f4/4d0>
  12:   0f 84 00 00 00 00         je     18 <_EIP+0x18> c011a12a <send_sig_info+fa/4d0>

best regards,
terry
