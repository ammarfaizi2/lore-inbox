Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWBKNlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWBKNlh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 08:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWBKNlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 08:41:37 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:26795 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S932259AbWBKNlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 08:41:36 -0500
From: Roger Leigh <rleigh@whinlatter.ukfsn.org>
To: Rene Engelhard <rene@debian.org>
Cc: "Linux Kernel ML" <linux-kernel@vger.kernel.org>, benh@kernel.crashing.org,
       debian-powerpc@lists.debian.org
Subject: Re: 2.6.16-rc1
References: <87hd7x8uxc.fsf@hardknott.home.whinlatter.ukfsn.org>
	<43D4129C.1090205@tee.gr> <20060123225956.GD4307@rene-engelhard.de>
Date: Sat, 11 Feb 2006 13:41:28 +0000
In-Reply-To: <20060123225956.GD4307@rene-engelhard.de> (Rene Engelhard's
	message of "Mon, 23 Jan 2006 23:59:56 +0100")
Message-ID: <87k6c2f1x3.fsf@hardknott.home.whinlatter.ukfsn.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Transfer-Encoding: quoted-printable

Rene Engelhard <rene@debian.org> writes:

> Emmanuel Galatoulas wrote:
>> >
>> >Has anyone managed to get linux-2.6.16-rc1 to boot successfully on a
>> >powermac?  It appears to detect the IDE controller and HDD on my mac
>> >mini, but then fails to mount the root fs.  (It's hard to double check
>> >this because the USB keyboard isn't initialised by the failure, so I
>> >can't scroll back to check.)
>
> Yep. same here. iBook G4.

Further investigation (using netconsole) shows the breakage (in
2.6.16-rc1 and -rc2) is due to discovering an additional IDE
controller (KeyLargo) before the normal (UniNorth) controller:

 Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
 ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=
=3Dxx
+ide0: Found Apple KeyLargo ATA-3 controller, bus ID 0, irq 24
 PCI: Enabling device 0002:20:0d.0 (0000 -> 0002)
=2Dide0: Found Apple UniNorth ATA-6 controller, bus ID 3, irq 39
=2Dhda: TOSHIBA MK8025GAS, ATA DISK drive
=2Dhdb: MATSHITACD-RW CW-8123, ATAPI CD/DVD-ROM drive
=2Dhda: Enabling Ultra DMA 5
=2Dhdb: Enabling Ultra DMA 2
=2Dide0 at 0xe1022000-0xe1022007,0xe1022160 on irq 39
=2Dide1: Found Apple KeyLargo ATA-3 controller, bus ID 0, irq 24
=2Dhda: max request size: 1024KiB
=2Dhda: 156301488 sectors (80026 MB), CHS=3D16383/255/63, UDMA(100)
=2Dhda: cache flushes supported
=2D hda: [mac] hda1 hda2 hda3 hda4 hda5 hda6 hda7
=2Dhdb: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
+ide1: Found Apple UniNorth ATA-6 controller, bus ID 3, irq 39
+hdc: TOSHIBA MK8025GAS, ATA DISK drive
+hdd: MATSHITACD-RW CW-8123, ATAPI CD/DVD-ROM drive
+hdc: Enabling Ultra DMA 5
+hdd: Enabling Ultra DMA 2
+ide1 at 0xe102a000-0xe102a007,0xe102a160 on irq 39
+hdc: max request size: 512KiB
+hdc: 156301488 sectors (80026 MB), CHS=3D16383/255/63, UDMA(100)
+hdc: cache flushes supported
+ hdc: [mac] hdc1 hdc2 hdc3 hdc4 hdc5 hdc6 hdc7
+hdd: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)

As a result, the IDE device names are changed and the boot fails.  If
the controllers were discovered in the reverse order, it wouldn't
break existing installations.

In both these cases the systems are G4-based PowerMacs (Mac Mini and
iBook).  In the case of the Mini, I'm not even certain it's physically
possible to use this additional controller, given how closed the
system is.


Regards,
Roger

=2D-=20
Roger Leigh
                Printing on GNU/Linux?  http://gutenprint.sourceforge.net/
                Debian GNU/Linux        http://www.debian.org/
                GPG Public Key: 0x25BFB848.  Please sign and encrypt your m=
ail.

--=-=-=
Content-Disposition: inline; filename=bootlog-2.6.15-ppc
Content-Transfer-Encoding: quoted-printable
Content-Description: 2.6.15.1 boot

$ netcat -u -l -p 4444
Total memory =3D 512MB; using 1024kB for hash table (at c0400000)
Linux version 2.6.15.1 (rleigh@hardknott) (gcc version 4.0.3 20060115 (prer=
elease) (Debian 4.0.2-7)) #22 Wed Feb 8 20:44:14 GMT 2006
Found UniNorth memory controller & host bridge, revision: 210
Mapped at 0xfddf4000
Found a Intrepid mac-io controller, rev: 0, mapped at 0xfdd74000
Processor NAP mode on idle enabled.
PowerMac motherboard: Mac mini
Enabling clock spreading on Intrepid ASIC
Found UniNorth PCI host bridge at 0xf0000000. Firmware bus number: 0->0
Found UniNorth PCI host bridge at 0xf2000000. Firmware bus number: 0->0
Found UniNorth PCI host bridge at 0xf4000000. Firmware bus number: 0->0
via-pmu: Server Mode is disabled
PMU driver 2 initialized for Core99, firmware: 55
nvram: Checking bank 0...
nvram: gen0=3D470, gen1=3D469
nvram: Active bank is: 0
nvram: OF partition at 0x410
nvram: XP partition at 0x1020
nvram: NR partition at 0x1120
Built 1 zonelists
Kernel command line: root=3D/dev/hda3 ro video=3Dradeonfb:1680x1050-32@60 n=
etconsole=3D@1/,4444@10.0.0.12/=20
netconsole: local port 6665
netconsole: local IP 1.0.0.0
netconsole: interface eth0
netconsole: remote port 4444
netconsole: remote IP 10.0.0.12
netconsole: remote ethernet address ff:ff:ff:ff:ff:ff
PowerMac using OpenPIC irq controller at 0x80040000
OpenPIC Version 1.2 (4 CPUs and 64 IRQ sources) at fc523000
OpenPIC timer frequency is 4.166666 MHz
PID hash table entries: 4096 (order: 12, 65536 bytes)
GMT Delta read from XPRAM: 0 minutes, DST: off
time_init: decrementer frequency =3D 41.620997 MHz
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 514048k available (2696k kernel code, 1044k data, 164k init, 0k hig=
hmem)
AGP special page: 0xdffff000
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
device-tree: property "l2-cache" name conflicts with node in /cpus/PowerPC,=
G4@0
NET: Registered protocol family 16
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 0 of device 0001:10:18.0
PCI: Cannot allocate resource region 0 of device 0001:10:19.0
Apple USB OHCI 0001:10:18.0 disabled by firmware
Apple USB OHCI 0001:10:19.0 disabled by firmware
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
Thermal assist unit not available
audit: initializing netlink socket (disabled)
audit(1139431511.116:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
PCI: Enabling device 0000:00:10.0 (0006 -> 0007)
radeonfb: Retreived PLL infos from Open Firmware
radeonfb: Reference=3D27.00 MHz (RefDiv=3D12) Memory=3D190.00 Mhz, System=
=3D250.00 MHz
radeonfb: PLL min 12000 max 35000
radeonfb: Monitor 1 type DFP found
radeonfb: EDID probed
radeonfb: Monitor 2 type DFP found
radeonfb: EDID probed
Console: switching to colour frame buffer device 210x65
radeonfb (0000:00:10.0): ATI Radeon Yb=20
Generic RTC Driver v1.07
Macintosh non-volatile memory driver v1.1
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected Apple UniNorth 2 chipset
agpgart: configuring for size idx: 4
agpgart: AGP aperture is 16M @ 0x0
[drm] Initialized drm 1.0.0 20040925
[drm] Initialized radeon 1.19.0 20050911 on minor 0:=20
sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)
eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:11:24:75:6d:56=20
eth0: Found BCM5221 PHY
netconsole: device eth0 not up yet, forcing it
eth0: Link is up at 100 Mbps, full-duplex.
eth0: Pause is disabled
netconsole: network logging started
MacIO PCI driver attached to Intrepid chipset
input: Macintosh mouse button emulation as /class/input/input0
apm_emu: APM Emulation 0.5 initialized.
adb: starting probe task...
adb: finished probe task...
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
PCI: Enabling device 0002:20:0d.0 (0000 -> 0002)
ide0: Found Apple UniNorth ATA-6 controller, bus ID 3, irq 39
hda: TOSHIBA MK8025GAS, ATA DISK drive
hdb: MATSHITACD-RW CW-8123, ATAPI CD/DVD-ROM drive
hda: Enabling Ultra DMA 5
hdb: Enabling Ultra DMA 2
ide0 at 0xe1022000-0xe1022007,0xe1022160 on irq 39
ide1: Found Apple KeyLargo ATA-3 controller, bus ID 0, irq 24
hda: max request size: 1024KiB
hda: 156301488 sectors (80026 MB), CHS=3D16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: [mac] hda1 hda2 hda3 hda4 hda5 hda6 hda7
hdb: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
usbmon: debugfs is not available
PCI: Enabling device 0001:10:1b.2 (0004 -> 0006)
ehci_hcd 0001:10:1b.2: EHCI Host Controller
ehci_hcd 0001:10:1b.2: new USB bus registered, assigned bus number 1
ehci_hcd 0001:10:1b.2: irq 63, io mem 0x80080000
ehci_hcd 0001:10:1b.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.15.1 ehci_hcd
usb usb1: SerialNumber: 0001:10:1b.2
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 5 ports detected
Apple USB OHCI 0001:10:18.0 disabled by firmware
Apple USB OHCI 0001:10:19.0 disabled by firmware
PCI: Enabling device 0001:10:1a.0 (0000 -> 0002)
ohci_hcd 0001:10:1a.0: OHCI Host Controller
ohci_hcd 0001:10:1a.0: new USB bus registered, assigned bus number 2
ohci_hcd 0001:10:1a.0: irq 29, io mem 0x80083000
usb usb2: Product: OHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.15.1 ohci_hcd
usb usb2: SerialNumber: 0001:10:1a.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PCI: Enabling device 0001:10:1b.0 (0000 -> 0002)
ohci_hcd 0001:10:1b.0: OHCI Host Controller
ohci_hcd 0001:10:1b.0: new USB bus registered, assigned bus number 3
ohci_hcd 0001:10:1b.0: irq 63, io mem 0x80082000
usb 1-2: new high speed USB device using ehci_hcd and address 3
usb usb3: Product: OHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.15.1 ohci_hcd
usb usb3: SerialNumber: 0001:10:1b.0
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
hub 1-2:1.0: USB hub found
hub 1-2:1.0: 3 ports detected
PCI: Enabling device 0001:10:1b.1 (0000 -> 0002)
ohci_hcd 0001:10:1b.1: OHCI Host Controller
ohci_hcd 0001:10:1b.1: new USB bus registered, assigned bus number 4
ohci_hcd 0001:10:1b.1: irq 63, io mem 0x80081000
usb usb4: Product: OHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.15.1 ohci_hcd
usb usb4: SerialNumber: 0001:10:1b.1
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
USB Universal Host Controller Interface driver v2.3
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb 3-1: new full speed USB device using ohci_hcd and address 2
usb 3-1: Product: Hub in Apple Extended USB Keyboard
usb 3-1: Manufacturer: Mitsumi Electric
hub 3-1:1.0: USB hub found
hub 3-1:1.0: 3 ports detected
usbcore: registered new driver hiddev
usb 1-2.2: new low speed USB device using ehci_hcd and address 4
usb 1-2.2: Product: Microsoft 3-Button Mouse with IntelliEye(TM)
usb 1-2.2: Manufacturer: Microsoft
usb 1-2.3: new low speed USB device using ehci_hcd and address 5
usb 1-2.3: Product: Apple Cinema Display
input: Microsoft Microsoft 3-Button Mouse with IntelliEye(TM) as /class/inp=
ut/input1
input: USB HID v1.10 Mouse [Microsoft Microsoft 3-Button Mouse with Intelli=
Eye(TM)] on usb-0001:10:1b.2-2.2
hiddev0: USB HID v1.11 Device [Apple Cinema Display] on usb-0001:10:1b.2-2.3
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
Found KeyWest i2c on "uni-n", 2 channels, stepping: 4 bits
Found KeyWest i2c on "mac-io", 1 channel, stepping: 4 bits
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
dmasound_pmac: couldn't find a Codec we can handle
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 164k init
usb 3-1.1: new full speed USB device using ohci_hcd and address 3
usb 3-1.1: Product: USB DRIVE=20=20=20=20
usb 3-1.1: Manufacturer: KINGSTON=20=20=20=20=20
usb 3-1.1: SerialNumber: 1120046114165
scsi0 : SCSI emulation for USB Mass Storage devices
usb 3-1.3: new full speed USB device using ohci_hcd and address 4
usb 3-1.3: Product: Apple Extended USB Keyboard
usb 3-1.3: Manufacturer: Mitsumi Electric
input: Mitsumi Electric Apple Extended USB Keyboard as /class/input/input2
input: USB HID v1.10 Keyboard [Mitsumi Electric Apple Extended USB Keyboard=
] on usb-0001:10:1b.0-1.3
input: Mitsumi Electric Apple Extended USB Keyboard as /class/input/input3
input: USB HID v1.10 Device [Mitsumi Electric Apple Extended USB Keyboard] =
on usb-0001:10:1b.0-1.3
ohci1394: $Rev: 1313 $ Ben Collins <bcollins@debian.org>
PCI: Enabling device 0002:20:0e.0 (0000 -> 0002)
ohci1394: fw-host0: Unexpected PCI resource length of 1000!
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=3D[40]  MMIO=3D[f5000000-f5000=
7ff]  Max Packet=3D[2048]
  Vendor: KINGSTON  Model: USB DRIVE         Rev: 1.12
  Type:   Direct-Access                      ANSI SCSI revision: 01 CCS
SCSI device sda: 251904 512-byte hdwr sectors (129 MB)
sda: Write Protect is off
sda: assuming drive cache: write through
hda: Enabling Ultra DMA 5
SCSI device sda: 251904 512-byte hdwr sectors (129 MB)
sda: Write Protect is off
sda: assuming drive cache: write through
 sda:<7>usb-storage: queuecommand called
 sda1 sda2
sd 0:0:0:0: Attached scsi removable disk sda
eth1394: $Rev: 1312 $ Ben Collins <bcollins@debian.org>
eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
hda: Enabling Ultra DMA 5
EXT3 FS on hda3, internal journal
sbp2: $Rev: 1306 $ Ben Collins <bcollins@debian.org>
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=3D1)
ieee1394: sbp2: Try serialize_io=3D0 for better performance
input: PowerMac Beep as /class/input/input4
device-mapper: snapshot is marked invalid
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on dm-6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
HFS+-fs: write access to a jounaled filesystem is not supported, use the fo=
rce option at your own risk, mounting read-only.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-14, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 2097144k swap on /dev/mapper/hda_vg-swap0.  Priority:2 extents:1 acr=
oss:2097144k
Adding 2097144k swap on /dev/mapper/hda_vg-swap1.  Priority:1 extents:1 acr=
oss:2097144k
Adding 2097144k swap on /dev/mapper/hda_vg-swap2.  Priority:3 extents:1 acr=
oss:2097144k
NET: Registered protocol family 17
sixxs: Disabled Privacy Extensions
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: recovery directory /var/lib/nfs/v4recovery doesn't exist
NFSD: starting 90-second grace period
agpgart: Putting AGP V2 device at 0000:00:0b.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:00:10.0 into 1x mode
[drm] Loading R200 Microcode
usb 3-1: USB disconnect, address 2
usb 3-1.1: USB disconnect, address 3
usb 3-1.3: USB disconnect, address 4
usb 3-1: new full speed USB device using ohci_hcd and address 5
usb 3-1: Product: Hub in Apple Extended USB Keyboard
usb 3-1: Manufacturer: Mitsumi Electric
hub 3-1:1.0: USB hub found
hub 3-1:1.0: 3 ports detected
usb 3-1.1: new full speed USB device using ohci_hcd and address 6
usb 3-1.1: Product: USB DRIVE=20=20=20=20
usb 3-1.1: Manufacturer: KINGSTON=20=20=20=20=20
usb 3-1.1: SerialNumber: 1120046114165
scsi1 : SCSI emulation for USB Mass Storage devices
usb 3-1.3: new full speed USB device using ohci_hcd and address 7
usb 3-1.3: Product: Apple Extended USB Keyboard
usb 3-1.3: Manufacturer: Mitsumi Electric
input: Mitsumi Electric Apple Extended USB Keyboard as /class/input/input5
input: USB HID v1.10 Keyboard [Mitsumi Electric Apple Extended USB Keyboard=
] on usb-0001:10:1b.0-1.3
input: Mitsumi Electric Apple Extended USB Keyboard as /class/input/input6
input: USB HID v1.10 Device [Mitsumi Electric Apple Extended USB Keyboard] =
on usb-0001:10:1b.0-1.3
usbcore: registered new driver ub
  Vendor: KINGSTON  Model: USB DRIVE         Rev: 1.12
  Type:   Direct-Access                      ANSI SCSI revision: 01 CCS
SCSI device sda: 251904 512-byte hdwr sectors (129 MB)
sda: Write Protect is off
sda: assuming drive cache: write through
SCSI device sda: 251904 512-byte hdwr sectors (129 MB)
sda: Write Protect is off
sda: assuming drive cache: write through
 sda:<7>usb-storage: queuecommand called
 sda1 sda2
sd 1:0:0:0: Attached scsi removable disk sda

--=-=-=
Content-Disposition: inline; filename=bootlog-2.6.16-rc2-ppc
Content-Transfer-Encoding: quoted-printable
Content-Description: 2.6.16-rc2 boot

$ netcat -u -l -p 4444
Total memory =3D 512MB; using 1024kB for hash table (at cff00000)
Linux version 2.6.16-rc2 (rleigh@hardknott) (gcc version 4.0.3 20060115 (pr=
erelease) (Debian 4.0.2-7)) #4 Wed Feb 8 18:56:44 GMT 2006
Found UniNorth memory controller & host bridge @ 0xf8000000 revision: 0xd2
Mapped at 0xfdfc0000
Found a Intrepid mac-io controller, rev: 0, mapped at 0xfdf40000
Processor NAP mode on idle enabled.
PowerMac motherboard: Mac mini
Using native/NAP idle loop
Found UniNorth PCI host bridge at 0xf0000000. Firmware bus number: 0->0
Found UniNorth PCI host bridge at 0xf2000000. Firmware bus number: 0->0
Found UniNorth PCI host bridge at 0xf4000000. Firmware bus number: 0->0
via-pmu: Server Mode is disabled
PMU driver v2 initialized for Core99, firmware: 55
nvram: Checking bank 0...
nvram: gen0=3D470, gen1=3D469
nvram: Active bank is: 0
nvram: OF partition at 0x410
nvram: XP partition at 0x1020
nvram: NR partition at 0x1120
Top of RAM: 0x20000000, Total RAM: 0x20000000
Memory hole size: 0MB
Built 1 zonelists
Kernel command line: root=3D/dev/hda3 ro video=3Dradeonfb:1680x1050-32@60 n=
etconsole=3D@1/,4444@10.0.0.12/=20
netconsole: local port 6665
netconsole: local IP 1.0.0.0
netconsole: interface eth0
netconsole: remote port 4444
netconsole: remote IP 10.0.0.12
netconsole: remote ethernet address ff:ff:ff:ff:ff:ff
mpic: Setting up MPIC " MPIC 1   " version 1.2 at 80040000, max 4 CPUs
mpic: ISU size: 64, shift: 6, mask: 3f
mpic: Initializing for 64 sources
PID hash table entries: 4096 (order: 12, 65536 bytes)
GMT Delta read from XPRAM: 0 minutes, DST: off
time_init: decrementer frequency =3D 41.620997 MHz
time_init: processor frequency   =3D 1416.666661 MHz
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 514048k/524288k available (2996k kernel code, 9744k reserved, 308k =
data, 190k bss, 148k init)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
device-tree: property "l2-cache" name conflicts with node in /cpus/PowerPC,=
G4@0
NET: Registered protocol family 16
KeyWest i2c @0xf8001003 irq 42 /uni-n@f8000000/i2c@f8001000
 channel 0 bus <multibus>
 channel 1 bus <multibus>
KeyWest i2c @0x80018000 irq 26 /pci@f2000000/mac-io@17/i2c@18000
 channel 0 bus <multibus>
PMU i2c /pci@f2000000/mac-io@17/via-pmu@16000/pmu-i2c
 channel 1 bus <multibus>
 channel 2 bus <multibus>
pmf: registering driver for node /pci@f2000000/mac-io@17/via-pmu@16000/pmu-=
i2c/temp-monitor@190
pmf: no functions, disposing..=20
Installing base platform functions...
Installing MMIO functions for macio /pci@f2000000/mac-io@17
pmf: registering driver for node /pci@f2000000/mac-io@17
pmf: Adding functions for platform-do-wor-enable
pmf: idx 1: flags=3D08000000, phandle=3Dff97f4d0  16 bytes remaining, parsi=
ng...
pmf: Added 1 functions
pmf: Adding functions for platform-do-wor-disable
pmf: idx 1: flags=3D08000000, phandle=3Dff97f4d0  16 bytes remaining, parsi=
ng...
pmf: Added 1 functions
Installing GPIO functions for macio /pci@f2000000/mac-io@17
pmf: registering driver for node /pci@f2000000/mac-io@17/gpio@50/modem-rese=
t@1d
pmf: Adding functions for platform-do-modem-reset
pmf: idx 1: flags=3D08000000, phandle=3Dff975e48  12 bytes remaining, parsi=
ng...
pmf: Added 1 functions
pmf: registering driver for node /pci@f2000000/mac-io@17/gpio@50/modem-powe=
r@1c
pmf: Adding functions for platform-do-modem-power
pmf: idx 1: flags=3D08000000, phandle=3Dff975e48  40 bytes remaining, parsi=
ng...
pmf: Added 1 functions
pmf: registering driver for node /pci@f2000000/mac-io@17/gpio@50/extint-gpi=
o1@9
pmf: no functions, disposing..=20
pmf: registering driver for node /pci@f2000000/mac-io@17/gpio@50/programmer=
-switch@11
pmf: no functions, disposing..=20
pmf: registering driver for node /pci@f2000000/mac-io@17/gpio@50/gpio5@6f
pmf: no functions, disposing..=20
pmf: registering driver for node /pci@f2000000/mac-io@17/gpio@50/gpio6@70
pmf: no functions, disposing..=20
pmf: registering driver for node /pci@f2000000/mac-io@17/gpio@50/extint-gpi=
o15@67
pmf: no functions, disposing..=20
Calling initial GPIO functions for macio /pci@f2000000/mac-io@17
Installing functions for UniN /uni-n@f8000000
pmf: registering driver for node /uni-n@f8000000
pmf: no functions, disposing..=20
Installing functions for UniN clock /uni-n@f8000000/hw-clock
pmf: registering driver for node /uni-n@f8000000/hw-clock
pmf: Adding functions for platform-do-clockspreading
pmf: idx 1: flags=3D20000000, phandle=3D00000000  56 bytes remaining, parsi=
ng...
pmf: idx 2: flags=3D10000000, phandle=3D00000000  16 bytes remaining, parsi=
ng...
pmf: Added 2 functions
All base functions installed
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 0 of device 0001:10:18.0
PCI: Cannot allocate resource region 0 of device 0001:10:19.0
Apple USB OHCI 0001:10:18.0 disabled by firmware
Apple USB OHCI 0001:10:19.0 disabled by firmware
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
Thermal assist unit not available
audit: initializing netlink socket (disabled)
audit(1139426338.104:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Enabling device 0000:00:10.0 (0006 -> 0007)
radeonfb: Retrieved PLL infos from Open Firmware
radeonfb: Reference=3D27.00 MHz (RefDiv=3D12) Memory=3D190.00 Mhz, System=
=3D250.00 MHz
radeonfb: PLL min 12000 max 35000
radeonfb: Monitor 1 type DFP found
radeonfb: EDID probed
radeonfb: Monitor 2 type DFP found
radeonfb: EDID probed
Console: switching to colour frame buffer device 210x65
radeonfb (0000:00:10.0): ATI Radeon Yb=20
Generic RTC Driver v1.07
Macintosh non-volatile memory driver v1.1
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected Apple UniNorth 2 chipset
agpgart: configuring for size idx: 4
agpgart: AGP aperture is 16M @ 0x0
[drm] Initialized drm 1.0.1 20051102
[drm] Initialized radeon 1.21.0 20051229 on minor 0
sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)
eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:11:24:75:6d:56=20
eth0: Found BCM5221 PHY
netconsole: device eth0 not up yet, forcing it
eth0: Link is up at 100 Mbps, full-duplex.
eth0: Pause is disabled
netconsole: network logging started
MacIO PCI driver attached to Intrepid chipset
adb: starting probe task...
adb: finished probe task...
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
ide0: Found Apple KeyLargo ATA-3 controller, bus ID 0, irq 24
PCI: Enabling device 0002:20:0d.0 (0000 -> 0002)
ide1: Found Apple UniNorth ATA-6 controller, bus ID 3, irq 39
hdc: TOSHIBA MK8025GAS, ATA DISK drive
hdd: MATSHITACD-RW CW-8123, ATAPI CD/DVD-ROM drive
hdc: Enabling Ultra DMA 5
hdd: Enabling Ultra DMA 2
ide1 at 0xe102a000-0xe102a007,0xe102a160 on irq 39
hdc: max request size: 512KiB
hdc: 156301488 sectors (80026 MB), CHS=3D16383/255/63, UDMA(100)
hdc: cache flushes supported
 hdc: [mac] hdc1 hdc2 hdc3 hdc4 hdc5 hdc6 hdc7
hdd: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
usbmon: debugfs is not available
PCI: Enabling device 0001:10:1b.2 (0004 -> 0006)
ehci_hcd 0001:10:1b.2: EHCI Host Controller
ehci_hcd 0001:10:1b.2: new USB bus registered, assigned bus number 1
ehci_hcd 0001:10:1b.2: irq 63, io mem 0x80080000
ehci_hcd 0001:10:1b.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.16-rc2 ehci_hcd
usb usb1: SerialNumber: 0001:10:1b.2
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 5 ports detected
Apple USB OHCI 0001:10:18.0 disabled by firmware
Apple USB OHCI 0001:10:19.0 disabled by firmware
PCI: Enabling device 0001:10:1a.0 (0000 -> 0002)
ohci_hcd 0001:10:1a.0: OHCI Host Controller
ohci_hcd 0001:10:1a.0: new USB bus registered, assigned bus number 2
ohci_hcd 0001:10:1a.0: irq 29, io mem 0x80083000
usb usb2: Product: OHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.16-rc2 ohci_hcd
usb usb2: SerialNumber: 0001:10:1a.0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PCI: Enabling device 0001:10:1b.0 (0000 -> 0002)
ohci_hcd 0001:10:1b.0: OHCI Host Controller
ohci_hcd 0001:10:1b.0: new USB bus registered, assigned bus number 3
ohci_hcd 0001:10:1b.0: irq 63, io mem 0x80082000
usb 1-2: new high speed USB device using ehci_hcd and address 3
usb usb3: Product: OHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.16-rc2 ohci_hcd
usb usb3: SerialNumber: 0001:10:1b.0
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
usb 1-2: configuration #1 chosen from 1 choice
hub 1-2:1.0: USB hub found
hub 1-2:1.0: 3 ports detected
PCI: Enabling device 0001:10:1b.1 (0000 -> 0002)
ohci_hcd 0001:10:1b.1: OHCI Host Controller
ohci_hcd 0001:10:1b.1: new USB bus registered, assigned bus number 4
ohci_hcd 0001:10:1b.1: irq 63, io mem 0x80081000
usb usb4: Product: OHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.16-rc2 ohci_hcd
usb usb4: SerialNumber: 0001:10:1b.1
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
USB Universal Host Controller Interface driver v2.3
Initializing USB Mass Storage driver...
usb 3-1: new full speed USB device using ohci_hcd and address 2
usb 3-1: Product: Hub in Apple Extended USB Keyboard
usb 3-1: Manufacturer: Mitsumi Electric
usb 3-1: configuration #1 chosen from 1 choice
hub 3-1:1.0: USB hub found
hub 3-1:1.0: 3 ports detected
usb 1-2.2: new low speed USB device using ehci_hcd and address 4
usb 1-2.2: Product: Microsoft 3-Button Mouse with IntelliEye(TM)
usb 1-2.2: Manufacturer: Microsoft
usb 1-2.2: configuration #1 chosen from 1 choice
usb 1-2.3: new low speed USB device using ehci_hcd and address 5
usb 1-2.3: Product: Apple Cinema Display
usb 1-2.3: configuration #1 chosen from 1 choice
usb 3-1.1: new full speed USB device using ohci_hcd and address 3
usb 3-1.1: Product: USB DRIVE=20=20=20=20
usb 3-1.1: Manufacturer: KINGSTON=20=20=20=20=20
usb 3-1.1: SerialNumber: 1120046114165
usb 3-1.1: configuration #1 chosen from 1 choice
usb 3-1.3: new full speed USB device using ohci_hcd and address 4
usb 3-1.3: Product: Apple Extended USB Keyboard
usb 3-1.3: Manufacturer: Mitsumi Electric
usb 3-1.3: configuration #1 chosen from 1 choice
scsi0 : SCSI emulation for USB Mass Storage devices
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver hiddev
input: Microsoft Microsoft 3-Button Mouse with IntelliEye(TM) as /class/inp=
ut/input0
input: USB HID v1.10 Mouse [Microsoft Microsoft 3-Button Mouse with Intelli=
Eye(TM)] on usb-0001:10:1b.2-2.2
hiddev0: USB HID v1.11 Device [Apple Cinema Display] on usb-0001:10:1b.2-2.3
input: Mitsumi Electric Apple Extended USB Keyboard as /class/input/input1
input: USB HID v1.10 Keyboard [Mitsumi Electric Apple Extended USB Keyboard=
] on usb-0001:10:1b.0-1.3
input: Mitsumi Electric Apple Extended USB Keyboard as /class/input/input2
input: USB HID v1.10 Device [Mitsumi Electric Apple Extended USB Keyboard] =
on usb-0001:10:1b.0-1.3
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
PowerMac i2c bus pmu 2 registered
PowerMac i2c bus pmu 1 registered
PowerMac i2c bus mac-io 0 registered
PowerMac i2c bus uni-n 1 registered
PowerMac i2c bus uni-n 0 registered
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
VFS: Cannot open root device "hda3" or unknown-block(0,0)
Please append a correct "root=3D" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0=
,0)
 <0>Rebooting in 180 seconds..<7>eth0: no IPv6 routers present

--=-=-=
Content-Disposition: inline; filename=bootlog-diff
Content-Transfer-Encoding: quoted-printable
Content-Description: Diff of the bootlogs

=2D-- bootlog-2.6.15-ppc	2006-02-11 13:24:36.000000000 +0000
+++ bootlog-2.6.16-rc2-ppc	2006-02-11 13:24:40.000000000 +0000
@@ -1,23 +1,25 @@
 $ netcat -u -l -p 4444
=2DTotal memory =3D 512MB; using 1024kB for hash table (at c0400000)
=2DLinux version 2.6.15.1 (rleigh@hardknott) (gcc version 4.0.3 20060115 (p=
rerelease) (Debian 4.0.2-7)) #22 Wed Feb 8 20:44:14 GMT 2006
=2DFound UniNorth memory controller & host bridge, revision: 210
=2DMapped at 0xfddf4000
=2DFound a Intrepid mac-io controller, rev: 0, mapped at 0xfdd74000
+Total memory =3D 512MB; using 1024kB for hash table (at cff00000)
+Linux version 2.6.16-rc2 (rleigh@hardknott) (gcc version 4.0.3 20060115 (p=
rerelease) (Debian 4.0.2-7)) #4 Wed Feb 8 18:56:44 GMT 2006
+Found UniNorth memory controller & host bridge @ 0xf8000000 revision: 0xd2
+Mapped at 0xfdfc0000
+Found a Intrepid mac-io controller, rev: 0, mapped at 0xfdf40000
 Processor NAP mode on idle enabled.
 PowerMac motherboard: Mac mini
=2DEnabling clock spreading on Intrepid ASIC
+Using native/NAP idle loop
 Found UniNorth PCI host bridge at 0xf0000000. Firmware bus number: 0->0
 Found UniNorth PCI host bridge at 0xf2000000. Firmware bus number: 0->0
 Found UniNorth PCI host bridge at 0xf4000000. Firmware bus number: 0->0
 via-pmu: Server Mode is disabled
=2DPMU driver 2 initialized for Core99, firmware: 55
+PMU driver v2 initialized for Core99, firmware: 55
 nvram: Checking bank 0...
 nvram: gen0=3D470, gen1=3D469
 nvram: Active bank is: 0
 nvram: OF partition at 0x410
 nvram: XP partition at 0x1020
 nvram: NR partition at 0x1120
+Top of RAM: 0x20000000, Total RAM: 0x20000000
+Memory hole size: 0MB
 Built 1 zonelists
 Kernel command line: root=3D/dev/hda3 ro video=3Dradeonfb:1680x1050-32@60 =
netconsole=3D@1/,4444@10.0.0.12/=20
 netconsole: local port 6665
@@ -26,17 +28,17 @@
 netconsole: remote port 4444
 netconsole: remote IP 10.0.0.12
 netconsole: remote ethernet address ff:ff:ff:ff:ff:ff
=2DPowerMac using OpenPIC irq controller at 0x80040000
=2DOpenPIC Version 1.2 (4 CPUs and 64 IRQ sources) at fc523000
=2DOpenPIC timer frequency is 4.166666 MHz
+mpic: Setting up MPIC " MPIC 1   " version 1.2 at 80040000, max 4 CPUs
+mpic: ISU size: 64, shift: 6, mask: 3f
+mpic: Initializing for 64 sources
 PID hash table entries: 4096 (order: 12, 65536 bytes)
 GMT Delta read from XPRAM: 0 minutes, DST: off
 time_init: decrementer frequency =3D 41.620997 MHz
+time_init: processor frequency   =3D 1416.666661 MHz
 Console: colour dummy device 80x25
 Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
 Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
=2DMemory: 514048k available (2696k kernel code, 1044k data, 164k init, 0k =
highmem)
=2DAGP special page: 0xdffff000
+Memory: 514048k/524288k available (2996k kernel code, 9744k reserved, 308k=
 data, 190k bss, 148k init)
 Security Framework v1.0.0 initialized
 SELinux:  Initializing.
 SELinux:  Starting in permissive mode
@@ -45,6 +47,55 @@
 Mount-cache hash table entries: 512
 device-tree: property "l2-cache" name conflicts with node in /cpus/PowerPC=
,G4@0
 NET: Registered protocol family 16
+KeyWest i2c @0xf8001003 irq 42 /uni-n@f8000000/i2c@f8001000
+ channel 0 bus <multibus>
+ channel 1 bus <multibus>
+KeyWest i2c @0x80018000 irq 26 /pci@f2000000/mac-io@17/i2c@18000
+ channel 0 bus <multibus>
+PMU i2c /pci@f2000000/mac-io@17/via-pmu@16000/pmu-i2c
+ channel 1 bus <multibus>
+ channel 2 bus <multibus>
+pmf: registering driver for node /pci@f2000000/mac-io@17/via-pmu@16000/pmu=
-i2c/temp-monitor@190
+pmf: no functions, disposing..=20
+Installing base platform functions...
+Installing MMIO functions for macio /pci@f2000000/mac-io@17
+pmf: registering driver for node /pci@f2000000/mac-io@17
+pmf: Adding functions for platform-do-wor-enable
+pmf: idx 1: flags=3D08000000, phandle=3Dff97f4d0  16 bytes remaining, pars=
ing...
+pmf: Added 1 functions
+pmf: Adding functions for platform-do-wor-disable
+pmf: idx 1: flags=3D08000000, phandle=3Dff97f4d0  16 bytes remaining, pars=
ing...
+pmf: Added 1 functions
+Installing GPIO functions for macio /pci@f2000000/mac-io@17
+pmf: registering driver for node /pci@f2000000/mac-io@17/gpio@50/modem-res=
et@1d
+pmf: Adding functions for platform-do-modem-reset
+pmf: idx 1: flags=3D08000000, phandle=3Dff975e48  12 bytes remaining, pars=
ing...
+pmf: Added 1 functions
+pmf: registering driver for node /pci@f2000000/mac-io@17/gpio@50/modem-pow=
er@1c
+pmf: Adding functions for platform-do-modem-power
+pmf: idx 1: flags=3D08000000, phandle=3Dff975e48  40 bytes remaining, pars=
ing...
+pmf: Added 1 functions
+pmf: registering driver for node /pci@f2000000/mac-io@17/gpio@50/extint-gp=
io1@9
+pmf: no functions, disposing..=20
+pmf: registering driver for node /pci@f2000000/mac-io@17/gpio@50/programme=
r-switch@11
+pmf: no functions, disposing..=20
+pmf: registering driver for node /pci@f2000000/mac-io@17/gpio@50/gpio5@6f
+pmf: no functions, disposing..=20
+pmf: registering driver for node /pci@f2000000/mac-io@17/gpio@50/gpio6@70
+pmf: no functions, disposing..=20
+pmf: registering driver for node /pci@f2000000/mac-io@17/gpio@50/extint-gp=
io15@67
+pmf: no functions, disposing..=20
+Calling initial GPIO functions for macio /pci@f2000000/mac-io@17
+Installing functions for UniN /uni-n@f8000000
+pmf: registering driver for node /uni-n@f8000000
+pmf: no functions, disposing..=20
+Installing functions for UniN clock /uni-n@f8000000/hw-clock
+pmf: registering driver for node /uni-n@f8000000/hw-clock
+pmf: Adding functions for platform-do-clockspreading
+pmf: idx 1: flags=3D20000000, phandle=3D00000000  56 bytes remaining, pars=
ing...
+pmf: idx 2: flags=3D10000000, phandle=3D00000000  16 bytes remaining, pars=
ing...
+pmf: Added 2 functions
+All base functions installed
 PCI: Probing PCI hardware
 PCI: Cannot allocate resource region 0 of device 0001:10:18.0
 PCI: Cannot allocate resource region 0 of device 0001:10:19.0
@@ -55,16 +106,16 @@
 usbcore: registered new driver hub
 Thermal assist unit not available
 audit: initializing netlink socket (disabled)
=2Daudit(1139431511.116:1): initialized
+audit(1139426338.104:1): initialized
 VFS: Disk quotas dquot_6.5.1
 Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
 Initializing Cryptographic API
 io scheduler noop registered
 io scheduler anticipatory registered
 io scheduler deadline registered
=2Dio scheduler cfq registered
+io scheduler cfq registered (default)
 PCI: Enabling device 0000:00:10.0 (0006 -> 0007)
=2Dradeonfb: Retreived PLL infos from Open Firmware
+radeonfb: Retrieved PLL infos from Open Firmware
 radeonfb: Reference=3D27.00 MHz (RefDiv=3D12) Memory=3D190.00 Mhz, System=
=3D250.00 MHz
 radeonfb: PLL min 12000 max 35000
 radeonfb: Monitor 1 type DFP found
@@ -79,8 +130,8 @@
 agpgart: Detected Apple UniNorth 2 chipset
 agpgart: configuring for size idx: 4
 agpgart: AGP aperture is 16M @ 0x0
=2D[drm] Initialized drm 1.0.0 20040925
=2D[drm] Initialized radeon 1.19.0 20050911 on minor 0:=20
+[drm] Initialized drm 1.0.1 20051102
+[drm] Initialized radeon 1.21.0 20051229 on minor 0
 sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)
 eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:11:24:75:6d:56=20
 eth0: Found BCM5221 PHY
@@ -89,25 +140,23 @@
 eth0: Pause is disabled
 netconsole: network logging started
 MacIO PCI driver attached to Intrepid chipset
=2Dinput: Macintosh mouse button emulation as /class/input/input0
=2Dapm_emu: APM Emulation 0.5 initialized.
 adb: starting probe task...
 adb: finished probe task...
 Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
 ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=
=3Dxx
+ide0: Found Apple KeyLargo ATA-3 controller, bus ID 0, irq 24
 PCI: Enabling device 0002:20:0d.0 (0000 -> 0002)
=2Dide0: Found Apple UniNorth ATA-6 controller, bus ID 3, irq 39
=2Dhda: TOSHIBA MK8025GAS, ATA DISK drive
=2Dhdb: MATSHITACD-RW CW-8123, ATAPI CD/DVD-ROM drive
=2Dhda: Enabling Ultra DMA 5
=2Dhdb: Enabling Ultra DMA 2
=2Dide0 at 0xe1022000-0xe1022007,0xe1022160 on irq 39
=2Dide1: Found Apple KeyLargo ATA-3 controller, bus ID 0, irq 24
=2Dhda: max request size: 1024KiB
=2Dhda: 156301488 sectors (80026 MB), CHS=3D16383/255/63, UDMA(100)
=2Dhda: cache flushes supported
=2D hda: [mac] hda1 hda2 hda3 hda4 hda5 hda6 hda7
=2Dhdb: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
+ide1: Found Apple UniNorth ATA-6 controller, bus ID 3, irq 39
+hdc: TOSHIBA MK8025GAS, ATA DISK drive
+hdd: MATSHITACD-RW CW-8123, ATAPI CD/DVD-ROM drive
+hdc: Enabling Ultra DMA 5
+hdd: Enabling Ultra DMA 2
+ide1 at 0xe102a000-0xe102a007,0xe102a160 on irq 39
+hdc: max request size: 512KiB
+hdc: 156301488 sectors (80026 MB), CHS=3D16383/255/63, UDMA(100)
+hdc: cache flushes supported
+ hdc: [mac] hdc1 hdc2 hdc3 hdc4 hdc5 hdc6 hdc7
+hdd: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
 Uniform CD-ROM driver Revision: 3.20
 usbmon: debugfs is not available
 PCI: Enabling device 0001:10:1b.2 (0004 -> 0006)
@@ -116,8 +165,9 @@
 ehci_hcd 0001:10:1b.2: irq 63, io mem 0x80080000
 ehci_hcd 0001:10:1b.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
 usb usb1: Product: EHCI Host Controller
=2Dusb usb1: Manufacturer: Linux 2.6.15.1 ehci_hcd
+usb usb1: Manufacturer: Linux 2.6.16-rc2 ehci_hcd
 usb usb1: SerialNumber: 0001:10:1b.2
+usb usb1: configuration #1 chosen from 1 choice
 hub 1-0:1.0: USB hub found
 hub 1-0:1.0: 5 ports detected
 Apple USB OHCI 0001:10:18.0 disabled by firmware
@@ -127,8 +177,9 @@
 ohci_hcd 0001:10:1a.0: new USB bus registered, assigned bus number 2
 ohci_hcd 0001:10:1a.0: irq 29, io mem 0x80083000
 usb usb2: Product: OHCI Host Controller
=2Dusb usb2: Manufacturer: Linux 2.6.15.1 ohci_hcd
+usb usb2: Manufacturer: Linux 2.6.16-rc2 ohci_hcd
 usb usb2: SerialNumber: 0001:10:1a.0
+usb usb2: configuration #1 chosen from 1 choice
 hub 2-0:1.0: USB hub found
 hub 2-0:1.0: 2 ports detected
 PCI: Enabling device 0001:10:1b.0 (0000 -> 0002)
@@ -137,10 +188,12 @@
 ohci_hcd 0001:10:1b.0: irq 63, io mem 0x80082000
 usb 1-2: new high speed USB device using ehci_hcd and address 3
 usb usb3: Product: OHCI Host Controller
=2Dusb usb3: Manufacturer: Linux 2.6.15.1 ohci_hcd
+usb usb3: Manufacturer: Linux 2.6.16-rc2 ohci_hcd
 usb usb3: SerialNumber: 0001:10:1b.0
+usb usb3: configuration #1 chosen from 1 choice
 hub 3-0:1.0: USB hub found
 hub 3-0:1.0: 3 ports detected
+usb 1-2: configuration #1 chosen from 1 choice
 hub 1-2:1.0: USB hub found
 hub 1-2:1.0: 3 ports detected
 PCI: Enabling device 0001:10:1b.1 (0000 -> 0002)
@@ -148,36 +201,56 @@
 ohci_hcd 0001:10:1b.1: new USB bus registered, assigned bus number 4
 ohci_hcd 0001:10:1b.1: irq 63, io mem 0x80081000
 usb usb4: Product: OHCI Host Controller
=2Dusb usb4: Manufacturer: Linux 2.6.15.1 ohci_hcd
+usb usb4: Manufacturer: Linux 2.6.16-rc2 ohci_hcd
 usb usb4: SerialNumber: 0001:10:1b.1
+usb usb4: configuration #1 chosen from 1 choice
 hub 4-0:1.0: USB hub found
 hub 4-0:1.0: 2 ports detected
 USB Universal Host Controller Interface driver v2.3
 Initializing USB Mass Storage driver...
=2Dusbcore: registered new driver usb-storage
=2DUSB Mass Storage support registered.
 usb 3-1: new full speed USB device using ohci_hcd and address 2
 usb 3-1: Product: Hub in Apple Extended USB Keyboard
 usb 3-1: Manufacturer: Mitsumi Electric
+usb 3-1: configuration #1 chosen from 1 choice
 hub 3-1:1.0: USB hub found
 hub 3-1:1.0: 3 ports detected
=2Dusbcore: registered new driver hiddev
 usb 1-2.2: new low speed USB device using ehci_hcd and address 4
 usb 1-2.2: Product: Microsoft 3-Button Mouse with IntelliEye(TM)
 usb 1-2.2: Manufacturer: Microsoft
+usb 1-2.2: configuration #1 chosen from 1 choice
 usb 1-2.3: new low speed USB device using ehci_hcd and address 5
 usb 1-2.3: Product: Apple Cinema Display
=2Dinput: Microsoft Microsoft 3-Button Mouse with IntelliEye(TM) as /class/=
input/input1
+usb 1-2.3: configuration #1 chosen from 1 choice
+usb 3-1.1: new full speed USB device using ohci_hcd and address 3
+usb 3-1.1: Product: USB DRIVE=20=20=20=20
+usb 3-1.1: Manufacturer: KINGSTON=20=20=20=20=20
+usb 3-1.1: SerialNumber: 1120046114165
+usb 3-1.1: configuration #1 chosen from 1 choice
+usb 3-1.3: new full speed USB device using ohci_hcd and address 4
+usb 3-1.3: Product: Apple Extended USB Keyboard
+usb 3-1.3: Manufacturer: Mitsumi Electric
+usb 3-1.3: configuration #1 chosen from 1 choice
+scsi0 : SCSI emulation for USB Mass Storage devices
+usbcore: registered new driver usb-storage
+USB Mass Storage support registered.
+usbcore: registered new driver hiddev
+input: Microsoft Microsoft 3-Button Mouse with IntelliEye(TM) as /class/in=
put/input0
 input: USB HID v1.10 Mouse [Microsoft Microsoft 3-Button Mouse with Intell=
iEye(TM)] on usb-0001:10:1b.2-2.2
 hiddev0: USB HID v1.11 Device [Apple Cinema Display] on usb-0001:10:1b.2-2=
.3
+input: Mitsumi Electric Apple Extended USB Keyboard as /class/input/input1
+input: USB HID v1.10 Keyboard [Mitsumi Electric Apple Extended USB Keyboar=
d] on usb-0001:10:1b.0-1.3
+input: Mitsumi Electric Apple Extended USB Keyboard as /class/input/input2
+input: USB HID v1.10 Device [Mitsumi Electric Apple Extended USB Keyboard]=
 on usb-0001:10:1b.0-1.3
 usbcore: registered new driver usbhid
 drivers/usb/input/hid-core.c: v2.6:USB HID core driver
 mice: PS/2 mouse device common for all mice
 i2c /dev entries driver
=2DFound KeyWest i2c on "uni-n", 2 channels, stepping: 4 bits
=2DFound KeyWest i2c on "mac-io", 1 channel, stepping: 4 bits
=2Ddevice-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
=2Ddmasound_pmac: couldn't find a Codec we can handle
+PowerMac i2c bus pmu 2 registered
+PowerMac i2c bus pmu 1 registered
+PowerMac i2c bus mac-io 0 registered
+PowerMac i2c bus uni-n 1 registered
+PowerMac i2c bus uni-n 0 registered
+device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
 NET: Registered protocol family 2
 IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
 TCP established hash table entries: 131072 (order: 7, 524288 bytes)
@@ -189,111 +262,7 @@
 NET: Registered protocol family 10
 lo: Disabled Privacy Extensions
 IPv6 over IPv4 tunneling driver
=2Dkjournald starting.  Commit interval 5 seconds
=2DEXT3-fs: mounted filesystem with ordered data mode.
=2DVFS: Mounted root (ext3 filesystem) readonly.
=2DFreeing unused kernel memory: 164k init
=2Dusb 3-1.1: new full speed USB device using ohci_hcd and address 3
=2Dusb 3-1.1: Product: USB DRIVE=20=20=20=20
=2Dusb 3-1.1: Manufacturer: KINGSTON=20=20=20=20=20
=2Dusb 3-1.1: SerialNumber: 1120046114165
=2Dscsi0 : SCSI emulation for USB Mass Storage devices
=2Dusb 3-1.3: new full speed USB device using ohci_hcd and address 4
=2Dusb 3-1.3: Product: Apple Extended USB Keyboard
=2Dusb 3-1.3: Manufacturer: Mitsumi Electric
=2Dinput: Mitsumi Electric Apple Extended USB Keyboard as /class/input/inpu=
t2
=2Dinput: USB HID v1.10 Keyboard [Mitsumi Electric Apple Extended USB Keybo=
ard] on usb-0001:10:1b.0-1.3
=2Dinput: Mitsumi Electric Apple Extended USB Keyboard as /class/input/inpu=
t3
=2Dinput: USB HID v1.10 Device [Mitsumi Electric Apple Extended USB Keyboar=
d] on usb-0001:10:1b.0-1.3
=2Dohci1394: $Rev: 1313 $ Ben Collins <bcollins@debian.org>
=2DPCI: Enabling device 0002:20:0e.0 (0000 -> 0002)
=2Dohci1394: fw-host0: Unexpected PCI resource length of 1000!
=2Dohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=3D[40]  MMIO=3D[f5000000-f5=
0007ff]  Max Packet=3D[2048]
=2D  Vendor: KINGSTON  Model: USB DRIVE         Rev: 1.12
=2D  Type:   Direct-Access                      ANSI SCSI revision: 01 CCS
=2DSCSI device sda: 251904 512-byte hdwr sectors (129 MB)
=2Dsda: Write Protect is off
=2Dsda: assuming drive cache: write through
=2Dhda: Enabling Ultra DMA 5
=2DSCSI device sda: 251904 512-byte hdwr sectors (129 MB)
=2Dsda: Write Protect is off
=2Dsda: assuming drive cache: write through
=2D sda:<7>usb-storage: queuecommand called
=2D sda1 sda2
=2Dsd 0:0:0:0: Attached scsi removable disk sda
=2Deth1394: $Rev: 1312 $ Ben Collins <bcollins@debian.org>
=2Deth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
=2Dhda: Enabling Ultra DMA 5
=2DEXT3 FS on hda3, internal journal
=2Dsbp2: $Rev: 1306 $ Ben Collins <bcollins@debian.org>
=2Dieee1394: sbp2: Driver forced to serialize I/O (serialize_io=3D1)
=2Dieee1394: sbp2: Try serialize_io=3D0 for better performance
=2Dinput: PowerMac Beep as /class/input/input4
=2Ddevice-mapper: snapshot is marked invalid
=2Dkjournald starting.  Commit interval 5 seconds
=2DEXT3 FS on dm-5, internal journal
=2DEXT3-fs: mounted filesystem with ordered data mode.
=2Dkjournald starting.  Commit interval 5 seconds
=2DEXT3 FS on dm-3, internal journal
=2DEXT3-fs: mounted filesystem with ordered data mode.
=2Dkjournald starting.  Commit interval 5 seconds
=2DEXT3 FS on dm-4, internal journal
=2DEXT3-fs: mounted filesystem with ordered data mode.
=2Dkjournald starting.  Commit interval 5 seconds
=2DEXT3-fs warning: maximal mount count reached, running e2fsck is recommen=
ded
=2DEXT3 FS on dm-6, internal journal
=2DEXT3-fs: mounted filesystem with ordered data mode.
=2DHFS+-fs: write access to a jounaled filesystem is not supported, use the=
 force option at your own risk, mounting read-only.
=2Dkjournald starting.  Commit interval 5 seconds
=2DEXT3 FS on dm-7, internal journal
=2DEXT3-fs: mounted filesystem with ordered data mode.
=2Dkjournald starting.  Commit interval 5 seconds
=2DEXT3 FS on dm-9, internal journal
=2DEXT3-fs: mounted filesystem with ordered data mode.
=2Dkjournald starting.  Commit interval 5 seconds
=2DEXT3 FS on dm-14, internal journal
=2DEXT3-fs: mounted filesystem with ordered data mode.
=2DAdding 2097144k swap on /dev/mapper/hda_vg-swap0.  Priority:2 extents:1 =
across:2097144k
=2DAdding 2097144k swap on /dev/mapper/hda_vg-swap1.  Priority:1 extents:1 =
across:2097144k
=2DAdding 2097144k swap on /dev/mapper/hda_vg-swap2.  Priority:3 extents:1 =
across:2097144k
=2DNET: Registered protocol family 17
=2Dsixxs: Disabled Privacy Extensions
=2DInstalling knfsd (copyright (C) 1996 okir@monad.swb.de).
=2DNFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
=2DNFSD: recovery directory /var/lib/nfs/v4recovery doesn't exist
=2DNFSD: starting 90-second grace period
=2Dagpgart: Putting AGP V2 device at 0000:00:0b.0 into 1x mode
=2Dagpgart: Putting AGP V2 device at 0000:00:10.0 into 1x mode
=2D[drm] Loading R200 Microcode
=2Dusb 3-1: USB disconnect, address 2
=2Dusb 3-1.1: USB disconnect, address 3
=2Dusb 3-1.3: USB disconnect, address 4
=2Dusb 3-1: new full speed USB device using ohci_hcd and address 5
=2Dusb 3-1: Product: Hub in Apple Extended USB Keyboard
=2Dusb 3-1: Manufacturer: Mitsumi Electric
=2Dhub 3-1:1.0: USB hub found
=2Dhub 3-1:1.0: 3 ports detected
=2Dusb 3-1.1: new full speed USB device using ohci_hcd and address 6
=2Dusb 3-1.1: Product: USB DRIVE=20=20=20=20
=2Dusb 3-1.1: Manufacturer: KINGSTON=20=20=20=20=20
=2Dusb 3-1.1: SerialNumber: 1120046114165
=2Dscsi1 : SCSI emulation for USB Mass Storage devices
=2Dusb 3-1.3: new full speed USB device using ohci_hcd and address 7
=2Dusb 3-1.3: Product: Apple Extended USB Keyboard
=2Dusb 3-1.3: Manufacturer: Mitsumi Electric
=2Dinput: Mitsumi Electric Apple Extended USB Keyboard as /class/input/inpu=
t5
=2Dinput: USB HID v1.10 Keyboard [Mitsumi Electric Apple Extended USB Keybo=
ard] on usb-0001:10:1b.0-1.3
=2Dinput: Mitsumi Electric Apple Extended USB Keyboard as /class/input/inpu=
t6
=2Dinput: USB HID v1.10 Device [Mitsumi Electric Apple Extended USB Keyboar=
d] on usb-0001:10:1b.0-1.3
=2Dusbcore: registered new driver ub
=2D  Vendor: KINGSTON  Model: USB DRIVE         Rev: 1.12
=2D  Type:   Direct-Access                      ANSI SCSI revision: 01 CCS
=2DSCSI device sda: 251904 512-byte hdwr sectors (129 MB)
=2Dsda: Write Protect is off
=2Dsda: assuming drive cache: write through
=2DSCSI device sda: 251904 512-byte hdwr sectors (129 MB)
=2Dsda: Write Protect is off
=2Dsda: assuming drive cache: write through
=2D sda:<7>usb-storage: queuecommand called
=2D sda1 sda2
=2Dsd 1:0:0:0: Attached scsi removable disk sda
+VFS: Cannot open root device "hda3" or unknown-block(0,0)
+Please append a correct "root=3D" boot option
+Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(=
0,0)
+ <0>Rebooting in 180 seconds..<7>eth0: no IPv6 routers present

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD7emLVcFcaSW/uEgRAqCPAKDlOp5pOl+Y/5q6pylg80ZD6bIWzQCffGZv
C3G4MGbh7LVsANp3AZF2gdc=
=N/Sv
-----END PGP SIGNATURE-----
--==-=-=--
