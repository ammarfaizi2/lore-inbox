Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130722AbRCMBfh>; Mon, 12 Mar 2001 20:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130733AbRCMBf2>; Mon, 12 Mar 2001 20:35:28 -0500
Received: from [64.41.138.201] ([64.41.138.201]:22026 "EHLO
	diexgcu1.digitalimpact.com") by vger.kernel.org with ESMTP
	id <S130722AbRCMBfM>; Mon, 12 Mar 2001 20:35:12 -0500
Message-ID: <E1932DB448A64D4898D773691B7CC7AE22EF17@diexgcu1.digitalimpact.com>
From: Shane Gibson <sgibson@digitalimpact.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Oops: 0002 error message, "unexpected IO-APIC", and "SCSI Host ab
	ort" messages
Date: Mon, 12 Mar 2001 17:34:24 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just upgraded my system from dual PII 450s to
dual PIII 750s.  I'm now getting three major problems.
I'm not sure if they are related.  The first is an
'Oops:  0002' crash and burn, the second is an io-apic
error as recorded by dmesg, the third is a crash and
burn with the console saying "SCSI host abort".  Please
note I had Zero problems with this system, until 
installing the PIII750s.  Is that odd, or what...

I'm running a relatively stock RedHat 7.0 platform, on
a SuperMicro PIIIDME dual processor motherboard.  The
processors are Intel PIII 750s, with 256k cache.  The
crash and 'ksymoops' produce:

ksymoops 2.3.4 on i686 2.2.16-22smp.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.16-22smp/ (default)
     -m /boot/System.map (specified)

Error (expand_objects): cannot stat(/lib/aic7xxx.o) for aic7xxx
Error (pclose_local): find_objects pclose failed 0x100
Mar 12 12:30:12 walker kernel: Unable to handle kernel paging request at
virtual address 86000020
Mar 12 12:30:12 walker kernel: current->tss.cr3 = 0d17a000, %%cr3 = 0d17a000
Mar 12 12:30:12 walker kernel: *pde = 00000000
Mar 12 12:30:12 walker kernel: Oops: 0002
Mar 12 12:30:12 walker kernel: CPU:    0
Mar 12 12:30:12 walker kernel: EIP:    0010:[truncate_inode_pages+124/316]
Mar 12 12:30:12 walker kernel: EFLAGS: 00010286
Mar 12 12:30:12 walker kernel: eax: 00000000   ebx: d4827288   ecx: c04e87e8
edx: c0433178
Mar 12 12:30:12 walker kernel: esi: d4827210   edi: 86000000   ebp: 00000000
esp: c9371ee8
Mar 12 12:30:12 walker kernel: ds: 0018   es: 0018   ss: 0018
Mar 12 12:30:12 walker kernel: Process rateup (pid: 18192, process nr: 41,
stackpage=c9371000)
Mar 12 12:30:12 walker kernel: Stack: 0005a178 00001af7 d4827288 df045c9c
d4827288 c0136e73 d4827210 00000000

Mar 12 12:30:12 walker kernel:        d4827210 c0142f29 d4827210 d4827210
d4827210 00000000 c7fe9ce0 d4827210

Mar 12 12:30:12 walker kernel:        00000017 df00c400 00000000 defd90e0
c01438a3 c01438c2 d4827210 c0234860

Mar 12 12:30:12 walker kernel: Call Trace: [clear_inode+19/112]
[ext2_free_inode+293/644] [ext2_delete_inode+
87/124] [ext2_delete_inode+118/124] [iput+155/588] [d_delete+74/104]
[ext2_unlink+385/416]
Mar 12 12:30:12 walker kernel: Code: 89 57 20 8b 51 20 8b 79 10 89 3a c7 41
20 00 00 00 00 ff 0d
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 57 20                  mov    %edx,0x20(%edi)
Code;  00000003 Before first symbol
   3:   8b 51 20                  mov    0x20(%ecx),%edx
Code;  00000006 Before first symbol
   6:   8b 79 10                  mov    0x10(%ecx),%edi
Code;  00000009 Before first symbol
   9:   89 3a                     mov    %edi,(%edx)
Code;  0000000b Before first symbol
   b:   c7 41 20 00 00 00 00      movl   $0x0,0x20(%ecx)
Code;  00000012 Before first symbol
  12:   ff 0d 00 00 00 00         decl   0x0


2 errors issued.  Results may not be reliable.




The IO-APIC error is recorded from this exerpt from the
syslog files.


Mar 11 15:07:10 walker kernel: Pentium-III serial number disabled.
Mar 11 15:07:10 walker kernel: Checking 386/387 coupling... OK, FPU using
exception 16 error reporting.
Mar 11 15:07:10 walker kernel: Checking 'hlt' instruction... OK.
Mar 11 15:07:10 walker kernel: POSIX conformance testing by UNIFIX
Mar 11 15:07:10 walker kernel: mtrr: v1.35a (19990819) Richard Gooch
(rgooch@atnf.csiro.au)
Mar 11 15:07:10 walker kernel: Pentium-III serial number disabled.
Mar 11 15:07:10 walker kernel: per-CPU timeslice cutoff: 50.03 usecs.
Mar 11 15:07:10 walker kernel: CPU0: Intel Pentium III (Coppermine) stepping
03
Mar 11 15:07:10 walker kernel: calibrating APIC timer ...
Mar 11 15:07:10 walker kernel: ..... CPU clock speed is 745.7690 MHz.
Mar 11 15:07:10 walker kernel: ..... system bus clock speed is 99.4358 MHz.
Mar 11 15:07:10 walker kernel: Booting processor 1 eip 2000
Mar 11 15:07:10 walker kernel: Calibrating delay loop... 1490.94 BogoMIPS
Mar 11 15:07:10 walker kernel: Pentium-III serial number disabled.
Mar 11 15:07:10 walker kernel: OK.
Mar 11 15:07:10 walker kernel: CPU1: Intel Pentium III (Coppermine) stepping
03
Mar 11 15:07:10 walker kernel: Total of 2 processors activated (2978.61
BogoMIPS).
Mar 11 15:07:10 walker kernel: enabling symmetric IO mode... ...done.
Mar 11 15:07:10 walker kernel: ENABLING IO-APIC IRQs
Mar 11 15:07:10 walker kernel: init IO_APIC IRQs
Mar 11 15:07:10 walker kernel:  IO-APIC (apicid-pin) 2-0, 2-18, 2-19, 2-20,
2-21, 2-22, 2-23, 3-0, 3-1, 3-2,
3-3, 3-5, 3-6, 3-7, 3-8, 3-9, 3-10, 3-11, 3-12, 3-13, 3-14, 3-15, 3-16,
3-17, 3-18, 3-19, 3-20, 3-21, 3-22, 3
-23 not connected.
Mar 11 15:07:10 walker kernel: number of MP IRQ sources: 23.
Mar 11 15:07:10 walker kernel: number of IO-APIC #2 registers: 24.
Mar 11 15:07:10 walker kernel: number of IO-APIC #3 registers: 24.
Mar 11 15:07:10 walker kernel: testing the IO APIC.......................
Mar 11 15:07:10 walker kernel:
Mar 11 15:07:10 walker kernel: IO APIC #2......
Mar 11 15:07:10 walker kernel: .... register #00: 02000000
Mar 11 15:07:10 walker kernel: .......    : physical APIC id: 02
Mar 11 15:07:10 walker kernel: .... register #01: 00170020
Mar 11 15:07:10 walker kernel: .......     : max redirection entries: 0017
Mar 11 15:07:10 walker kernel: .......     : IO APIC version: 0020
Mar 11 15:07:10 walker kernel:  WARNING: unexpected IO-APIC, please mail
Mar 11 15:07:10 walker kernel:           to linux-smp@vger.rutgers.edu
Mar 11 15:07:10 walker kernel: .... register #02: 00000000
Mar 11 15:07:10 walker kernel: .......     : arbitration: 00
Mar 11 15:07:10 walker kernel: .... IRQ redirection table:
Mar 11 15:07:10 walker kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli
Vect:
Mar 11 15:07:10 walker kernel:  00 000 00  1    0    0   0   0    0    0
00
Mar 11 15:07:10 walker kernel:  01 000 00  0    0    0   0   0    1    1
59
Mar 11 15:07:11 walker kernel:  02 0FF 0F  0    0    0   0   0    1    1
51
Mar 11 15:07:11 walker kernel:  03 000 00  0    0    0   0   0    1    1
61
Mar 11 15:07:11 walker kernel:  04 000 00  0    0    0   0   0    1    1
69
Mar 11 15:07:11 walker kernel:  05 000 00  0    0    0   0   0    1    1
71
Mar 11 15:07:11 walker kernel:  06 000 00  0    0    0   0   0    1    1
79
Mar 11 15:07:11 walker kernel:  07 000 00  0    0    0   0   0    1    1
81
Mar 11 15:07:11 walker kernel:  08 000 00  0    0    0   0   0    1    1
89
Mar 11 15:07:11 walker kernel:  09 000 00  0    0    0   0   0    1    1
91
Mar 11 15:07:11 walker kernel:  0a 000 00  0    0    0   0   0    1    1
99
Mar 11 15:07:11 walker kernel:  0b 000 00  0    0    0   0   0    1    1
A1
Mar 11 15:07:11 walker kernel:  0c 000 00  0    0    0   0   0    1    1
A9
Mar 11 15:07:11 walker kernel:  0d 000 00  1    0    0   0   0    0    0
00
Mar 11 15:07:11 walker kernel:  0e 000 00  0    0    0   0   0    1    1
B1
Mar 11 15:07:11 walker kernel:  0f 000 00  0    0    0   0   0    1    1
B9
Mar 11 15:07:11 walker kernel:  10 0FF 0F  1    1    0   1   0    1    1
C1
Mar 11 15:07:11 walker kernel:  11 0FF 0F  1    1    0   1   0    1    1
C9
Mar 11 15:07:11 walker kernel:  12 000 00  1    0    0   0   0    0    0
00
Mar 11 15:07:11 walker kernel:  13 000 00  1    0    0   0   0    0    0
00
Mar 11 15:07:11 walker kernel:  14 000 00  1    0    0   0   0    0    0
00
Mar 11 15:07:11 walker kernel:  15 000 00  1    0    0   0   0    0    0
00
Mar 11 15:07:11 walker kernel:  16 000 00  1    0    0   0   0    0    0
00
Mar 11 15:07:11 walker kernel:  17 000 00  1    0    0   0   0    0    0
00
Mar 11 15:07:11 walker kernel:
Mar 11 15:07:11 walker kernel: IO APIC #3......
Mar 11 15:07:11 walker kernel: .... register #00: 03000000
Mar 11 15:07:11 walker kernel: .......    : physical APIC id: 03
Mar 11 15:07:11 walker kernel: .... register #01: 00178020
Mar 11 15:07:11 walker kernel: .......     : max redirection entries: 0017
Mar 11 15:07:11 walker kernel: .......     : IO APIC version: 0020
Mar 11 15:07:11 walker kernel:  WARNING: unexpected IO-APIC, please mail
Mar 11 15:07:11 walker kernel:           to linux-smp@vger.rutgers.edu
Mar 11 15:07:11 walker kernel:  WARNING: unexpected IO-APIC, please mail
Mar 11 15:07:11 walker kernel:           to linux-smp@vger.rutgers.edu
Mar 11 15:07:11 walker kernel: .... register #02: 0F000000
Mar 11 15:07:11 walker kernel: .......     : arbitration: 0F
Mar 11 15:07:11 walker kernel: .... IRQ redirection table:
Mar 11 15:07:11 walker kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli
Vect:
Mar 11 15:07:11 walker kernel:  00 000 00  1    0    0   0   0    0    0
00
Mar 11 15:07:11 walker kernel:  01 000 00  1    0    0   0   0    0    0
00
Mar 11 15:07:11 walker kernel:  02 000 00  1    0    0   0   0    0    0
00
Mar 11 15:07:11 walker kernel:  03 000 00  1    0    0   0   0    0    0
00
Mar 11 15:07:11 walker kernel:  04 0FF 0F  1    1    0   1   0    1    1
D1
Mar 11 15:07:11 walker kernel:  05 000 00  1    0    0   0   0    0    0
00
Mar 11 15:07:11 walker kernel:  06 000 00  1    0    0   0   0    0    0
00
Mar 11 15:07:11 walker kernel:  07 000 00  1    0    0   0   0    0    0
00
Mar 11 15:07:11 walker kernel:  08 000 00  1    0    0   0   0    0    0
00
Mar 11 15:07:11 walker kernel:  09 000 00  1    0    0   0   0    0    0
00
Mar 11 15:07:11 walker kernel:  0a 000 00  1    0    0   0   0    0    0
00
Mar 11 15:07:11 walker kernel:  0b 000 00  1    0    0   0   0    0    0
00
Mar 11 15:07:11 walker kernel:  0c 000 00  1    0    0   0   0    0    0
00
Mar 11 15:07:11 walker kernel:  0d 000 00  1    0    0   0   0    0    0
00
Mar 11 15:07:11 walker kernel:  0e 000 00  1    0    0   0   0    0    0
00
Mar 11 15:07:11 walker kernel:  0f 000 00  1    0    0   0   0    0    0
00
Mar 11 15:07:11 walker kernel:  10 000 00  1    0    0   0   0    0    0
00
Mar 11 15:07:11 walker kernel:  11 000 00  1    0    0   0   0    0    0
00
Mar 11 15:07:11 walker kernel:  12 000 00  1    0    0   0   0    0    0
00
Mar 11 15:07:11 walker kernel:  13 000 00  1    0    0   0   0    0    0
00
Mar 11 15:07:11 walker kernel:  14 000 00  1    0    0   0   0    0    0
00
Mar 11 15:07:11 walker kernel:  15 000 00  1    0    0   0   0    0    0
00
Mar 11 15:07:11 walker kernel:  16 000 00  1    0    0   0   0    0    0
00
Mar 11 15:07:11 walker kernel:  17 000 00  1    0    0   0   0    0    0
00
Mar 11 15:07:12 walker kernel: .................................... done.
Mar 11 15:07:12 walker kernel: checking TSC synchronization across CPUs:
passed.


Please let me know if there is anything more I can provide or
help with.  I just upgraded from PII 450 MHz processors to
the 750s.  Unfortunately, my machine seems to crash several
minutes (maybe 10 or 15) after boot up.  Here's the crash
output as recorded in /var/log/messages.


Mar 12 12:30:12 walker kernel: Unable to handle kernel paging request at
virtual address 86000020
Mar 12 12:30:12 walker kernel: current->tss.cr3 = 0d17a000, %%cr3 = 0d17a000
Mar 12 12:30:12 walker kernel: *pde = 00000000
Mar 12 12:30:12 walker kernel: Oops: 0002
Mar 12 12:30:12 walker kernel: CPU:    0
Mar 12 12:30:12 walker kernel: EIP:    0010:[truncate_inode_pages+124/316]
Mar 12 12:30:12 walker kernel: EFLAGS: 00010286
Mar 12 12:30:12 walker kernel: eax: 00000000   ebx: d4827288   ecx: c04e87e8
edx: c0433178
Mar 12 12:30:12 walker kernel: esi: d4827210   edi: 86000000   ebp: 00000000
esp: c9371ee8
Mar 12 12:30:12 walker kernel: ds: 0018   es: 0018   ss: 0018
Mar 12 12:30:12 walker kernel: Process rateup (pid: 18192, process nr: 41,
stackpage=c9371000)
Mar 12 12:30:12 walker kernel: Stack: 0005a178 00001af7 d4827288 df045c9c
d4827288 c0136e73 d4827210 00000000

Mar 12 12:30:12 walker kernel:        d4827210 c0142f29 d4827210 d4827210
d4827210 00000000 c7fe9ce0 d4827210

Mar 12 12:30:12 walker kernel:        00000017 df00c400 00000000 defd90e0
c01438a3 c01438c2 d4827210 c0234860

Mar 12 12:30:12 walker kernel: Call Trace: [clear_inode+19/112]
[ext2_free_inode+293/644] [ext2_delete_inode+
87/124] [ext2_delete_inode+118/124] [iput+155/588] [d_delete+74/104]
[ext2_unlink+385/416]
Mar 12 12:30:12 walker kernel:        [vfs_unlink+225/232]
[sys_unlink+142/216] [system_call+52/56]
Mar 12 12:30:12 walker kernel: Code: 89 57 20 8b 51 20 8b 79 10 89 3a c7 41
20 00 00 00 00 ff 0d


My limited knowledge of the kernel and stuff, would seem
to indicate the above crash output is on filesystem problems.

v/r
Shane

--
Shane Y. Gibson                                sgibson@digitalimpact.com
Network Architect                              (408) 447-8253  work
IT Data Center Operations                      (650) 302-0193  cellular
Digital Impact, Inc.                           (888) 786-4863  pager
"The Science of eMarketing!"                   (408) 447-8298  fax

        "The world is, for the most part, a collective mad-
         house, and practically everyone,  however `normal'
         his facade, is faking sanity."       -- John Astin
