Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267208AbTA0Pbq>; Mon, 27 Jan 2003 10:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267216AbTA0Pbq>; Mon, 27 Jan 2003 10:31:46 -0500
Received: from tao.natur.cuni.cz ([195.113.56.1]:57360 "EHLO tao.natur.cuni.cz")
	by vger.kernel.org with ESMTP id <S267208AbTA0Pbn>;
	Mon, 27 Jan 2003 10:31:43 -0500
X-Obalka-From: mmokrejs@natur.cuni.cz
X-Obalka-To: <linux-kernel@vger.kernel.org>
Date: Mon, 27 Jan 2003 16:41:00 +0100 (CET)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre3 kernel crash
Message-ID: <Pine.OSF.4.51.0301271632230.49659@tao.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  yesterday I've hit a bug on my laptopo ASUS L3800C ;)
with linux kernel 2.4.21-pre3. I think the crash is related to my tunes
with hdparm() (enabling 32bit, enabling DMA, enabling udma5), but I'm not
sure, although I could check, if someone asks. Currently, I can 100%
reproduce the bug (i.e. cannot boot with that kernel).

  The crash I actually observe while booting. One of the init scripts starts up also
network and adds default gateway. That's where it crashes. Please Cc: me
in replies.

# ksymoops -K -o /lib/modules/2.4.21-pre3/ -m /boot/System.map-2.4.21-pre3 kernel.crash
ksymoops 2.4.8 on i686 2.4.19-gentoo-r10.  Options used
     -V (default)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-pre3/ (specified)
     -m /boot/System.map-2.4.21-pre3 (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Kernel BUG at panic.c: 141!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c011a3e7>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000026   ebx: 00000000     ecx: 00000001       edx: 00000001
esi: c03e5920   edi: 00001000     ebp: 00000000       esp: f764fbf0
ds: 0018        es: 0018       ss: 0018
Process runscript.sh (pid: 1038, stackpage=f764f000)
Stack: c02fee40 0000009b c024dfc1 0000009b 00000000 00000014 00000014 00000001
       f7e32000 f7e35000 c03e59d0 00000000 c03e5920 c024e1b4 c03e5920 f7e2d700
       00000002 f79f6c80 00000000 c03e5920 c03e5920 c03e59d0 f7e2d700 c03e5920
Call trace: [<c024dfc1>] [<c024e1b4>] [<c024e6df>] [<c024a11d>] [<c01b2380>]
[<c023fc5e>] [<c01b2380>] [<c0248d71>] [<c0248eeb>] [<c024902a>] [<c021b186>]
[<c011f3ca>] [<c013f5bf>] [<c012c41d>] [<c012ccde>] [<c012d0d0>] [<c012d258>]
[<c012d0d0>] [<c0143312>] [<c01437a6>] [<c0143cb5>] [<c0105cc0>] [<c010744f>]
Code: 0f 0b 8d 00 5f fb 2f c0 90 eb fe 90 90 90 90 90 90 90 90 90


>>EIP; c011a3e7 <__out_of_line_bug+17/30>   <=====

>>esi; c03e5920 <ide_hwifs+0/2af8>

Trace; c024dfc1 <ide_build_sglist+181/1a0>
Trace; c024e1b4 <ide_build_dmatable+54/1a0>
Trace; c024e6df <__ide_dma_read+3f/150>
Trace; c024a11d <do_rw_disk+1ed/740>
Trace; c01b2380 <reiserfs_find_actor+0/20>
Trace; c023fc5e <ide_wait_stat+fe/140>
Trace; c01b2380 <reiserfs_find_actor+0/20>
Trace; c0248d71 <start_request+1c1/240>
Trace; c0248eeb <ide_do_request+ab/1a0>
Trace; c024902a <do_ide_request+1a/20>
Trace; c021b186 <generic_unplug_device+36/40>
Trace; c011f3ca <__run_task_queue+5a/70>
Trace; c013f5bf <block_sync_page+1f/30>
Trace; c012c41d <___wait_on_page+bd/c0>
Trace; c012ccde <do_generic_file_read+2fe/450>
Trace; c012d0d0 <file_read_actor+0/e0>
Trace; c012d258 <generic_file_read+a8/150>
Trace; c012d0d0 <file_read_actor+0/e0>
Trace; c0143312 <kernel_read+72/80>
Trace; c01437a6 <prepare_binprm+136/150>
Trace; c0143cb5 <do_execve+e5/220>
Trace; c0105cc0 <sys_execve+50/80>
Trace; c010744f <system_call+33/38>

Code;  c011a3e7 <__out_of_line_bug+17/30>
00000000 <_EIP>:
Code;  c011a3e7 <__out_of_line_bug+17/30>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c011a3e9 <__out_of_line_bug+19/30>
   2:   8d 00                     lea    (%eax),%eax
Code;  c011a3eb <__out_of_line_bug+1b/30>
   4:   5f                        pop    %edi
Code;  c011a3ec <__out_of_line_bug+1c/30>
   5:   fb                        sti
Code;  c011a3ed <__out_of_line_bug+1d/30>
   6:   2f                        das
Code;  c011a3ee <__out_of_line_bug+1e/30>
   7:   c0 90 eb fe 90 90 90      rclb   $0x90,0x9090feeb(%eax)
Code;  c011a3f5 <__out_of_line_bug+25/30>
   e:   90                        nop
Code;  c011a3f6 <__out_of_line_bug+26/30>
   f:   90                        nop
Code;  c011a3f7 <__out_of_line_bug+27/30>
  10:   90                        nop
Code;  c011a3f8 <__out_of_line_bug+28/30>
  11:   90                        nop
Code;  c011a3f9 <__out_of_line_bug+29/30>
  12:   90                        nop
Code;  c011a3fa <__out_of_line_bug+2a/30>
  13:   90                        nop

-- 
Martin Mokrejs <mmokrejs@natur.cuni.cz>, <m.mokrejs@gsf.de>
PGP5.0i key is at http://www.natur.cuni.cz/~mmokrejs
MIPS / Institute for Bioinformatics <http://mips.gsf.de>
GSF - National Research Center for Environment and Health
Ingolstaedter Landstrasse 1, D-85764 Neuherberg, Germany
tel.: +49-89-3187 3683 , fax: +49-89-3187 3585
