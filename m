Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280073AbRKNDeV>; Tue, 13 Nov 2001 22:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280081AbRKNDeB>; Tue, 13 Nov 2001 22:34:01 -0500
Received: from orion.hjc.edu.sg ([203.127.28.35]:31395 "HELO orion.hjc.edu.sg")
	by vger.kernel.org with SMTP id <S280073AbRKNDd5>;
	Tue, 13 Nov 2001 22:33:57 -0500
To: linux-kernel@vger.kernel.org
Subject: Kernel-2.4.13/ac-6 & ucd-snmp oops
Message-ID: <1005708829.3bf1e61d90dcd@home.hjc.edu.sg>
Date: Wed, 14 Nov 2001 11:33:49 +0800 (SGT)
From: Chen Shiyuan <csy@hjc.edu.sg>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Hwa Chong Junior College Mail System (CMS)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm currently running RedHat 7.2 on a Dell PowerEdge 2550 with 2 x 
PIII1000 and 512MB RAM together with an onboard RAID controller that 
requires the AACRAID patch before the kernel can detect the controller.

Apparently all is working fine except that occasionally, especially 
after running for more than 24hrs, the snmpd daemon will cause a kernel 
oops and die. I can then restart the snmpd daemon and it will run for 
more than 24hrs and then die again with a kernel oops.

The snmp dies randomly without a fixed pattern other than the 
accompanying kernel oops as well as it runs generally fine for more than 
24hrs.

The ucd-snmp is verion 4.2.1 that comes with RedHat 7.2 SRPM. I rebuilt 
the ucd-snmp package from the SRPM as the stock ucd-snmp RPM cannot seem 
to work properly with the "disk" parameter as it causes the snmpd to die 
upon startup. A direct recompilation without any changes from the source 
RPM solved the problem.

I have tried out kernel-2.4.13 as well as kernel 2.4.13-ac6 and the oops 
still occurs.

The following is the oops message followed by the ksymoops output as 
mentioned in the oops-tracing.txt file.

OOPS Message
============
Unable to handle kernel NULL pointer dereference at virtual address 
000002de
printing eip: c01f8ec6
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[sprintf_stats+38/192]    Not tainted
EIP:    0010:[<c01f8ec6>]    Not tainted
EFLAGS: 00010202
eax: 00000286   ebx: dfe06000   ecx: 00000000   edx: 00000286
esi: c1f041c0   edi: 00000000   ebp: 00000000   esp: de7ebf24
ds: 0018   es: 0018   ss: 0018
Process snmpd (pid: 842, stackpage=de7eb000)
Stack: 000001c0 dfe06000 c01f8fb4 c1f041c0 dfe06000 00000000 00000c00 
00001000
       c1f04000 c0155d64 c1f04000 de7ebf68 00000000 00000c00 c18ce5a0 
00000000
       00000000 00000000 dc482960 ffffffea 00000000 00001000 c0135146 
dc482960
Call Trace: [dev_get_info+84/160] [proc_file_read+148/400] 
[sys_read+150/208] [system_call+51/56]

Call Trace: [<c01f8fb4>] [<c0155d64>] [<c0135146>] [<c0106f1b>]

Code: 8b 42 58 50 8b 4a 44 8b 42 40 01 c8 8b 4a 50 01 c8 8b 4a 4c


KSYMOOPS OUTPUT
===============
ksymoops 2.4.1 on i686 2.4.13-ac6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.13-ac6/ (default)
     -m /boot/System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 
000002de
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[sprintf_stats+38/192]    Not tainted
EIP:    0010:[<c01f8ec6>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000286   ebx: dfe06000   ecx: 00000000   edx: 00000286
esi: c1f041c0   edi: 00000000   ebp: 00000000   esp: de7ebf24
ds: 0018   es: 0018   ss: 0018
Process snmpd (pid: 842, stackpage=de7eb000)
Stack: 000001c0 dfe06000 c01f8fb4 c1f041c0 dfe06000 00000000 00000c00 
00001000
       c1f04000 c0155d64 c1f04000 de7ebf68 00000000 00000c00 c18ce5a0 
00000000
       00000000 00000000 dc482960 ffffffea 00000000 00001000 c0135146 
dc482960
Call Trace: [dev_get_info+84/160] [proc_file_read+148/400] 
[sys_read+150/208] [system_call+51/56]
Call Trace: [<c01f8fb4>] [<c0155d64>] [<c0135146>] [<c0106f1b>]
Code: 8b 42 58 50 8b 4a 44 8b 42 40 01 c8 8b 4a 50 01 c8 8b 4a 4c

>>EIP; c01f8ec6 <sprintf_stats+26/c0>   <=====
Trace; c01f8fb4 <dev_get_info+54/a0>
Trace; c0155d64 <proc_file_read+94/190>
Trace; c0135146 <sys_read+96/d0>
Trace; c0106f1b <system_call+33/38>
Code;  c01f8ec6 <sprintf_stats+26/c0>
00000000 <_EIP>:
Code;  c01f8ec6 <sprintf_stats+26/c0>   <=====
   0:   8b 42 58                  mov    0x58(%edx),%eax   <=====
Code;  c01f8ec9 <sprintf_stats+29/c0>
   3:   50                        push   %eax
Code;  c01f8eca <sprintf_stats+2a/c0>
   4:   8b 4a 44                  mov    0x44(%edx),%ecx
Code;  c01f8ecd <sprintf_stats+2d/c0>
   7:   8b 42 40                  mov    0x40(%edx),%eax
Code;  c01f8ed0 <sprintf_stats+30/c0>
   a:   01 c8                     add    %ecx,%eax
Code;  c01f8ed2 <sprintf_stats+32/c0>
   c:   8b 4a 50                  mov    0x50(%edx),%ecx
Code;  c01f8ed5 <sprintf_stats+35/c0>
   f:   01 c8                     add    %ecx,%eax
Code;  c01f8ed7 <sprintf_stats+37/c0>
  11:   8b 4a 4c                  mov    0x4c(%edx),%ecx


Does anyone have any idea what could be causing the problem?

Many thanks in advance for any help.
