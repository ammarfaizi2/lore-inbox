Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263334AbUDPXbv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 19:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263950AbUDPXbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 19:31:45 -0400
Received: from dip-220-235-63-55.wa.westnet.com.au ([220.235.63.55]:43538 "EHLO
	fw.computerdatasafe.com.au") by vger.kernel.org with ESMTP
	id S263227AbUDPXbV (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 19:31:21 -0400
From: John Summerfield <spam@computerdatasafe.com.au>
To: Linux-Kernel@vger.kernel.org
Subject: Unable to handle kernel paging request at virtual address 6e65704f 
Date: Sat, 17 Apr 2004 07:31:10 +0800
User-Agent: KMail/1.5.3
Organization: Computer Datasafe
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200404170731.10807.spam@computerdatasafe.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not at all sure that I have this entirely straight.

The problem.
I get very many segfaults and oopses. I suspect there is a problem in the 
hardware, but before I scrap the system I'd like someone who can 
authoratatively distinguish between bad hardware and bad software has a look 
to see whether they can diagnose the problem.

If the hardware's bad, then at least it's good enough to run long enough to do 
useful testing, and bad enough to fail often enough to be really useful for 
testing error recovery: I get serious failures (requiring reset) every few 
days, less serious ones (segfaults) more often:
Bilby:~# dmesg | ksymoops -k /proc/kallsyms  -v /boot/vmlinuz-2.6.3-1-686 -m 
/boot/System.map-2.6.3-1-686  >/tmp/oops1 2>&1
Segmentation fault
Bilby:~# dmesg | ksymoops -k /proc/kallsyms  -v /boot/vmlinuz-2.6.3-1-686 -m 
/boot/System.map-2.6.3-1-686  >/tmp/oops1 2>&1
Segmentation fault
Bilby:~# dmesg | ksymoops -k /proc/kallsyms  -v /boot/vmlinuz-2.6.3-1-686 -m 
/boot/System.map-2.6.3-1-686  >/tmp/oops1 2>&1
Bilby:~# 



The environment.

I'm running Debian/Sarge in a Pentum III system:
Bilby:~# uname -a
Linux Bilby 2.6.3-1-686 #2 Tue Feb 24 20:24:38 EST 2004 i686 GNU/Linux
Bilby:~# 

This is a standard Debian kernel.

I get similar problems with all the other Debian kernels I've tried, including 
some 2.4.x.

Bilby:~# lspci -v 
0000:00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge 
(rev 03)
        Flags: bus master, medium devsel, latency 64
        Memory at f8000000 (32-bit, prefetchable)
        Capabilities: [a0] AGP version 1.0

0000:00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge 
(rev 03) (prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, medium devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64

0000:00:0d.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 
26)
        Subsystem: LSI Logic / Symbios Logic: Unknown device 1000
        Flags: bus master, medium devsel, latency 72, IRQ 11
        I/O ports at 1400
        Memory at f4102000 (32-bit, non-prefetchable) [size=256]
        Memory at f4100000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 1

0000:00:0f.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] 
(rev 05)
        Subsystem: Intel Corp. 82558 10/100 with Wake on LAN
        Flags: bus master, medium devsel, latency 64, IRQ 10
        Memory at f4103000 (32-bit, prefetchable)
        I/O ports at 1060 [size=32]
        Memory at f4000000 (32-bit, non-prefetchable) [size=1M]

0000:00:12.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
        Flags: bus master, medium devsel, latency 0

0000:00:12.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) 
(prog-if 80 [Master])
        Flags: bus master, medium devsel, latency 64
        I/O ports at 1050 [size=16]

0000:00:12.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) 
(prog-if 00 [UHCI])
        Flags: bus master, medium devsel, latency 64, IRQ 10
        I/O ports at 1080 [size=32]

0000:00:12.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
        Flags: medium devsel, IRQ 9

0000:00:14.0 VGA compatible controller: Cirrus Logic GD 5480 (rev 23) (prog-if 
00 [VGA])
        Subsystem: Intel Corp.: Unknown device 4945
        Flags: bus master, medium devsel, latency 64
        Memory at f6000000 (32-bit, prefetchable)
        Memory at f4101000 (32-bit, non-prefetchable) [size=4K]

Bilby:~# 

I'll provide a more verbose listing if anyone asks.

I have these SCSI devices:
        -raw96r         Write disk in RAW/RAW96R mode. This option will be 
replaced Bilby:~# cdrecord -s -scanbus
Cdrecord-Clone 2.01a27 (i686-pc-linux-gnu) Copyright (C) 1995-2004 Jörg 
Schilling
NOTE: this version of cdrecord is an inofficial (modified) release of cdrecord
      and thus may have bugs that are not present in the original version.
      Please send bug reports and support requests to 
<cdrtools@packages.debian.org>.
      The original author should not be bothered with problems of this 
version.

Linux sg driver version: 3.5.30
Using libscg version 'schily-0.8'.
scsibus0:
        0,0,0     0) 'QUANTUM ' 'ATLAS IV 9 WLS  ' '0909' Disk
        0,1,0     1) 'QUANTUM ' 'ATLAS IV 18 WLS ' '0909' Disk
        0,2,0     2) *
        0,3,0     3) *
        0,4,0     4) *
        0,5,0     5) 'SONY    ' 'SDT-7000        ' '0300' Removable Tape
        0,6,0     6) *
        0,7,0     7) *
Bilby:~# 


The tape is not in use.
/dev/hdc is a Creative CD-ROM CD4832E, my only IDE/ATA device, and not in use 
at the relevant time.

These are the bits of dmidecode's report that seem to me most relevant. If 
anyone asks, they can have the full report.
        BIOS Information Block
                Vendor: Intel Corporation
                Version: NITELT0.86B.0044.P11.9910111055 
                Release: 10/11/99
                BIOS base: 0xE0000
                ROM size: 448K
                Capabilities:
                        Flags: 0x000000007FE9DA90
        Board Information Block
                Vendor:                                
                Product: NL440BX
                Version: 700980-417
                Serial Number: IMNL93701413
        Processor
                Socket Designation: J5C1
                Processor Type: Central Processor
                Processor Family: Pentium III processor
                Processor Manufacturer: Intel Corporation
                Processor Version: Intel(R) Pentium(R) III processor
It has 256 Mbytes of ECC RAM, but there's no DMI info about it.


The report.
The standard ksymoops options are wrong for this kernel. I've made my best 
guess, but it doesn't seem entirely happy. I'm using this commandline:
ksymoops -k /proc/kallsyms  -v /boot/vmlinuz-2.6.3-1-686 -m 
/boot/System.map-2.6.3-1-686


ksymoops 2.4.9 on i686 2.6.3-1-686.  Options used
     -v /boot/vmlinuz-2.6.3-1-686 (specified)
     -k /proc/kallsyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.6.3-1-686/ (default)
     -m /boot/System.map-2.6.3-1-686 (specified)

/usr/bin/nm: /boot/vmlinuz-2.6.3-1-686: File format not recognized
Error (pclose_local): read_nm_symbols pclose failed 0x100
Warning (read_vmlinux): no kernel symbols in vmlinux, is 
/boot/vmlinuz-2.6.3-1-686 a valid vmlinux file?
Warning (read_ksyms): no kernel symbols in ksyms, is /proc/kallsyms a valid 
ksyms file?
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Machine check exception polling timer started.
  Receiver lock-up bug exists -- enabling work-around.
Unable to handle kernel paging request at virtual address 6e65704f
c0171b30
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0171b30>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: c243fc14   ebx: 00027d2e   ecx: 6e65704f   edx: 6e65704f
esi: cf549400   edi: cfb0ef08   ebp: cf549400   esp: ce921e30
ds: 007b   es: 007b   ss: 0068
Stack: 00000000 ce920000 ca402c20 00027d2e c01721e2 cf549400 cfb0ef08 00027d2e 
       cfb0ef08 00027d2e ca402c20 cf549400 ca402c20 d08d7efb cf549400 00027d2e 
       c6f77ed4 fffffff4 cd02f4fc cd02f494 c0165c12 cd02f494 ca402c20 ce921f38 
Call Trace:
 [<c01721e2>] iget_locked+0x52/0xc0
 [<d08d7efb>] ext3_lookup+0x6b/0xd0 [ext3]
 [<c0165c12>] real_lookup+0xd2/0x100
 [<c0165ea6>] do_lookup+0x96/0xb0
 [<c016638d>] link_path_walk+0x4cd/0x950
 [<c012fc65>] in_group_p+0x25/0x30
 [<c0166d29>] __user_walk+0x49/0x60
 [<c0161b1c>] vfs_lstat+0x1c/0x60
 [<c016228b>] sys_lstat64+0x1b/0x40
 [<c010b38b>] syscall_call+0x7/0xb
Code: 8b 11 0f 18 02 90 39 59 18 89 c8 74 13 85 d2 89 d1 75 ed 31 


>>EIP; c0171b30 <find_inode_fast+20/70>   <=====

>>eax; c243fc14 <__crc_udp_disconnect+8426e/44eb7f>
>>ecx; 6e65704f <__crc_input_grab_device+26387/f032a>
>>edx; 6e65704f <__crc_input_grab_device+26387/f032a>
>>esi; cf549400 <__crc_nf_unregister_hook+4e82fe/b96145>
>>edi; cfb0ef08 <__crc_nf_unregister_hook+aade06/b96145>
>>ebp; cf549400 <__crc_nf_unregister_hook+4e82fe/b96145>
>>esp; ce921e30 <__crc_unregister_serial+7dfcb/2c078b>

Trace; c01721e2 <iget_locked+52/c0>
Trace; d08d7efb <__crc_alloc_fddidev+820d0/19f023>
Trace; c0165c12 <real_lookup+d2/100>
Trace; c0165ea6 <do_lookup+96/b0>
Trace; c016638d <link_path_walk+4cd/950>
Trace; c012fc65 <in_group_p+25/30>
Trace; c0166d29 <__user_walk+49/60>
Trace; c0161b1c <vfs_lstat+1c/60>
Trace; c016228b <sys_lstat64+1b/40>
Trace; c010b38b <syscall_call+7/b>

Code;  c0171b30 <find_inode_fast+20/70>
00000000 <_EIP>:
Code;  c0171b30 <find_inode_fast+20/70>   <=====
   0:   8b 11                     mov    (%ecx),%edx   <=====
Code;  c0171b32 <find_inode_fast+22/70>
   2:   0f 18 02                  prefetchnta (%edx)
Code;  c0171b35 <find_inode_fast+25/70>
   5:   90                        nop    
Code;  c0171b36 <find_inode_fast+26/70>
   6:   39 59 18                  cmp    %ebx,0x18(%ecx)
Code;  c0171b39 <find_inode_fast+29/70>
   9:   89 c8                     mov    %ecx,%eax
Code;  c0171b3b <find_inode_fast+2b/70>
   b:   74 13                     je     20 <_EIP+0x20>
Code;  c0171b3d <find_inode_fast+2d/70>
   d:   85 d2                     test   %edx,%edx
Code;  c0171b3f <find_inode_fast+2f/70>
   f:   89 d1                     mov    %edx,%ecx
Code;  c0171b41 <find_inode_fast+31/70>
  11:   75 ed                     jne    0 <_EIP>
Code;  c0171b43 <find_inode_fast+33/70>
  13:   31 00                     xor    %eax,(%eax)

Call Trace:
 [<c011dcd6>] schedule+0x596/0x5a0
 [<c014820b>] zap_pmd_range+0x4b/0x70
 [<c014827b>] unmap_page_range+0x4b/0x80
 [<c014847d>] unmap_vmas+0x1cd/0x230
 [<c014c410>] exit_mmap+0x80/0x1a0
 [<c011f715>] mmput+0x65/0x90
 [<c01239ec>] do_exit+0x15c/0x410
 [<c011ba30>] do_page_fault+0x0/0x52e
 [<c010c451>] die+0xe1/0xf0
 [<c011bc0e>] do_page_fault+0x1de/0x52e
 [<d08d384e>] ext3_getblk+0xae/0x2a0 [ext3]
 [<d089d6ca>] __journal_file_buffer+0x1aa/0x2b0 [jbd]
 [<c015917f>] wake_up_buffer+0xf/0x30
 [<c01591cc>] unlock_buffer+0x2c/0x50
 [<d089bcc6>] do_get_write_access+0x2e6/0x620 [jbd]
 [<c015cdec>] ll_rw_block+0x5c/0x90
 [<d08d7b92>] ext3_find_entry+0x332/0x3f0 [ext3]
 [<c011ba30>] do_page_fault+0x0/0x52e
 [<c010bdb5>] error_code+0x2d/0x38
 [<c0171b30>] find_inode_fast+0x20/0x70
 [<c01721e2>] iget_locked+0x52/0xc0
 [<d08d7efb>] ext3_lookup+0x6b/0xd0 [ext3]
 [<c0165c12>] real_lookup+0xd2/0x100
 [<c0165ea6>] do_lookup+0x96/0xb0
 [<c016638d>] link_path_walk+0x4cd/0x950
 [<c012fc65>] in_group_p+0x25/0x30
 [<c0166d29>] __user_walk+0x49/0x60
 [<c0161b1c>] vfs_lstat+0x1c/0x60
 [<c016228b>] sys_lstat64+0x1b/0x40
 [<c010b38b>] syscall_call+0x7/0xb
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c011dcd6 <schedule+596/5a0>
Trace; c014820b <zap_pmd_range+4b/70>
Trace; c014827b <unmap_page_range+4b/80>
Trace; c014847d <unmap_vmas+1cd/230>
Trace; c014c410 <exit_mmap+80/1a0>
Trace; c011f715 <mmput+65/90>
Trace; c01239ec <do_exit+15c/410>
Trace; c011ba30 <do_page_fault+0/52e>
Trace; c010c451 <die+e1/f0>
Trace; c011bc0e <do_page_fault+1de/52e>
Trace; d08d384e <__crc_alloc_fddidev+7da23/19f023>
Trace; d089d6ca <__crc_alloc_fddidev+4789f/19f023>
Trace; c015917f <wake_up_buffer+f/30>
Trace; c01591cc <unlock_buffer+2c/50>
Trace; d089bcc6 <__crc_alloc_fddidev+45e9b/19f023>
Trace; c015cdec <ll_rw_block+5c/90>
Trace; d08d7b92 <__crc_alloc_fddidev+81d67/19f023>
Trace; c011ba30 <do_page_fault+0/52e>
Trace; c010bdb5 <error_code+2d/38>
Trace; c0171b30 <find_inode_fast+20/70>
Trace; c01721e2 <iget_locked+52/c0>
Trace; d08d7efb <__crc_alloc_fddidev+820d0/19f023>
Trace; c0165c12 <real_lookup+d2/100>
Trace; c0165ea6 <do_lookup+96/b0>
Trace; c016638d <link_path_walk+4cd/950>
Trace; c012fc65 <in_group_p+25/30>
Trace; c0166d29 <__user_walk+49/60>
Trace; c0161b1c <vfs_lstat+1c/60>
Trace; c016228b <sys_lstat64+1b/40>
Trace; c010b38b <syscall_call+7/b>


3 warnings and 1 error issued.  Results may not be reliable.

-- 
Cheers
John Summerfield

