Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbVCGDdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVCGDdh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 22:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbVCGDdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 22:33:15 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:32448 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261470AbVCGDcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 22:32:25 -0500
From: Darren Williams <dsw@gelato.unsw.edu.au>
To: Christoph Lameter <clameter@sgi.com>
Date: Mon, 7 Mar 2005 14:32:09 +1100
Cc: Darren Williams <dsw@gelato.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Page fault scalability patch V18: Overview
Message-ID: <20050307033209.GE19053@cse.unsw.EDU.AU>
Mail-Followup-To: Christoph Lameter <clameter@sgi.com>,
	Darren Williams <dsw@gelato.unsw.edu.au>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0503011947001.25441@schroedinger.engr.sgi.com> <20050304021847.GF28102@cse.unsw.EDU.AU> <20050304024704.GG28102@cse.unsw.EDU.AU> <Pine.LNX.4.58.0503040814220.17378@schroedinger.engr.sgi.com> <20050306214902.GC19053@cse.unsw.EDU.AU> <Pine.LNX.4.58.0503061557220.3152@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503061557220.3152@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Christoph

On Sun, 06 Mar 2005, Christoph Lameter wrote:

> On Mon, 7 Mar 2005, Darren Williams wrote:
> 
> > Hi Christoph
> >
> > On Fri, 04 Mar 2005, Christoph Lameter wrote:
> >
> > > Make sure that scrubd_stop on startup is set to 2 and no zero in
> > > mm/scrubd.c. The current patch on oss.sgi.com may have that set to zero.
> > >
> > unsigned int sysctl_scrub_stop = 2;     /* Mininum order of page to zero */
> >
> > This is the assignment when page zero fails.
> 
> Could you just test this with the prezeroing patches alone?
> Include a dmesg from a successful boot and then tell me what
> you changed and where the boot failed. Which version of the patches did
> you apply?
> 

PATCHES:
 ftp://oss.sgi.com/projects/page_fault_performance/download/prezero/patch/patchset-2.6.11/

No scrubd_stop
cat /proc/sys/vm/scrub_stop
2

/etc/sysctl.conf
vm.scrub_stop=2

CONFIG_SCRUBD  =N    =Y
Boots          OK   FAILED

Oops of failed prezero boot:
/dev/sdb4 has been mounted 31 times without being checked, check forced.Unable to handle kernel NULL pointer dereference (address 0000000000000000)%
kscrubd0[362]: Oops 11012296146944 [1]

Pid: 362, CPU 0, comm:             kscrubd0
psr : 0000121008022038 ifs : 8000000000000308 ip  : [<a0000001000cf821>]    Not tainted
ip is at scrubd_rmpage+0x61/0x140
unat: 0000000000000000 pfs : 0000000000000308 rsc : 0000000000000003
rnat: 0000000000000000 bsps: 0000000000000000 pr  : 0000000000009641
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70433f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a0000001000cf7f0 b6  : a000000100002d70 b7  : a000000100009ff0
f6  : 1003e6db6db6db6db6db7 f7  : 0fff4847277b800000000
f8  : 1003e000000001c07c8b4 f9  : 1003e00000000c4367cec
f10 : 10017a77079199649f035 f11 : 1003e00000000014ee0f2
r1  : a000000100a53d80 r2  : 0000000000100100 r3  : e0000721fe04fdd0
r8  : 0000001008026038 r9  : e000070020041070 r10 : 0000000000000008
r11 : 0000000000200200 r12 : e0000721fe04fdc0 r13 : e0000721fe048000
r14 : 0000000000000000 r15 : fffffffffffffffd r16 : ffffffffffffffff
r17 : a0007fffabf48000 r18 : ffffffffffffc000 r19 : 0000000000000000
r20 : ffffffffffffefff r21 : 0000000000000001 r22 : 0000000000000002
r23 : 0000000000000000 r24 : 0000000000000000 r25 : 0000000000000000
r26 : 0000000000000000 r27 : 0000001008026038 r28 : e0000721fe04fdd0
r29 : a0007fffabf4a7e0 r30 : 0000000000000000 r31 : e000070020041080

Call Trace:
 [<a00000010000f3a0>] show_stack+0x80/0xa0
                                sp=e0000721fe04f980 bsp=e0000721fe049010
 [<a00000010000fc00>] show_regs+0x7e0/0x800
                                sp=e0000721fe04fb50 bsp=e0000721fe048fa8
 [<a0000001000335f0>] die+0x150/0x1c0
                                sp=e0000721fe04fb60 bsp=e0000721fe048f68
 [<a000000100052430>] ia64_do_page_fault+0x370/0x980
                                sp=e0000721fe04fb60 bsp=e0000721fe048f00
 [<a00000010000a780>] ia64_leave_kernel+0x0/0x260
                                sp=e0000721fe04fbf0 bsp=e0000721fe048f00
 [<a0000001000cf820>] scrubd_rmpage+0x60/0x140
                                sp=e0000721fe04fdc0 bsp=e0000721fe048ec0
 [<a00000010010e080>] zero_highest_order_page+0x120/0x2c0
                                sp=e0000721fe04fdc0 bsp=e0000721fe048e68
 [<a00000010010e330>] scrub_pgdat+0x110/0x1c0
                                sp=e0000721fe04fdd0 bsp=e0000721fe048e30
 [<a00000010010e600>] kscrubd+0x220/0x240
                                sp=e0000721fe04fdd0 bsp=e0000721fe048e00
 [<a000000100011410>] kernel_thread_helper+0xd0/0x100
                                sp=e0000721fe04fe30 bsp=e0000721fe048dd0
 [<a0000001000090e0>] start_kernel_thread+0x20/0x40
                                sp=e0000721fe04fe30 bsp=e0000721fe048dd0
 <1>Unable to handle kernel NULL pointer dereference (address 0000000000000000)
kscrubd1[363]: Oops 11012296146944 [2]

Pid: 363, CPU 6, comm:             kscrubd1
psr : 0000121008022018 ifs : 8000000000000308 ip  : [<a0000001000cf821>]    Not tainted
ip is at scrubd_rmpage+0x61/0x140
unat: 0000000000000000 pfs : 0000000000000308 rsc : 0000000000000003
rnat: 0000000000000000 bsps: 0000000000000000 pr  : 0000000000009641
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70433f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a0000001000cf7f0 b6  : a000000100002d70 b7  : a000000100009ff0
f6  : 1003e6db6db6db6db6db7 f7  : 0fff68a47601000000000
f8  : 1003e000000001c87f85a f9  : 1003e00000000c7b7ca76
f10 : 100188a47600ff75b89ff f11 : 1003e0000000002291d80
r1  : a000000100a53d80 r2  : 0000000000100100 r3  : e0000741fe427dd0
r8  : 0000001008026018 r9  : e0000720000510f0 r10 : 0000000000000008
r11 : 0000000000200200 r12 : e0000741fe427dc0 r13 : e0000741fe420000
r14 : 0000000000000000 r15 : fffffffffffffffd r16 : ffffffffffffffff
r17 : a0007fffc7ff0000 r18 : ffffffffffffc000 r19 : 0000000000000000
r20 : ffffffffffffefff r21 : 0000000000000001 r22 : 0000000000000001
r23 : 0000000000000000 r24 : 0000000000000000 r25 : 0000000000000000
r26 : 0000000000000000 r27 : 0000001008026018 r28 : e0000741fe427dd0
r29 : a0007fffc7ff13f8 r30 : 0000000000000000 r31 : e000072000051100

Call Trace:
 [<a00000010000f3a0>] show_stack+0x80/0xa0
                                sp=e0000741fe427980 bsp=e0000741fe421010
 [<a00000010000fc00>] show_regs+0x7e0/0x800
                                sp=e0000741fe427b50 bsp=e0000741fe420fa8
 [<a0000001000335f0>] die+0x150/0x1c0
                                sp=e0000741fe427b60 bsp=e0000741fe420f68
 [<a000000100052430>] ia64_do_page_fault+0x370/0x980
                                sp=e0000741fe427b60 bsp=e0000741fe420f00
 [<a00000010000a780>] ia64_leave_kernel+0x0/0x260
                                sp=e0000741fe427bf0 bsp=e0000741fe420f00
 [<a0000001000cf820>] scrubd_rmpage+0x60/0x140
                                sp=e0000741fe427dc0 bsp=e0000741fe420ec0
 [<a00000010010e080>] zero_highest_order_page+0x120/0x2c0
                                sp=e0000741fe427dc0 bsp=e0000741fe420e68
 [<a00000010010e330>] scrub_pgdat+0x110/0x1c0
                                sp=e0000741fe427dd0 bsp=e0000741fe420e30
 [<a00000010010e600>] kscrubd+0x220/0x240
                                sp=e0000741fe427dd0 bsp=e0000741fe420e00
 [<a000000100011410>] kernel_thread_helper+0xd0/0x100
                                sp=e0000741fe427e30 bsp=e0000741fe420dd0
 [<a0000001000090e0>] start_kernel_thread+0x20/0x40
                                sp=e0000741fe427e30 bsp=e0000741fe420dd0



With atomic and page-zero patches applied 

ftp://oss.sgi.com/projects/page_fault_performance/download/hpc-2.6.11.gz

the dmesg is attached.

These are the values in scrub_[start|stop]

debian-dsw@trixie:~$ cat /proc/sys/vm/scrub_start
5
debian-dsw@trixie:~$ cat /proc/sys/vm/scrub_stop
2

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--------------------------------------------------
Darren Williams <dsw AT gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------

--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="HPC-dmesg.txt"

000MHz, ITC ratio=15/2, ITC freq=1500.000MHz
Calibrating delay loop... 2241.08 BogoMIPS (lpj=1093632)
CPU 11: synchronized ITC with CPU 0 (last diff 2 cycles, maxerr 2623 cycles)
CPU 11: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz
Calibrating delay loop... 2241.08 BogoMIPS (lpj=1093632)
CPU 12: synchronized ITC with CPU 0 (last diff -9 cycles, maxerr 2616 cycles)
CPU 12: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz
Calibrating delay loop... 2241.08 BogoMIPS (lpj=1093632)
CPU 13: synchronized ITC with CPU 0 (last diff 2 cycles, maxerr 2624 cycles)
CPU 13: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz
Calibrating delay loop... 2241.08 BogoMIPS (lpj=1093632)
CPU 14: synchronized ITC with CPU 0 (last diff -5 cycles, maxerr 2624 cycles)
CPU 14: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz
Calibrating delay loop... 2241.08 BogoMIPS (lpj=1093632)
CPU 15: synchronized ITC with CPU 0 (last diff 2 cycles, maxerr 2624 cycles)
CPU 15: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz
Calibrating delay loop... 2241.08 BogoMIPS (lpj=1093632)
Brought up 16 CPUs
Total of 16 processors activated (35856.28 BogoMIPS).
CPU0 attaching sched-domain:
 domain 0: span 000f
  groups: 0001 0002 0004 0008
  domain 1: span ffff
   groups: 000f 00f0 0f00 f000
CPU1 attaching sched-domain:
 domain 0: span 000f
  groups: 0002 0004 0008 0001
  domain 1: span ffff
   groups: 000f 00f0 0f00 f000
CPU2 attaching sched-domain:
 domain 0: span 000f
  groups: 0004 0008 0001 0002
  domain 1: span ffff
   groups: 000f 00f0 0f00 f000
CPU3 attaching sched-domain:
 domain 0: span 000f
  groups: 0008 0001 0002 0004
  domain 1: span ffff
   groups: 000f 00f0 0f00 f000
CPU4 attaching sched-domain:
 domain 0: span 00f0
  groups: 0010 0020 0040 0080
  domain 1: span ffff
   groups: 00f0 0f00 f000 000f
CPU5 attaching sched-domain:
 domain 0: span 00f0
  groups: 0020 0040 0080 0010
  domain 1: span ffff
   groups: 00f0 0f00 f000 000f
CPU6 attaching sched-domain:
 domain 0: span 00f0
  groups: 0040 0080 0010 0020
  domain 1: span ffff
   groups: 00f0 0f00 f000 000f
CPU7 attaching sched-domain:
 domain 0: span 00f0
  groups: 0080 0010 0020 0040
  domain 1: span ffff
   groups: 00f0 0f00 f000 000f
CPU8 attaching sched-domain:
 domain 0: span 0f00
  groups: 0100 0200 0400 0800
  domain 1: span ffff
   groups: 0f00 f000 000f 00f0
CPU9 attaching sched-domain:
 domain 0: span 0f00
  groups: 0200 0400 0800 0100
  domain 1: span ffff
   groups: 0f00 f000 000f 00f0
CPU10 attaching sched-domain:
 domain 0: span 0f00
  groups: 0400 0800 0100 0200
  domain 1: span ffff
   groups: 0f00 f000 000f 00f0
CPU11 attaching sched-domain:
 domain 0: span 0f00
  groups: 0800 0100 0200 0400
  domain 1: span ffff
   groups: 0f00 f000 000f 00f0
CPU12 attaching sched-domain:
 domain 0: span f000
  groups: 1000 2000 4000 8000
  domain 1: span ffff
   groups: f000 000f 00f0 0f00
CPU13 attaching sched-domain:
 domain 0: span f000
  groups: 2000 4000 8000 1000
  domain 1: span ffff
   groups: f000 000f 00f0 0f00
CPU14 attaching sched-domain:
 domain 0: span f000
  groups: 4000 8000 1000 2000
  domain 1: span ffff
   groups: f000 000f 00f0 0f00
CPU15 attaching sched-domain:
 domain 0: span f000
  groups: 8000 1000 2000 4000
  domain 1: span ffff
   groups: f000 000f 00f0 0f00
NET: Registered protocol family 16
ACPI: Subsystem revision 20050211
ACPI: Interpreter enabled
ACPI: Using IOSAPIC for interrupt routing
ACPI: PCI Root Bridge [L000] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.N000.S000.IOC0.L000._PRT]
ACPI: PCI Root Bridge [L001] (00:08)
ACPI: PCI Interrupt Routing Table [\_SB_.N000.S000.IOC0.L001._PRT]
ACPI: PCI Root Bridge [L002] (00:10)
ACPI: PCI Interrupt Routing Table [\_SB_.N000.S000.IOC0.L002._PRT]
ACPI: PCI Root Bridge [L004] (00:20)
ACPI: PCI Interrupt Routing Table [\_SB_.N000.S000.IOC0.L004._PRT]
ACPI: PCI Root Bridge [L006] (00:30)
ACPI: PCI Interrupt Routing Table [\_SB_.N000.S000.IOC0.L006._PRT]
ACPI: PCI Root Bridge [L008] (00:40)
ACPI: PCI Interrupt Routing Table [\_SB_.N000.S000.IOC1.L008._PRT]
ACPI: PCI Root Bridge [L010] (00:50)
ACPI: PCI Interrupt Routing Table [\_SB_.N000.S000.IOC1.L010._PRT]
ACPI: PCI Root Bridge [L012] (00:60)
ACPI: PCI Interrupt Routing Table [\_SB_.N000.S000.IOC1.L012._PRT]
ACPI: PCI Root Bridge [L014] (00:70)
ACPI: PCI Interrupt Routing Table [\_SB_.N000.S000.IOC1.L014._PRT]
ACPI: PCI Root Bridge [L000] (01:00)
ACPI: PCI Interrupt Routing Table [\_SB_.N001.S016.IOC0.L000._PRT]
ACPI: PCI Root Bridge [L001] (01:08)
ACPI: PCI Interrupt Routing Table [\_SB_.N001.S016.IOC0.L001._PRT]
ACPI: PCI Root Bridge [L002] (01:10)
ACPI: PCI Interrupt Routing Table [\_SB_.N001.S016.IOC0.L002._PRT]
ACPI: PCI Root Bridge [L004] (01:20)
ACPI: PCI Interrupt Routing Table [\_SB_.N001.S016.IOC0.L004._PRT]
ACPI: PCI Root Bridge [L006] (01:30)
ACPI: PCI Interrupt Routing Table [\_SB_.N001.S016.IOC0.L006._PRT]
ACPI: PCI Root Bridge [L008] (01:40)
ACPI: PCI Interrupt Routing Table [\_SB_.N001.S016.IOC1.L008._PRT]
ACPI: PCI Root Bridge [L010] (01:50)
ACPI: PCI Interrupt Routing Table [\_SB_.N001.S016.IOC1.L010._PRT]
ACPI: PCI Root Bridge [L012] (01:60)
ACPI: PCI Interrupt Routing Table [\_SB_.N001.S016.IOC1.L012._PRT]
ACPI: PCI Root Bridge [L014] (01:70)
ACPI: PCI Interrupt Routing Table [\_SB_.N001.S016.IOC1.L014._PRT]
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
IOC: sx1000 0.1 HPA 0xf8020002000 IOVA space 1024Mb at 0x80000000
IOC: sx1000 0.1 HPA 0xf8020003000 IOVA space 1024Mb at 0x80000000
IOC: sx1000 0.1 HPA 0xf8120002000 IOVA space 1024Mb at 0x80000000
IOC: sx1000 0.1 HPA 0xf8120003000 IOVA space 1024Mb at 0x80000000
perfmon: version 2.0 IRQ 238
perfmon: Itanium 2 PMU detected, 16 PMCs, 18 PMDs, 4 counters (47 bits)
PAL Information Facility v0.5
perfmon: added sampling format default_format
perfmon_default_smpl: default_format v2.0 registered
SGI XFS with realtime, large block/inode numbers, no debug enabled
Initializing Cryptographic API
ACPI: Sleep Button (FF) [SLPF]
ACPI: Power Button (CM) [PWRB]
EFI Time Services Driver v0.4
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
GSI 29 (level, low) -> CPU 1 (0x0400) vector 49
ACPI: PCI interrupt 0000:00:00.0[A] -> GSI 29 (level, low) -> IRQ 49
ttyS0 at MMIO 0xf0000018000 (irq = 49) is a 16550A
ACPI: PCI interrupt 0000:00:00.1[A] -> GSI 29 (level, low) -> IRQ 49
ttyS1 at MMIO 0xf0000019000 (irq = 49) is a 16550A
ttyS2 at MMIO 0xf0000019010 (irq = 49) is a 16550A
ttyS3 at MMIO 0xf0000019038 (irq = 49) is a 16550A
GSI 133 (level, low) -> CPU 6 (0x0801) vector 50
ACPI: PCI interrupt 0001:00:00.0[A] -> GSI 133 (level, low) -> IRQ 50
ttyS4 at MMIO 0xf0100018000 (irq = 50) is a 16550A
ACPI: PCI interrupt 0001:00:00.1[A] -> GSI 133 (level, low) -> IRQ 50
ttyS5 at MMIO 0xf0100019000 (irq = 50) is a 16550A
ttyS6 at MMIO 0xf0100019010 (irq = 50) is a 16550A
ttyS7 at MMIO 0xf0100019038 (irq = 50) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 4194304K size 4096 blocksize
loop: loaded (max 8 devices)
tg3.c:v2.9 (March 8, 2004)
GSI 28 (level, low) -> CPU 3 (0x0c00) vector 51
ACPI: PCI interrupt 0000:00:01.0[A] -> GSI 28 (level, low) -> IRQ 51
eth0: Tigon3 [partno(A7109-60001) rev 0105 PHY(5701)] (PCI:33MHz:64-bit) 10/100/1000BaseT Ethernet 00:0e:7f:ed:91:8f
GSI 132 (level, low) -> CPU 4 (0x0001) vector 52
ACPI: PCI interrupt 0001:00:01.0[A] -> GSI 132 (level, low) -> IRQ 52
eth1: Tigon3 [partno(A7109-60001) rev 0105 PHY(5701)] (PCI:33MHz:64-bit) 10/100/1000BaseT Ethernet 00:0e:7f:ed:71:b9
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Probing IDE interface ide0...
Probing IDE interface ide1...
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
GSI 24 (level, low) -> CPU 1 (0x0400) vector 53
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 24 (level, low) -> IRQ 53
sym0: <1010-66> rev 0x1 at pci 0000:00:02.0 irq 53
sym0: Symbios NVRAM, ID 7, Fast-80, SE, parity checking
sym0: open drain IRQ line driver, using on-chip SRAM
sym0: using LOAD/STORE-based firmware.
sym0: handling phase mismatch from SCRIPTS.
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.18n
  Vendor: HP 36.4G  Model: ST336753LC        Rev: HPC4
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym0:6:0: tagged command queuing enabled, command queue depth 16.
 target0:0:6: Beginning Domain Validation
sym0:6: wide asynchronous.
sym0:6: FAST-20 WIDE SCSI 40.0 MB/s ST (50.0 ns, offset 31)
 target0:0:6: Ending Domain Validation
GSI 25 (level, low) -> CPU 2 (0x0800) vector 54
ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 25 (level, low) -> IRQ 54
sym1: <1010-66> rev 0x1 at pci 0000:00:02.1 irq 54
sym1: Symbios NVRAM, ID 7, Fast-80, SE, parity checking
sym1: open drain IRQ line driver, using on-chip SRAM
sym1: using LOAD/STORE-based firmware.
sym1: handling phase mismatch from SCRIPTS.
sym1: SCSI BUS has been reset.
scsi1 : sym-2.1.18n
  Vendor: HP        Model: DVD-ROM 305       Rev: 1.01
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target1:0:2: Beginning Domain Validation
 target1:0:2: Domain Validation skipping write tests
sym1:2: FAST-20 SCSI 20.0 MB/s ST (50.0 ns, offset 16)
 target1:0:2: Ending Domain Validation
GSI 26 (level, low) -> CPU 3 (0x0c00) vector 55
ACPI: PCI interrupt 0000:00:03.0[A] -> GSI 26 (level, low) -> IRQ 55
sym2: <1010-66> rev 0x1 at pci 0000:00:03.0 irq 55
sym2: Symbios NVRAM, ID 7, Fast-80, SE, parity checking
sym2: open drain IRQ line driver, using on-chip SRAM
sym2: using LOAD/STORE-based firmware.
sym2: handling phase mismatch from SCRIPTS.
sym2: SCSI BUS has been reset.
scsi2 : sym-2.1.18n
  Vendor: HP 73.4G  Model: MAS3735NC         Rev: HPC3
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym2:6:0: tagged command queuing enabled, command queue depth 16.
 target2:0:6: Beginning Domain Validation
sym2:6: wide asynchronous.
sym2:6: FAST-20 WIDE SCSI 40.0 MB/s ST (50.0 ns, offset 31)
 target2:0:6: Ending Domain Validation
GSI 27 (level, low) -> CPU 0 (0x0000) vector 56
ACPI: PCI interrupt 0000:00:03.1[B] -> GSI 27 (level, low) -> IRQ 56
sym3: <1010-66> rev 0x1 at pci 0000:00:03.1 irq 56
sym3: Symbios NVRAM, ID 7, Fast-80, LVD, parity checking
sym3: open drain IRQ line driver, using on-chip SRAM
sym3: using LOAD/STORE-based firmware.
sym3: handling phase mismatch from SCRIPTS.
sym3: SCSI BUS has been reset.
scsi3 : sym-2.1.18n
GSI 128 (level, low) -> CPU 5 (0x0401) vector 57
ACPI: PCI interrupt 0001:00:02.0[A] -> GSI 128 (level, low) -> IRQ 57
sym4: <1010-66> rev 0x1 at pci 0001:00:02.0 irq 57
sym4: Symbios NVRAM, ID 7, Fast-80, SE, parity checking
sym4: open drain IRQ line driver, using on-chip SRAM
sym4: using LOAD/STORE-based firmware.
sym4: handling phase mismatch from SCRIPTS.
sym4: SCSI BUS has been reset.
scsi4 : sym-2.1.18n
GSI 129 (level, low) -> CPU 6 (0x0801) vector 58
ACPI: PCI interrupt 0001:00:02.1[B] -> GSI 129 (level, low) -> IRQ 58
sym5: <1010-66> rev 0x1 at pci 0001:00:02.1 irq 58
sym5: Symbios NVRAM, ID 7, Fast-80, SE, parity checking
sym5: open drain IRQ line driver, using on-chip SRAM
sym5: using LOAD/STORE-based firmware.
sym5: handling phase mismatch from SCRIPTS.
sym5: SCSI BUS has been reset.
scsi5 : sym-2.1.18n
  Vendor: HP        Model: DVD-ROM 305       Rev: 1.01
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target5:0:2: Beginning Domain Validation
 target5:0:2: Domain Validation skipping write tests
sym5:2: FAST-20 SCSI 20.0 MB/s ST (50.0 ns, offset 16)
 target5:0:2: Ending Domain Validation
GSI 130 (level, low) -> CPU 7 (0x0c01) vector 59
ACPI: PCI interrupt 0001:00:03.0[A] -> GSI 130 (level, low) -> IRQ 59
sym6: <1010-66> rev 0x1 at pci 0001:00:03.0 irq 59
sym6: Symbios NVRAM, ID 7, Fast-80, SE, parity checking
sym6: open drain IRQ line driver, using on-chip SRAM
sym6: using LOAD/STORE-based firmware.
sym6: handling phase mismatch from SCRIPTS.
sym6: SCSI BUS has been reset.
scsi6 : sym-2.1.18n
GSI 131 (level, low) -> CPU 4 (0x0001) vector 60
ACPI: PCI interrupt 0001:00:03.1[B] -> GSI 131 (level, low) -> IRQ 60
sym7: <1010-66> rev 0x1 at pci 0001:00:03.1 irq 60
sym7: Symbios NVRAM, ID 7, Fast-80, LVD, parity checking
sym7: open drain IRQ line driver, using on-chip SRAM
sym7: using LOAD/STORE-based firmware.
sym7: handling phase mismatch from SCRIPTS.
sym7: SCSI BUS has been reset.
scsi7 : sym-2.1.18n
SCSI device sda: 71132960 512-byte hdwr sectors (36420 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 71132960 512-byte hdwr sectors (36420 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4
Attached scsi disk sda at scsi0, channel 0, id 6, lun 0
SCSI device sdb: 143374738 512-byte hdwr sectors (73408 MB)
SCSI device sdb: drive cache: write through
SCSI device sdb: 143374738 512-byte hdwr sectors (73408 MB)
SCSI device sdb: drive cache: write through
 sdb: sdb1 sdb2 sdb3 sdb4
Attached scsi disk sdb at scsi2, channel 0, id 6, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 6, lun 0,  type 0
Attached scsi generic sg1 at scsi1, channel 0, id 2, lun 0,  type 5
Attached scsi generic sg2 at scsi2, channel 0, id 6, lun 0,  type 0
Attached scsi generic sg3 at scsi5, channel 0, id 2, lun 0,  type 5
Fusion MPT base driver 3.01.18
Copyright (c) 1999-2004 LSI Logic Corporation
Fusion MPT SCSI Host driver 3.01.18
mice: PS/2 mouse device common for all mice
EFI Variables Facility v0.08 2004-May-17
perfmon: added sampling format oprofile_format
oprofile: using perfmon.
NET: Registered protocol family 2
IP: routing cache hash table of 524288 buckets, 8192Kbytes
TCP established hash table entries: 16777216 (order: 14, 268435456 bytes)
TCP bind hash table entries: 65536 (order: 6, 1048576 bytes)
TCP: Hash tables configured (established 16777216 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
Adding console on ttyS1 at MMIO 0xf0000019000 (options '9600n8')
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 240kB freed
Adding 2046944k swap on /dev/sdb3.  Priority:42 extents:1
EXT3 FS on sda4, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
tg3: eth0: Link is up at 1000 Mbps, full duplex.
tg3: eth0: Flow control is off for TX and off for RX.

--opJtzjQTFsWo+cga--
