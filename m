Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276094AbRKNSSe>; Wed, 14 Nov 2001 13:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276759AbRKNSSV>; Wed, 14 Nov 2001 13:18:21 -0500
Received: from eos.telenet-ops.be ([195.130.132.40]:36539 "EHLO
	eos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S276094AbRKNSSB>; Wed, 14 Nov 2001 13:18:01 -0500
From: DevilKin <DevilKin@gmx.net>
Subject: Re: USB problems on 2.4.15-pre2?
Date: Thu, 15 Nov 2001 19:14:58 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <5.1.0.14.2.20011112072307.00a80410@pop.gmx.net>
In-Reply-To: <5.1.0.14.2.20011112072307.00a80410@pop.gmx.net>
X-Cats: All your linux' belong to us!
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_YCTUEULK4XR5DLWCX077"
Message-Id: <20011114191431.28CF1209F6@eos.telenet-ops.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_YCTUEULK4XR5DLWCX077
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Monday 12 November 2001 07:32, DevilKin wrote:
> Hi All,
>
> I recently (yesterday) upgraded my kernel from 2.4.10 to 2.4.15-pre2 (i
> needed to recompile anyway to get USB, and it seemed that the VM troubles
> were over). I must say that I'm pleased with this kernel, operates very
> smooth on my machine. I even got better responce times (that I thought I
> wouldn't notice on a 1.4ghz...).
>
> Anyway, I'm straying...
>
> USB is compiled entirely as modules, no kmod support, hotswap activated.
> USB Bridge is a VIA bridge. (as I'm not behind the PC i don't know the
> typenumber)
>
> I have had mount locking up when attempting to mount my /dev/sda1 which
> refers to an USB mass-storage device (actually, it's my digicam, but it
> acts as if it is an USB storage device).
>
> When I plug the cam on the USB cable, it is recognized as a massstorage
> device and the appropriate module is loaded (storage-usb if i'm correct) It
> is registered in the /proc/bus/usb filesystem. When attempting to mount it,
> the mount hangs indefinitely, and the cam compactflash access led keeps on
> blinking, as if it can't read the FS on the cam (which is vfat).
>
> Every subsequent mount of this device hangs too. The mounts are unkillable
> (not even with -SIGKILL as root).
>
> This causes 2 problems when shutting down the system:
> - system hangs, waiting for mounts to get killed
> - an oops (which, unfortunately, isn't registered in syslog & stuff because
> they are dead already - I'll copy it by hand someday)
>

Followup on this. I have now compiled all USB things in the kernel, and for 
some weird reason this now fails to work too.  Mounting works now, but as 
soon as I try to copy something from the cam it hangs.

One other question: what's the difference between the UHCI and the usb-uhci 
drivers?

INFO:
~~~~~

CPU Info:
-----------
bash-2.05$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) processor
stepping        : 4
cpu MHz         : 1401.744
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov 
pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2798.38

PCI Info:
---------
bash-2.05# lspci -v
00:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 700e (rev 
13)
        Flags: bus master, medium devsel, latency 32
        Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Memory at e3001000 (32-bit, prefetchable) [size=4K]
        I/O ports at d000 [disabled] [size=4]
        Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 700f 
(prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 32
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        Memory behind bridge: e0000000-e1ffffff
        Prefetchable memory behind bridge: d8000000-dfffffff

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 40)
        Subsystem: ABIT Computer Corp.: Unknown device a702
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06) 
(prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. VT82C586 IDE [Apollo]
        Flags: bus master, medium devsel, latency 32
        I/O ports at d400 [size=16]
        Capabilities: [c0] Power Management version 2

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 1a) 
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Flags: bus master, medium devsel, latency 32, IRQ 4
        I/O ports at d800 [size=32]
        Capabilities: [80] Power Management version 2

00:07.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 1a) 
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Flags: bus master, medium devsel, latency 32, IRQ 4
        I/O ports at dc00 [size=32]
        Capabilities: [80] Power Management version 2

00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
        Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
        Flags: medium devsel, IRQ 9
        Capabilities: [68] Power Management version 2

00:09.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 
74)
        Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC 
Management NIC
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at e000 [size=128]
        Memory at e3000000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2

00:0d.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 08)
        Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
        Flags: bus master, slow devsel, latency 32, IRQ 11
        I/O ports at e400 [size=64]
        Capabilities: [dc] Power Management version 1

00:0f.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
        Subsystem: Adaptec AHA-2904/Integrated AIC-7850
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at e800 [disabled] [size=256]
        Memory at e3002000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 1

01:05.0 VGA compatible controller: nVidia Corporation NV15 (Geforce2 GTS) 
(rev a4) (prog-if 00 [VGA])
        Subsystem: CardExpert Technology: Unknown device 012c
        Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 3
        Memory at e0000000 (32-bit, non-prefetchable) [size=16M]
        Memory at d8000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
        Capabilities: [44] AGP version 2.0

USB Information (as reported by lsusb)
--------------------------------------------
bash-2.05# lsusb -v

Bus 002 Device 001: ID 0000:0000 Virtual Hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x0000 Virtual
  idProduct          0x0000 Hub
  bcdDevice            0.00
  iManufacturer           0
  iProduct                2 USB UHCI Root Hub
  iSerial                 1 dc00
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x40
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          8
        bInterval             255
  Language IDs: (length=4)
     0000 (null)((null))

Bus 001 Device 001: ID 0000:0000 Virtual Hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x0000 Virtual
  idProduct          0x0000 Hub
  bcdDevice            0.00
  iManufacturer           0
  iProduct                2 USB UHCI Root Hub
  iSerial                 1 d800
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x40
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          8
        bInterval             255
  Language IDs: (length=4)
     0000 (null)((null))

/* This is the webcam */
Bus 001 Device 002: ID 03f0:4002 Hewlett-Packard
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 Interface
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x03f0 Hewlett-Packard
  idProduct          0x4002
  bcdDevice            0.02
  iManufacturer           1 Hewlett-Packard
  iProduct                2 HP PhotoSmart 618 (MSDC)
  iSerial                 3 00030A4510A1
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           39
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xc0
      Self Powered
    MaxPower               10mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass         8 Mass Storage
      bInterfaceSubClass      6 SCSI
      bInterfaceProtocol     80 Bulk (Zip)
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          2
        bInterval             255
  Language IDs: (length=4)
     0409 English(US)

USB info from /proc/bus/usb/devices (after attaching cam)
-----------------------------------------
T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=dc00
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=d800
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=03f0 ProdID=4002 Rev= 0.02
S:  Manufacturer=Hewlett-Packard
S:  Product=HP PhotoSmart 618 (MSDC)
S:  SerialNumber=00030A4510A1
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr= 10mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=08(stor.) Sub=06 Prot=50 Driver=usb-storage
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

Modules loaded
------------------
Module                  Size  Used by
NVdriver              722720  14
via686a                 8228   0  (unused)
i2c-isa                 1220   0  (unused)
i2c-viapro              3720   0  (unused)
i2c-proc                6176   0  [via686a]
i2c-core               12584   0  [via686a i2c-isa i2c-viapro i2c-proc]


/var/log/debug messages
-----------------------
At bootup:
----------
Nov 15 17:26:28 whocares kernel: usb.c: kmalloc IF c1847a40, numif 1
Nov 15 17:26:28 whocares kernel: usb.c: new device strings: Mfr=0, Product=2, 
SerialNumber=1
Nov 15 17:26:28 whocares kernel: usb.c: USB device number 1 default language 
ID
0x0
Nov 15 17:26:28 whocares kernel: hub.c: standalone hub
Nov 15 17:26:28 whocares kernel: hub.c: ganged power switching
Nov 15 17:26:28 whocares kernel: hub.c: global over-current protection
Nov 15 17:26:29 whocares kernel: hub.c: Port indicators are not supported
Nov 15 17:26:29 whocares kernel: hub.c: power on to power good time: 2ms
Nov 15 17:26:29 whocares kernel: hub.c: hub controller current requirement: 
0mA
Nov 15 17:26:29 whocares kernel: hub.c: port removable status: RR
Nov 15 17:26:29 whocares kernel: hub.c: local power source is good
Nov 15 17:26:29 whocares kernel: hub.c: no over-current condition exists
Nov 15 17:26:29 whocares kernel: hub.c: enabling power on all ports
Nov 15 17:26:29 whocares kernel: usb.c: hub driver claimed interface c1847a40
Nov 15 17:26:29 whocares kernel: hub.c: port 1 connection change
Nov 15 17:26:29 whocares kernel: hub.c: port 1, portstatus 100, change 3, 12 
Mb/s
Nov 15 17:26:29 whocares kernel: hub.c: port 2 connection change
Nov 15 17:26:29 whocares kernel: hub.c: port 2, portstatus 300, change 3, 1.5 
Mb/s
Nov 15 17:26:29 whocares kernel: hub.c: port 1 enable change, status 100
Nov 15 17:26:29 whocares kernel: hub.c: port 2 enable change, status 300
Nov 15 17:26:29 whocares kernel: usb.c: kmalloc IF c1847c40, numif 1
Nov 15 17:26:29 whocares kernel: usb.c: new device strings: Mfr=0, Product=2, 
SerialNumber=1
Nov 15 17:26:29 whocares kernel: usb.c: USB device number 1 default language 
ID
0x0
Nov 15 17:26:29 whocares kernel: hub.c: standalone hub
Nov 15 17:26:29 whocares kernel: hub.c: ganged power switching
Nov 15 17:26:30 whocares kernel: hub.c: global over-current protection
Nov 15 17:26:30 whocares kernel: hub.c: Port indicators are not supported
Nov 15 17:26:30 whocares kernel: hub.c: power on to power good time: 2ms
Nov 15 17:26:30 whocares kernel: hub.c: hub controller current requirement: 
0mA
Nov 15 17:26:30 whocares kernel: hub.c: port removable status: RR
Nov 15 17:26:30 whocares kernel: hub.c: local power source is good
Nov 15 17:26:30 whocares kernel: hub.c: no over-current condition exists
Nov 15 17:26:30 whocares kernel: hub.c: enabling power on all ports
Nov 15 17:26:30 whocares kernel: usb.c: hub driver claimed interface c1847c40
Nov 15 17:26:30 whocares kernel: hub.c: port 1 connection change
Nov 15 17:26:30 whocares kernel: hub.c: port 1, portstatus 100, change 3, 12 
Mb/s
Nov 15 17:26:30 whocares kernel: hub.c: port 2 connection change
Nov 15 17:26:31 whocares kernel: hub.c: port 2, portstatus 100, change 3, 12 
Mb/s
Nov 15 17:26:31 whocares kernel: hub.c: port 1 enable change, status 100
Nov 15 17:26:31 whocares kernel: hub.c: port 2 enable change, status 100

When attaching the cam:
-----------------------
Nov 15 17:33:04 whocares kernel: hub.c: port 1 connection change
Nov 15 17:33:04 whocares kernel: hub.c: port 1, portstatus 100, change 3, 12 
Mb/s
Nov 15 17:33:04 whocares kernel: hub.c: port 1 enable change, status 100
Nov 15 17:33:07 whocares kernel: hub.c: port 1 connection change
Nov 15 17:33:07 whocares kernel: hub.c: port 1, portstatus 101, change 1, 12 
Mb/s
Nov 15 17:33:07 whocares kernel: hub.c: port 1, portstatus 103, change 0, 12 
Mb/s
Nov 15 17:33:07 whocares kernel: usb.c: kmalloc IF dd5d3d80, numif 1
Nov 15 17:33:07 whocares kernel: usb.c: new device strings: Mfr=1, Product=2, 
SerialNumber=3
Nov 15 17:33:07 whocares kernel: usb.c: USB device number 2 default language 
ID
0x409
Nov 15 17:33:08 whocares kernel: WARNING: USB Mass Storage data integrity not 
assured
Nov 15 17:33:08 whocares kernel: USB Mass Storage device found at 2
Nov 15 17:33:08 whocares kernel: usb.c: usb-storage driver claimed interface 
dd5d3d80


---------------------------------------------------
/var/log/messages messages
--------------------------
At bootup:
----------
Nov 15 17:26:28 whocares kernel: usb.c: registered new driver usbdevfs
Nov 15 17:26:28 whocares kernel: usb.c: registered new driver hub
Nov 15 17:26:28 whocares kernel: usb-uhci.c: $Revision: 1.268 $ time 17:23:58 
Nov 15 2001
Nov 15 17:26:28 whocares kernel: usb-uhci.c: High bandwidth mode enabled
Nov 15 17:26:28 whocares kernel: usb-uhci.c: USB UHCI at I/O 0xd800, IRQ 4
Nov 15 17:26:28 whocares kernel: usb.c: new USB bus registered, assigned bus 
number 1
Nov 15 17:26:28 whocares kernel: Product: USB UHCI Root Hub
Nov 15 17:26:28 whocares kernel: SerialNumber: d800
Nov 15 17:26:28 whocares kernel: hub.c: USB hub found
Nov 15 17:26:28 whocares kernel: hub.c: 2 ports detected
Nov 15 17:26:29 whocares kernel: usb-uhci.c: USB UHCI at I/O 0xdc00, IRQ 4
Nov 15 17:26:29 whocares kernel: usb.c: new USB bus registered, assigned bus 
number 2
Nov 15 17:26:29 whocares kernel: Product: USB UHCI Root Hub
Nov 15 17:26:29 whocares kernel: SerialNumber: dc00
Nov 15 17:26:29 whocares kernel: hub.c: USB hub found
Nov 15 17:26:29 whocares kernel: hub.c: 2 ports detected
Nov 15 17:26:30 whocares kernel: usb-uhci.c: v1.268:USB Universal Host 
Controller Interface driver
Nov 15 17:26:30 whocares kernel: Initializing USB Mass Storage driver...
Nov 15 17:26:30 whocares kernel: usb.c: registered new driver usb-storage
Nov 15 17:26:30 whocares kernel: USB Mass Storage support registered.

When attaching the cam:
-----------------------
Nov 15 17:33:07 whocares kernel: hub.c: USB new device connect on bus1/1, 
assigned device number 2
Nov 15 17:33:07 whocares kernel: Manufacturer: Hewlett-Packard
Nov 15 17:33:07 whocares kernel: Product: HP PhotoSmart 618 (MSDC)
Nov 15 17:33:07 whocares kernel: SerialNumber: 00030A4510A1
Nov 15 17:33:08 whocares kernel: scsi1 : SCSI emulation for USB Mass Storage 
devices
Nov 15 17:33:08 whocares kernel:  sda: sda1

so it sees it, and it assigns sda1 to the VFAT partition on it

Then I try to mount the camera with:
mount /dev/sda1 /mnt/camera -t vfat (as root)

which works with usb compiled in the kernel, but not as modules

when attempting to copy something of the cam
cp /mnt/camera/camera01/* /tmp (for instance), the process hangs. I've 
noticed though, that it hangs sometimes immediately (no files are copied) and 
sometimes it copies one or two files and hangs.

I've been unable to recreate the Oops lately, since my system just won't shut 
down. I have to use the SysRq to get my system down in a safe state when i've 
tried using the cam.

Kernel config appended.

Thanks for any advice.

-- 
devilkin@gmx.net

--------------Boundary-00=_YCTUEULK4XR5DLWCX077
Content-Type: text/plain;
  charset="iso-8859-1";
  name=".config"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=".config"

IwojIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIGJ5IG1ha2UgbWVudWNvbmZpZzogZG9uJ3QgZWRp
dAojCkNPTkZJR19YODY9eQpDT05GSUdfSVNBPXkKIyBDT05GSUdfU0JVUyBpcyBub3Qgc2V0CkNP
TkZJR19VSUQxNj15CgojCiMgQ29kZSBtYXR1cml0eSBsZXZlbCBvcHRpb25zCiMKQ09ORklHX0VY
UEVSSU1FTlRBTD15CgojCiMgTG9hZGFibGUgbW9kdWxlIHN1cHBvcnQKIwpDT05GSUdfTU9EVUxF
Uz15CiMgQ09ORklHX01PRFZFUlNJT05TIGlzIG5vdCBzZXQKIyBDT05GSUdfS01PRCBpcyBub3Qg
c2V0CgojCiMgUHJvY2Vzc29yIHR5cGUgYW5kIGZlYXR1cmVzCiMKIyBDT05GSUdfTTM4NiBpcyBu
b3Qgc2V0CiMgQ09ORklHX000ODYgaXMgbm90IHNldAojIENPTkZJR19NNTg2IGlzIG5vdCBzZXQK
IyBDT05GSUdfTTU4NlRTQyBpcyBub3Qgc2V0CiMgQ09ORklHX001ODZNTVggaXMgbm90IHNldAoj
IENPTkZJR19NNjg2IGlzIG5vdCBzZXQKIyBDT05GSUdfTVBFTlRJVU1JSUkgaXMgbm90IHNldAoj
IENPTkZJR19NUEVOVElVTTQgaXMgbm90IHNldAojIENPTkZJR19NSzYgaXMgbm90IHNldApDT05G
SUdfTUs3PXkKIyBDT05GSUdfTUNSVVNPRSBpcyBub3Qgc2V0CiMgQ09ORklHX01XSU5DSElQQzYg
aXMgbm90IHNldAojIENPTkZJR19NV0lOQ0hJUDIgaXMgbm90IHNldAojIENPTkZJR19NV0lOQ0hJ
UDNEIGlzIG5vdCBzZXQKIyBDT05GSUdfTUNZUklYSUlJIGlzIG5vdCBzZXQKQ09ORklHX1g4Nl9X
UF9XT1JLU19PSz15CkNPTkZJR19YODZfSU5WTFBHPXkKQ09ORklHX1g4Nl9DTVBYQ0hHPXkKQ09O
RklHX1g4Nl9YQUREPXkKQ09ORklHX1g4Nl9CU1dBUD15CkNPTkZJR19YODZfUE9QQURfT0s9eQoj
IENPTkZJR19SV1NFTV9HRU5FUklDX1NQSU5MT0NLIGlzIG5vdCBzZXQKQ09ORklHX1JXU0VNX1hD
SEdBRERfQUxHT1JJVEhNPXkKQ09ORklHX1g4Nl9MMV9DQUNIRV9TSElGVD02CkNPTkZJR19YODZf
VFNDPXkKQ09ORklHX1g4Nl9HT09EX0FQSUM9eQpDT05GSUdfWDg2X1VTRV8zRE5PVz15CkNPTkZJ
R19YODZfUEdFPXkKQ09ORklHX1g4Nl9VU0VfUFBST19DSEVDS1NVTT15CiMgQ09ORklHX1RPU0hJ
QkEgaXMgbm90IHNldAojIENPTkZJR19JOEsgaXMgbm90IHNldAojIENPTkZJR19NSUNST0NPREUg
aXMgbm90IHNldApDT05GSUdfWDg2X01TUj15CkNPTkZJR19YODZfQ1BVSUQ9eQpDT05GSUdfTk9I
SUdITUVNPXkKIyBDT05GSUdfSElHSE1FTTRHIGlzIG5vdCBzZXQKIyBDT05GSUdfSElHSE1FTTY0
RyBpcyBub3Qgc2V0CiMgQ09ORklHX01BVEhfRU1VTEFUSU9OIGlzIG5vdCBzZXQKQ09ORklHX01U
UlI9eQojIENPTkZJR19TTVAgaXMgbm90IHNldAojIENPTkZJR19YODZfVVBfQVBJQyBpcyBub3Qg
c2V0CiMgQ09ORklHX1g4Nl9VUF9JT0FQSUMgaXMgbm90IHNldAoKIwojIEdlbmVyYWwgc2V0dXAK
IwpDT05GSUdfTkVUPXkKQ09ORklHX1BDST15CiMgQ09ORklHX1BDSV9HT0JJT1MgaXMgbm90IHNl
dAojIENPTkZJR19QQ0lfR09ESVJFQ1QgaXMgbm90IHNldApDT05GSUdfUENJX0dPQU5ZPXkKQ09O
RklHX1BDSV9CSU9TPXkKQ09ORklHX1BDSV9ESVJFQ1Q9eQpDT05GSUdfUENJX05BTUVTPXkKIyBD
T05GSUdfRUlTQSBpcyBub3Qgc2V0CiMgQ09ORklHX01DQSBpcyBub3Qgc2V0CiMgQ09ORklHX0hP
VFBMVUcgaXMgbm90IHNldAojIENPTkZJR19QQ01DSUEgaXMgbm90IHNldApDT05GSUdfU1lTVklQ
Qz15CiMgQ09ORklHX0JTRF9QUk9DRVNTX0FDQ1QgaXMgbm90IHNldApDT05GSUdfU1lTQ1RMPXkK
Q09ORklHX0tDT1JFX0VMRj15CiMgQ09ORklHX0tDT1JFX0FPVVQgaXMgbm90IHNldApDT05GSUdf
QklORk1UX0FPVVQ9eQpDT05GSUdfQklORk1UX0VMRj15CkNPTkZJR19CSU5GTVRfTUlTQz15CkNP
TkZJR19QTT15CiMgQ09ORklHX0FDUEkgaXMgbm90IHNldApDT05GSUdfQVBNPXkKIyBDT05GSUdf
QVBNX0lHTk9SRV9VU0VSX1NVU1BFTkQgaXMgbm90IHNldAojIENPTkZJR19BUE1fRE9fRU5BQkxF
IGlzIG5vdCBzZXQKIyBDT05GSUdfQVBNX0NQVV9JRExFIGlzIG5vdCBzZXQKQ09ORklHX0FQTV9E
SVNQTEFZX0JMQU5LPXkKIyBDT05GSUdfQVBNX1JUQ19JU19HTVQgaXMgbm90IHNldAojIENPTkZJ
R19BUE1fQUxMT1dfSU5UUyBpcyBub3Qgc2V0CiMgQ09ORklHX0FQTV9SRUFMX01PREVfUE9XRVJf
T0ZGIGlzIG5vdCBzZXQKCiMKIyBNZW1vcnkgVGVjaG5vbG9neSBEZXZpY2VzIChNVEQpCiMKIyBD
T05GSUdfTVREIGlzIG5vdCBzZXQKCiMKIyBQYXJhbGxlbCBwb3J0IHN1cHBvcnQKIwpDT05GSUdf
UEFSUE9SVD15CkNPTkZJR19QQVJQT1JUX1BDPXkKQ09ORklHX1BBUlBPUlRfUENfQ01MMT15CiMg
Q09ORklHX1BBUlBPUlRfU0VSSUFMIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFSUE9SVF9QQ19GSUZP
IGlzIG5vdCBzZXQKIyBDT05GSUdfUEFSUE9SVF9QQ19TVVBFUklPIGlzIG5vdCBzZXQKIyBDT05G
SUdfUEFSUE9SVF9BTUlHQSBpcyBub3Qgc2V0CiMgQ09ORklHX1BBUlBPUlRfTUZDMyBpcyBub3Qg
c2V0CiMgQ09ORklHX1BBUlBPUlRfQVRBUkkgaXMgbm90IHNldAojIENPTkZJR19QQVJQT1JUX1NV
TkJQUCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBUlBPUlRfT1RIRVIgaXMgbm90IHNldAojIENPTkZJ
R19QQVJQT1JUXzEyODQgaXMgbm90IHNldAoKIwojIFBsdWcgYW5kIFBsYXkgY29uZmlndXJhdGlv
bgojCkNPTkZJR19QTlA9eQpDT05GSUdfSVNBUE5QPXkKCiMKIyBCbG9jayBkZXZpY2VzCiMKQ09O
RklHX0JMS19ERVZfRkQ9eQojIENPTkZJR19CTEtfREVWX1hEIGlzIG5vdCBzZXQKIyBDT05GSUdf
UEFSSURFIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0NQUV9EQSBpcyBub3Qgc2V0CiMgQ09ORklH
X0JMS19DUFFfQ0lTU19EQSBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfREFDOTYwIGlzIG5v
dCBzZXQKQ09ORklHX0JMS19ERVZfTE9PUD15CiMgQ09ORklHX0JMS19ERVZfTkJEIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQkxLX0RFVl9SQU0gaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0lOSVRS
RCBpcyBub3Qgc2V0CgojCiMgTXVsdGktZGV2aWNlIHN1cHBvcnQgKFJBSUQgYW5kIExWTSkKIwoj
IENPTkZJR19NRCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfTUQgaXMgbm90IHNldAojIENP
TkZJR19NRF9MSU5FQVIgaXMgbm90IHNldAojIENPTkZJR19NRF9SQUlEMCBpcyBub3Qgc2V0CiMg
Q09ORklHX01EX1JBSUQxIGlzIG5vdCBzZXQKIyBDT05GSUdfTURfUkFJRDUgaXMgbm90IHNldAoj
IENPTkZJR19NRF9NVUxUSVBBVEggaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0xWTSBpcyBu
b3Qgc2V0CgojCiMgTmV0d29ya2luZyBvcHRpb25zCiMKQ09ORklHX1BBQ0tFVD15CiMgQ09ORklH
X1BBQ0tFVF9NTUFQIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUTElOSyBpcyBub3Qgc2V0CiMgQ09O
RklHX05FVEZJTFRFUiBpcyBub3Qgc2V0CkNPTkZJR19GSUxURVI9eQpDT05GSUdfVU5JWD15CkNP
TkZJR19JTkVUPXkKIyBDT05GSUdfSVBfTVVMVElDQVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBf
QURWQU5DRURfUk9VVEVSIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBfUE5QIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkVUX0lQSVAgaXMgbm90IHNldAojIENPTkZJR19ORVRfSVBHUkUgaXMgbm90IHNldAoj
IENPTkZJR19JTkVUX0VDTiBpcyBub3Qgc2V0CkNPTkZJR19TWU5fQ09PS0lFUz15CiMgQ09ORklH
X0lQVjYgaXMgbm90IHNldAojIENPTkZJR19LSFRUUEQgaXMgbm90IHNldAojIENPTkZJR19BVE0g
aXMgbm90IHNldAojIENPTkZJR19WTEFOXzgwMjFRIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBYIGlz
IG5vdCBzZXQKIyBDT05GSUdfQVRBTEsgaXMgbm90IHNldAojIENPTkZJR19ERUNORVQgaXMgbm90
IHNldAojIENPTkZJR19CUklER0UgaXMgbm90IHNldAojIENPTkZJR19YMjUgaXMgbm90IHNldAoj
IENPTkZJR19MQVBCIGlzIG5vdCBzZXQKIyBDT05GSUdfTExDIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkVUX0RJVkVSVCBpcyBub3Qgc2V0CiMgQ09ORklHX0VDT05FVCBpcyBub3Qgc2V0CiMgQ09ORklH
X1dBTl9ST1VURVIgaXMgbm90IHNldAojIENPTkZJR19ORVRfRkFTVFJPVVRFIGlzIG5vdCBzZXQK
IyBDT05GSUdfTkVUX0hXX0ZMT1dDT05UUk9MIGlzIG5vdCBzZXQKCiMKIyBRb1MgYW5kL29yIGZh
aXIgcXVldWVpbmcKIwojIENPTkZJR19ORVRfU0NIRUQgaXMgbm90IHNldAoKIwojIFRlbGVwaG9u
eSBTdXBwb3J0CiMKIyBDT05GSUdfUEhPTkUgaXMgbm90IHNldAojIENPTkZJR19QSE9ORV9JWEog
aXMgbm90IHNldAojIENPTkZJR19QSE9ORV9JWEpfUENNQ0lBIGlzIG5vdCBzZXQKCiMKIyBBVEEv
SURFL01GTS9STEwgc3VwcG9ydAojCkNPTkZJR19JREU9eQoKIwojIElERSwgQVRBIGFuZCBBVEFQ
SSBCbG9jayBkZXZpY2VzCiMKQ09ORklHX0JMS19ERVZfSURFPXkKIyBDT05GSUdfQkxLX0RFVl9I
RF9JREUgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0hEIGlzIG5vdCBzZXQKQ09ORklHX0JM
S19ERVZfSURFRElTSz15CkNPTkZJR19JREVESVNLX01VTFRJX01PREU9eQojIENPTkZJR19CTEtf
REVWX0lERURJU0tfVkVORE9SIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9JREVESVNLX0ZV
SklUU1UgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0lERURJU0tfSUJNIGlzIG5vdCBzZXQK
IyBDT05GSUdfQkxLX0RFVl9JREVESVNLX01BWFRPUiBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19E
RVZfSURFRElTS19RVUFOVFVNIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9JREVESVNLX1NF
QUdBVEUgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0lERURJU0tfV0QgaXMgbm90IHNldAoj
IENPTkZJR19CTEtfREVWX0NPTU1FUklBTCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfVElW
TyBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfSURFQ1MgaXMgbm90IHNldApDT05GSUdfQkxL
X0RFVl9JREVDRD15CiMgQ09ORklHX0JMS19ERVZfSURFVEFQRSBpcyBub3Qgc2V0CiMgQ09ORklH
X0JMS19ERVZfSURFRkxPUFBZIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9JREVTQ1NJIGlz
IG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9DTUQ2NDAgaXMgbm90IHNldAojIENPTkZJR19CTEtf
REVWX0NNRDY0MF9FTkhBTkNFRCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfSVNBUE5QIGlz
IG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9SWjEwMDAgaXMgbm90IHNldApDT05GSUdfQkxLX0RF
Vl9JREVQQ0k9eQpDT05GSUdfSURFUENJX1NIQVJFX0lSUT15CkNPTkZJR19CTEtfREVWX0lERURN
QV9QQ0k9eQpDT05GSUdfQkxLX0RFVl9BRE1BPXkKIyBDT05GSUdfQkxLX0RFVl9PRkZCT0FSRCBp
cyBub3Qgc2V0CkNPTkZJR19JREVETUFfUENJX0FVVE89eQpDT05GSUdfQkxLX0RFVl9JREVETUE9
eQojIENPTkZJR19JREVETUFfUENJX1dJUCBpcyBub3Qgc2V0CiMgQ09ORklHX0lERURNQV9ORVdf
RFJJVkVfTElTVElOR1MgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0FFQzYyWFggaXMgbm90
IHNldAojIENPTkZJR19BRUM2MlhYX1RVTklORyBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZf
QUxJMTVYMyBpcyBub3Qgc2V0CiMgQ09ORklHX1dEQ19BTEkxNVgzIGlzIG5vdCBzZXQKIyBDT05G
SUdfQkxLX0RFVl9BTUQ3NFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfQU1ENzRYWF9PVkVSUklERSBp
cyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfQ01ENjRYIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxL
X0RFVl9DWTgyQzY5MyBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfQ1M1NTMwIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQkxLX0RFVl9IUFQzNFggaXMgbm90IHNldAojIENPTkZJR19IUFQzNFhfQVVU
T0RNQSBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfSFBUMzY2IGlzIG5vdCBzZXQKIyBDT05G
SUdfQkxLX0RFVl9QSUlYIGlzIG5vdCBzZXQKIyBDT05GSUdfUElJWF9UVU5JTkcgaXMgbm90IHNl
dAojIENPTkZJR19CTEtfREVWX05TODc0MTUgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX09Q
VEk2MjEgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1BEQzIwMlhYIGlzIG5vdCBzZXQKIyBD
T05GSUdfUERDMjAyWFhfQlVSU1QgaXMgbm90IHNldAojIENPTkZJR19QREMyMDJYWF9GT1JDRSBp
cyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfU1ZXS1MgaXMgbm90IHNldAojIENPTkZJR19CTEtf
REVWX1NJUzU1MTMgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1NMQzkwRTY2IGlzIG5vdCBz
ZXQKIyBDT05GSUdfQkxLX0RFVl9UUk0yOTAgaXMgbm90IHNldApDT05GSUdfQkxLX0RFVl9WSUE4
MkNYWFg9eQojIENPTkZJR19JREVfQ0hJUFNFVFMgaXMgbm90IHNldApDT05GSUdfSURFRE1BX0FV
VE89eQojIENPTkZJR19JREVETUFfSVZCIGlzIG5vdCBzZXQKIyBDT05GSUdfRE1BX05PTlBDSSBp
cyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX0lERV9NT0RFUz15CiMgQ09ORklHX0JMS19ERVZfQVRB
UkFJRCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfQVRBUkFJRF9QREMgaXMgbm90IHNldAoj
IENPTkZJR19CTEtfREVWX0FUQVJBSURfSFBUIGlzIG5vdCBzZXQKCiMKIyBTQ1NJIHN1cHBvcnQK
IwpDT05GSUdfU0NTST15CkNPTkZJR19CTEtfREVWX1NEPXkKQ09ORklHX1NEX0VYVFJBX0RFVlM9
NDAKIyBDT05GSUdfQ0hSX0RFVl9TVCBpcyBub3Qgc2V0CiMgQ09ORklHX0NIUl9ERVZfT1NTVCBp
cyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX1NSPXkKQ09ORklHX0JMS19ERVZfU1JfVkVORE9SPXkK
Q09ORklHX1NSX0VYVFJBX0RFVlM9MgpDT05GSUdfQ0hSX0RFVl9TRz15CkNPTkZJR19TQ1NJX0RF
QlVHX1FVRVVFUz15CkNPTkZJR19TQ1NJX01VTFRJX0xVTj15CkNPTkZJR19TQ1NJX0NPTlNUQU5U
Uz15CiMgQ09ORklHX1NDU0lfTE9HR0lORyBpcyBub3Qgc2V0CgojCiMgU0NTSSBsb3ctbGV2ZWwg
ZHJpdmVycwojCiMgQ09ORklHX0JMS19ERVZfM1dfWFhYWF9SQUlEIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0NTSV83MDAwRkFTU1QgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0FDQVJEIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0NTSV9BSEExNTJYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9BSEExNTQy
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9BSEExNzQwIGlzIG5vdCBzZXQKQ09ORklHX1NDU0lf
QUlDN1hYWD15CkNPTkZJR19BSUM3WFhYX0NNRFNfUEVSX0RFVklDRT0yNTMKQ09ORklHX0FJQzdY
WFhfUkVTRVRfREVMQVlfTVM9MTUwMDAKIyBDT05GSUdfQUlDN1hYWF9CVUlMRF9GSVJNV0FSRSBp
cyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfRFBUX0kyTyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lf
QURWQU5TWVMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0lOMjAwMCBpcyBub3Qgc2V0CiMgQ09O
RklHX1NDU0lfQU01M0M5NzQgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX01FR0FSQUlEIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0NTSV9CVVNMT0dJQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQ1BR
RkNUUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfRE1YMzE5MUQgaXMgbm90IHNldAojIENPTkZJ
R19TQ1NJX0RUQzMyODAgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0VBVEEgaXMgbm90IHNldAoj
IENPTkZJR19TQ1NJX0VBVEFfRE1BIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9FQVRBX1BJTyBp
cyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfRlVUVVJFX0RPTUFJTiBpcyBub3Qgc2V0CiMgQ09ORklH
X1NDU0lfR0RUSCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfR0VORVJJQ19OQ1I1MzgwIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0NTSV9JUFMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0lOSVRJTyBp
cyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfSU5JQTEwMCBpcyBub3Qgc2V0CkNPTkZJR19TQ1NJX1BQ
QT1tCiMgQ09ORklHX1NDU0lfSU1NIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9JWklQX0VQUDE2
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9JWklQX1NMT1dfQ1RSIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0NTSV9OQ1I1M0M0MDZBIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9OQ1I1M0M3eHggaXMg
bm90IHNldAojIENPTkZJR19TQ1NJX05DUjUzQzhYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lf
U1lNNTNDOFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9QQVMxNiBpcyBub3Qgc2V0CiMgQ09O
RklHX1NDU0lfUENJMjAwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfUENJMjIyMEkgaXMgbm90
IHNldAojIENPTkZJR19TQ1NJX1BTSTI0MEkgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1FMT0dJ
Q19GQVMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1FMT0dJQ19JU1AgaXMgbm90IHNldAojIENP
TkZJR19TQ1NJX1FMT0dJQ19GQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfUUxPR0lDXzEyODAg
aXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NFQUdBVEUgaXMgbm90IHNldAojIENPTkZJR19TQ1NJ
X1NJTTcxMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfU1lNNTNDNDE2IGlzIG5vdCBzZXQKIyBD
T05GSUdfU0NTSV9EQzM5MFQgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1QxMjggaXMgbm90IHNl
dAojIENPTkZJR19TQ1NJX1UxNF8zNEYgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1VMVFJBU1RP
UiBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfREVCVUcgaXMgbm90IHNldAoKIwojIEZ1c2lvbiBN
UFQgZGV2aWNlIHN1cHBvcnQKIwojIENPTkZJR19GVVNJT04gaXMgbm90IHNldAojIENPTkZJR19G
VVNJT05fQk9PVCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZVU0lPTl9JU0VOU0UgaXMgbm90IHNldAoj
IENPTkZJR19GVVNJT05fQ1RMIGlzIG5vdCBzZXQKIyBDT05GSUdfRlVTSU9OX0xBTiBpcyBub3Qg
c2V0CgojCiMgSUVFRSAxMzk0IChGaXJlV2lyZSkgc3VwcG9ydCAoRVhQRVJJTUVOVEFMKQojCiMg
Q09ORklHX0lFRUUxMzk0IGlzIG5vdCBzZXQKCiMKIyBJMk8gZGV2aWNlIHN1cHBvcnQKIwojIENP
TkZJR19JMk8gaXMgbm90IHNldAojIENPTkZJR19JMk9fUENJIGlzIG5vdCBzZXQKIyBDT05GSUdf
STJPX0JMT0NLIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJPX0xBTiBpcyBub3Qgc2V0CiMgQ09ORklH
X0kyT19TQ1NJIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJPX1BST0MgaXMgbm90IHNldAoKIwojIE5l
dHdvcmsgZGV2aWNlIHN1cHBvcnQKIwpDT05GSUdfTkVUREVWSUNFUz15CgojCiMgQVJDbmV0IGRl
dmljZXMKIwojIENPTkZJR19BUkNORVQgaXMgbm90IHNldAojIENPTkZJR19EVU1NWSBpcyBub3Qg
c2V0CiMgQ09ORklHX0JPTkRJTkcgaXMgbm90IHNldAojIENPTkZJR19FUVVBTElaRVIgaXMgbm90
IHNldAojIENPTkZJR19UVU4gaXMgbm90IHNldAojIENPTkZJR19ORVRfU0IxMDAwIGlzIG5vdCBz
ZXQKCiMKIyBFdGhlcm5ldCAoMTAgb3IgMTAwTWJpdCkKIwpDT05GSUdfTkVUX0VUSEVSTkVUPXkK
IyBDT05GSUdfU1VOTEFOQ0UgaXMgbm90IHNldAojIENPTkZJR19IQVBQWU1FQUwgaXMgbm90IHNl
dAojIENPTkZJR19TVU5CTUFDIGlzIG5vdCBzZXQKIyBDT05GSUdfU1VOUUUgaXMgbm90IHNldAoj
IENPTkZJR19TVU5MQU5DRSBpcyBub3Qgc2V0CiMgQ09ORklHX1NVTkdFTSBpcyBub3Qgc2V0CkNP
TkZJR19ORVRfVkVORE9SXzNDT009eQojIENPTkZJR19FTDEgaXMgbm90IHNldAojIENPTkZJR19F
TDIgaXMgbm90IHNldAojIENPTkZJR19FTFBMVVMgaXMgbm90IHNldAojIENPTkZJR19FTDE2IGlz
IG5vdCBzZXQKIyBDT05GSUdfRUwzIGlzIG5vdCBzZXQKIyBDT05GSUdfM0M1MTUgaXMgbm90IHNl
dAojIENPTkZJR19FTE1DIGlzIG5vdCBzZXQKIyBDT05GSUdfRUxNQ19JSSBpcyBub3Qgc2V0CkNP
TkZJR19WT1JURVg9eQojIENPTkZJR19MQU5DRSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5E
T1JfU01DIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9SQUNBTCBpcyBub3Qgc2V0CiMg
Q09ORklHX0FUMTcwMCBpcyBub3Qgc2V0CiMgQ09ORklHX0RFUENBIGlzIG5vdCBzZXQKIyBDT05G
SUdfSFAxMDAgaXMgbm90IHNldAojIENPTkZJR19ORVRfSVNBIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkVUX1BDSSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9QT0NLRVQgaXMgbm90IHNldAoKIwojIEV0
aGVybmV0ICgxMDAwIE1iaXQpCiMKIyBDT05GSUdfQUNFTklDIGlzIG5vdCBzZXQKIyBDT05GSUdf
REwySyBpcyBub3Qgc2V0CiMgQ09ORklHX01ZUklfU0JVUyBpcyBub3Qgc2V0CiMgQ09ORklHX05T
ODM4MjAgaXMgbm90IHNldAojIENPTkZJR19IQU1BQ0hJIGlzIG5vdCBzZXQKIyBDT05GSUdfWUVM
TE9XRklOIGlzIG5vdCBzZXQKIyBDT05GSUdfU0s5OExJTiBpcyBub3Qgc2V0CiMgQ09ORklHX0ZE
REkgaXMgbm90IHNldAojIENPTkZJR19ISVBQSSBpcyBub3Qgc2V0CiMgQ09ORklHX1BMSVAgaXMg
bm90IHNldAojIENPTkZJR19QUFAgaXMgbm90IHNldAojIENPTkZJR19TTElQIGlzIG5vdCBzZXQK
CiMKIyBXaXJlbGVzcyBMQU4gKG5vbi1oYW1yYWRpbykKIwojIENPTkZJR19ORVRfUkFESU8gaXMg
bm90IHNldAoKIwojIFRva2VuIFJpbmcgZGV2aWNlcwojCiMgQ09ORklHX1RSIGlzIG5vdCBzZXQK
IyBDT05GSUdfTkVUX0ZDIGlzIG5vdCBzZXQKIyBDT05GSUdfUkNQQ0kgaXMgbm90IHNldAojIENP
TkZJR19TSEFQRVIgaXMgbm90IHNldAoKIwojIFdhbiBpbnRlcmZhY2VzCiMKIyBDT05GSUdfV0FO
IGlzIG5vdCBzZXQKCiMKIyBBbWF0ZXVyIFJhZGlvIHN1cHBvcnQKIwojIENPTkZJR19IQU1SQURJ
TyBpcyBub3Qgc2V0CgojCiMgSXJEQSAoaW5mcmFyZWQpIHN1cHBvcnQKIwojIENPTkZJR19JUkRB
IGlzIG5vdCBzZXQKCiMKIyBJU0ROIHN1YnN5c3RlbQojCiMgQ09ORklHX0lTRE4gaXMgbm90IHNl
dAoKIwojIE9sZCBDRC1ST00gZHJpdmVycyAobm90IFNDU0ksIG5vdCBJREUpCiMKIyBDT05GSUdf
Q0RfTk9fSURFU0NTSSBpcyBub3Qgc2V0CgojCiMgSW5wdXQgY29yZSBzdXBwb3J0CiMKIyBDT05G
SUdfSU5QVVQgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9LRVlCREVWIGlzIG5vdCBzZXQKIyBD
T05GSUdfSU5QVVRfTU9VU0VERVYgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9KT1lERVYgaXMg
bm90IHNldAojIENPTkZJR19JTlBVVF9FVkRFViBpcyBub3Qgc2V0CgojCiMgQ2hhcmFjdGVyIGRl
dmljZXMKIwpDT05GSUdfVlQ9eQpDT05GSUdfVlRfQ09OU09MRT15CkNPTkZJR19TRVJJQUw9eQoj
IENPTkZJR19TRVJJQUxfQ09OU09MRSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF9FWFRFTkRF
RCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF9OT05TVEFOREFSRCBpcyBub3Qgc2V0CkNPTkZJ
R19VTklYOThfUFRZUz15CkNPTkZJR19VTklYOThfUFRZX0NPVU5UPTI1NgpDT05GSUdfUFJJTlRF
Uj15CiMgQ09ORklHX0xQX0NPTlNPTEUgaXMgbm90IHNldAojIENPTkZJR19QUERFViBpcyBub3Qg
c2V0CgojCiMgSTJDIHN1cHBvcnQKIwojIENPTkZJR19JMkMgaXMgbm90IHNldAoKIwojIE1pY2UK
IwojIENPTkZJR19CVVNNT1VTRSBpcyBub3Qgc2V0CkNPTkZJR19NT1VTRT15CkNPTkZJR19QU01P
VVNFPXkKIyBDT05GSUdfODJDNzEwX01PVVNFIGlzIG5vdCBzZXQKIyBDT05GSUdfUEMxMTBfUEFE
IGlzIG5vdCBzZXQKCiMKIyBKb3lzdGlja3MKIwojIENPTkZJR19JTlBVVF9HQU1FUE9SVCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1FJQzAyX1RBUEUgaXMgbm90IHNldAoKIwojIFdhdGNoZG9nIENhcmRz
CiMKIyBDT05GSUdfV0FUQ0hET0cgaXMgbm90IHNldAojIENPTkZJR19JTlRFTF9STkcgaXMgbm90
IHNldAojIENPTkZJR19OVlJBTSBpcyBub3Qgc2V0CkNPTkZJR19SVEM9eQojIENPTkZJR19EVExL
IGlzIG5vdCBzZXQKIyBDT05GSUdfUjM5NjQgaXMgbm90IHNldAojIENPTkZJR19BUFBMSUNPTSBp
cyBub3Qgc2V0CiMgQ09ORklHX1NPTllQSSBpcyBub3Qgc2V0CgojCiMgRnRhcGUsIHRoZSBmbG9w
cHkgdGFwZSBkZXZpY2UgZHJpdmVyCiMKIyBDT05GSUdfRlRBUEUgaXMgbm90IHNldApDT05GSUdf
QUdQPXkKIyBDT05GSUdfQUdQX0lOVEVMIGlzIG5vdCBzZXQKIyBDT05GSUdfQUdQX0k4MTAgaXMg
bm90IHNldAojIENPTkZJR19BR1BfVklBIGlzIG5vdCBzZXQKQ09ORklHX0FHUF9BTUQ9eQojIENP
TkZJR19BR1BfU0lTIGlzIG5vdCBzZXQKIyBDT05GSUdfQUdQX0FMSSBpcyBub3Qgc2V0CiMgQ09O
RklHX0FHUF9TV09SS1MgaXMgbm90IHNldAojIENPTkZJR19EUk0gaXMgbm90IHNldAojIENPTkZJ
R19NV0FWRSBpcyBub3Qgc2V0CgojCiMgTXVsdGltZWRpYSBkZXZpY2VzCiMKIyBDT05GSUdfVklE
RU9fREVWIGlzIG5vdCBzZXQKCiMKIyBGaWxlIHN5c3RlbXMKIwojIENPTkZJR19RVU9UQSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0FVVE9GU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0FVVE9GUzRfRlMg
aXMgbm90IHNldApDT05GSUdfUkVJU0VSRlNfRlM9eQojIENPTkZJR19SRUlTRVJGU19DSEVDSyBp
cyBub3Qgc2V0CiMgQ09ORklHX1JFSVNFUkZTX1BST0NfSU5GTyBpcyBub3Qgc2V0CiMgQ09ORklH
X0FERlNfRlMgaXMgbm90IHNldAojIENPTkZJR19BREZTX0ZTX1JXIGlzIG5vdCBzZXQKIyBDT05G
SUdfQUZGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklH
X0JGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0VYVDNfRlMgaXMgbm90IHNldAojIENPTkZJR19K
QkQgaXMgbm90IHNldAojIENPTkZJR19KQkRfREVCVUcgaXMgbm90IHNldApDT05GSUdfRkFUX0ZT
PXkKQ09ORklHX01TRE9TX0ZTPXkKIyBDT05GSUdfVU1TRE9TX0ZTIGlzIG5vdCBzZXQKQ09ORklH
X1ZGQVRfRlM9eQojIENPTkZJR19FRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19KRkZTX0ZTIGlz
IG5vdCBzZXQKIyBDT05GSUdfSkZGUzJfRlMgaXMgbm90IHNldAojIENPTkZJR19DUkFNRlMgaXMg
bm90IHNldApDT05GSUdfVE1QRlM9eQojIENPTkZJR19SQU1GUyBpcyBub3Qgc2V0CkNPTkZJR19J
U085NjYwX0ZTPXkKQ09ORklHX0pPTElFVD15CiMgQ09ORklHX1pJU09GUyBpcyBub3Qgc2V0CkNP
TkZJR19NSU5JWF9GUz15CiMgQ09ORklHX1ZYRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19OVEZT
X0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfTlRGU19SVyBpcyBub3Qgc2V0CiMgQ09ORklHX0hQRlNf
RlMgaXMgbm90IHNldApDT05GSUdfUFJPQ19GUz15CiMgQ09ORklHX0RFVkZTX0ZTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfREVWRlNfTU9VTlQgaXMgbm90IHNldAojIENPTkZJR19ERVZGU19ERUJVRyBp
cyBub3Qgc2V0CkNPTkZJR19ERVZQVFNfRlM9eQojIENPTkZJR19RTlg0RlNfRlMgaXMgbm90IHNl
dAojIENPTkZJR19RTlg0RlNfUlcgaXMgbm90IHNldAojIENPTkZJR19ST01GU19GUyBpcyBub3Qg
c2V0CkNPTkZJR19FWFQyX0ZTPXkKIyBDT05GSUdfU1lTVl9GUyBpcyBub3Qgc2V0CkNPTkZJR19V
REZfRlM9eQojIENPTkZJR19VREZfUlcgaXMgbm90IHNldAojIENPTkZJR19VRlNfRlMgaXMgbm90
IHNldAojIENPTkZJR19VRlNfRlNfV1JJVEUgaXMgbm90IHNldAoKIwojIE5ldHdvcmsgRmlsZSBT
eXN0ZW1zCiMKIyBDT05GSUdfQ09EQV9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX05GU19GUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX05GU19WMyBpcyBub3Qgc2V0CiMgQ09ORklHX1JPT1RfTkZTIGlzIG5v
dCBzZXQKIyBDT05GSUdfTkZTRCBpcyBub3Qgc2V0CiMgQ09ORklHX05GU0RfVjMgaXMgbm90IHNl
dAojIENPTkZJR19TVU5SUEMgaXMgbm90IHNldAojIENPTkZJR19MT0NLRCBpcyBub3Qgc2V0CkNP
TkZJR19TTUJfRlM9eQojIENPTkZJR19TTUJfTkxTX0RFRkFVTFQgaXMgbm90IHNldAojIENPTkZJ
R19OQ1BfRlMgaXMgbm90IHNldAojIENPTkZJR19OQ1BGU19QQUNLRVRfU0lHTklORyBpcyBub3Qg
c2V0CiMgQ09ORklHX05DUEZTX0lPQ1RMX0xPQ0tJTkcgaXMgbm90IHNldAojIENPTkZJR19OQ1BG
U19TVFJPTkcgaXMgbm90IHNldAojIENPTkZJR19OQ1BGU19ORlNfTlMgaXMgbm90IHNldAojIENP
TkZJR19OQ1BGU19PUzJfTlMgaXMgbm90IHNldAojIENPTkZJR19OQ1BGU19TTUFMTERPUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX05DUEZTX05MUyBpcyBub3Qgc2V0CiMgQ09ORklHX05DUEZTX0VYVFJB
UyBpcyBub3Qgc2V0CiMgQ09ORklHX1pJU09GU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX1pMSUJf
RlNfSU5GTEFURSBpcyBub3Qgc2V0CgojCiMgUGFydGl0aW9uIFR5cGVzCiMKIyBDT05GSUdfUEFS
VElUSU9OX0FEVkFOQ0VEIGlzIG5vdCBzZXQKQ09ORklHX01TRE9TX1BBUlRJVElPTj15CkNPTkZJ
R19TTUJfTkxTPXkKQ09ORklHX05MUz15CgojCiMgTmF0aXZlIExhbmd1YWdlIFN1cHBvcnQKIwpD
T05GSUdfTkxTX0RFRkFVTFQ9Imlzbzg4NTktMSIKIyBDT05GSUdfTkxTX0NPREVQQUdFXzQzNyBp
cyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV83MzcgaXMgbm90IHNldAojIENPTkZJR19O
TFNfQ09ERVBBR0VfNzc1IGlzIG5vdCBzZXQKQ09ORklHX05MU19DT0RFUEFHRV84NTA9eQojIENP
TkZJR19OTFNfQ09ERVBBR0VfODUyIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg1
NSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NTcgaXMgbm90IHNldAojIENPTkZJ
R19OTFNfQ09ERVBBR0VfODYwIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2MSBp
cyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NjIgaXMgbm90IHNldAojIENPTkZJR19O
TFNfQ09ERVBBR0VfODYzIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2NCBpcyBu
b3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NjUgaXMgbm90IHNldAojIENPTkZJR19OTFNf
Q09ERVBBR0VfODY2IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2OSBpcyBub3Qg
c2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV85MzYgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09E
RVBBR0VfOTUwIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzkzMiBpcyBub3Qgc2V0
CiMgQ09ORklHX05MU19DT0RFUEFHRV85NDkgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBB
R0VfODc0IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfOCBpcyBub3Qgc2V0CiMgQ09O
RklHX05MU19DT0RFUEFHRV8xMjUxIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfMSBp
cyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzIgaXMgbm90IHNldAojIENPTkZJR19OTFNf
SVNPODg1OV8zIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfNCBpcyBub3Qgc2V0CiMg
Q09ORklHX05MU19JU084ODU5XzUgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV82IGlz
IG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfNyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19J
U084ODU5XzkgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV8xMyBpcyBub3Qgc2V0CiMg
Q09ORklHX05MU19JU084ODU5XzE0IGlzIG5vdCBzZXQKQ09ORklHX05MU19JU084ODU5XzE1PXkK
IyBDT05GSUdfTkxTX0tPSThfUiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19LT0k4X1UgaXMgbm90
IHNldAojIENPTkZJR19OTFNfVVRGOCBpcyBub3Qgc2V0CgojCiMgQ29uc29sZSBkcml2ZXJzCiMK
Q09ORklHX1ZHQV9DT05TT0xFPXkKQ09ORklHX1ZJREVPX1NFTEVDVD15CiMgQ09ORklHX01EQV9D
T05TT0xFIGlzIG5vdCBzZXQKCiMKIyBGcmFtZS1idWZmZXIgc3VwcG9ydAojCiMgQ09ORklHX0ZC
IGlzIG5vdCBzZXQKCiMKIyBTb3VuZAojCkNPTkZJR19TT1VORD15CiMgQ09ORklHX1NPVU5EX0JU
ODc4IGlzIG5vdCBzZXQKIyBDT05GSUdfU09VTkRfQ01QQ0kgaXMgbm90IHNldAojIENPTkZJR19T
T1VORF9FTVUxMEsxIGlzIG5vdCBzZXQKIyBDT05GSUdfTUlESV9FTVUxMEsxIGlzIG5vdCBzZXQK
IyBDT05GSUdfU09VTkRfRlVTSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfU09VTkRfQ1M0MjgxIGlz
IG5vdCBzZXQKIyBDT05GSUdfU09VTkRfRVMxMzcwIGlzIG5vdCBzZXQKQ09ORklHX1NPVU5EX0VT
MTM3MT15CiMgQ09ORklHX1NPVU5EX0VTU1NPTE8xIGlzIG5vdCBzZXQKIyBDT05GSUdfU09VTkRf
TUFFU1RSTyBpcyBub3Qgc2V0CiMgQ09ORklHX1NPVU5EX01BRVNUUk8zIGlzIG5vdCBzZXQKIyBD
T05GSUdfU09VTkRfSUNIIGlzIG5vdCBzZXQKIyBDT05GSUdfU09VTkRfUk1FOTZYWCBpcyBub3Qg
c2V0CiMgQ09ORklHX1NPVU5EX1NPTklDVklCRVMgaXMgbm90IHNldAojIENPTkZJR19TT1VORF9U
UklERU5UIGlzIG5vdCBzZXQKIyBDT05GSUdfU09VTkRfTVNORENMQVMgaXMgbm90IHNldAojIENP
TkZJR19TT1VORF9NU05EUElOIGlzIG5vdCBzZXQKIyBDT05GSUdfU09VTkRfVklBODJDWFhYIGlz
IG5vdCBzZXQKIyBDT05GSUdfTUlESV9WSUE4MkNYWFggaXMgbm90IHNldAojIENPTkZJR19TT1VO
RF9PU1MgaXMgbm90IHNldAojIENPTkZJR19TT1VORF9UVk1JWEVSIGlzIG5vdCBzZXQKCiMKIyBV
U0Igc3VwcG9ydAojCkNPTkZJR19VU0I9eQpDT05GSUdfVVNCX0RFQlVHPXkKQ09ORklHX1VTQl9E
RVZJQ0VGUz15CiMgQ09ORklHX1VTQl9CQU5EV0lEVEggaXMgbm90IHNldAojIENPTkZJR19VU0Jf
TE9OR19USU1FT1VUIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9VSENJPXkKIyBDT05GSUdfVVNCX1VI
Q0lfQUxUIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX09IQ0kgaXMgbm90IHNldAojIENPTkZJR19V
U0JfQVVESU8gaXMgbm90IHNldAojIENPTkZJR19VU0JfQkxVRVRPT1RIIGlzIG5vdCBzZXQKQ09O
RklHX1VTQl9TVE9SQUdFPXkKIyBDT05GSUdfVVNCX1NUT1JBR0VfREVCVUcgaXMgbm90IHNldAoj
IENPTkZJR19VU0JfU1RPUkFHRV9EQVRBRkFCIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JB
R0VfRlJFRUNPTSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX0lTRDIwMCBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX0RQQ00gaXMgbm90IHNldAojIENPTkZJR19VU0JfU1RP
UkFHRV9IUDgyMDBlIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JBR0VfU0REUjA5IGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX1NUT1JBR0VfSlVNUFNIT1QgaXMgbm90IHNldAojIENPTkZJR19V
U0JfQUNNIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1BSSU5URVIgaXMgbm90IHNldAojIENPTkZJ
R19VU0JfREMyWFggaXMgbm90IHNldAojIENPTkZJR19VU0JfTURDODAwIGlzIG5vdCBzZXQKIyBD
T05GSUdfVVNCX1NDQU5ORVIgaXMgbm90IHNldAojIENPTkZJR19VU0JfTUlDUk9URUsgaXMgbm90
IHNldAojIENPTkZJR19VU0JfSFBVU0JTQ1NJIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1BFR0FT
VVMgaXMgbm90IHNldAojIENPTkZJR19VU0JfS0FXRVRIIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X0NBVEMgaXMgbm90IHNldAojIENPTkZJR19VU0JfQ0RDRVRIRVIgaXMgbm90IHNldAojIENPTkZJ
R19VU0JfVVNCTkVUIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1VTUzcyMCBpcyBub3Qgc2V0Cgoj
CiMgVVNCIFNlcmlhbCBDb252ZXJ0ZXIgc3VwcG9ydAojCiMgQ09ORklHX1VTQl9TRVJJQUwgaXMg
bm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0dFTkVSSUMgaXMgbm90IHNldAojIENPTkZJR19V
U0JfU0VSSUFMX0JFTEtJTiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfV0hJVEVIRUFU
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9ESUdJX0FDQ0VMRVBPUlQgaXMgbm90IHNl
dAojIENPTkZJR19VU0JfU0VSSUFMX0VNUEVHIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklB
TF9GVERJX1NJTyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfVklTT1IgaXMgbm90IHNl
dAojIENPTkZJR19VU0JfU0VSSUFMX0lSIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9F
REdFUE9SVCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfS0VZU1BBTl9QREEgaXMgbm90
IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0tFWVNQQU4gaXMgbm90IHNldAojIENPTkZJR19VU0Jf
U0VSSUFMX0tFWVNQQU5fVVNBMjggaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0tFWVNQ
QU5fVVNBMjhYIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9LRVlTUEFOX1VTQTI4WEEg
aXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0tFWVNQQU5fVVNBMjhYQiBpcyBub3Qgc2V0
CiMgQ09ORklHX1VTQl9TRVJJQUxfS0VZU1BBTl9VU0ExOSBpcyBub3Qgc2V0CiMgQ09ORklHX1VT
Ql9TRVJJQUxfS0VZU1BBTl9VU0ExOFggaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0tF
WVNQQU5fVVNBMTlXIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9LRVlTUEFOX1VTQTQ5
VyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfTUNUX1UyMzIgaXMgbm90IHNldAojIENP
TkZJR19VU0JfU0VSSUFMX1BMMjMwMyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfQ1lC
RVJKQUNLIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9YSVJDT00gaXMgbm90IHNldAoj
IENPTkZJR19VU0JfU0VSSUFMX09NTklORVQgaXMgbm90IHNldAojIENPTkZJR19VU0JfUklPNTAw
IGlzIG5vdCBzZXQKCiMKIyBCbHVldG9vdGggc3VwcG9ydAojCiMgQ09ORklHX0JMVUVaIGlzIG5v
dCBzZXQKCiMKIyBLZXJuZWwgaGFja2luZwojCkNPTkZJR19ERUJVR19LRVJORUw9eQojIENPTkZJ
R19ERUJVR19ISUdITUVNIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfU0xBQiBpcyBub3Qgc2V0
CiMgQ09ORklHX0RFQlVHX0lPVklSVCBpcyBub3Qgc2V0CkNPTkZJR19NQUdJQ19TWVNSUT15CiMg
Q09ORklHX0RFQlVHX1NQSU5MT0NLIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfQlVHVkVSQk9T
RSBpcyBub3Qgc2V0Cg==

--------------Boundary-00=_YCTUEULK4XR5DLWCX077--
