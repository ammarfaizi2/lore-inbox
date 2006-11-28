Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936000AbWK1T7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936000AbWK1T7A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 14:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936084AbWK1T7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 14:59:00 -0500
Received: from smtp3.Stanford.EDU ([171.67.20.26]:60078 "EHLO
	smtp3.stanford.edu") by vger.kernel.org with ESMTP id S936083AbWK1T65
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 14:58:57 -0500
Subject: 2.6.19-rc6-rt8: alsa xruns
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>
Cc: nando@ccrma.Stanford.EDU
Content-Type: text/plain
Date: Tue, 28 Nov 2006 11:58:51 -0800
Message-Id: <1164743931.15887.34.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I'm trying out the latest -rt patch and getting alsa xruns when
using jackd and jack clients. This is a sample from the output of
qjackctl / jackd (jack 0.102.25, qjackctl 0.2.21):

--------
**** alsa_pcm: xrun of at least 0.034 msecs
11:38:03.681 XRUN callback (154).
delay of 18710.000 usecs exceeds estimated spare time of 2604.000;
restart ...
delay of 31993.000 usecs exceeds estimated spare time of 2605.000;
restart ...
11:38:12.748 XRUN callback (155).
delay of 110914.000 usecs exceeds estimated spare time of 2605.000;
restart ...
11:38:14.976 XRUN callback (156).
**** alsa_pcm: xrun of at least 0.033 msecs
11:38:15.547 XRUN callback (1 skipped).
**** alsa_pcm: xrun of at least 0.033 msecs
11:38:20.044 XRUN callback (158).
**** alsa_pcm: xrun of at least 0.035 msecs
11:38:21.903 XRUN callback (159).
delay of 5480.000 usecs exceeds estimated spare time of 2600.000;
restart ...
11:38:23.758 XRUN callback (1 skipped).
**** alsa_pcm: xrun of at least 10.878 msecs
11:38:55.076 XRUN callback (161).
**** alsa_pcm: xrun of at least 5.338 msecs
11:38:56.750 XRUN callback (162).
delay of 12588.000 usecs exceeds estimated spare time of 2606.000;
restart ...
11:39:13.049 XRUN callback (163).
**** alsa_pcm: xrun of at least 0.258 msecs
11:39:15.039 XRUN callback (1 skipped).
**** alsa_pcm: xrun of at least 0.032 msecs
11:39:28.572 XRUN callback (165).
**** alsa_pcm: xrun of at least 10.818 msecs
11:41:03.001 XRUN callback (166).
**** alsa_pcm: xrun of at least 6.475 msecs
11:41:14.144 XRUN callback (167).
**** alsa_pcm: xrun of at least 4.931 msecs
11:41:25.643 XRUN callback (168).
**** alsa_pcm: xrun of at least 21.347 msecs
11:41:28.163 XRUN callback (169).
**** alsa_pcm: xrun of at least 11.910 msecs
11:41:28.513 XRUN callback (1 skipped).
**** alsa_pcm: xrun of at least 5.623 msecs
11:42:04.347 XRUN callback (171).
delay of 180434.000 usecs exceeds estimated spare time of 2607.000;
restart ...
11:43:13.748 XRUN callback (172).
delay of 205776.000 usecs exceeds estimated spare time of 2607.000;
restart ...
delay of 221779.000 usecs exceeds estimated spare time of 2607.000;
restart ...
11:43:15.263 XRUN callback (2 skipped).
delay of 25987.000 usecs exceeds estimated spare time of 2607.000;
restart ...
11:43:24.325 XRUN callback (175).
delay of 25990.000 usecs exceeds estimated spare time of 2607.000;
restart ...
11:43:25.519 XRUN callback (1 skipped).
**** alsa_pcm: xrun of at least 31.450 msecs
11:43:29.760 XRUN callback (177).
**** alsa_pcm: xrun of at least 35.110 msecs
11:44:12.244 XRUN callback (178).
**** alsa_pcm: xrun of at least 1.843 msecs
11:45:25.668 XRUN callback (179).
11:46:19.516 XRUN callback (180).
**** alsa_pcm: xrun of at least 15.978 msecs
delay of 50782.000 usecs exceeds estimated spare time of 2606.000;
restart ...
11:46:41.114 XRUN callback (181).
**** alsa_pcm: xrun of at least 17.744 msecs
11:46:54.612 XRUN callback (182).
**** alsa_pcm: xrun of at least 0.089 msecs
11:47:02.364 XRUN callback (183).
**** alsa_pcm: xrun of at least 0.027 msecs
11:47:03.102 XRUN callback (1 skipped).
delay of 3891.000 usecs exceeds estimated spare time of 2608.000;
restart ...
11:47:04.812 XRUN callback (185).
delay of 5224.000 usecs exceeds estimated spare time of 2577.000;
restart ...
**** alsa_pcm: xrun of at least 0.501 msecs
11:47:05.151 XRUN callback (2 skipped).
11:47:13.614 XRUN callback (188).
delay of 15536.000 usecs exceeds estimated spare time of 2602.000;
restart ...
**** alsa_pcm: xrun of at least 0.156 msecs
11:47:15.461 XRUN callback (1 skipped).
**** alsa_pcm: xrun of at least 0.037 msecs
11:47:41.528 XRUN callback (190).
delay of 5303.000 usecs exceeds estimated spare time of 2606.000;
restart ...
11:47:45.515 XRUN callback (191).
**** alsa_pcm: xrun of at least 0.361 msecs
11:48:25.755 XRUN callback (192).
delay of 2940.000 usecs exceeds estimated spare time of 2601.000;
restart ...
11:49:28.306 XRUN callback (193).
delay of 20574.000 usecs exceeds estimated spare time of 2615.000;
restart ...
11:49:43.013 XRUN callback (194).
**** alsa_pcm: xrun of at least 0.030 msecs
11:50:41.496 XRUN callback (195).
**** alsa_pcm: xrun of at least 27.624 msecs
11:51:04.761 XRUN callback (196).
**** alsa_pcm: xrun of at least 13.712 msecs
11:51:24.033 XRUN callback (197).
delay of 3956.000 usecs exceeds estimated spare time of 2611.000;
restart ...
11:51:54.670 XRUN callback (198).
**** alsa_pcm: xrun of at least 0.033 msecs
11:51:56.452 XRUN callback (199).
**** alsa_pcm: xrun of at least 0.039 msecs
11:52:00.756 XRUN callback (200).
**** alsa_pcm: xrun of at least 0.732 msecs
11:52:29.894 XRUN callback (201).

--------

The test machine is an Athlon X2 4400 running FC6 x86_64 booting into a
rebuilt 2.6.19-rc6-rt8 rpm package based on Ingo's packages
(same .config except for 4KSTACKS=off). 

- jackd and clients running with realtime priorities
- irqs priorities reordered with the rtirq script,
  this is the status after running it:

--------
  PID CLS RTPRIO  NI PRI %CPU STAT COMMAND	
    5 FF      99   - 139  0.0 S    softirq-timer/0	
   17 FF      99   - 139  0.0 S    softirq-timer/1	
  348 FF      80   - 120  0.0 S<   IRQ 8	rtc
 1081 FF      70   - 110  1.1 S<   IRQ 18	ohci1394, ICE1712
  436 FF      69   - 109  0.0 S<   IRQ 20	ehci_hcd:usb3, NVidia CK8S
  432 FF      60   - 100  0.0 S<   IRQ 21	ohci_hcd:usb2
  431 FF      59   -  99  0.0 S<   IRQ 22	ohci_hcd:usb1, libata
  413 FF      50   -  90  0.0 S<   IRQ 1	i8042
   73 FF      49   -  89  0.0 S<   IRQ 9	acpi
  412 FF      49   -  89  0.0 S<   IRQ 12	i8042
  383 FF      47   -  87  0.0 S<   IRQ 14	ide0
  468 FF      41   -  81  0.0 S<   IRQ 17	libata
 1034 FF      40   -  80  0.0 S<   IRQ 19	eth0
 1145 FF      38   -  78  0.0 S<   IRQ 6	floppy
 1491 FF      37   -  77  0.0 S<   IRQ 7	parport0
    4 FF       1   -  41  0.0 S    softirq-high/0	
    6 FF       1   -  41  0.0 S    softirq-net-tx/	
    7 FF       1   -  41  0.0 S    softirq-net-rx/	
    8 FF       1   -  41  0.0 S    softirq-block/0	
    9 FF       1   -  41  0.0 S    softirq-tasklet	
   10 FF       1   -  41  0.0 S    softirq-hrtimer	
   11 FF       1   -  41  0.0 S    softirq-rcu/0	
   16 FF       1   -  41  0.0 S    softirq-high/1	
   18 FF       1   -  41  0.0 S    softirq-net-tx/	
   19 FF       1   -  41  0.0 S    softirq-net-rx/	
   20 FF       1   -  41  0.0 S    softirq-block/1	
   21 FF       1   -  41  0.0 S    softirq-tasklet	
   22 FF       1   -  41  0.0 S    softirq-hrtimer	
   23 FF       1   -  41  0.0 S    softirq-rcu/1	
--------

and these are the interrupts:
--------
           CPU0       CPU1       
  0:         88       1033   IO-APIC-edge      timer
  1:       2239       1194   IO-APIC-edge      i8042
  6:          0          6   IO-APIC-edge      floppy
  7:          0          0   IO-APIC-edge      parport0
  8:          0          0   IO-APIC-edge      rtc
  9:          0          0   IO-APIC-fasteoi   acpi
 12:      96809       1404   IO-APIC-edge      i8042
 14:      48064        574   IO-APIC-edge      ide0
 17:          0          0   IO-APIC-fasteoi   libata
 18:        878    3921815   IO-APIC-fasteoi   ohci1394, ICE1712
 19:      63049         14   IO-APIC-fasteoi   eth0
 20:          0          0   IO-APIC-fasteoi   ehci_hcd:usb3, NVidia
CK8S
 21:          0        586   IO-APIC-fasteoi   ohci_hcd:usb2
 22:      88081      10197   IO-APIC-fasteoi   ohci_hcd:usb1, libata
NMI:   20028857   18536099 
LOC:     849887     848257 
ERR:          0
--------

(the soundcard being used by jackd is the ICE1712, IRQ 18, jackd runs
with priority 62/72)

What follows is the output of dmesg. At the end you can find the latency
wakeup numbers. It goes back to a low value each time I reset the
counter in proc. 

-- Fernando



This is from dmesg:
--------
Linux version 2.6.18-1.0001.3.rt8.fc6.ccrma
(machbuild@planetforge.stanford.edu) (gcc version 4.1.1 20061011 (Red
Hat 4.1.1-30)) #1 SMP PREEMPT Tue Nov 28 12:34:38 EST 2006
Command line: ro root=LABEL=/ rhgb quiet
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007fff3000 (ACPI NVS)
 BIOS-e820: 000000007fff3000 - 0000000080000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
Entering add_active_range(0, 0, 159) 0 entries of 3200 used
Entering add_active_range(0, 256, 524272) 1 entries of 3200 used
end_pfn_map = 1048576
DMI 2.3 present.
ACPI: RSDP (v000 Nvidia                                ) @
0x00000000000f6c90
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x01010101) @
0x000000007fff3000
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x01010101) @
0x000000007fff3040
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x01010101) @
0x000000007fff7bc0
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000c) @
0x0000000000000000
Scanning NUMA topology in Northbridge 24
Number of nodes 1
Node 0 MemBase 0000000000000000 Limit 000000007fff0000
Entering add_active_range(0, 0, 159) 0 entries of 3200 used
Entering add_active_range(0, 256, 524272) 1 entries of 3200 used
NUMA: Using 63 for the hash shift.
Using node hash shift of 63
Bootmem setup node 0 0000000000000000-000000007fff0000
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
early_node_map[2] active PFN ranges
    0:        0 ->      159
    0:      256 ->   524272
On node 0 totalpages: 524175
  DMA zone: 96 pages used for memmap
  DMA zone: 2299 pages reserved
  DMA zone: 1604 pages, LIFO batch:0
  DMA32 zone: 12191 pages used for memmap
  DMA32 zone: 507985 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
Nvidia board detected. Ignoring ACPI timer override.
If you got timer trouble try acpi_use_timer_override
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
ACPI: IRQ15 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Nosave address range: 000000000009f000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000f0000
Nosave address range: 00000000000f0000 - 0000000000100000
Allocating PCI resources starting at 88000000 (gap: 80000000:7ec00000)
SMP: Allowing 2 CPUs, 0 hotplug CPUs
PERCPU: Allocating 70144 bytes of per cpu data
Real-Time Preemption Support (C) 2004-2006 Ingo Molnar
Built 1 zonelists.  Total pages: 509589
Kernel command line: ro root=LABEL=/ rhgb quiet
Initializing CPU#0
WARNING: experimental RCU implementation.
PID hash table entries: 4096 (order: 12, 32768 bytes)
Clock event device pit configured with caps set: 07
Console: colour VGA+ 80x25
num_possible_cpus(): 2
CPU#0: allocated 6291408 bytes trace buffer.
CPU#0: allocated 6291408 bytes max-trace buffer.
CPU#1: allocated 6291408 bytes trace buffer.
CPU#1: allocated 6291408 bytes max-trace buffer.
allocated 12582816 bytes out-trace buffer.
tracer: a total of 37748448 bytes allocated.
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Checking aperture...
CPU 0: aperture @ f0000000 size 32 MB
Aperture too small (32 MB)
AGP bridge at 00:00:00
Aperture from AGP @ f0000000 size 4096 MB (APSIZE 0)
Aperture too small (0 MB)
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ 8000000
Memory: 1930732k/2097088k available (2588k kernel code, 165968k
reserved, 1853k data, 352k init)
Calibrating delay using timer specific routine.. 4424.19 BogoMIPS
(lpj=8848387)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0/0 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
SMP alternatives: switching to UP code
ACPI: Core revision 20060707
Using local APIC timer interrupts.
result 12561226
Detected 12.561 MHz APIC timer.
lapic max_delta_ns: 667817485
Clock event device pit new caps set: 01
Clock event device lapic configured with caps set: 06
SMP alternatives: switching to SMP code
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4421.93 BogoMIPS
(lpj=8843862)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
AMD Athlon(tm) 64 X2 Dual Core Processor 4400+ stepping 02
Clock event device pit new caps set: 01
Clock event device lapic configured with caps set: 06
Brought up 2 CPUs
testing NMI watchdog ... OK.
migration_cost=480
checking if image is initramfs... it is
Freeing initrd memory: 1525k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: Power Resource [ISAV] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs *23), disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 15 devices
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
agpgart: Detected AGP bridge 0
agpgart: Aperture conflicts with PCI mapping.
agpgart: Aperture from AGP @ f0000000 size 4096 MB
agpgart: Aperture too small (0 MB)
agpgart: No usable aperture found.
agpgart: Consider rebooting with iommu=memaper=2 to get a good aperture.
PCI-DMA: Disabling IOMMU.
pnp: 00:00: ioport range 0x1000-0x107f could not be reserved
pnp: 00:00: ioport range 0x1080-0x10ff has been reserved
pnp: 00:00: ioport range 0x1400-0x147f has been reserved
pnp: 00:00: ioport range 0x1480-0x14ff could not be reserved
pnp: 00:00: ioport range 0x1800-0x187f has been reserved
pnp: 00:00: ioport range 0x1880-0x18ff has been reserved
PCI: Bridge: 0000:00:0b.0
  IO window: 7000-7fff
  MEM window: f2000000-f3ffffff
  PREFETCH window: e0000000-efffffff
PCI: Bridge: 0000:00:0e.0
  IO window: 8000-afff
  MEM window: f4000000-f5ffffff
  PREFETCH window: 88000000-880fffff
PCI: Setting latency timer of device 0000:00:0e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 65536 (order: 10, 4194304 bytes)
TCP bind hash table entries: 32768 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 65536 bind 32768)
TCP reno registered
Initializing RT-Tester: OK
audit: initializing netlink socket (disabled)
audit(1164737006.388:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
NFORCE3-250: IDE controller at PCI slot 0000:00:08.0
NFORCE3-250: chipset revision 162
NFORCE3-250: not 100% native mode: will probe irqs later
NFORCE3-250: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE3-250: 0000:00:08.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: SONY DVD RW DW-Q28A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
ide-floppy driver 0.99.newide
usbcore: registered new interface driver libusual
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
kvm: no hardware support
TCP bic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Found 2 AMD Athlon(tm) 64 X2 Dual Core Processor 4400+
processors (version 2.00.00)
powernow-k8: invalid freq entries 3900000 kHz vs. 65535000 kHz
powernow-k8: invalid freq entries 3900000 kHz vs. 65535000 kHz
powernow-k8: invalid freq entries 3900000 kHz vs. 65535000 kHz
powernow-k8: invalid freq entries 3900000 kHz vs. 65535000 kHz
powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x8
powernow-k8:    1 : fid 0x2 (1000 MHz), vid 0x12
ACPI: (supports S0 S1 S4 S5)
Freeing unused kernel memory: 352k freed
Time: tsc clocksource has been installed.
Clock event device pit disabled
Clock event device lapic configured with caps set: 08
Switched to high resolution mode on CPU 0
Write protecting the kernel read-only data: 486k
Clock event device lapic configured with caps set: 08
Switched to high resolution mode on CPU 1
input: AT Translated Set 2 keyboard as /class/input/input0
Time: acpi_pm clocksource has been installed.
USB Universal Host Controller Interface driver v3.0
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
(PCI)
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 22 (level,
high) -> IRQ 22
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.0: irq 22, io mem 0xf6003000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCG] -> GSI 21 (level,
high) -> IRQ 21
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: OHCI Host Controller
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.1: irq 21, io mem 0xf6004000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:02.2[C] -> Link [APCL] -> GSI 20 (level,
high) -> IRQ 20
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: EHCI Host Controller
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 3
ehci_hcd 0000:00:02.2: debug port 3
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: irq 20, io mem 0xf6005000
ehci_hcd 0000:00:02.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 8 ports detected
SCSI subsystem initialized
libata version 2.00 loaded.
sata_nv 0000:00:0a.0: version 2.0
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APSJ] -> GSI 22 (level,
high) -> IRQ 22
PCI: Setting latency timer of device 0000:00:0a.0 to 64
ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xD800 irq 22
ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xD808 irq 22
scsi0 : sata_nv
input: ImExPS/2 Logitech Wheel Mouse as /class/input/input1
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-6, max UDMA/133, 156299375 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
scsi1 : sata_nv
ata2: SATA link down (SStatus 0 SControl 300)
scsi 0:0:0:0: Direct-Access     ATA      ST380817AS       3.42 PQ: 0
ANSI: 5
SCSI device sda: 156299375 512-byte hdwr sectors (80025 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 156299375 512-byte hdwr sectors (80025 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2
sd 0:0:0:0: Attached scsi disk sda
sata_sil 0000:02:0d.0: version 2.0
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
ACPI: PCI Interrupt 0000:02:0d.0[A] -> Link [APC2] -> GSI 17 (level,
low) -> IRQ 17
ata3: SATA max UDMA/100 cmd 0xFFFFC2000001A080 ctl 0xFFFFC2000001A08A
bmdma 0xFFFFC2000001A000 irq 17
ata4: SATA max UDMA/100 cmd 0xFFFFC2000001A0C0 ctl 0xFFFFC2000001A0CA
bmdma 0xFFFFC2000001A008 irq 17
scsi2 : sata_sil
ata3: SATA link down (SStatus 0 SControl 310)
scsi3 : sata_sil
ata4: SATA link down (SStatus 0 SControl 310)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
audit(1164737012.513:2): enforcing=1 old_enforcing=0 auid=4294967295
security:  3 users, 6 roles, 1569 types, 170 bools, 1 sens, 1024 cats
security:  59 classes, 48714 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev sda1, type ext3), uses xattr
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
SELinux: initialized (dev selinuxfs, type selinuxfs), uses
genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses
genfs_contexts
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev eventpollfs, type eventpollfs), uses task SIDs
SELinux: initialized (dev inotifyfs, type inotifyfs), uses
genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev cpuset, type cpuset), not configured for
labeling
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
audit(1164737012.989:3): policy loaded auid=4294967295
hda: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(66)
Uniform CD-ROM driver Revision: 3.20
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.57.
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:05.0[A] -> Link [APCH] -> GSI 21 (level,
high) -> IRQ 21
PCI: Setting latency timer of device 0000:00:05.0 to 64
input: PC Speaker as /class/input/input2
eth0: forcedeth.c: subsystem: 01458:e000 bound to 0000:00:05.0
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x1c00
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x2000
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
ACPI: PCI Interrupt 0000:02:0b.0[A] -> Link [APC4] -> GSI 19 (level,
low) -> IRQ 19
skge 1.9 addr 0xf5000000 irq 19 chip Yukon-Lite rev 9
skge eth1: addr 00:14:85:02:11:83
ieee1394: Initialized config rom entry `ip1394'
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
ACPI: PCI Interrupt 0000:02:0e.0[A] -> Link [APC3] -> GSI 18 (level,
low) -> IRQ 18
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[18]
MMIO=[f5008000-f50087ff]  Max Packet=[4096]  IR/IT contexts=[4/8]
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
ACPI: PCI Interrupt 0000:02:0a.0[A] -> Link [APC3] -> GSI 18 (level,
low) -> IRQ 18
sd 0:0:0:0: Attached scsi generic sg0 type 0
ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [APCJ] -> GSI 20 (level,
high) -> IRQ 20
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0_measure_ac97_clock: measured 54567 usecs
intel8x0: clocking to 46912
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00148556000157de]
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
lp0: using parport0 (interrupt-driven).
lp0: console ready
SELinux: initialized (dev ramfs, type ramfs), uses genfs_contexts
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
[drm] Initialized drm 1.0.1 20051102
ACPI: PCI Interrupt Link [APC5] enabled at IRQ 16
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [APC5] -> GSI 16 (level,
low) -> IRQ 16
[drm] Initialized radeon 1.25.0 20060524 on minor 0
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ibm_acpi: ec object not found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised:
dm-devel@redhat.com
device-mapper: multipath: version 1.0.5 loaded
EXT3 FS on sda1, internal journal
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
Adding 4096564k swap on /dev/sda2.  Priority:-1 extents:1
across:4096564k
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses
genfs_contexts
ip6_tables: (C) 2000-2006 Netfilter Core Team
ip_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.4 (8192 buckets, 65536 max) - 344 bytes per
conntrack
process `sysctl' is using deprecated sysctl (syscall)
net.ipv6.neigh.lo.base_reachable_time; Use
net.ipv6.neigh.lo.base_reachable_time_ms instead.
skge eth0: enabling interface
ADDRCONF(NETDEV_UP): eth0: link is not ready
skge eth0: Link is up at 100 Mbps, full duplex, flow control both
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
eth1: no link during initialization.
ADDRCONF(NETDEV_UP): eth1: link is not ready
SELinux: initialized (dev rpc_pipefs, type rpc_pipefs), uses
genfs_contexts
Bluetooth: Core ver 2.11
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
eth0: no IPv6 routers present
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata1: EH complete
SCSI device sda: 156299375 512-byte hdwr sectors (80025 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 156299375 512-byte hdwr sectors (80025 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
[drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
[drm:drm_unlock] *ERROR* Process 3225 using kernel context 0
( softirq-timer/0-5    |#0): new 7 us maximum-latency wakeup.
(           jackd-3457 |#0): new 12 us maximum-latency wakeup.
(         beagled-3410 |#1): new 15 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 15 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 15 us maximum-latency wakeup.
(         beagled-3410 |#1): new 16 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 16 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 19 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 21 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 22 us maximum-latency wakeup.
(            escd-3378 |#1): new 27 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 27 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 4007 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 13 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 15 us maximum-latency wakeup.
(            mono-3626 |#0): new 16 us maximum-latency wakeup.
( softirq-timer/1-17   |#1): new 17 us maximum-latency wakeup.
( softirq-timer/0-5    |#0): new 17 us maximum-latency wakeup.
( softirq-timer/1-17   |#1): new 18 us maximum-latency wakeup.
(           jackd-3457 |#0): new 19 us maximum-latency wakeup.
(           jackd-3457 |#0): new 19 us maximum-latency wakeup.
(           jackd-3457 |#0): new 22 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 24 us maximum-latency wakeup.
( softirq-timer/1-17   |#1): new 25 us maximum-latency wakeup.
( softirq-timer/1-17   |#1): new 26 us maximum-latency wakeup.
( softirq-timer/1-17   |#1): new 27 us maximum-latency wakeup.
(           jackd-3457 |#0): new 79 us maximum-latency wakeup.
(           jackd-3457 |#0): new 264 us maximum-latency wakeup.
(           jackd-3457 |#0): new 1857 us maximum-latency wakeup.
(  gnome-terminal-3429 |#1): new 11 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 13 us maximum-latency wakeup.
( softirq-timer/0-5    |#0): new 16 us maximum-latency wakeup.
( softirq-timer/0-5    |#0): new 17 us maximum-latency wakeup.
( softirq-timer/0-5    |#0): new 17 us maximum-latency wakeup.
( softirq-timer/0-5    |#0): new 18 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 20 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 22 us maximum-latency wakeup.
( softirq-timer/1-17   |#1): new 22 us maximum-latency wakeup.
(          IRQ 19-1034 |#0): new 26 us maximum-latency wakeup.
( softirq-timer/0-5    |#0): new 27 us maximum-latency wakeup.
(            mono-3626 |#1): new 27 us maximum-latency wakeup.
(          IRQ 22-431  |#0): new 29 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 32 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 4007 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 4010 us maximum-latency wakeup.
(            Xorg-3225 |#0): new 4 us maximum-latency wakeup.
( softirq-timer/0-5    |#0): new 7 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 9 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 17 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 17 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 18 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 23 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 25 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 25 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 28 us maximum-latency wakeup.
(           jackd-4037 |#0): new 590 us maximum-latency wakeup.
(            japa-4096 |#0): new 821 us maximum-latency wakeup.
(            japa-4096 |#0): new 1938 us maximum-latency wakeup.
(            japa-4096 |#0): new 2241 us maximum-latency wakeup.
(          IRQ 18-1081 |#0): new 4011 us maximum-latency wakeup.
(          IRQ 18-1081 |#0): new 11185 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 12014 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 9 us maximum-latency wakeup.
( softirq-timer/0-5    |#0): new 11 us maximum-latency wakeup.
(           pcscd-2690 |#1): new 14 us maximum-latency wakeup.
( softirq-timer/1-17   |#1): new 15 us maximum-latency wakeup.
(      gdm-binary-3224 |#1): new 15 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 16 us maximum-latency wakeup.
(             snd-4040 |#0): new 18 us maximum-latency wakeup.
(            jaaa-4092 |#0): new 19 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 22 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 22 us maximum-latency wakeup.
(            japa-4096 |#0): new 759 us maximum-latency wakeup.
(          IRQ 18-1081 |#0): new 9592 us maximum-latency wakeup.
(        metacity-3327 |#0): new 8 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 9 us maximum-latency wakeup.
(          aeolus-4085 |#1): new 12 us maximum-latency wakeup.
( softirq-timer/1-17   |#1): new 14 us maximum-latency wakeup.
( softirq-timer/1-17   |#1): new 15 us maximum-latency wakeup.
(            japa-4096 |#0): new 16 us maximum-latency wakeup.
( softirq-timer/1-17   |#1): new 17 us maximum-latency wakeup.
(            japa-4096 |#0): new 17 us maximum-latency wakeup.
(         beagled-3412 |#1): new 19 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 26 us maximum-latency wakeup.
(             snd-4040 |#1): new 1107 us maximum-latency wakeup.
(            japa-4096 |#0): new 1445 us maximum-latency wakeup.
(            japa-4096 |#0): new 2110 us maximum-latency wakeup.
(        qjackctl-4038 |#1): new 2328 us maximum-latency wakeup.
(            japa-4096 |#0): new 2548 us maximum-latency wakeup.
(          IRQ 18-1081 |#0): new 10291 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 14 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 15 us maximum-latency wakeup.
( softirq-timer/1-17   |#1): new 19 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 21 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 23 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 5145 us maximum-latency wakeup.
(          IRQ 18-1081 |#0): new 5494 us maximum-latency wakeup.
( softirq-timer/0-5    |#0): new 14 us maximum-latency wakeup.
(  gnome-terminal-3429 |#1): new 14 us maximum-latency wakeup.
( softirq-timer/1-17   |#1): new 15 us maximum-latency wakeup.
( softirq-timer/1-17   |#1): new 17 us maximum-latency wakeup.
(             snd-4040 |#0): new 19 us maximum-latency wakeup.
( softirq-timer/1-17   |#1): new 19 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 22 us maximum-latency wakeup.
(          IRQ 18-1081 |#1): new 23 us maximum-latency wakeup.
(            japa-4096 |#0): new 1781 us maximum-latency wakeup.



