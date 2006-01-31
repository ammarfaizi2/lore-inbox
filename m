Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751587AbWAaWGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbWAaWGl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 17:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbWAaWGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 17:06:41 -0500
Received: from balin.visn.co.uk ([69.57.146.32]:22954 "EHLO balin.visn.co.uk")
	by vger.kernel.org with ESMTP id S1751585AbWAaWGk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 17:06:40 -0500
Message-ID: <43DFDFFC.1030403@coada.org.uk>
Date: Tue, 31 Jan 2006 22:09:00 +0000
From: Andrew Akehurst <ada@coada.org.uk>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: r8169 driver - no net connection and hang at shutdown
Content-Type: multipart/mixed;
 boundary="------------080003070408080002030807"
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - balin.visn.co.uk
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - coada.org.uk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080003070408080002030807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I'm having some trouble with r8169 and Linux kernel 2.6.15.1 getting my 
Realtek 8169 ethernet controller to work. This is the gigabit 
ethernet-capable embedded version which is integrated into a Foxconn 
925A01-8EKRS2 motherboard.

I'm not sure if this is the right place to post, so I apologise if this 
is more appropriate to linux-kernel.

Whenever the system boots, the r8169 driver does not pick up the MAC
address for the card; it reports the MAC addrress as being
FF:FF:FF:FF:FF:FF. (I have also tried various 2.6.12, 2.6.13, 2.6.14
kernels with the same experience). My first thought was "broken chip", 
but this box has similar issues with other network cards which I'll 
mention later.

When I run ifconfig, this reports:

eth0      Link encap:Ethernet  HWaddr FF:FF:FF:FF:FF:FF
              inet addr:192.168.0.9  Bcast:192.168.255.255  Mask:255.255.0.0
              UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
              RX packets:0 errors:0 dropped:4294967290 overruns:0 frame:0
              TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
              collisions:0 txqueuelen:1000
              RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
              Interrupt:21 Base address:0x4800

The IP address has been assigned statically in /etc/network/interfaces
as I don't use DHCP (and I doubt DHCP would currently work anyway). If I
try to use "ifconfig eth0 hw ether" to set the MAC address then ifconfig
just hangs.

I am unable to ping anywhere in my network or beyond the gateway, nor
can I establish any network connections to any other machine. Given that
there appears to be something wrong at the link layer, I wouldn't expect
higher layer diagnostics to reveal much, but I figured it was worth a try.

In addition, my system tends to hang at the "deconfiguring network
interfaces" stage of system shutdown.

I have tried building the r8169 module both with and without gigabit
ethernet support and using MMIO versus PIO - no luck.

 From browsing around the web, some people suggest changing the Plug and
Play OS setting in the BIOS, only my BIOS doesn't appear to have any
such setting. The only option in the PNP area was to reset the ESCD
data, so I tried this to see if that would help, but still the issue
persisted.

Some reports seemed to suggest an issue with IRQ assignment and ACPI,
so I tried booting with kernel options including nolapic, acpi=off,
acpi=noirq, pci=noacpi and various combinations of these. None of them
worked (in fact nolapic hangs my system during boot-up).

I include the output from lspci -vvv and dmesg so you can see what is
happening. I also used Donald Becker's rtl8169-diag program, but that
complained that "A recognized chip has been found, but it does not
appear to exist in I/O space".

Incidentally, I tried some known good 3Com and D-Link network cards in
this machine (both with and without the Realtek enabled in the BIOS) and
I couldn't get them to work either for similar reasons. If it were just
the Realtek I might assume it was a defective chip, but the lack of
ability to get any network card working on this machine suggests a
deeper issue.

I'm happy to try testing new patches or settings, but would appreciate
some tips on what to do next. In all other respects my system is happy
and stable, it just lacks a working network connection.

Thanks in advance

Andrew

--------------080003070408080002030807
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

88:207f
[17179581.756000] ata2: dev 0 ATA-7, max UDMA/133, 586072368 sectors: LBA48
[17179581.756000] ata2: dev 0 configured for UDMA/133
[17179581.756000] scsi1 : ahci
[17179581.960000] ata3: no device found (phy stat 00000000)
[17179581.960000] scsi2 : ahci
[17179582.164000] ata4: no device found (phy stat 00000000)
[17179582.164000] scsi3 : ahci
[17179582.164000]   Vendor: ATA       Model: ST3300831AS       Rev: 3.01
[17179582.164000]   Type:   Direct-Access                      ANSI SCSI revision: 05
[17179582.164000]   Vendor: ATA       Model: ST3300831AS       Rev: 3.01
[17179582.164000]   Type:   Direct-Access                      ANSI SCSI revision: 05
[17179582.168000] Probing IDE interface ide1...
[17179582.748000] hda: ATAPI 52X DVD-ROM CD-R/RW drive, 2048kB Cache
[17179582.748000] Uniform CD-ROM driver Revision: 3.20
[17179582.764000] SCSI device sda: 586072368 512-byte hdwr sectors (300069 MB)
[17179582.764000] SCSI device sda: drive cache: write back
[17179582.764000] SCSI device sda: 586072368 512-byte hdwr sectors (300069 MB)
[17179582.764000] SCSI device sda: drive cache: write back
[17179582.764000]  sda: sda1 sda2 < sda5 sda6 sda7 >
[17179582.808000] sd 0:0:0:0: Attached scsi disk sda
[17179582.808000] SCSI device sdb: 586072368 512-byte hdwr sectors (300069 MB)
[17179582.808000] SCSI device sdb: drive cache: write back
[17179582.808000] SCSI device sdb: 586072368 512-byte hdwr sectors (300069 MB)
[17179582.808000] SCSI device sdb: drive cache: write back
[17179582.808000]  sdb: sdb1 sdb2 < sdb5 sdb6 sdb7 >
[17179582.852000] sd 1:0:0:0: Attached scsi disk sdb
[17179583.068000] Attempting manual resume
[17179583.068000] swsusp: Resume From Partition 8:6
[17179583.068000] PM: Checking swsusp image.
[17179583.076000] swsusp: Error -22 check for resume file
[17179583.076000] PM: Resume from disk failed.
[17179583.116000] usbcore: registered new driver usbfs
[17179583.116000] usbcore: registered new driver hub
[17179583.116000] USB Universal Host Controller Interface driver v2.3
[17179583.116000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 20
[17179583.116000] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[17179583.116000] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[17179583.116000] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
[17179583.116000] uhci_hcd 0000:00:1d.0: irq 20, io base 0x0000e300
[17179583.116000] hub 1-0:1.0: USB hub found
[17179583.116000] hub 1-0:1.0: 2 ports detected
[17179583.220000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
[17179583.220000] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[17179583.220000] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[17179583.220000] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
[17179583.220000] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000e000
[17179583.220000] hub 2-0:1.0: USB hub found
[17179583.220000] hub 2-0:1.0: 2 ports detected
[17179583.324000] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
[17179583.324000] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[17179583.324000] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[17179583.324000] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
[17179583.324000] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000e100
[17179583.324000] hub 3-0:1.0: USB hub found
[17179583.324000] hub 3-0:1.0: 2 ports detected
[17179583.428000] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 16
[17179583.428000] PCI: Setting latency timer of device 0000:00:1d.3 to 64
[17179583.428000] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[17179583.428000] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
[17179583.428000] uhci_hcd 0000:00:1d.3: irq 16, io base 0x0000e200
[17179583.428000] hub 4-0:1.0: USB hub found
[17179583.428000] hub 4-0:1.0: 2 ports detected
[17179583.556000] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 20
[17179583.556000] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[17179583.556000] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[17179583.556000] PCI: cache line size of 128 is not supported by device 0000:00:1d.7
[17179583.556000] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
[17179583.556000] ehci_hcd 0000:00:1d.7: irq 20, io mem 0xd0004000
[17179583.560000] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[17179583.560000] hub 5-0:1.0: USB hub found
[17179583.560000] hub 5-0:1.0: 8 ports detected
[17179583.708000] r8169 Gigabit Ethernet driver 2.2LK loaded
[17179583.708000] ACPI: PCI Interrupt 0000:05:01.0[A] -> GSI 22 (level, low) -> IRQ 21
[17179583.720000] eth0: Identified chip type is 'RTL8169s/8110s'.
[17179583.720000] eth0: RTL8169 at 0xf8864800, ff:ff:ff:ff:ff:ff, IRQ 21
[17179587.624000] ACPI: Fan [FAN] (on)
[17179587.628000] ACPI: Thermal Zone [THRM] (36 C)
[17179587.788000] md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
[17179587.788000] md: bitmap version 4.39
[17179587.788000] md: raid1 personality registered as nr 3
[17179587.964000] md: md0 stopped.
[17179587.964000] md: bind<sdb1>
[17179587.964000] md: bind<sda1>
[17179587.964000] raid1: raid set md0 active with 2 out of 2 mirrors
[17179587.972000] md: md1 stopped.
[17179587.976000] md: bind<sdb5>
[17179587.976000] md: bind<sda5>
[17179587.976000] raid1: raid set md1 active with 2 out of 2 mirrors
[17179587.988000] md: md2 stopped.
[17179587.988000] md: bind<sdb7>
[17179587.988000] md: bind<sda7>
[17179587.988000] raid1: raid set md2 active with 2 out of 2 mirrors
[17179588.048000] Attempting manual resume
[17179588.048000] swsusp: Resume From Partition 8:6
[17179588.048000] PM: Checking swsusp image.
[17179588.048000] swsusp: Error -22 check for resume file
[17179588.048000] PM: Resume from disk failed.
[17179588.052000] ReiserFS: md0: found reiserfs format "3.6" with standard journal
[17179588.840000] ReiserFS: md0: using ordered data mode
[17179588.848000] ReiserFS: md0: journal params: device md0, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[17179588.848000] ReiserFS: md0: checking transaction log (md0)
[17179589.192000] ReiserFS: md0: replayed 18 transactions in 1 seconds
[17179589.212000] ReiserFS: md0: Using r5 hash to sort names
[17179591.724000] Adding 1052216k swap on /dev/sda6.  Priority:-1 extents:1 across:1052216k
[17179591.736000] Adding 1052216k swap on /dev/sdb6.  Priority:-2 extents:1 across:1052216k
[17179592.052000] ReiserFS: md0: Removing [7001 18698 0x0 SD]..done
[17179592.052000] ReiserFS: md0: Removing [7001 11090 0x0 SD]..done
[17179592.052000] ReiserFS: md0: Removing [7001 11001 0x0 SD]..done
[17179592.052000] ReiserFS: md0: There were 3 uncompleted unlinks/truncates. Completed
[17179592.712000] mice: PS/2 mouse device common for all mice
[17179592.988000] input: ImPS/2 Generic Wheel Mouse as /class/input/input1
[17179595.152000] device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
[17179595.860000] cdrom: open failed.
[17179596.308000] device-mapper: dm-linear: Device lookup failed
[17179596.308000] device-mapper: error adding target to table
[17179596.316000] device-mapper: dm-linear: Device lookup failed
[17179596.316000] device-mapper: error adding target to table
[17179596.320000] device-mapper: dm-linear: Device lookup failed
[17179596.320000] device-mapper: error adding target to table
[17179596.324000] device-mapper: dm-linear: Device lookup failed
[17179596.324000] device-mapper: error adding target to table
[17179596.332000] device-mapper: dm-linear: Device lookup failed
[17179596.332000] device-mapper: error adding target to table
[17179596.332000] device-mapper: dm-linear: Device lookup failed
[17179596.332000] device-mapper: error adding target to table
[17179596.332000] device-mapper: dm-linear: Device lookup failed
[17179596.332000] device-mapper: error adding target to table
[17179596.336000] device-mapper: dm-linear: Device lookup failed
[17179596.336000] device-mapper: error adding target to table
[17179596.336000] device-mapper: dm-linear: Device lookup failed
[17179596.336000] device-mapper: error adding target to table
[17179596.336000] device-mapper: dm-linear: Device lookup failed
[17179596.336000] device-mapper: error adding target to table
[17179596.336000] device-mapper: dm-linear: Device lookup failed
[17179596.336000] device-mapper: error adding target to table
[17179596.340000] device-mapper: dm-linear: Device lookup failed
[17179596.340000] device-mapper: error adding target to table
[17179596.340000] device-mapper: dm-linear: Device lookup failed
[17179596.340000] device-mapper: error adding target to table
[17179596.340000] device-mapper: dm-linear: Device lookup failed
[17179596.340000] device-mapper: error adding target to table
[17179596.344000] device-mapper: dm-linear: Device lookup failed
[17179596.344000] device-mapper: error adding target to table
[17179596.344000] device-mapper: dm-linear: Device lookup failed
[17179596.344000] device-mapper: error adding target to table
[17179596.344000] device-mapper: dm-linear: Device lookup failed
[17179596.344000] device-mapper: error adding target to table
[17179596.348000] device-mapper: dm-linear: Device lookup failed
[17179596.348000] device-mapper: error adding target to table
[17179596.348000] device-mapper: dm-linear: Device lookup failed
[17179596.348000] device-mapper: error adding target to table
[17179596.348000] device-mapper: dm-linear: Device lookup failed
[17179596.348000] device-mapper: error adding target to table
[17179598.488000] ts: Compaq touchscreen protocol output
[17179625.644000] ReiserFS: md2: found reiserfs format "3.6" with standard journal
[17179633.244000] ReiserFS: md2: using ordered data mode
[17179633.264000] ReiserFS: md2: journal params: device md2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[17179633.264000] ReiserFS: md2: checking transaction log (md2)
[17179633.400000] ReiserFS: md2: Using r5 hash to sort names
[17179633.452000] ReiserFS: md1: found reiserfs format "3.6" with standard journal
[17179633.696000] ReiserFS: md1: using ordered data mode
[17179633.716000] ReiserFS: md1: journal params: device md1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[17179633.716000] ReiserFS: md1: checking transaction log (md1)
[17179633.860000] ReiserFS: md1: Using r5 hash to sort names
[17179634.656000] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[17179634.672000] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[17179635.096000] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 16
[17179635.096000] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[17179635.176000] hda_codec: Unknown model for ALC880, trying auto-probe from BIOS...
[17179635.536000] hda_codec: Cannot set up configuration from BIOS.  Using 3-stack mode...
[17179636.088000] hw_random: RNG not detected
[17179636.328000] ieee1394: Initialized config rom entry `ip1394'
[17179636.332000] ohci1394: $Rev: 1313 $ Ben Collins <bcollins@debian.org>
[17179636.332000] ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 21 (level, low) -> IRQ 22
[17179636.332000] PCI: Via IRQ fixup for 0000:05:00.0, from 11 to 6
[17179636.484000] ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
[17179636.640000] ohci1394: fw-host0: Runaway loop while stopping context: ...
[17179636.692000] ohci1394: fw-host0: Runaway loop while stopping context: ...
[17179636.748000] ohci1394: fw-host0: Runaway loop while stopping context: ...
[17179636.800000] ohci1394: fw-host0: Runaway loop while stopping context: ...
[17179636.800000] ohci1394: fw-host0: OHCI-1394 165.165 (PCI): IRQ=[22]  MMIO=[50100000-501007ff]  Max Packet=[65536]
[17179636.800000] ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
[17179636.900000] ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
[17179637.000000] ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
[17179637.100000] ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
[17179637.200000] ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
[17179637.300000] ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
[17179637.396000] ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
[17179637.496000] ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
[17179637.596000] ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
[17179637.696000] ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
[17179637.796000] ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
[17179637.896000] ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
[17179637.992000] ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
[17179638.092000] ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
[17179638.192000] ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
[17179638.292000] ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
[17179638.392000] ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
[17179638.492000] ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
[17179638.588000] ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
[17179638.688000] ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
[17179638.788000] ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
[17179638.888000] ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
[17179638.988000] ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
[17179639.084000] ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
[17179639.184000] ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
[17179639.284000] ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
[17179639.384000] ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
[17179639.484000] ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
[17179639.584000] ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
[17179639.680000] ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
[17179639.780000] ohci1394: fw-host0: Serial EEPROM has suspicious values, attempting to setting max_packet_size to 512 bytes
[17179640.780000] ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
[17179641.008000] Real Time Clock Driver v1.12
[17179641.044000] input: PC Speaker as /class/input/input2
[17179641.116000] FDC 0 is a post-1991 82077
[17179641.528000] r8169: eth0: link up
[17179643.492000] Using specific hotkey driver
[17179643.564000] toshiba_acpi: Unknown parameter `hotkeys_over_acpi'
[17179643.576000] ACPI: Power Button (FF) [PWRF]
[17179643.576000] ACPI: Power Button (CM) [PWRB]
[17179643.600000] ibm_acpi: ec object not found
[17179647.660000] apm: BIOS not found.
[17179648.068000] Bluetooth: Core ver 2.8
[17179648.068000] NET: Registered protocol family 31
[17179648.068000] Bluetooth: HCI device and connection manager initialized
[17179648.068000] Bluetooth: HCI socket layer initialized
[17179648.092000] Bluetooth: L2CAP ver 2.8
[17179648.092000] Bluetooth: L2CAP socket layer initialized
[17179648.128000] Bluetooth: RFCOMM socket layer initialized
[17179648.128000] Bluetooth: RFCOMM TTY layer initialized
[17179648.128000] Bluetooth: RFCOMM ver 1.6




--------------080003070408080002030807
Content-Type: text/plain;
 name="lspci.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci.txt"

0000:00:00.0 Host bridge: Intel Corp. 925X Memory Controller Hub (rev 05)
	Subsystem: Intel Corp. 925X Memory Controller Hub
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Capabilities: [e0] #09 [2109]

0000:00:01.0 PCI bridge: Intel Corp. 925X PCI Express Root Port (rev 05) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x08 (32 bytes)
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: b0000000-cfffffff
	Prefetchable memory behind bridge: 50000000-500fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [88] #0d [0000]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [a0] #10 [0141]

0000:00:1b.0 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition Audio Controller (rev 03)
	Subsystem: Foxconn International, Inc.: Unknown device 0c24
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at d0000000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] #10 [0091]

0000:00:1c.0 PCI bridge: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 1 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x08 (32 bytes)
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1c.1 PCI bridge: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 2 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x08 (32 bytes)
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1c.2 PCI bridge: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 3 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x08 (32 bytes)
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1d.0 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Foxconn International, Inc.: Unknown device 0c24
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 20
	Region 4: I/O ports at e300 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Foxconn International, Inc.: Unknown device 0c24
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 4: I/O ports at e000 [size=32]

0000:00:1d.2 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Foxconn International, Inc.: Unknown device 0c24
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 4: I/O ports at e100 [size=32]

0000:00:1d.3 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Foxconn International, Inc.: Unknown device 0c24
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 16
	Region 4: I/O ports at e200 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller (rev 03) (prog-if 20 [EHCI])
	Subsystem: Foxconn International, Inc.: Unknown device 0c24
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at d0004000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev d3) (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=32
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: 50100000-501fffff
	Prefetchable memory behind bridge: 0000000050200000-0000000050200000
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [50] #0d [0000]

0000:00:1f.0 ISA bridge: Intel Corp. 82801FB/FR (ICH6/ICH6R) LPC Interface Bridge (rev 03)
	Subsystem: Foxconn International, Inc.: Unknown device 0c24
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:1f.1 IDE interface: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE Controller (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: Foxconn International, Inc.: Unknown device 0c24
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at f000 [size=16]

0000:00:1f.2 IDE interface: Intel Corp. 82801FR/FRW (ICH6R/ICH6RW) SATA Controller (rev 03) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: Foxconn International, Inc.: Unknown device 0c24
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 0: I/O ports at e400 [size=8]
	Region 1: I/O ports at e500 [size=4]
	Region 2: I/O ports at e600 [size=8]
	Region 3: I/O ports at e700 [size=4]
	Region 4: I/O ports at e800 [size=16]
	Region 5: Memory at d0005000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1f.3 SMBus: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller (rev 03)
	Subsystem: Foxconn International, Inc.: Unknown device 0c24
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 11
	Region 4: I/O ports at 0500 [size=32]

0000:01:00.0 VGA compatible controller: nVidia Corporation: Unknown device 0161 (rev a1) (prog-if 00 [VGA])
	Subsystem: Unknown device 1682:2142
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at c0000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at b0000000 (64-bit, prefetchable) [size=256M]
	Region 3: Memory at c1000000 (64-bit, non-prefetchable) [size=16M]
	Expansion ROM at 50000000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] #10 [0001]

0000:05:00.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80) (prog-if 10 [OHCI])
	Subsystem: Foxconn International, Inc.: Unknown device 0c24
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 32 (8000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at 50100000 (32-bit, non-prefetchable) [size=2K]
	Region 1: I/O ports at d000 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:05:01.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit Ethernet (rev 10)
	Subsystem: Foxconn International, Inc.: Unknown device 0c24
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 32 (8000ns min, 16000ns max), Cache Line Size: 0x20 (128 bytes)
	Interrupt: pin A routed to IRQ 21
	Region 0: I/O ports at d100 [size=256]
	Region 1: Memory at 50100800 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at 50200000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-





--------------080003070408080002030807--
