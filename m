Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318398AbSHGQ0P>; Wed, 7 Aug 2002 12:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318428AbSHGQ0P>; Wed, 7 Aug 2002 12:26:15 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:133 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id <S318398AbSHGQZx>; Wed, 7 Aug 2002 12:25:53 -0400
Date: Wed, 7 Aug 2002 18:29:32 +0200
From: Adam Lackorzynski <adam@os.inf.tu-dresden.de>
To: linux-kernel@vger.kernel.org
Subject: Oopses on dual Athlon with 2.4.19-ac4 and 2.4.20-pre1-ac1
Message-ID: <20020807162932.GH23816@os.inf.tu-dresden.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a dual Athlon here which ooopses after 2 minutes of dnetc when
running 2.4.19-ac4 or 2.4.20-pre1-ac1. I cannot reproduce this with
2.4.19 or 2.4.20-pre1. The two Athlons are sitting on a A7M266-D.


I have put the kern log, kernel config, lspci info etc. on
  http://os.inf.tu-dresden.de/~adam/oops/
as this is quite big.

2.4.20-pre1-ac1:

Unable to handle kernel NULL pointer dereference at virtual address 0000002a
 printing eip:
c011831c
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c011831c>]    Not tainted
EFLAGS: 00010007
eax: 0000008c   ebx: ffffffd6   ecx: c0395264   edx: ddecc000
esi: c0395240   edi: ddecc02c   ebp: ddecdfa4   esp: ddecdf88
ds: 0018   es: 0018   ss: 0018
Process dnetc (pid: 310, stackpage=ddecd000)
Stack: ddecc000 c0395264 ddecc02c 00000001 c011521f ddecc000 ddecc000 ddecdfbc 
       c011935d ddecc000 000000c5 000b4aa0 c0395240 bffff7b4 c0108b6b 00000000 
       00000000 40025004 000000c5 000b4aa0 bffff7b4 0000009e 0000002b 0000002b 
Call Trace:    [<c011521f>] [<c011935d>] [<c0108b6b>]

Code: 8b 4b 54 89 4d f4 8b 72 58 85 c9 75 37 89 73 58 f0 ff 46 14 

>>EIP; c011831c <schedule+19c/3a0>   <=====

>>ebx; ffffffd6 <END_OF_CODE+3fbf683a/????>
>>ecx; c0395264 <runqueues+9e4/13800>
>>edx; ddecc000 <END_OF_CODE+1dac2864/????>
>>esi; c0395240 <runqueues+9c0/13800>
>>edi; ddecc02c <END_OF_CODE+1dac2890/????>
>>ebp; ddecdfa4 <END_OF_CODE+1dac4808/????>
>>esp; ddecdf88 <END_OF_CODE+1dac47ec/????>

Trace; c011521f <smp_apic_timer_interrupt+ef/110>
Trace; c011935d <sys_sched_yield+11d/130>
Trace; c0108b6b <system_call+33/38>

Code;  c011831c <schedule+19c/3a0>
00000000 <_EIP>:
Code;  c011831c <schedule+19c/3a0>   <=====
   0:   8b 4b 54                  mov    0x54(%ebx),%ecx   <=====
Code;  c011831f <schedule+19f/3a0>
   3:   89 4d f4                  mov    %ecx,0xfffffff4(%ebp)
Code;  c0118322 <schedule+1a2/3a0>
   6:   8b 72 58                  mov    0x58(%edx),%esi
Code;  c0118325 <schedule+1a5/3a0>
   9:   85 c9                     test   %ecx,%ecx
Code;  c0118327 <schedule+1a7/3a0>
   b:   75 37                     jne    44 <_EIP+0x44> c0118360 <schedule+1e0/3a0>
Code;  c0118329 <schedule+1a9/3a0>
   d:   89 73 58                  mov    %esi,0x58(%ebx)
Code;  c011832c <schedule+1ac/3a0>
  10:   f0 ff 46 14               lock incl 0x14(%esi)

------------------------------------------------------------

Unable to handle kernel NULL pointer dereference at virtual address 0000002a
 printing eip:
c011831c
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c011831c>]    Not tainted
EFLAGS: 00010003
eax: 0000008c   ebx: ffffffd6   ecx: c0395264   edx: dea0c000
esi: c0395240   edi: dea0c02c   ebp: dea0dfa4   esp: dea0df88
ds: 0018   es: 0018   ss: 0018
Process dnetc (pid: 307, stackpage=dea0d000)
Stack: dea0c000 c0395264 dea0c02c c011521f 00000000 dea0c000 dea0c000 dea0dfbc 
       c011935d dea0c000 000000c5 000be6e0 c0395240 bffff7b4 c0108b6b 00000000 
       00000000 40025004 000000c5 000be6e0 bffff7b4 0000009e 0000002b 0000002b 
Call Trace:    [<c011521f>] [<c011935d>] [<c0108b6b>]

Code: 8b 4b 54 89 4d f4 8b 72 58 85 c9 75 37 89 73 58 f0 ff 46 14 

>>EIP; c011831c <schedule+19c/3a0>   <=====

>>ebx; ffffffd6 <END_OF_CODE+3fbf683a/????>
>>ecx; c0395264 <runqueues+9e4/13800>
>>edx; dea0c000 <END_OF_CODE+1e602864/????>
>>esi; c0395240 <runqueues+9c0/13800>
>>edi; dea0c02c <END_OF_CODE+1e602890/????>
>>ebp; dea0dfa4 <END_OF_CODE+1e604808/????>
>>esp; dea0df88 <END_OF_CODE+1e6047ec/????>

Trace; c011521f <smp_apic_timer_interrupt+ef/110>
Trace; c011935d <sys_sched_yield+11d/130>
Trace; c0108b6b <system_call+33/38>

Code;  c011831c <schedule+19c/3a0>
00000000 <_EIP>:
Code;  c011831c <schedule+19c/3a0>   <=====
   0:   8b 4b 54                  mov    0x54(%ebx),%ecx   <=====
Code;  c011831f <schedule+19f/3a0>
   3:   89 4d f4                  mov    %ecx,0xfffffff4(%ebp)
Code;  c0118322 <schedule+1a2/3a0>
   6:   8b 72 58                  mov    0x58(%edx),%esi
Code;  c0118325 <schedule+1a5/3a0>
   9:   85 c9                     test   %ecx,%ecx
Code;  c0118327 <schedule+1a7/3a0>
   b:   75 37                     jne    44 <_EIP+0x44> c0118360 <schedule+1e0/3a0>
Code;  c0118329 <schedule+1a9/3a0>
   d:   89 73 58                  mov    %esi,0x58(%ebx)
Code;  c011832c <schedule+1ac/3a0>
  10:   f0 ff 46 14               lock incl 0x14(%esi)


2.4.19-ac4:

Unable to handle kernel NULL pointer dereference at virtual address 0000002a
 printing eip:
c01181ac
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01181ac>]    Not tainted
EFLAGS: 00010003
eax: 0000008c   ebx: ffffffd6   ecx: c038b8a4   edx: de7ce000
esi: c038b880   edi: de7ce02c   ebp: de7cffa4   esp: de7cff88
ds: 0018   es: 0018   ss: 0018
Process dnetc (pid: 302, stackpage=de7cf000)
Stack: de7ce000 c038b8a4 de7ce02c 00000000 c011521f de7ce000 de7ce000 de7cffbc 
       c01191ed de7ce000 0000003c 00050910 c038b880 bffff7b4 c0108b6b 00000000 
       00000000 40025004 0000003c 00050910 bffff7b4 0000009e 0000002b 0000002b 
Call Trace:    [<c011521f>] [<c01191ed>] [<c0108b6b>]

Code: 8b 4b 54 89 4d f4 8b 72 58 85 c9 75 37 89 73 58 f0 ff 46 14 
 
>>EIP; c01181ac <schedule+19c/3a0>   <=====

>>ebx; ffffffd6 <END_OF_CODE+3fbff8ba/????>
>>ecx; c038b8a4 <runqueues+24/13800>
>>edx; de7ce000 <END_OF_CODE+1e3cd8e4/????>
>>esi; c038b880 <runqueues+0/13800>
>>edi; de7ce02c <END_OF_CODE+1e3cd910/????>
>>ebp; de7cffa4 <END_OF_CODE+1e3cf888/????>
>>esp; de7cff88 <END_OF_CODE+1e3cf86c/????>

Trace; c011521f <smp_apic_timer_interrupt+ef/110>
Trace; c01191ed <sys_sched_yield+11d/130>
Trace; c0108b6b <system_call+33/38>

Code;  c01181ac <schedule+19c/3a0>
00000000 <_EIP>:
Code;  c01181ac <schedule+19c/3a0>   <=====
   0:   8b 4b 54                  mov    0x54(%ebx),%ecx   <=====
Code;  c01181af <schedule+19f/3a0>
   3:   89 4d f4                  mov    %ecx,0xfffffff4(%ebp)
Code;  c01181b2 <schedule+1a2/3a0>
   6:   8b 72 58                  mov    0x58(%edx),%esi
Code;  c01181b5 <schedule+1a5/3a0>
   9:   85 c9                     test   %ecx,%ecx
Code;  c01181b7 <schedule+1a7/3a0>
   b:   75 37                     jne    44 <_EIP+0x44> c01181f0 <schedule+1e0/3
a0>
Code;  c01181b9 <schedule+1a9/3a0>
   d:   89 73 58                  mov    %esi,0x58(%ebx)
Code;  c01181bc <schedule+1ac/3a0>
  10:   f0 ff 46 14               lock incl 0x14(%esi)






HTH,
Adam
-- 
Adam                 adam@os.inf.tu-dresden.de
  Lackorzynski         http://os.inf.tu-dresden.de/~adam/
