Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314375AbSD2SOx>; Mon, 29 Apr 2002 14:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314502AbSD2SOx>; Mon, 29 Apr 2002 14:14:53 -0400
Received: from smtp1.xs4all.be ([195.144.64.135]:63389 "EHLO smtp1.xs4all.be")
	by vger.kernel.org with ESMTP id <S314375AbSD2SOv>;
	Mon, 29 Apr 2002 14:14:51 -0400
Date: Mon, 29 Apr 2002 20:14:45 +0200
From: frank@gevaerts.be
To: linux-kernel@vger.kernel.org
Subject: Sparc32 oops in chmod (2.2.20 SMP)
Message-ID: <20020429201445.A431@gevaerts.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-flash-is-evil: do not use it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm having some problems with my dual SparcServer 20. While
doing a chmod() in /dev (while booting), it gives the following oops.
The strange thing is : if I boot with console=/dev/ttyS1 ,
with /dev/console being a symlink to /dev/ttyS0, the oops doesn't
happen (but I don't get kernel messages, not even on ttyS1)
The kernel was compiled with 2.95.2 (debian potato).
This oops is 100% reproducible.
I also get semi-random lockups (probably) during disk-io. 

I had (probably) the same problem with 2.2.14.

Frank


ksymoops 2.3.4 on sparc 2.2.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.20/ (default)
     -m /boot/System.map-2.2.20 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Warning (compare_maps): ksyms_base symbol module_list_R__ver_module_list not found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference<1>tsk->mm->context = 00000059
tsk->mm->pgd = f7bb3000
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
chmod(97): Oops
PSR: 401000c4 PC: f005d51c NPC: f005d520 Y: 1b000000
Using defaults from ksymoops -t elf32-sparc -a sparc
g0: f007a4f8 g1: f03c49b0 g2: 00000000 g3: 000000a0 g4: f004de20 g5: f01b8265 g6: f798a000 g7: 00000014
o0: 00000000 o1: 00000900 o2: 00001000 o3: 000000c9 o4: f7e25600 o5: 00000014 sp: f798bc18 o7: f0079c94
l0: 00000000 l1: f7e25600 l2: 00000000 l3: f0409b3c l4: 00000008 l5: f01b8265 l6: f798a000 l7: f0052a84
i0: 00000000 i1: 000242ab i2: f01f3cd8 i3: 00000000 i4: 00000000 i5: 0000b700 fp: f798bc80 i7: f005d974
Caller[f005d974]
Caller[f005d9d8]
Caller[f007bb38]
Caller[f0055230]
Caller[f0055638]
Caller[f0055744]
Caller[f0052ab8]
Caller[f00154bc]
Caller[f00c36b4]
Instruction DUMP: 02800017  b0102000  b0100010 <d0062068> 80a20011  32bffffa  e0040000  d0062018  80a20019

>>PC;  f005d51c <find_inode+20/78>   <=====
>>O7;  f0079c94 <inode_getblk+68/294>
>>I7;  f005d974 <iget4+50/a4>
Trace; f005d974 <iget4+50/a4>
Trace; f005d9d8 <iget+10/20>
Trace; f007bb38 <ext2_lookup+78/ac>
Trace; f0055230 <real_lookup+6c/100>
Trace; f0055638 <lookup_dentry+2ac/398>
Trace; f0055744 <__namei+20/68>
Trace; f0052ab8 <sys_newlstat+34/c8>
Trace; f00154bc <syscall_is_too_hard+34/40>
Trace; f00c36b4 <nlm_lookup_file+18c/248>
Code;  f005d510 <find_inode+14/78>
0000000000000000 <_PC>:
Code;  f005d510 <find_inode+14/78>
   0:   02 80 00 17       be  5c <_PC+0x5c> f005d56c <find_inode+70/78>
Code;  f005d514 <find_inode+18/78>
   4:   b0 10 20 00       clr  %i0
Code;  f005d518 <find_inode+1c/78>
   8:   b0 10 00 10       mov  %l0, %i0
Code;  f005d51c <find_inode+20/78>   <=====
   c:   d0 06 20 68       ld  [ %i0 + 0x68 ], %o0   <=====
Code;  f005d520 <find_inode+24/78>
  10:   80 a2 00 11       cmp  %o0, %l1
Code;  f005d524 <find_inode+28/78>
  14:   32 bf ff fa       bne,a   fffffffffffffffc <_PC+0xfffffffffffffffc> f005d50c <find_inode+10/78>
Code;  f005d528 <find_inode+2c/78>
  18:   e0 04 00 00       ld  [ %l0 ], %l0
Code;  f005d52c <find_inode+30/78>
  1c:   d0 06 20 18       ld  [ %i0 + 0x18 ], %o0
Code;  f005d530 <find_inode+34/78>
  20:   80 a2 00 19       cmp  %o0, %i1


3 warnings issued.  Results may not be reliable.
