Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265301AbSJaVZ4>; Thu, 31 Oct 2002 16:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265289AbSJaVZ4>; Thu, 31 Oct 2002 16:25:56 -0500
Received: from tantale.fifi.org ([216.27.190.146]:45707 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id <S265284AbSJaVZq>;
	Thu, 31 Oct 2002 16:25:46 -0500
To: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: sparc32: oops when writing to block devices
From: Philippe Troin <phil@fifi.org>
Date: 31 Oct 2002 13:32:11 -0800
Message-ID: <874rb2uwf8.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

seen on 2.4.20-pre11, sparc32 (UP SS20).

it happens while doing:

  dd bs=8k < file > /dev/scsi/disc/disc1/part1

ksymoops output enclosed.

This is 100% reproducible.

I found that bs=1k and bs=4k causes the oops, but bs=512 does not.

Oops (two of them) processed by ksymoops follows. However it does not
seem to be exploitable since the backtrace is quite munged.

Phil.

ksymoops 2.4.5 on sparc 2.4.20-pre11.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-20pre11/ (default)
     -m /boot/System.map-2.4.19-20pre11 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address 9de3b000
tsk->{mm,active_mm}->context = 00000ef5
tsk->{mm,active_mm}->pgd = fc02f400
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
dd(3863): Oops
PSR: 1e1000c6 PC: f004b46c NPC: f004b470 Y: 00000000    Not tainted
Using defaults from ksymoops -t elf32-sparc -a sparc
g0: fa9e7ea0 g1: fffffffd g2: 00000004 g3: 9de3bf98 g4: 00000000 g5: 30000000 g6: fa9e6000 g7: ff000000
o0: a4400010 o1: fd011000 o2: fd011000 o3: 00000800 o4: 00000000 o5: 00000000 sp: fa9e7ea0 o7: 00000001
l0: 1e800fa7 l1: f0012e00 l2: f00106c4 l3: 00000002 l4: 00000004 l5: 00000000 l6: fb6b4fc0 l7: 00000000
i0: 00000000 i1: 00000000 i2: 00000000 i3: f00d3d90 i4: f01654b8 i5: f0178440 fp: fa9e7f08 i7: f004a624
Caller[f004a624]
Caller[f0011184]
Caller[00012f58]
Instruction DUMP: b0102000  c600e010  852be002 <f000c002> 80a62000  02800006  82062014  84102001  8810000f 


>>PC;  f004b46c <fget+24/4c>   <=====

>>g0; fa9e7ea0 <end+a8272c0/e141420>
>>g1; fffffffd <END_OF_CODE+1c79b46/????>
>>g3; 9de3bf98 Before first symbol
>>g5; 30000000 Before first symbol
>>g6; fa9e6000 <end+a825420/e141420>
>>g7; ff000000 <END_OF_CODE+c79b49/????>
>>o0; a4400010 Before first symbol
>>o1; fd011000 <end+ce50420/e141420>
>>o2; fd011000 <end+ce50420/e141420>
>>o3; 00000800 Before first symbol
>>sp; fa9e7ea0 <end+a8272c0/e141420>
>>l0; 1e800fa7 Before first symbol
>>l1; f0012e00 <handler_irq+d4/d8>
>>l2; f00106c4 <patch_handler_irq+8/24>
>>l6; fb6b4fc0 <end+b4f43e0/e141420>
>>i3; f00d3d90 <esp_intr+0/7c>
>>i4; f01654b8 <current_set+0/4>
>>i5; f0178440 <sun4m_init+2ec/328>
>>fp; fa9e7f08 <end+a827328/e141420>
>>i7; f004a624 <sys_write+4/14c>

Trace; f004a624 <sys_write+4/14c>
Trace; f0011184 <syscall_is_too_hard+34/40>
Trace; 00012f58 Before first symbol

Code;  f004b460 <fget+18/4c>
00000000 <_PC>:
Code;  f004b460 <fget+18/4c>
   0:   b0 10 20 00       clr  %i0
Code;  f004b464 <fget+1c/4c>
   4:   c6 00 e0 10       ld  [ %g3 + 0x10 ], %g3
Code;  f004b468 <fget+20/4c>
   8:   85 2b e0 02       sll  %o7, 2, %g2
Code;  f004b46c <fget+24/4c>   <=====
   c:   f0 00 c0 02       ld  [ %g3 + %g2 ], %i0   <=====
Code;  f004b470 <fget+28/4c>
  10:   80 a6 20 00       cmp  %i0, 0
Code;  f004b474 <fget+2c/4c>
  14:   02 80 00 06       be  2c <_PC+0x2c> f004b48c <fget+44/4c>
Code;  f004b478 <fget+30/4c>
  18:   82 06 20 14       add  %i0, 0x14, %g1
Code;  f004b47c <fget+34/4c>
  1c:   84 10 20 01       mov  1, %g2
Code;  f004b480 <fget+38/4c>
  20:   88 10 00 0f       mov  %o7, %g4

Unable to handle kernel NULL pointer dereference in mna handler<1> at virtual address 00000007
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
dd(3863): Oops
PSR: 1e0000c2 PC: f00812a0 NPC: f00812a4 Y: 00000000    Not tainted
g0: 00000000 g1: f152888c g2: 00000000 g3: 1e1000e6 g4: f0048878 g5: 53545556 g6: fa9e6000 g7: 00000001
o0: 00000001 o1: 00000007 o2: 00000007 o3: f0166074 o4: 00000000 o5: f019dc00 sp: fa9e78c0 o7: f00745e0
l0: 0000003f l1: 00000007 l2: f0080b9c l3: 00000020 l4: 00000040 l5: 00000000 l6: fa9e6000 l7: 00000000
i0: fbc1de00 i1: 00000001 i2: f0143400 i3: fbc6c400 i4: f004b46c i5: f0173ecc fp: fa9e7928 i7: f007ab0c
Caller[f007ab0c]
Caller[f0060e18]
Caller[f003cb3c]
Caller[f0074e48]
Caller[f002e2d8]
Caller[f002e31c]
Caller[f0029ac0]
Caller[f001239c]
Caller[f001c610]
Caller[f001c9b4]
Caller[f0010e24]
Caller[00000001]
Caller[f004a624]
Caller[f0011184]
Caller[00012f58]
Instruction DUMP: 80a46000  0280001c  01000000 <d0044000> d2020000  80a24018  02800012  213c0515  a0142370 


>>PC;  f00812a0 <journal_start+28/e0>   <=====

>>g1; f152888c <end+1367cac/e141420>
>>g3; 1e1000e6 Before first symbol
>>g4; f0048878 <vfs_statfs+44/58>
>>g5; 53545556 Before first symbol
>>g6; fa9e6000 <end+a825420/e141420>
>>o3; f0166074 <console_printk+0/10>
>>o5; f019dc00 <log_buf+3dc8/4000>
>>sp; fa9e78c0 <end+a826ce0/e141420>
>>o7; f00745e0 <ext3_group_sparse+d0/10c>
>>l2; f0080b9c <ext3_statfs+6c/2dc>
>>l6; fa9e6000 <end+a825420/e141420>
>>i0; fbc1de00 <end+ba5d220/e141420>
>>i2; f0143400 <Unused_offset+40b0/947c>
>>i3; fbc6c400 <end+baab820/e141420>
>>i4; f004b46c <fget+24/4c>
>>i5; f0173ecc <__copy_user_end+0/0>
>>fp; fa9e7928 <end+a826d48/e141420>
>>i7; f007ab0c <ext3_dirty_inode+54/108>

Trace; f007ab0c <ext3_dirty_inode+54/108>
Trace; f0060e18 <__mark_inode_dirty+3c/ac>
Trace; f003cb3c <generic_file_write+3b8/8c4>
Trace; f0074e48 <ext3_file_write+18/d4>
Trace; f002e2d8 <do_acct_process+1f8/210>
Trace; f002e31c <acct_process+2c/44>
Trace; f0029ac0 <do_exit+78/320>
Trace; f001239c <die_if_kernel+104/114>
Trace; f001c610 <unhandled_fault+90/98>
Trace; f001c9b4 <do_sparc_fault+2d4/3f0>
Trace; f0010e24 <srmmu_fault+58/68>
Trace; 00000001 Before first symbol
Trace; f004a624 <sys_write+4/14c>
Trace; f0011184 <syscall_is_too_hard+34/40>
Trace; 00012f58 Before first symbol

Code;  f0081294 <journal_start+1c/e0>
00000000 <_PC>:
Code;  f0081294 <journal_start+1c/e0>
   0:   80 a4 60 00       cmp  %l1, 0
Code;  f0081298 <journal_start+20/e0>
   4:   02 80 00 1c       be  74 <_PC+0x74> f0081308 <journal_start+90/e0>
Code;  f008129c <journal_start+24/e0>
   8:   01 00 00 00       nop 
Code;  f00812a0 <journal_start+28/e0>   <=====
   c:   d0 04 40 00       ld  [ %l1 ], %o0   <=====
Code;  f00812a4 <journal_start+2c/e0>
  10:   d2 02 00 00       ld  [ %o0 ], %o1
Code;  f00812a8 <journal_start+30/e0>
  14:   80 a2 40 18       cmp  %o1, %i0
Code;  f00812ac <journal_start+34/e0>
  18:   02 80 00 12       be  60 <_PC+0x60> f00812f4 <journal_start+7c/e0>
Code;  f00812b0 <journal_start+38/e0>
  1c:   21 3c 05 15       sethi  %hi(0xf0145400), %l0
Code;  f00812b4 <journal_start+3c/e0>
  20:   a0 14 23 70       or  %l0, 0x370, %l0  ! f0145770 <_PC+0xf0145770> e01c6a04 Before first symbol


1 warning issued.  Results may not be reliable.
