Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263963AbRF0Q0n>; Wed, 27 Jun 2001 12:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263970AbRF0Q0Z>; Wed, 27 Jun 2001 12:26:25 -0400
Received: from mail.gkg-com.com ([207.211.22.3]:1816 "EHLO mail.gkg-com.com")
	by vger.kernel.org with ESMTP id <S263963AbRF0Q0R>;
	Wed, 27 Jun 2001 12:26:17 -0400
Date: Wed, 27 Jun 2001 11:26:08 -0500 (CDT)
From: Michael J Schout <mschout@gkg.net>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: various oops's in 2.2.19 SMP kernel.
Message-ID: <Pine.LNX.4.10.10106271124500.17066-100000@galaxy.gkg-com.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:    

PROBLEM: various oops's in 2.2.19 SMP kernel.

[2.] Full description of the problem/report:

The machine runs along fine for a couple of weeks, and will eventually hang
with an oops.   I have had this happen approximately 5 times to date with
different 2.2.x kernels, but have not reported it until now.  The ooops's are
not always the same.

Latest oops (2.2.19 SMP)
-------------------------------------------
Unable to handle kernel NULL pointer dereference at virtual address 00000100 
current->tss.cr3 = 1c6ad000, %%cr3 = 1c6ad000 
*pde = 00000000 
Oops: 0000 
CPU:    0 
EIP:    0010:[find_buffer+104/144] 
EFLAGS: 00010206 
eax: 00000100   ebx: 00000007   ecx: 0005ff98   edx: 00000100 
esi: 0000000d   edi: 00003006   ebp: 0003198f   esp: e426dee4 
ds: 0018   es: 0018   ss: 0018 
Process postmaster (pid: 13314, process nr: 30, stackpage=e426d000) 
Stack: edffc498 00000000 0005ff98 c012bd04 00003006 0003198f 00001000 00000000  
       c0142d42 00003006 0003198f 00001000 000003fc 00000000 c0142ece edffc498  
       d9eecff0 00000000 0000001b 00000000 edffc498 00000000 d18c5320 c0142f4e  
Call Trace: [get_hash_table+24/76] [sync_block+46/216] [sync_indirect+78/128] [sync_dindirect+78/128] [ext2_sync_file+103/164] [sys_fsync+143/200] [system_call+52/56]  [_stext+43/164]  
-------------------------------------------

An older oops (2.2.16 SMP (redhat's kernel - redhats patches))
-------------------------------------------
Unable to handle kernel NULL pointer dereference at virtual address 00000134
current->tss.cr3 = 03b8f000, %%cr3 = 03b8f000
*pde = 00000000
Oops: 0002
CPU:    1
EIP:    0010:[remove_from_queues+169/328]
EFLAGS: 00010206
eax: 00000100   ebx: de47ae40   ecx: de47ae40   edx: e4b886c0
esi: 0000000c   edi: 00000000   ebp: 00000007   esp: c2339ed0
ds: 0018   es: 0018   ss: 0018
Process postmaster (pid: 18747, process nr: 54, stackpage=c2339000)
Stack: 0007a671 c012b752 de47ae40 de47ae40 ece48420 c012bf5a de47ae40 c0148b19
       de47ae40 00000000 eb28c000 00000000 eb28c0d0 00001000 ec54d0b8 00000008
       00000400 0007a66a 00000000 0000002e c0148edf eb28c000 0000000c eb28c0cc
Call Trace: [put_last_free+50/124] [__bforget+34/40] [trunc_indirect+505/692] [ext2_truncate+107/516] [do_truncate+85/132] [do_truncate+105/132] [filp_open+172/240] [sys_ftruncate+322/368] [system_call+52/56]
Code: 89 50 34 c7 01 00 00 00 00 89 02 c7 41 34 00 00 00 00 ff 0d

-------------------------------------------

THe machine is a dual CPU (both PIII 500's) SMP machine with a Mylex DAC960
raid controller

[3.] Keywords (i.e., modules, networking, kernel):

    linux kernel 2.2.19 SMP oops 0000 [find_buffer+104/144]

    loaded modules:
    3c59x
    DAC960

[4.] Kernel version (from /proc/version):

Linux version 2.2.19 (root@deathstar.gkg-com.com) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 SMP Fri Apr 27 10:49:53 CDT 2001

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

-----------------------------------------------------------------------
Latest oops (2.2.19 SMP vanilla)

Options used: -V (default)
              -o /lib/modules/2.2.19/ (default)
              -k /proc/ksyms (default)
              -l /proc/modules (default)
              -m /boot/System.map (specified)
              -c 1 (default)

Unable to handle kernel NULL pointer dereference at virtual address 00000134
current->tss.cr3 = 03b8f000, %%cr3 = 03b8f000
*pde = 00000000
Oops: 0002
CPU:    1
EIP:    0010:[remove_from_queues+169/328]
EFLAGS: 00010206
eax: 00000100   ebx: de47ae40   ecx: de47ae40   edx: e4b886c0
esi: 0000000c   edi: 00000000   ebp: 00000007   esp: c2339ed0
ds: 0018   es: 0018   ss: 0018
Process postmaster (pid: 18747, process nr: 54, stackpage=c2339000)
Stack: 0007a671 c012b752 de47ae40 de47ae40 ece48420 c012bf5a de47ae40 c0148b19
       de47ae40 00000000 eb28c000 00000000 eb28c0d0 00001000 ec54d0b8 00000008
       00000400 0007a66a 00000000 0000002e c0148edf eb28c000 0000000c eb28c0cc
Call Trace: [put_last_free+50/124] [__bforget+34/40] [trunc_indirect+505/692] [ext2_truncate+107/516] [do_truncate+85/132] [do_truncate+105/132] [filp_open+172/240] [sys_ftruncate+322/368] [system_call+52/56]
Code: 89 50 34 c7 01 00 00 00 00 89 02 c7 41 34 00 00 00 00 ff 0d

Code:  00000000 Before first symbol            00000000 <_IP>: <===
Code:  00000000 Before first symbol               0:    89 50 34                mov    %edx,0x34(%eax) <===
Code:  00000003 Before first symbol               3:    c7 01 00 00 00 00       movl   $0x0,(%ecx)
Code:  00000009 Before first symbol               9:    89 02                   mov    %eax,(%edx)
Code:  0000000b Before first symbol               b:    c7 41 34 00 00 00 00    movl   $0x0,0x34(%ecx)
Code:  00000012 Before first symbol              12:    ff 0d 00 00 00 00       decl   0x0

833 warnings issued.  Results may not be reliable.

-----------------------------------------------------------------------
Older oops (2.2.16-3 SMP (redhat stock)

Options used: -V (default)
              -o /lib/modules/2.2.19/ (default)
              -k /proc/ksyms (default)
              -l /proc/modules (default)
              -m /boot/System.map-2.2.16-3smp (specified)
              -c 1 (default)

Unable to handle kernel NULL pointer dereference at virtual address 00000134
current->tss.cr3 = 03b8f000, %%cr3 = 03b8f000
*pde = 00000000
Oops: 0002
CPU:    1
EIP:    0010:[remove_from_queues+169/328]
EFLAGS: 00010206
eax: 00000100   ebx: de47ae40   ecx: de47ae40   edx: e4b886c0
esi: 0000000c   edi: 00000000   ebp: 00000007   esp: c2339ed0
ds: 0018   es: 0018   ss: 0018
Process postmaster (pid: 18747, process nr: 54, stackpage=c2339000)
Stack: 0007a671 c012b752 de47ae40 de47ae40 ece48420 c012bf5a de47ae40 c0148b19
       de47ae40 00000000 eb28c000 00000000 eb28c0d0 00001000 ec54d0b8 00000008
       00000400 0007a66a 00000000 0000002e c0148edf eb28c000 0000000c eb28c0cc
Call Trace: [put_last_free+50/124] [__bforget+34/40] [trunc_indirect+505/692] [ext2_truncate+107/516] [do_truncate+85/132] [do_truncate+105/132] [filp_open+172/240] [sys_ftruncate+322/
368] [system_call+52/56]
Code: 89 50 34 c7 01 00 00 00 00 89 02 c7 41 34 00 00 00 00 ff 0d

Code:  00000000 Before first symbol            00000000 <_IP>: <===
Code:  00000000 Before first symbol               0:    89 50 34                mov    %edx,0x34(%eax) <===
Code:  00000003 Before first symbol               3:    c7 01 00 00 00 00       movl   $0x0,(%ecx)
Code:  00000009 Before first symbol               9:    89 02                   mov    %eax,(%edx)
Code:  0000000b Before first symbol               b:    c7 41 34 00 00 00 00    movl   $0x0,0x34(%ecx)
Code:  00000012 Before first symbol              12:    ff 0d 00 00 00 00       decl   0x0


843 warnings issued.  Results may not be reliable.

[6.] A small shell script or example program which triggers the
     problem (if possible)

Not applicable. Cant reproduce easily.  The oops's have been happening
anytime after 3 to 6 weeks of uptime.

[7.] Environment

Machine is an SMP dual PIII 500 machine with 768MB RAM,
Mylex DAC960 RAID controller in RAID 5 configuration with
5 active disks, 1 standby disk.

this machine functions as a postgresql (7.0.3) server. Nothing else signifigant
is running on this machine.  The machine is running redhat 6.2 with all of the
released updates applied, and is running a stock 2.2.19 kernel that was
downloaded from ftp.us.kernel.org and was compiled on this same machine.

[7.1.] Software (add the output of the ver_linux script here)

Linux deathstar.gkg-com.com 2.2.19 #1 SMP Fri Apr 27 10:49:53 CDT 2001 i686 unknown
 
Gnu C                  egcs-2.91.66
Gnu make               3.78.1
binutils               2.9.5.0.22
util-linux             2.10r
modutils               2.3.21
e2fsprogs              1.18
pcmcia-cs              3.1.8
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Procps                 2.0.6
Net-tools              1.54
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         3c59x DAC960

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 501.147
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr xmm
bogomips        : 999.42

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 501.147
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr xmm
bogomips        : 999.42

[7.3.] Module information (from /proc/modules):

3c59x                  22480   2 (autoclean)
DAC960                 60848   3

[7.4.] SCSI information (from /proc/scsi/scsi)

/proc/scsi/scsi:
Attached devices: none

/proc/rd/c0/current_status:
***** DAC960 RAID Driver Version 2.2.10 of 1 February 2001 *****
Copyright 1998-2001 by Leonard N. Zubkoff <lnz@dandelion.com>
Configuring Mylex DAC960PTL1 PCI RAID Controller
  Firmware Version: 4.07-0-29, Channels: 1, Memory Size: 8MB
  PCI Bus: 0, Device: 18, Function: 1, I/O Address: Unassigned
  PCI Address: 0xFC8FE000 mapped at 0xF0810000, IRQ Channel: 18
  Controller Queue Depth: 124, Maximum Blocks per Command: 128
  Driver Queue Depth: 123, Scatter/Gather Limit: 33 of 33 Segments
  Stripe Size: 64KB, Segment Size: 8KB, BIOS Geometry: 255/63
  Physical Devices:
    0:0  Vendor: SEAGATE   Model: ST39175LW         Revision: 0001
         Serial Number: 3AL0NXK100007008KQ52
         Disk Status: Online, 17782784 blocks
    0:1  Vendor: SEAGATE   Model: ST39175LW         Revision: 0001
         Serial Number: 3AL0P60T00007012R69K
         Disk Status: Online, 17782784 blocks
    0:2  Vendor: SEAGATE   Model: ST39175LW         Revision: 0001
         Serial Number: 3AL0P4VE00007012R7QV
         Disk Status: Online, 17782784 blocks
    0:3  Vendor: SEAGATE   Model: ST39175LW         Revision: 0001
         Serial Number: 3AL0P3V700001005HKUC
         Disk Status: Standby, 17782784 blocks
    0:4  Vendor: SEAGATE   Model: ST39175LW         Revision: 0001
         Serial Number: 3AL0P3SW000070113RRF
         Disk Status: Online, 17782784 blocks
    0:5  Vendor: SEAGATE   Model: ST39175LW         Revision: 0001
         Serial Number: 3AL0P1MV00007012RDGX
         Disk Status: Online, 17782784 blocks
  Logical Drives:
    /dev/rd/c0d0: RAID-5, Online, 71131136 blocks, Write Thru
  No Rebuild or Consistency Check in Progress

[7.5.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

None.S

[X.] Other notes, patches, fixes, workarounds:

None.  Please email me directly if you need any additional
information on this problem.


