Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313380AbSDJRlA>; Wed, 10 Apr 2002 13:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313384AbSDJRk7>; Wed, 10 Apr 2002 13:40:59 -0400
Received: from ciani.phy.uic.edu ([131.193.191.66]:896 "EHLO ciani.phy.uic.edu")
	by vger.kernel.org with ESMTP id <S313380AbSDJRk5>;
	Wed, 10 Apr 2002 13:40:57 -0400
Date: Wed, 10 Apr 2002 12:40:56 -0500 (CDT)
From: "Anthony J. Ciani" <tony@ciani.phy.uic.edu>
To: linux-kernel@vger.kernel.org
Subject: 2.4.16 & 2.4.18, kswapd invalid operand
Message-ID: <Pine.LNX.4.21.0204101234560.1001-100000@ciani.phy.uic.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kswapd causing invalid operand 0000 on K6-II with kernels 2.4.16 & 2.4.18.
BUG() reports vmscan line 358.

Something to do with LRU's.

The machine has been crashing after heavy network load (not data
transfered, but number of opened and closed connections).  The last crash
was after somebody tried to ftp in as a non-existent user some 150 times. 
The manner of the crash is different between 2.4.16 and 2.4.18,
but the cause seems to be the same.  With 2.4.18 all programs would
terminate (or segfault) and no new programs could be started (or users log
on).  With 2.4.16 the machine simply freezes on the terminal, although ssh
still connects, no users can log on.

At first I thought that the new memory manager in 2.4.18 was at fault and
downgraded to 2.4.16, but the same error seems to occur, although it seems
more stable.

I am running a stock kernel 2.4.16 on a K6-II/450.  The motherboard is a
Tekram P5T30-B4.  I am using the onboard IDE controller for the primary
drive, and a Promise Ultra66 for a second drive.  Both use ext2, and a dos
partition is also mounted. The sound card is a Sound Blaster PnP / AWE
32.  Networking card is a 3c509.

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 5
model		: 8
model name	: AMD-K6(tm) 3D processor
stepping	: 12
cpu MHz		: 450.009
cache size	: 64 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow k6_mtrr
bogomips	: 897.84

3c509                   7744   1 (autoclean)
vfat                    9224   4 (autoclean)
fat                    28920   0 (autoclean) [vfat]
awe_wave              155476   0
sb                      9732   0
sb_lib                 32580   0 [sb]
uart401                 6092   0 [sb_lib]
sound                  53080   0 [awe_wave sb_lib uart401]
soundcore               3652   6 [sb_lib sound]

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0213-0213 : isapnp read
0220-022f : soundblaster
0300-030f : 3c509
0330-0333 : MPU-401 UART
0376-0376 : ide1
03c0-03df : vga+
03e8-03ef : serial(auto)
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0620-0623 : sound driver (AWE32)
0a20-0a23 : sound driver (AWE32)
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
0e20-0e23 : sound driver (AWE32)
5800-583f : Intel Corp. 82371AB PIIX4 ACPI
5c00-5c1f : Intel Corp. 82371AB PIIX4 ACPI
6000-601f : Intel Corp. 82371AB PIIX4 USB
6400-64ff : ATI Technologies Inc 3D Rage I/II 215GT [Mach64 GT]
6800-6807 : Promise Technology, Inc. 20262
  6800-6807 : ide2
6c00-6c03 : Promise Technology, Inc. 20262
  6c02-6c02 : ide2
7000-7007 : Promise Technology, Inc. 20262
7400-7403 : Promise Technology, Inc. 20262
7800-783f : Promise Technology, Inc. 20262
  7800-7807 : ide2
  7808-780f : ide3
  7810-783f : PDC20262
f000-f00f : Intel Corp. 82371AB PIIX4 IDE
  f000-f007 : ide0
  f008-f00f : ide1

00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000cd7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-0fffffff : System RAM
  00100000-001bc10f : Kernel code
  001bc110-001f3323 : Kernel data
e0000000-e0ffffff : ATI Technologies Inc 3D Rage I/II 215GT [Mach64 GT]
e1000000-e101ffff : Promise Technology, Inc. 20262
e1020000-e1020fff : ATI Technologies Inc 3D Rage I/II 215GT [Mach64 GT]
ffff0000-ffffffff : reserved

The ksymoops output follows below for both kernel versions.

Stock 2.4.18

Mar 11 17:15:48 ciani kernel: invalid operand: 0000
Mar 11 17:15:48 ciani kernel: CPU:    0
Mar 11 17:15:48 ciani kernel: EIP:    0010:[shrink_cache+146/728]    Not tainted
Mar 11 17:15:48 ciani kernel: EFLAGS: 00010246
Mar 11 17:15:48 ciani kernel: eax: 00000008   ebx: 00000000   ecx: c119e79c   edx: c01e6d08
Mar 11 17:15:48 ciani kernel: esi: c119e780   edi: 0000001e   ebp: 00004ba9   esp: c14e3f54
Mar 11 17:15:48 ciani kernel: ds: 0018   es: 0018   ss: 0018
Mar 11 17:15:48 ciani kernel: Process kswapd (pid: 4, stackpage=c14e3000)
Mar 11 17:15:48 ciani kernel: Stack: 0000001e 000001d0 0000001e 00000002 00000002 c14e2000 00000784 000001d0 
Mar 11 17:15:48 ciani kernel:        c01e6d08 c0126741 00000002 00000007 00000002 000001d0 c01e6d08 00000000 
Mar 11 17:15:48 ciani kernel:        c01e6d08 c01267a2 0000001e c01e6d08 00000001 c14e2000 c0126833 c01e6c60 
Mar 11 17:15:48 ciani kernel: Call Trace: [shrink_caches+93/140] [try_to_free_pages+50/80] [kswapd_balance_pgdat+67/140] [kswapd_balance+18/40] [kswapd+153/188] 
Mar 11 17:15:48 ciani kernel: Code: 0f 0b 8b 41 fc a8 80 74 02 0f 0b 8b 01 8b 51 04 89 50 04 89 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   8b 41 fc                  mov    0xfffffffc(%ecx),%eax
Code;  00000005 Before first symbol
   5:   a8 80                     test   $0x80,%al
Code;  00000007 Before first symbol
   7:   74 02                     je     b <_EIP+0xb> 0000000b Before first symbol
Code;  00000009 Before first symbol
   9:   0f 0b                     ud2a   
Code;  0000000b Before first symbol
   b:   8b 01                     mov    (%ecx),%eax
Code;  0000000d Before first symbol
   d:   8b 51 04                  mov    0x4(%ecx),%edx
Code;  00000010 Before first symbol
  10:   89 50 04                  mov    %edx,0x4(%eax)
Code;  00000013 Before first symbol
  13:   89 00                     mov    %eax,(%eax)

----------------------------------------------------------------------------
Another from 2.4.18

Mar 11 17:15:54 ciani kernel:  invalid operand: 0000
Mar 11 17:15:54 ciani kernel: CPU:    0
Mar 11 17:15:54 ciani kernel: EIP:    0010:[shrink_cache+146/728]    Not tainted
Mar 11 17:15:54 ciani kernel: EFLAGS: 00010246
Mar 11 17:15:54 ciani kernel: eax: 00000008   ebx: 00000000   ecx: c119e79c   edx: ce84e000
Mar 11 17:15:54 ciani kernel: esi: c119e780   edi: 0000001f   ebp: 00001a25   esp: ce84fd24
Mar 11 17:15:54 ciani kernel: ds: 0018   es: 0018   ss: 0018
Mar 11 17:15:54 ciani kernel: Process grep (pid: 23105, stackpage=ce84f000)
Mar 11 17:15:54 ciani kernel: Stack: 00000020 000001d2 00000020 00000006 00000006 ce84e000 00000200 000001d2 
Mar 11 17:15:54 ciani kernel:        c01e6d08 c0126741 00000006 00000007 00000006 000001d2 c01e6d08 c01e6d08 
Mar 11 17:15:54 ciani kernel:        c01e6d08 c01267a2 00000020 ce84e000 00000120 00000000 c0126fbe c01e6e84 
Mar 11 17:15:54 ciani kernel: Call Trace: [shrink_caches+93/140] [try_to_free_pages+50/80] [balance_classzone+78/372] [rs_interrupt_single+114/136] [__alloc_pages+252/348] 
Mar 11 17:15:54 ciani kernel: Code: 0f 0b 8b 41 fc a8 80 74 02 0f 0b 8b 01 8b 51 04 89 50 04 89 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   8b 41 fc                  mov    0xfffffffc(%ecx),%eax
Code;  00000005 Before first symbol
   5:   a8 80                     test   $0x80,%al
Code;  00000007 Before first symbol
   7:   74 02                     je     b <_EIP+0xb> 0000000b Before first symbol
Code;  00000009 Before first symbol
   9:   0f 0b                     ud2a   
Code;  0000000b Before first symbol
   b:   8b 01                     mov    (%ecx),%eax
Code;  0000000d Before first symbol
   d:   8b 51 04                  mov    0x4(%ecx),%edx
Code;  00000010 Before first symbol
  10:   89 50 04                  mov    %edx,0x4(%eax)
Code;  00000013 Before first symbol
  13:   89 00                     mov    %eax,(%eax)

Mar 11 17:15:54 ciani kernel:  invalid operand: 0000
Mar 11 17:15:54 ciani kernel: CPU:    0
Mar 11 17:15:54 ciani kernel: EIP:    0010:[shrink_cache+146/728]    Not tainted
Mar 11 17:15:54 ciani kernel: EFLAGS: 00010246
Mar 11 17:15:54 ciani kernel: eax: 00000008   ebx: 00000000   ecx: c119e79c   edx: 00000200
Mar 11 17:15:54 ciani kernel: esi: c119e780   edi: 00000020   ebp: 00001a27   esp: ce84fe98
Mar 11 17:15:54 ciani kernel: ds: 0018   es: 0018   ss: 0018
Mar 11 17:15:54 ciani kernel: Process grep (pid: 23106, stackpage=ce84f000)
Mar 11 17:15:54 ciani kernel: Stack: 00000020 000001d2 00000020 00000006 00000006 ce84e000 00000200 000001d2 


----------------------------------------------------------------------------
Stock 2.4.16

Mar 13 15:37:02 ciani kernel: invalid operand: 0000
Mar 13 15:37:02 ciani kernel: CPU:    0
Mar 13 15:37:02 ciani kernel: EIP:    0010:[shrink_cache+130/708]    Not tainted
Mar 13 15:37:02 ciani kernel: EFLAGS: 00010246
Mar 13 15:37:02 ciani kernel: eax: 00000008   ebx: 00000000   ecx: c12c4cdc   edx: c12c4cc0
Mar 13 15:37:02 ciani kernel: esi: c12c4cc0   edi: 00000012   ebp: 000020a1   esp: c14e5f54
Mar 13 15:37:02 ciani kernel: ds: 0018   es: 0018   ss: 0018
Mar 13 15:37:02 ciani kernel: Process kswapd (pid: 4, stackpage=c14e5000)
Mar 13 15:37:02 ciani kernel: Stack: 00000020 000001d0 00000020 00000006 00000006 c14e4000 00000100 000001d0 
Mar 13 15:37:02 ciani kernel:        c01e51a8 c01279f1 00000006 00000002 00000006 000001d0 c01e51a8 00000000 
Mar 13 15:37:02 ciani kernel:        c01e51a8 c0127a3d 00000020 c01e51a8 00000001 c14e4000 c0127ad3 c01e5100 
Mar 13 15:37:02 ciani kernel: Call Trace: [shrink_caches+93/140] [try_to_free_pages+29/60] [kswapd_balance_pgdat+67/140] [kswapd_balance+18/40] [kswapd+153/188] 
Mar 13 15:37:02 ciani kernel: Code: 0f 0b 8b 41 fc a8 80 74 02 0f 0b 8b 01 8b 51 04 89 50 04 89 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   8b 41 fc                  mov    0xfffffffc(%ecx),%eax
Code;  00000005 Before first symbol
   5:   a8 80                     test   $0x80,%al
Code;  00000007 Before first symbol
   7:   74 02                     je     b <_EIP+0xb> 0000000b Before first symbol
Code;  00000009 Before first symbol
   9:   0f 0b                     ud2a   
Code;  0000000b Before first symbol
   b:   8b 01                     mov    (%ecx),%eax
Code;  0000000d Before first symbol
   d:   8b 51 04                  mov    0x4(%ecx),%edx
Code;  00000010 Before first symbol
  10:   89 50 04                  mov    %edx,0x4(%eax)
Code;  00000013 Before first symbol
  13:   89 00                     mov    %eax,(%eax)

Mar 13 15:37:03 ciani kernel:  invalid operand: 0000

-- 
------------------------------------------------------------
              Anthony Ciani (aciani1@uic.edu)
             Computational Solid State Physics
   Department of Physics, University of Illinois, Chicago
              http://ciani.phy.uic.edu/~tony
------------------------------------------------------------


