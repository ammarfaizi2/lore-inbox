Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262692AbSKHWeY>; Fri, 8 Nov 2002 17:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262689AbSKHWeY>; Fri, 8 Nov 2002 17:34:24 -0500
Received: from tantale.fifi.org ([216.27.190.146]:32907 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id <S262525AbSKHWeV>;
	Fri, 8 Nov 2002 17:34:21 -0500
To: sparclinux@vger.kernel.org
Reply-To: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: sparc32: 2.4.20-pre11 oopses in flush_sigqueue()
From: Philippe Troin <phil@fifi.org>
Date: 08 Nov 2002 14:41:02 -0800
Message-ID: <87d6pfr8g1.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seen on a UP SS20 box.
The kernel killed a `cp' process and went on...

Phil.

ksymoops 2.4.5 on sparc 2.4.20-pre11.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-pre11/ (default)
     -m /boot/System.map-2.4.20-pre11 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

16257MB HIGHMEM available.
Unable to handle kernel paging request at virtual address 809c4000
tsk->{mm,active_mm}->context = 00000322
tsk->{mm,active_mm}->pgd = fc041400
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
cp(829): Oops
PSR: 1e800fc7 PC: f00304f4 NPC: f00304f8 Y: 00000000    Not tainted
Using defaults from ksymoops -t elf32-sparc -a sparc
g0: 7fffffff g1: 1e400fe0 g2: 00000000 g3: 1e800fe1 g4: f004017c g5: 00000322 g6: fa54c000 g7: 00000001
o0: 00000005 o1: 809c4400 o2: f01c2c08 o3: f019f400 o4: 00000005 o5: effff000 sp: fa54ddd0 o7: f004017c
l0: fab5a020 l1: f019f400 l2: f0029b18 l3: 00000004 l4: 00000008 l5: 00000000 l6: 5002c130 l7: 500283c8
i0: f019f400 i1: fab5b2c0 i2: f01c2ce8 i3: f019f400 i4: f0198400 i5: 00000001 fp: fa54de38 i7: f00305a8
Caller[f00305a8]
Caller[f0029c90]
Caller[f0029d90]
Caller[f0011184]
Caller[5005e7d0]
Instruction DUMP: c0260000  233c067d  313c067d <e0024000> 40003f0b  d0046334  82162338  84102001  8810000f 


>>PC;  f00304f4 <flush_sigqueue+28/5c>   <=====

>>g0; 7fffffff Before first symbol
>>g1; 1e400fe0 Before first symbol
>>g3; 1e800fe1 Before first symbol
>>g4; f004017c <kmem_cache_free+58/110>
>>g6; fa54c000 <end+a38b420/e141420>
>>o1; 809c4400 Before first symbol
>>o2; f01c2c08 <end+2028/e141420>
>>o3; f019f400 <uidhash_table+cc/400>
>>o5; effff000 Before first symbol
>>sp; fa54ddd0 <end+a38d1f0/e141420>
>>o7; f004017c <kmem_cache_free+58/110>
>>l0; fab5a020 <end+a999440/e141420>
>>l1; f019f400 <uidhash_table+cc/400>
>>l2; f0029b18 <do_exit+d0/320>
>>l6; 5002c130 Before first symbol
>>l7; 500283c8 Before first symbol
>>i0; f019f400 <uidhash_table+cc/400>
>>i1; fab5b2c0 <end+a99a6e0/e141420>
>>i2; f01c2ce8 <end+2108/e141420>
>>i3; f019f400 <uidhash_table+cc/400>
>>i4; f0198400 <kstat+1280/145c>
>>fp; fa54de38 <end+a38d258/e141420>
>>i7; f00305a8 <exit_sighand+68/9c>

Trace; f00305a8 <exit_sighand+68/9c>
Trace; f0029c90 <do_exit+248/320>
Trace; f0029d90 <sys_exit+8/10>
Trace; f0011184 <syscall_is_too_hard+34/40>
Trace; 5005e7d0 Before first symbol

Code;  f00304e8 <flush_sigqueue+1c/5c>
00000000 <_PC>:
Code;  f00304e8 <flush_sigqueue+1c/5c>
   0:   c0 26 00 00       clr  [ %i0 ]
Code;  f00304ec <flush_sigqueue+20/5c>
   4:   23 3c 06 7d       sethi  %hi(0xf019f400), %l1
Code;  f00304f0 <flush_sigqueue+24/5c>
   8:   31 3c 06 7d       sethi  %hi(0xf019f400), %i0
Code;  f00304f4 <flush_sigqueue+28/5c>   <=====
   c:   e0 02 40 00       ld  [ %o1 ], %l0   <=====
Code;  f00304f8 <flush_sigqueue+2c/5c>
  10:   40 00 3f 0b       call  fc3c <_PC+0xfc3c> f0040124 <kmem_cache_free+0/110>
Code;  f00304fc <flush_sigqueue+30/5c>
  14:   d0 04 63 34       ld  [ %l1 + 0x334 ], %o0
Code;  f0030500 <flush_sigqueue+34/5c>
  18:   82 16 23 38       or  %i0, 0x338, %g1
Code;  f0030504 <flush_sigqueue+38/5c>
  1c:   84 10 20 01       mov  1, %g2
Code;  f0030508 <flush_sigqueue+3c/5c>
  20:   88 10 00 0f       mov  %o7, %g4


1 warning issued.  Results may not be reliable.
