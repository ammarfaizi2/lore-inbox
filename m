Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293283AbSCFH2k>; Wed, 6 Mar 2002 02:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293302AbSCFH2V>; Wed, 6 Mar 2002 02:28:21 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:54665 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S293289AbSCFH2R>; Wed, 6 Mar 2002 02:28:17 -0500
Date: Wed, 6 Mar 2002 09:14:16 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Spurious interrupt and local-APIC
Message-ID: <Pine.LNX.4.44.0203060904450.2839-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a box here which has been locking up from time to time. And when 
i finally disabled local-APIC (UP box) its stopped. One thing to note is 
that it always generated spurious interrupt messages for a device in a 
particular PCI slot (slot 1, Pin A). Here are some details...

Linux version 2.4.18-pre8-zm1 (root@proxy-mba3.realnet.co.sz) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #5 Wed Mar 6 08:39:41 SAST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000009ff0000 (usable)
 BIOS-e820: 0000000009ff0000 - 0000000009ff3000 (ACPI NVS)
 BIOS-e820: 0000000009ff3000 - 000000000a000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 40944
zone(0): 4096 pages.
zone(1): 36848 pages.
zone(2): 0 pages.
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Kernel command line: ro root=/dev/sda1 nousb profile=1 console=ttyS0,115200 console=tty1
Initializing CPU#0
Detected 701.245 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1399.19 BogoMIPS
Memory: 156948k/163776k available (1275k kernel code, 6440k reserved, 347k data, 224k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
CPU: Before vendor init, caps: 0183fbff c1c7fbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU: After vendor init, caps: 0183fbff c1c7fbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:             Common caps: 0183fbff c1c7fbff 00000000 00000000
CPU: AMD Duron(tm) Processor stepping 01
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 701.2556 MHz.
..... host bus clock speed is 200.3587 MHz.
cpu: 0, clocks: 2003587, slice: 1001793
CPU0<T0:2003584,T1:1001776,D:15,S:1001793,C:2003587>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb380, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PCI: Cannot allocate resource region 1 of device 00:08.0
PCI: Cannot allocate resource region 0 of device 00:09.0
<snip>
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 11 for device 00:08.0
spurious 8259A interrupt: IRQ7.
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

  Vendor: IBM       Model: DMVS09V           Rev: 02B0
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
(scsi0:A:0): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4 < sda5 >

           CPU0       
  0:      24277          XT-PIC  timer
  1:       1123          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  4:          8          XT-PIC  serial
  5:       3149          XT-PIC  eth0
  8:          1          XT-PIC  rtc
  9:      19988          XT-PIC  pentanet0
 10:        631          XT-PIC  eth1
 11:      13610          XT-PIC  aic7xxx
 15:          5          XT-PIC  ide1
NMI:          0 
LOC:      24233 
ERR:         10		<== 1 for ~3 aic7xxx interrupts

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 3
model name	: AMD Duron(tm) Processor
stepping	: 1
cpu MHz		: 701.245
cache size	: 64 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips	: 1399.19

Now with local-APIC disabled i don't get the spurious interrupt message 
when the SCSI HBA gets initialised, plus no more errors reported, if 
anyone wants any more information i'd be glad to provide it.

Regards,
	Zwane Mwaikambo


