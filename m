Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264980AbTFLUWd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 16:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264981AbTFLUWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 16:22:33 -0400
Received: from web14707.mail.yahoo.com ([216.136.224.124]:60432 "HELO
	web14707.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264980AbTFLUWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 16:22:25 -0400
Message-ID: <20030612203610.26428.qmail@web14707.mail.yahoo.com>
Date: Thu, 12 Jun 2003 13:36:10 -0700 (PDT)
From: Y B <ybusenet@yahoo.com>
Subject: Oops in reading cdrom (2.4.21-rc6) 
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware:
Leadtek K7NCR18G-Pro (nforce2) with Athlon 1700+.
Yamaha CDRW 2200E on hdc

I have
CONFIG_IDEDMA_ONLYDISK=y

ide-cd is a module. Command line is hdc=ide-scsi
In single user mode..
mount /dev/scd0 /mnt/cdrom
read files from cdrom ... OK
umount /mnt/cdrom
mount /dev/scd0 /mnt/cdrom
read files from cdrom ... hang..
press ctl+alt+del after a minute or so => oops!!

----------------------Oops-------------------------------------------------

Syncing hardware clock to system time. Kernel bug at
ide-scsi.c:512!
Invalid operand: 0000

CPU 0
EIP: 0010:[<de8a8a4f>] Not tainted
EFLAGS: 0010286
eax: c1be9280 ebx: c0306d04 ecx: 5e6cc224 edx:
c01a9e60
esi: c15cfcc0 edi: ddbe7d80 ebp: c02afe94 esp:
c02a5e70
ds: 0018 es: 0018 ss: 0018

stack: 00000172 c0306d04 00000008 00000080 000001f4
ddbe7d80 c0306d04 
00000000 00000000 c02a5ec8 c01b250a c0306d04 c15cfcc0
00000000
00000088
000001f4 dd898940 00000000 00000016 c0306d04 c15c9280
dd898ec0
c02a5eec
c01b2680

call trace: c01b250a c01b2686 c01b292a c01b2840
c0125463 c0124bed 
c0121446 c0121366 c0121197 c010a700 c010760 c010cb98
c0107060 c0107083
c01070f2 c0105666

code: 0c 0b 00 02 be a3 8a de 8b 56 38 a1 44 65 2d c0
89 d1 29 c1
<0> Kernel panic: Aiee! Killing interrupt handler. 
-------------------------Ksymoops
o/p--------------------------------------
Syncing hardware clock to system time. Kernel bug at
ide-scsi.c:512!
Invalid operand: 0000
CPU 0
EIP: 0010:[<de8a8a4f>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 0010286
eax: c1be9280 ebx: c0306d04 ecx: 5e6cc224 edx:
c01a9e60
esi: c15cfcc0 edi: ddbe7d80 ebp: c02afe94 esp:
c02a5e70
ds: 0018 es: 0018 ss: 0018
stack: 00000172 c0306d04 00000008 00000080 000001f4
ddbe7d80 c0306d04 
00000000 00000000 c02a5ec8 c01b250a c0306d04 c15cfcc0
00000000
00000088
000001f4 dd898940 00000000 00000016 c0306d04 c15c9280
dd898ec0
c02a5eec
c01b2680
call trace: c01b250a c01b2686 c01b292a c01b2840
c0125463 c0124bed 
c0121446 c0121366 c0121197 c010a700 c010760 c010cb98
c0107060 c0107083
c01070f2 c0105666
code: 0c 0b 00 02 be a3 8a de 8b 56 38 a1 44 65 2d c0
89 d1 29 c1

>>EIP; de8a8a4f <[ipchains].bss.end+f740/1acf1>  
<=====
Trace; c01b250a <start_request+18a/200>
Trace; c01b2686 <ide_do_request+b6/190>
Trace; c01b292a <ide_timer_expiry+ea/1c0>
Trace; c01b2840 <ide_timer_expiry+0/1c0>
Trace; c0125463 <run_timer_list+f3/160>
Trace; c0124bed <update_wall_time+d/40>
Code;  de8a8a4f <[ipchains].bss.end+f740/1acf1>
00000000 <_EIP>:
Code;  de8a8a4f <[ipchains].bss.end+f740/1acf1>  
<=====
   0:   0c 0b                     or     $0xb,%al  
<=====
Code;  de8a8a51 <[ipchains].bss.end+f742/1acf1>
   2:   00 02                     add    %al,(%edx)
Code;  de8a8a53 <[ipchains].bss.end+f744/1acf1>
   4:   be a3 8a de 8b            mov   
$0x8bde8aa3,%esi
Code;  de8a8a58 <[ipchains].bss.end+f749/1acf1>
   9:   56                        push   %esi
Code;  de8a8a59 <[ipchains].bss.end+f74a/1acf1>
   a:   38 a1 44 65 2d c0         cmp   
%ah,0xc02d6544(%ecx)
Code;  de8a8a5f <[ipchains].bss.end+f750/1acf1>
  10:   89 d1                     mov    %edx,%ecx
Code;  de8a8a61 <[ipchains].bss.end+f752/1acf1>
  12:   29 c1                     sub    %eax,%ecx

<0> Kernel panic: Aiee! Killing interrupt handler. 

1 warning issued.  Results may not be reliable.

-------------------------From
dmesg----------------------------------------

ide: Assuming 33MHz system bus speed for PIO modes;
override with
idebus=xx
NFORCE2: IDE controller at PCI slot 00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
AMD_IDE: Bios didn't set cable bits corectly. Enabling
workaround.
ide: Assuming 33MHz system bus speed for PIO modes;
override with
idebus=xx
AMD_IDE: PCI device 10de:0065 (nVidia Corporation)
(rev a2) UDMA100
controller on pci00:09.0
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings:
hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings:
hdc:DMA, hdd:DMA
hda: WDC WD153BA, ATA DISK drive
hdb: Maxtor 6Y080P0, ATA DISK drive
blk: queue c03068c0, I/O limit 4095Mb (mask
0xffffffff)
blk: queue c03069fc, I/O limit 4095Mb (mask
0xffffffff)
hdc: YAMAHA CRW2200E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 30043440 sectors (15382 MB) w/2048KiB Cache,
CHS=1870/255/63,
UDMA(66)
hdb: attached ide-disk driver.
hdb: host protected area => 1
hdb: 160086528 sectors (81964 MB) w/7936KiB Cache,
CHS=9964/255/63,
UDMA(100)
ide-floppy driver 0.99.newide
...
ide-cd: ignoring drive hdc
...
------------------cat
/proc/ide/amd74xx-------------------------------
 ----------AMD BusMastering IDE
Configuration----------------
Driver Version:                     2.10
%ah,0xc02d6544(%ecx)
South Bridge:                       PCI device
10de:0065 (nVidia
Corporation)
Revision:                           IDE 0xa2x,%ecx
Highest DMA rate:                   UDMA100cf1>
BM-DMA base:                        0xf000eax,%ecx
PCI clock:                          33.3MHz
-----------------------Primary IDE-------Secondary
IDE------
Prefetch Buffer:              yes                 yes
Post Write Buffer:            yes                 yes
Enabled:                      yes                
yes6/
Simplex only:                  no                 
nonfig
Cable Type:                   80w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA      UDMA       PIO      
DMA
Address Setup:       30ns      30ns      30ns     
90ns
Cmd Active:          90ns      90ns      90ns     
90ns
Cmd Recovery:        30ns      30ns      30ns     
30ns
Data Active:         90ns      90ns      90ns    
330ns
Data Recovery:       30ns      30ns      30ns    
270ns
Cycle Time:          30ns      20ns     120ns    
600ns
Transfer Rate:   66.6MB/s  99.9MB/s  16.6MB/s  
3.3MB/s
--------------------------Oops-----------------------------------


__________________________________
Do you Yahoo!?
Yahoo! Calendar - Free online calendar with sync to Outlook(TM).
http://calendar.yahoo.com
