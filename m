Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292037AbSBAVGY>; Fri, 1 Feb 2002 16:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292028AbSBAVGP>; Fri, 1 Feb 2002 16:06:15 -0500
Received: from imr2.ericy.com ([198.24.6.3]:130 "EHLO imr2.ericy.com")
	by vger.kernel.org with ESMTP id <S292037AbSBAVGM>;
	Fri, 1 Feb 2002 16:06:12 -0500
Message-ID: <7B2A7784F4B7F0409947481F3F3FEF8301B133EF@eammlnt051.lmc.ericsson.se>
From: "David Gordon (LMC)" <David.Gordon@ericsson.ca>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: ESS1868 sound card oops kernel 2.5.3
Date: Fri, 1 Feb 2002 16:05:56 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried running sndconfig to enable my sound card and got oops. I have:
ESS1868 I/O: 0x220 IRQ:5 DMA:1 MPU:0x330

I compiled the following drivers into the 2.5.3 kernel:
CONFIG_SOUND=m
CONFIG_SOUND_ES1371=m
CONFIG_SOUND_ESSSOLO1=m
CONFIG_SOUND_MAESTRO=m
CONFIG_SOUND_MAESTRO3=m
CONFIG_SOUND_OSS=m
CONFIG_SOUND_SB=m
CONFIG_SOUND_AWE32_SYNTH=m
CONFIG_SOUND_VMIDI=m

I run a RH7.1 system with 192 Mb RAM. The oops occurs when sndconfig plays
the first sample:

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   ff 04 85 30 6a 39 c0      incl   0xc0396a30(,%eax,4)
Code;  00000007 Before first symbol
   7:   f0 fe 8b 10 b8 35 c0      lock decb 0xc035b810(%ebx)
Code;  0000000e Before first symbol
   e:   0f 88 0d 2b 18 00         js     182b21 <_EIP+0x182b21> 00182b21
Before 
first symbol

 ;1>Unable to handle kernel paging request at virtual address a6fff324
c011ab56
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c011ab56>]  Not tainted
EFLAGS: 00010282
eax: c029eb18   ebx: 00000000     ecx: ca6b2000       edx: e6c6a680
esi: c029eb80   edi: c9932000     ebp: c9932000       esp: c9931fc8
ds: 0018        es: 0018       ss: 0018
Process (pid: 0, stackpage=c9931000)
Stack:  00000002 ca6b2000 ca6b3f64 c029ebfe c99320c4 00000002 c029eb18
00000018
        c0290018 ffffffef c0108f97 00000010 00000000 c029eb80
Call Trace: [<c0290018>] [<c0108f97>]
Code: 8b 82 a4 4c 39 c0 8b 8a a8 4c 39 c0 01 c8 85 c0 74 0a 68 20

>>EIP; c011ab56 <exit_mm+396/630>   <=====
Trace; c0290018 <crc32_be+5478/3e8ac>
Trace; c0108f97 <__read_lock_failed+170b/2724>
Code;  c011ab56 <exit_mm+396/630>
00000000 <_EIP>:
Code;  c011ab56 <exit_mm+396/630>   <=====
   0:   8b 82 a4 4c 39 c0         mov    0xc0394ca4(%edx),%eax   <=====
Code;  c011ab5c <exit_mm+39c/630>
   6:   8b 8a a8 4c 39 c0         mov    0xc0394ca8(%edx),%ecx
Code;  c011ab62 <exit_mm+3a2/630>
   c:   01 c8                     add    %ecx,%eax
Code;  c011ab64 <exit_mm+3a4/630>
   e:   85 c0                     test   %eax,%eax
Code;  c011ab66 <exit_mm+3a6/630>
  10:   74 0a                     je     1c <_EIP+0x1c> c011ab72
<exit_mm+3b2/63
0>
Code;  c011ab68 <exit_mm+3a8/630>
  12:   68 20 00 00 00            push   $0x20

 <0>Kernel panic: Attempted to kill the idle task!



Thank you,

David
