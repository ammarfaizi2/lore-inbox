Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280872AbRKTOcu>; Tue, 20 Nov 2001 09:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281080AbRKTOck>; Tue, 20 Nov 2001 09:32:40 -0500
Received: from smtp-2u-1.atlantic.net ([209.208.25.2]:21508 "EHLO
	smtp-2u-1.atlantic.net") by vger.kernel.org with ESMTP
	id <S280872AbRKTOc0>; Tue, 20 Nov 2001 09:32:26 -0500
Date: Tue, 20 Nov 2001 09:32:21 -0500 (EST)
From: Burton Windle <bwindle@fint.org>
To: linux-kernel@vger.kernel.org
cc: andre@linux-ide.org
Subject: Oops: 2.4.15-pre6 in write_intr (ide related?)
Message-ID: <Pine.LNX.4.21.0111200927470.20883-100000@grub.atlantic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got this oops on a PPro200 with 32mb ram running 2.4.15-pre6. I was
doing some memory stress testing (using perl).

Decoded and raw oops follows:

logger:~# ksymoops -m /usr/src/linux/System.map < oooops
ksymoops 2.4.3 on i686 2.4.15-pre6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.15-pre6/ (default)
     -m /usr/src/linux/System.map (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod
file?
Unable to handle kernel NULL pointer dereference at virtual address
00000020
c01c4cc1
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01c4cc1>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000050   ebx: c02db020   ecx: 00000058   edx: 00000158
esi: 00000000   edi: c02db020   ebp: c10ef064   esp: c027df34
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c027d000)
Stack: c02db020 c10ef064 00000296 c02dafe0 c01bd987 c02db020 c108476c
04000001
       0000000e c027dfa8 c01c4c70 c0107d1f 0000000e c10ef064 c027dfa8
000001c0
       c02b2ac0 0000000e c027dfa0 c0107e86 0000000e c027dfa8 c108476c
c0105150
Call Trace: [<c01bd987>] [<c01c4c70>] [<c0107d1f>] [<c0107e86>]
[<c0105150>]
   [<c0105150>] [<c0105150>] [<c0105150>] [<c0105173>] [<c01051d9>]
[<c0105000>]
   [<c0105027>]
Code: 83 7e 20 01 0f 94 c0 0f b6 c0 f6 c1 08 74 10 85 c0 74 14 e9

>>EIP; c01c4cc0 <write_intr+50/128>   <=====
Trace; c01bd986 <ide_intr+fa/150>
Trace; c01c4c70 <write_intr+0/128>
Trace; c0107d1e <handle_IRQ_event+2e/58>
Trace; c0107e86 <do_IRQ+6a/a8>
Trace; c0105150 <default_idle+0/28>
Trace; c0105150 <default_idle+0/28>
Trace; c0105150 <default_idle+0/28>
Trace; c0105150 <default_idle+0/28>
Trace; c0105172 <default_idle+22/28>
Trace; c01051d8 <cpu_idle+40/54>
Trace; c0105000 <_stext+0/0>
Trace; c0105026 <rest_init+26/28>
Code;  c01c4cc0 <write_intr+50/128>
00000000 <_EIP>:
Code;  c01c4cc0 <write_intr+50/128>   <=====
   0:   83 7e 20 01               cmpl   $0x1,0x20(%esi)   <=====
Code;  c01c4cc4 <write_intr+54/128>
   4:   0f 94 c0                  sete   %al
Code;  c01c4cc6 <write_intr+56/128>
   7:   0f b6 c0                  movzbl %al,%eax
Code;  c01c4cca <write_intr+5a/128>
   a:   f6 c1 08                  test   $0x8,%cl
Code;  c01c4ccc <write_intr+5c/128>
   d:   74 10                     je     1f <_EIP+0x1f> c01c4cde
<write_intr+6e/128>
Code;  c01c4cce <write_intr+5e/128>
   f:   85 c0                     test   %eax,%eax
Code;  c01c4cd0 <write_intr+60/128>
  11:   74 14                     je     27 <_EIP+0x27> c01c4ce6
<write_intr+76/128>
Code;  c01c4cd2 <write_intr+62/128>
  13:   e9 00 00 00 00            jmp    18 <_EIP+0x18> c01c4cd8
<write_intr+68/128>

 <0>Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.



Raw oops:

EXT3-fs: mounted filesystem with ordered data mode.
Out of Memory: Killed process 26068 (perl).
Out of Memory: Killed process 26068 (perl).
Out of Memory: Killed process 26068 (perl).
Out of Memory: Killed process 26073 (perl).
Out of Memory: Killed process 26073 (perl).
end_request: buffer-list destroyed
hda6: bad access: block=15544, count=-8
end_request: I/O error, dev 03:06 (hda), sector 15544
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hda: drive not ready for command
hda: status timeout: status=0xd0 { Busy }
hda: drive not ready for command
ide0: reset: success
Unable to handle kernel NULL pointer dereference at virtual address
00000020
 printing eip:
c01c4cc1
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01c4cc1>]    Not tainted
EFLAGS: 00010046
eax: 00000050   ebx: c02db020   ecx: 00000058   edx: 00000158
esi: 00000000   edi: c02db020   ebp: c10ef064   esp: c027df34
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c027d000)
Stack: c02db020 c10ef064 00000296 c02dafe0 c01bd987 c02db020 c108476c
04000001
       0000000e c027dfa8 c01c4c70 c0107d1f 0000000e c10ef064 c027dfa8
000001c0
       c02b2ac0 0000000e c027dfa0 c0107e86 0000000e c027dfa8 c108476c
c0105150
Call Trace: [<c01bd987>] [<c01c4c70>] [<c0107d1f>] [<c0107e86>]
[<c0105150>]
   [<c0105150>] [<c0105150>] [<c0105150>] [<c0105173>] [<c01051d9>]
[<c0105000>]

   [<c0105027>]

Code: 83 7e 20 01 0f 94 c0 0f b6 c0 f6 c1 08 74 10 85 c0 74 14 e9
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

--
Burton Windle                           burton@fint.org
Linux: the "grim reaper of innocent orphaned children."
          from /usr/src/linux-2.4.0/init/main.c:655

