Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129310AbRCALTY>; Thu, 1 Mar 2001 06:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129155AbRCALTP>; Thu, 1 Mar 2001 06:19:15 -0500
Received: from mgw-x1.nokia.com ([131.228.20.21]:54153 "EHLO mgw-x1.nokia.com")
	by vger.kernel.org with ESMTP id <S129310AbRCALTA>;
	Thu, 1 Mar 2001 06:19:00 -0500
Date: Thu, 1 Mar 2001 13:18:57 +0200 (EET)
From: "Matilainen Panu (NRC/Helsinki)" <panu.matilainen@nokia.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.x very unstable on 8-way IBM 8500R
Message-ID: <Pine.LNX.4.30.0103011229500.23756-100000@godzilla.research.nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been playing around with 8-way IBM8500R (8x700MHz Xeon) with 4.5GB
memory & AIC7xxx SCSI-controller. It's perfectly stable with 2.2-kernel
(from Red Hat 7) but very erratic on all 2.4-kernels I've tried it with
(2.4.[012], compiled both with egcs and RH7's gcc-2.96, both share the
same symptoms). It did have a ServeRAID controller too but IBM suggested
we take it out since 4500R also had problems with it on 2.4 but it didn't
make any difference at all. Also tried to turn off highmem support but
didn't make difference either.

Symptoms: it sometimes boots and stays up for a while (anything between 10
seconds to maximum of about half an hour) but most of the time it locks up
early in the boot while its enabling the CPUs:

--
Booting processor 4/3 eip 2000
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Waiting for send to finish...
+Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2.
Sending STARTUP #1.
After apic_write.
Startup point 1.
Waiting for send to finish...
+Sending STARTUP #2.
After apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 4.
After Callout 4.
-- 
..this is where it *usually* locks up, but the processor number where it
hangs varies randomly. Also it has locked up in other places too a couple
of times. If it boots and crashes then there's nothing in the logs, it's
just a sudden hard lockup.

If it is booted with "nosmp noapic" it seems perfectly stable but I'd sure
like to use those other 7 CPU's too :)

Any ideas/suggestions/patches etc would be greatly appreciated...

	- Panu -

Here's a bootlog of a rare succesfull boot (hopefully got the copy-paste
right...)
---
Inspecting /boot/System.map-2.4.2
Loaded 14798 symbols from /boot/System.map-2.4.2.
Symbols match kernel version 2.4.2.
No module symbols loaded.
 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1399.19 BogoMIPS
Stack at about c5cd7fb8
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check reporting enabled on CPU#2.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
OK.
CPU2: Intel Pentium III (Cascades) stepping 01
CPU has booted.
Booting processor 3/2 eip 2000
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Waiting for send to finish...
+Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2.
Sending STARTUP #1.
After apic_write.
Startup point 1.
Waiting for send to finish...
+Sending STARTUP #2.
After apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 3.
After Callout 3.
Initializing CPU#3
CPU#3 (phys ID: 2) waiting for CALLOUT
CALLIN, before setup_local_APIC().
masked ExtINT on CPU#3
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1399.19 BogoMIPS
Stack at about c5cd5fb8
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check reporting enabled on CPU#3.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
OK.
CPU3: Intel Pentium III (Cascades) stepping 01
CPU has booted.
Booting processor 4/3 eip 2000
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Waiting for send to finish...
+Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2.
Sending STARTUP #1.
After apic_write.
Startup point 1.
Waiting for send to finish...
+Sending STARTUP #2.
After apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 4.
After Callout 4.
Initializing CPU#4
CPU#4 (phys ID: 3) waiting for CALLOUT
CALLIN, before setup_local_APIC().
masked ExtINT on CPU#4
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1399.19 BogoMIPS
Stack at about c5cd3fb8
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check reporting enabled on CPU#4.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
OK.
CPU4: Intel Pentium III (Cascades) stepping 01
CPU has booted.
Booting processor 5/4 eip 2000
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Waiting for send to finish...
+Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2.
Sending STARTUP #1.
After apic_write.
Startup point 1.
Waiting for send to finish...
+Sending STARTUP #2.
After apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 5.
After Callout 5.
Initializing CPU#5
CPU#5 (phys ID: 4) waiting for CALLOUT
CALLIN, before setup_local_APIC().
masked ExtINT on CPU#5
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1399.19 BogoMIPS
Stack at about c5cfffb8
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check reporting enabled on CPU#5.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
OK.
CPU5: Intel Pentium III (Cascades) stepping 01
CPU has booted.
Booting processor 6/5 eip 2000
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Waiting for send to finish...
+Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2.
Sending STARTUP #1.
After apic_write.
Startup point 1.
Waiting for send to finish...
+Sending STARTUP #2.
After apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 6.
After Callout 6.
Initializing CPU#6
CPU#6 (phys ID: 5) waiting for CALLOUT
CALLIN, before setup_local_APIC().
masked ExtINT on CPU#6
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1399.19 BogoMIPS
Stack at about c5cfdfb8
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check reporting enabled on CPU#6.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
OK.
CPU6: Intel Pentium III (Cascades) stepping 01
CPU has booted.
Booting processor 7/6 eip 2000
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Waiting for send to finish...
+Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2.
Sending STARTUP #1.
After apic_write.
Startup point 1.
Waiting for send to finish...
+Sending STARTUP #2.
After apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 7.
After Callout 7.
Initializing CPU#7
CPU#7 (phys ID: 6) waiting for CALLOUT
CALLIN, before setup_local_APIC().
masked ExtINT on CPU#7
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1399.19 BogoMIPS
Stack at about c5cfbfb8
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check reporting enabled on CPU#7.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
OK.
CPU7: Intel Pentium III (Cascades) stepping 01
CPU has booted.
Before bogomips.
Total of 8 processors activated (11190.27 BogoMIPS).
Before bogocount - setting activated=1.
Boot done.
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 14 ... ok.
Synchronizing Arb IDs.
..TIMER: vector=49 pin1=2 pin2=-1
activating NMI Watchdog ... done.
testing the IO APIC.......................

.................................... done.
calibrating APIC timer ...
..... CPU clock speed is 699.9388 MHz.
..... host bus clock speed is 99.9912 MHz.
cpu: 0, clocks: 999912, slice: 111101
CPU0<T0:999904,T1:888800,D:3,S:111101,C:999912>
cpu: 2, clocks: 999912, slice: 111101
cpu: 3, clocks: 999912, slice: 111101
cpu: 7, clocks: 999912, slice: 111101
cpu: 5, clocks: 999912, slice: 111101
cpu: 6, clocks: 999912, slice: 111101
cpu: 4, clocks: 999912, slice: 111101
cpu: 1, clocks: 999912, slice: 111101
CPU1<T0:999904,T1:777696,D:6,S:111101,C:999912>
CPU2<T0:999904,T1:666592,D:9,S:111101,C:999912>
CPU3<T0:999904,T1:555488,D:12,S:111101,C:999912>
CPU4<T0:999904,T1:444384,D:15,S:111101,C:999912>
CPU5<T0:999904,T1:333296,D:2,S:111101,C:999912>
CPU6<T0:999904,T1:222192,D:5,S:111101,C:999912>
CPU7<T0:999904,T1:111088,D:8,S:111101,C:999912>
checking TSC synchronization across CPUs:
BIOS BUG: CPU#7 improperly initialized, has 3 usecs TSC skew! FIXED.
Setting commenced=1, go go go
PCI: PCI BIOS revision 2.10 entry at 0xfd26c, last bus=15
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Compaq host bridge: last bus ff
PCI->APIC IRQ transform: (B0,I2,P0) -> 53
PCI->APIC IRQ transform: (B0,I14,P0) -> 51
PCI->APIC IRQ transform: (B0,I14,P0) -> 51
PCI->APIC IRQ transform: (B0,I15,P3) -> 49
PCI: Cannot allocate resource region 4 of device 00:0f.1
  got res[1000:100f] for resource 4 of Intel Corporation 82371AB PIIX4 IDE
isapnp: Scanning for Pnp cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
IA-32 Microcode Update Driver: v1.08 <tigran@veritas.com>
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 2910933kB/2779861kB, 8192 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: enabling 8 loop devices
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 79
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:pio, hdb:pio
hda: LTN485S, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 48X CD-ROM drive, 120kB Cache
Uniform CD-ROM driver Revision: 3.12
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
Non-volatile memory driver v1.1
SCSI subsystem driver Revision: 1.00
(scsi0) <Adaptec AIC-7896/7 Ultra2 SCSI host adapter> found at PCI 0/14/1
(scsi0) Wide Channel B, SCSI ID=7, 32/255 SCBs
(scsi0) Downloading sequencer code... 392 instructions downloaded
(scsi1) <Adaptec AIC-7896/7 Ultra2 SCSI host adapter> found at PCI 0/14/0
(scsi1) Wide Channel A, SCSI ID=7, 32/255 SCBs
(scsi1) Downloading sequencer code... 392 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AIC-7896/7 Ultra2 SCSI host adapter>
scsi1 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AIC-7896/7 Ultra2 SCSI host adapter>
(scsi1:0:0:0) Synchronous at 80.0 Mbyte/sec, offset 63.
  Vendor: IBM-PSG   Model: ST318404LC    !#  Rev: 3283
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi1:0:1:0) Synchronous at 80.0 Mbyte/sec, offset 63.
  Vendor: IBM-PSG   Model: ST318404LC    !#  Rev: 3283
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: IBM       Model: TP4.6 V41b3       Rev: 4.1b
  Type:   Processor                          ANSI SCSI revision: 02
Detected scsi disk sda at scsi1, channel 0, id 0, lun 0
Detected scsi disk sdb at scsi1, channel 0, id 1, lun 0
SCSI device sda: 35548320 512-byte hdwr sectors (18201 MB)
Partition check:
 sda: sda1 sda2 sda3 < sda5 >
SCSI device sdb: 35548320 512-byte hdwr sectors (18201 MB)
 sdb: sdb1 sdb2 < sdb5 >
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 65536 buckets, 512Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 208k freed
Adding Swap: 2096220k swap-space (priority -1)


