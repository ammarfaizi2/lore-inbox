Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbULPQXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbULPQXH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 11:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbULPQWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 11:22:37 -0500
Received: from piglet.wetlettuce.com ([82.68.149.69]:27520 "EHLO
	piglet.wetlettuce.com") by vger.kernel.org with ESMTP
	id S261431AbULPQVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 11:21:52 -0500
Message-ID: <59719.192.102.214.6.1103214002.squirrel@webmail.wetlettuce.com>
Date: Thu, 16 Dec 2004 16:20:02 -0000 (GMT)
Subject: Lockup with 2.6.9-ac15 related to netconsole
From: "Mark Broadbent" <markb@wetlettuce.com>
To: <mpm@selenic.com>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Cc: <linux-kernel@vger.kernel.org>
Reply-To: markb@wetlettuce.com
X-Mailer: SquirrelMail (version 1.2.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MailScanner: Mail is clear of Viree
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm having problem using ethereal/tcpdump in conjunction with the
netconsole (built as a module).  If the netconsole is loaded and I try to
launch tcpdump on the same interface as the netconsole is transmitting I
get a hard lock-up.  The following commands can consistently do this:
# tcpdump -i eth0
eth0: Promiscuous Mode Entered
<... normal output ...>
^C
# modprobe netconsole
# tcpdump -i eth0
eth0: Promiscuous Mode Entered
<4>NMI Watchdog detected LOCKUP

I attempted to dump registers to the screen using SysRq but all I get is:

<6>SysRq:

There are no kernel messages (after the ones attached) received by the
machine collecting the netconsole output.
Attached are dmesg, lspci and lsmod output.

/proc/version says:
Linux version 2.6.9-ac15-mb7 (broadben@mbpc) (gcc version 3.3.5 (Debian
1:3.3.5-3)) #12 SMP Wed Dec 15 09:42:13 GMT 2004
netconsole options:
options netconsole
netconsole=@172.20.0.117/eth0,514@172.20.0.127/00:02:B3:03:4E:EA
Command line:
root=/dev/hdb1 nmi_watchdog=1


Any ideas (apart from not using tcpdump and netconsole on the same interface)

Thanks
Mark

-- 
Mark Broadbent <markb@wetlettuce.com>
Web: http://www.wetlettuce.com

dmesg output:

Linux version 2.6.9-ac15-mb7 (broadben@mbpc) (gcc version 3.3.5 (Debian
1:3.3.5-3)) #12 SMP Wed Dec 15 09:42:13 GMT 2004BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000fc0f0
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                   ) @ 0x000fa3b0
ACPI: RSDT (v001 AMIINT INTEL865 0x00000010 MSFT 0x00000097) @ 0x1fff0000
ACPI: FADT (v001 AMIINT INTEL865 0x00000011 MSFT 0x00000097) @ 0x1fff0030
ACPI: MADT (v001 AMIINT INTEL865 0x00000009 MSFT 0x00000097) @ 0x1fff00c0
ACPI: DSDT (v001  INTEL    I865G 0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 20 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: root=/dev/hdb1 nmi_watchdog=1
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 3001.290 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 515976k/524224k available (1526k kernel code, 7648k reserved, 766k
data, 156k init, 0k highmem)Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 5947.39 BogoMIPS (lpj=2973696)
Security Scaffold v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 09
per-CPU timeslice cutoff: 1462.52 usecs.
task migration cache decay timeout: 2 msecs.
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay loop... 5996.54 BogoMIPS (lpj=2998272)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 09
Total of 2 processors activated (11943.93 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
testing NMI watchdog ... OK.
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdb81, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.ICHB._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Disabled by ACPI
PCI: Using ACPI for IRQ routing
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI interrupt 0000:02:03.0[A] -> GSI 19 (level, low) -> IRQ 19
ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 20 (level, low) -> IRQ 20
Machine check exception polling timer started.
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
hw_random: RNG not detected
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is
60 seconds).serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: Maxtor 92049U6, ATA DISK drive
hdb: MAXTOR 6L040J2, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: GENERIC CRD-BP1600P, ATAPI CD/DVD-ROM drive
hdd: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: 40026672 sectors (20493 MB) w/2048KiB Cache, CHS=39709/16/63, UDMA(66)
hda: cache flushes not supported
 hda: hda1
hdb: max request size: 128KiB
hdb: 78177792 sectors (40027 MB) w/1818KiB Cache, CHS=65535/16/63, UDMA(100)
hdb: cache flushes supported
 hdb: hdb1 hdb2 hdb3 hdb4
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 15
ReiserFS: hdb1: found reiserfs format "3.6" with standard journal
ReiserFS: hdb1: using ordered data mode
ReiserFS: hdb1: journal params: device hdb1, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max trans
age 30ReiserFS: hdb1: checking transaction log (hdb1)
ReiserFS: hdb1: replayed 11 transactions in 0 seconds
ReiserFS: hdb1: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 156k freed
hdc: ATAPI 40X CD-ROM CD-R/RW drive, 4096kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
Adding 2008116k swap on /dev/hdb3.  Priority:-1 extents:1
ReiserFS: hdb1: Removing [6201 106807 0x0 SD]..done
ReiserFS: hdb1: Removing [6201 106340 0x0 SD]..done
ReiserFS: hdb1: Removing [6201 106169 0x0 SD]..done
ReiserFS: hdb1: Removing [6201 103322 0x0 SD]..done
ReiserFS: hdb1: There were 4 uncompleted unlinks/truncates. Completed
Linux Tulip driver version 1.1.13-NAPI (May 11, 2002)
ACPI: PCI interrupt 0000:02:03.0[A] -> GSI 19 (level, low) -> IRQ 19
tulip0:  MII transceiver #1 config 1000 status 786d advertising 05e1.
tulip0:  MII transceiver #2 config 1000 status 786d advertising 05e1.
tulip0:  MII transceiver #3 config 1000 status 786d advertising 05e1.
tulip0:  MII transceiver #4 config 1000 status 786d advertising 05e1.
eth0: ADMtek Comet rev 17 at 0xcc00, 00:04:E2:39:36:B4, IRQ 19.
ReiserFS: hdb2: found reiserfs format "3.6" with standard journal
ReiserFS: hdb2: using ordered data mode
ReiserFS: hdb2: journal params: device hdb2, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max trans
age 30ReiserFS: hdb2: checking transaction log (hdb2)
ReiserFS: hdb2: Using r5 hash to sort names
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 865 Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 128M @ 0xf0000000
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.0: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 16, io base 0000e000
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.1: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 19, io base 0000e400
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 18, io base 0000e800
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.3: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: irq 16, io base 0000ec00
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI
ControllerPCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 23, pci mem e09d6c00
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49569 usecs
intel8x0: clocking to 48000
r8169 Gigabit Ethernet driver 1.2 loaded
ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 20 (level, low) -> IRQ 20
r8169: NAPI enabled
eth1: Identified chip type is 'RTL8169s/8110s'.
eth1: RTL8169 at 0xe0ac8b00, 00:0c:76:91:7d:6b, IRQ 20
r8169: eth1: link up
eth0: Setting full-duplex based on MII#1 link partner capability of 41e1.
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.12
NET: Registered protocol family 10
Disabled Privacy Extensions on device c03042e0(lo)
IPv6 over IPv4 tunneling driver
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
microcode: CPU1 updated from revision 0x14 to 0x2e, date = 08112004
microcode: CPU0 updated from revision 0x14 to 0x2e, date = 08112004
IA-32 Microcode Update Driver v1.14 unregistered
ACPI: Processor [CPU1] (supports C1, 8 throttling states)
ACPI: Processor [CPU2] (supports C1, 8 throttling states)
ACPI: Power Button (FF) [PWRF]
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
lp0: using parport0 (polling).
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
eth0: no IPv6 routers present
eth1: no IPv6 routers present
nfs warning: mount version older than kernel


lsmod output:

Module                  Size  Used by
nfsd                  216992  8
exportfs                6272  1 nfsd
parport_pc             34496  1
lp                     10376  0
parport                39496  2 parport_pc,lp
binfmt_misc            12040  1
autofs4                18948  1
thermal                13320  0
fan                     4228  0
button                  6800  0
processor              13728  1 thermal
md5                     4224  1
ipv6                  242816  14
rtc                    12744  0
8250                   20992  0
serial_core            22528  1 8250
nfs                   210404  6
lockd                  66120  3 nfsd,nfs
sunrpc                147108  11 nfsd,nfs,lockd
r8169                  20104  0
snd_intel8x0           33356  1
snd_ac97_codec         65232  1 snd_intel8x0
snd_pcm_oss            50344  0
snd_mixer_oss          19072  1 snd_pcm_oss
snd_pcm                92292  2 snd_intel8x0,snd_pcm_oss
snd_timer              24836  1 snd_pcm
snd_page_alloc          9992  2 snd_intel8x0,snd_pcm
gameport                4864  1 snd_intel8x0
snd_mpu401_uart         7936  1 snd_intel8x0
snd_rawmidi            24484  1 snd_mpu401_uart
snd_seq_device          8072  1 snd_rawmidi
snd                    54884  11
snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_devicesoundcore               9952  1 snd
ehci_hcd               27908  0
uhci_hcd               31376  0
usbcore               111844  4 ehci_hcd,uhci_hcd
intel_mch_agp          10256  0
intel_agp              21024  1
agpgart                32940  2 intel_mch_agp,intel_agp
evdev                   9088  0
ext3                  116712  1
jbd                    63128  1 ext3
mbcache                 8836  1 ext3
tulip                  46752  0
crc32                   4608  2 r8169,tulip
ide_cd                 40608  0
cdrom                  38172  1 ide_cd

lspci output:

0000:00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM Controller/Host-Hub
Interface (rev 02)	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7280
	Flags: bus master, fast devsel, latency 0
	Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [e4] #09 [2106]
	Capabilities: [a0] AGP version 3.0

0000:00:01.0 PCI bridge: Intel Corp. 82865G/PE/P PCI to AGP Controller
(rev 02) (prog-if 00 [Normal decode])	Flags: bus master, 66MHz, fast devsel, latency 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	Memory behind bridge: fc900000-fe9fffff
	Prefetchable memory behind bridge: dff00000-efefffff

0000:00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI
#1 (rev 02) (prog-if 00 [UHCI])	Subsystem: Micro-Star International Co., Ltd. 865PE Neo2 (MS-6728)
	Flags: bus master, medium devsel, latency 0, IRQ 16
	I/O ports at e000 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI
#2 (rev 02) (prog-if 00 [UHCI])	Subsystem: Micro-Star International Co., Ltd. 865PE Neo2 (MS-6728)
	Flags: bus master, medium devsel, latency 0, IRQ 19
	I/O ports at e400 [size=32]

0000:00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI
#3 (rev 02) (prog-if 00 [UHCI])	Subsystem: Micro-Star International Co., Ltd. 865PE Neo2 (MS-6728)
	Flags: bus master, medium devsel, latency 0, IRQ 18
	I/O ports at e800 [size=32]

0000:00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI
#4 (rev 02) (prog-if 00 [UHCI])	Subsystem: Micro-Star International Co., Ltd. 865PE Neo2 (MS-6728)
	Flags: bus master, medium devsel, latency 0, IRQ 16
	I/O ports at ec00 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI
Controller (rev 02) (prog-if 20 [EHCI])	Subsystem: Micro-Star International Co., Ltd. 865PE Neo2 (MS-6728)
	Flags: bus master, medium devsel, latency 0, IRQ 23
	Memory at febffc00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] #0a [20a0]

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2) (prog-if 00
[Normal decode])	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fea00000-feafffff

0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge
(rev 02)	Flags: bus master, medium devsel, latency 0

0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA
100 Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])	Subsystem: Micro-Star International Co., Ltd. 865PE Neo2 (MS-6728)
	Flags: bus master, medium devsel, latency 0, IRQ 18
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at fc00 [size=16]
	Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

0000:00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller
(rev 02)	Subsystem: Micro-Star International Co., Ltd. 865PE Neo2 (MS-6728)
	Flags: medium devsel, IRQ 17
	I/O ports at 0c00 [size=32]

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER
(ICH5/ICH5R) AC'97 Audio Controller (rev 02)	Subsystem: Micro-Star International Co., Ltd.: Unknown device 0080
	Flags: bus master, medium devsel, latency 0, IRQ 17
	I/O ports at dc00 [size=256]
	I/O ports at d800 [size=64]
	Memory at febffa00 (32-bit, non-prefetchable) [size=512]
	Memory at febff900 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2

0000:01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2
MX/MX 400] (rev a1) (prog-if 00 [VGA])	Subsystem: Guillemot Corporation: Unknown device 7100
	Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 16
	Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at fe9f0000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 2
	Capabilities: [44] AGP version 2.0

0000:02:03.0 Ethernet controller: Accton Technology Corporation EN-1216
Ethernet Adapter (rev 11)	Subsystem: Standard Microsystems Corp [SMC]: Unknown device 1255
	Flags: bus master, medium devsel, latency 32, IRQ 19
	I/O ports at cc00 [size=256]
	Memory at feaffc00 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at feac0000 [disabled] [size=128K]
	Capabilities: [c0] Power Management version 2

0000:02:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169
Gigabit Ethernet (rev 10)	Subsystem: Micro-Star International Co., Ltd.: Unknown device 728c
	Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 20
	I/O ports at c800 [size=256]
	Memory at feaffb00 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at feaa0000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2


dmesg netconsole output:

Linux Tulip driver version 1.1.13-NAPI (May 11, 2002)
ACPI: PCI interrupt 0000:02:03.0[A] -> GSI 19 (level, low) -> IRQ 19
tulip0:  MII transceiver #1 config 1000 status 786d advertising 05e1.
tulip0:  MII transceiver #2 config 1000 status 786d advertising 05e1.
tulip0:  MII transceiver #3 config 1000 status 786d advertising 05e1.
tulip0:  MII transceiver #4 config 1000 status 786d advertising 05e1.
eth0: ADMtek Comet rev 17 at 0xcc00, 00:04:E2:39:36:B4, IRQ 19.
netconsole: local port 6665
netconsole: local IP 172.20.0.117
netconsole: interface eth0
netconsole: remote port 514
netconsole: remote IP 172.20.0.127
netconsole: remote ethernet address 00:02:b3:03:4e:ea
netconsole: device eth0 not up yet, forcing it
netconsole: carrier detect appears flaky, waiting 10 seconds
eth0: Setting full-duplex based on MII#1 link partner capability of 41e1.
netconsole: network logging started



