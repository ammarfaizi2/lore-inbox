Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273622AbRKNSp3>; Wed, 14 Nov 2001 13:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274368AbRKNSpW>; Wed, 14 Nov 2001 13:45:22 -0500
Received: from tartarus.telenet-ops.be ([195.130.132.34]:23499 "EHLO
	tartarus.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S273622AbRKNSpJ>; Wed, 14 Nov 2001 13:45:09 -0500
From: DevilKin <DevilKin@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: USB problems on 2.4.15-pre2?
Date: Thu, 15 Nov 2001 19:42:07 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <5.1.0.14.2.20011112072307.00a80410@pop.gmx.net> <20011114191431.28CF1209F6@eos.telenet-ops.be>
In-Reply-To: <20011114191431.28CF1209F6@eos.telenet-ops.be>
X-Cats: All your linux' belong to us!
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_7MUUDLCMTNFX032YRX2X"
Message-Id: <20011114184501.98B54216FA9@tartarus.telenet-ops.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_7MUUDLCMTNFX032YRX2X
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Thursday 15 November 2001 19:14, DevilKin wrote:
> On Monday 12 November 2001 07:32, DevilKin wrote:
> > Hi All,
> >
> > I recently (yesterday) upgraded my kernel from 2.4.10 to 2.4.15-pre2 (i
> > needed to recompile anyway to get USB, and it seemed that the VM troubles
> > were over). I must say that I'm pleased with this kernel, operates very
> > smooth on my machine. I even got better responce times (that I thought I
> > wouldn't notice on a 1.4ghz...).
> >
> > Anyway, I'm straying...
> >
> > USB is compiled entirely as modules, no kmod support, hotswap activated.
> > USB Bridge is a VIA bridge. (as I'm not behind the PC i don't know the
> > typenumber)
> >
> > I have had mount locking up when attempting to mount my /dev/sda1 which
> > refers to an USB mass-storage device (actually, it's my digicam, but it
> > acts as if it is an USB storage device).
> >
> > When I plug the cam on the USB cable, it is recognized as a massstorage
> > device and the appropriate module is loaded (storage-usb if i'm correct)
> > It is registered in the /proc/bus/usb filesystem. When attempting to
> > mount it, the mount hangs indefinitely, and the cam compactflash access
> > led keeps on blinking, as if it can't read the FS on the cam (which is
> > vfat).
> >
> > Every subsequent mount of this device hangs too. The mounts are
> > unkillable (not even with -SIGKILL as root).
> >
> > This causes 2 problems when shutting down the system:
> > - system hangs, waiting for mounts to get killed
> > - an oops (which, unfortunately, isn't registered in syslog & stuff
> > because they are dead already - I'll copy it by hand someday)
>
> Followup on this. I have now compiled all USB things in the kernel, and for
> some weird reason this now fails to work too.  Mounting works now, but as
> soon as I try to copy something from the cam it hangs.
>
> One other question: what's the difference between the UHCI and the usb-uhci
> drivers?
>
> INFO:
> ~~~~~
>
> CPU Info:
> -----------
> bash-2.05$ cat /proc/cpuinfo
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 6
> model           : 4
> model name      : AMD Athlon(tm) processor
> stepping        : 4
> cpu MHz         : 1401.744
> cache size      : 256 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
> pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
> bogomips        : 2798.38
>
> PCI Info:
> ---------
> bash-2.05# lspci -v
> 00:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 700e (rev
> 13)
>         Flags: bus master, medium devsel, latency 32
>         Memory at d0000000 (32-bit, prefetchable) [size=128M]
>         Memory at e3001000 (32-bit, prefetchable) [size=4K]
>         I/O ports at d000 [disabled] [size=4]
>         Capabilities: [a0] AGP version 2.0
>
> 00:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 700f
> (prog-if 00 [Normal decode])
>         Flags: bus master, 66Mhz, medium devsel, latency 32
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
>         Memory behind bridge: e0000000-e1ffffff
>         Prefetchable memory behind bridge: d8000000-dfffffff
>
> 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 40)
>         Subsystem: ABIT Computer Corp.: Unknown device a702
>         Flags: bus master, stepping, medium devsel, latency 0
>         Capabilities: [c0] Power Management version 2
>
> 00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
> 06) (prog-if 8a [Master SecP PriP])
>         Subsystem: VIA Technologies, Inc. VT82C586 IDE [Apollo]
>         Flags: bus master, medium devsel, latency 32
>         I/O ports at d400 [size=16]
>         Capabilities: [c0] Power Management version 2
>
> 00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 1a)
> (prog-if 00 [UHCI])
>         Subsystem: Unknown device 0925:1234
>         Flags: bus master, medium devsel, latency 32, IRQ 4
>         I/O ports at d800 [size=32]
>         Capabilities: [80] Power Management version 2
>
> 00:07.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 1a)
> (prog-if 00 [UHCI])
>         Subsystem: Unknown device 0925:1234
>         Flags: bus master, medium devsel, latency 32, IRQ 4
>         I/O ports at dc00 [size=32]
>         Capabilities: [80] Power Management version 2
>
> 00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
>         Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
>         Flags: medium devsel, IRQ 9
>         Capabilities: [68] Power Management version 2
>
> 00:09.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink]
> (rev 74)
>         Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC
> Management NIC
>         Flags: bus master, medium devsel, latency 32, IRQ 10
>         I/O ports at e000 [size=128]
>         Memory at e3000000 (32-bit, non-prefetchable) [size=128]
>         Expansion ROM at <unassigned> [disabled] [size=128K]
>         Capabilities: [dc] Power Management version 2
>
> 00:0d.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 08)
>         Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
>         Flags: bus master, slow devsel, latency 32, IRQ 11
>         I/O ports at e400 [size=64]
>         Capabilities: [dc] Power Management version 1
>
> 00:0f.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
>         Subsystem: Adaptec AHA-2904/Integrated AIC-7850
>         Flags: bus master, medium devsel, latency 32, IRQ 11
>         I/O ports at e800 [disabled] [size=256]
>         Memory at e3002000 (32-bit, non-prefetchable) [size=4K]
>         Capabilities: [dc] Power Management version 1
>
> 01:05.0 VGA compatible controller: nVidia Corporation NV15 (Geforce2 GTS)
> (rev a4) (prog-if 00 [VGA])
>         Subsystem: CardExpert Technology: Unknown device 012c
>         Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 3
>         Memory at e0000000 (32-bit, non-prefetchable) [size=16M]
>         Memory at d8000000 (32-bit, prefetchable) [size=128M]
>         Expansion ROM at <unassigned> [disabled] [size=64K]
>         Capabilities: [60] Power Management version 1
>         Capabilities: [44] AGP version 2.0
>
> USB Information (as reported by lsusb)
> --------------------------------------------
> bash-2.05# lsusb -v
>
> Bus 002 Device 001: ID 0000:0000 Virtual Hub
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               1.00
>   bDeviceClass            9 Hub
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0         8
>   idVendor           0x0000 Virtual
>   idProduct          0x0000 Hub
>   bcdDevice            0.00
>   iManufacturer           0
>   iProduct                2 USB UHCI Root Hub
>   iSerial                 1 dc00
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength           25
>     bNumInterfaces          1
>     bConfigurationValue     1
>     iConfiguration          0
>     bmAttributes         0x40
>       Self Powered
>     MaxPower                0mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           1
>       bInterfaceClass         9 Hub
>       bInterfaceSubClass      0
>       bInterfaceProtocol      0
>       iInterface              0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x81  EP 1 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               none
>         wMaxPacketSize          8
>         bInterval             255
>   Language IDs: (length=4)
>      0000 (null)((null))
>
> Bus 001 Device 001: ID 0000:0000 Virtual Hub
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               1.00
>   bDeviceClass            9 Hub
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0         8
>   idVendor           0x0000 Virtual
>   idProduct          0x0000 Hub
>   bcdDevice            0.00
>   iManufacturer           0
>   iProduct                2 USB UHCI Root Hub
>   iSerial                 1 d800
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength           25
>     bNumInterfaces          1
>     bConfigurationValue     1
>     iConfiguration          0
>     bmAttributes         0x40
>       Self Powered
>     MaxPower                0mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           1
>       bInterfaceClass         9 Hub
>       bInterfaceSubClass      0
>       bInterfaceProtocol      0
>       iInterface              0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x81  EP 1 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               none
>         wMaxPacketSize          8
>         bInterval             255
>   Language IDs: (length=4)
>      0000 (null)((null))
>
> /* This is the webcam */
> Bus 001 Device 002: ID 03f0:4002 Hewlett-Packard
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               1.10
>   bDeviceClass            0 Interface
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0        64
>   idVendor           0x03f0 Hewlett-Packard
>   idProduct          0x4002
>   bcdDevice            0.02
>   iManufacturer           1 Hewlett-Packard
>   iProduct                2 HP PhotoSmart 618 (MSDC)
>   iSerial                 3 00030A4510A1
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength           39
>     bNumInterfaces          1
>     bConfigurationValue     1
>     iConfiguration          0
>     bmAttributes         0xc0
>       Self Powered
>     MaxPower               10mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           3
>       bInterfaceClass         8 Mass Storage
>       bInterfaceSubClass      6 SCSI
>       bInterfaceProtocol     80 Bulk (Zip)
>       iInterface              0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x81  EP 1 IN
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               none
>         wMaxPacketSize         64
>         bInterval               0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x02  EP 2 OUT
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               none
>         wMaxPacketSize         64
>         bInterval               0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x83  EP 3 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               none
>         wMaxPacketSize          2
>         bInterval             255
>   Language IDs: (length=4)
>      0409 English(US)
>
> USB info from /proc/bus/usb/devices (after attaching cam)
> -----------------------------------------
> T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
> B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
> D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=0000 ProdID=0000 Rev= 0.00
> S:  Product=USB UHCI Root Hub
> S:  SerialNumber=dc00
> C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
> T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
> B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
> D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=0000 ProdID=0000 Rev= 0.00
> S:  Product=USB UHCI Root Hub
> S:  SerialNumber=d800
> C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
> T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=03f0 ProdID=4002 Rev= 0.02
> S:  Manufacturer=Hewlett-Packard
> S:  Product=HP PhotoSmart 618 (MSDC)
> S:  SerialNumber=00030A4510A1
> C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr= 10mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=08(stor.) Sub=06 Prot=50 Driver=usb-storage
> E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
> E:  Ad=83(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
>
> Modules loaded
> ------------------
> Module                  Size  Used by
> NVdriver              722720  14
> via686a                 8228   0  (unused)
> i2c-isa                 1220   0  (unused)
> i2c-viapro              3720   0  (unused)
> i2c-proc                6176   0  [via686a]
> i2c-core               12584   0  [via686a i2c-isa i2c-viapro i2c-proc]
>
>
> /var/log/debug messages
> -----------------------
> At bootup:
> ----------
> Nov 15 17:26:28 whocares kernel: usb.c: kmalloc IF c1847a40, numif 1
> Nov 15 17:26:28 whocares kernel: usb.c: new device strings: Mfr=0,
> Product=2, SerialNumber=1
> Nov 15 17:26:28 whocares kernel: usb.c: USB device number 1 default
> language ID
> 0x0
> Nov 15 17:26:28 whocares kernel: hub.c: standalone hub
> Nov 15 17:26:28 whocares kernel: hub.c: ganged power switching
> Nov 15 17:26:28 whocares kernel: hub.c: global over-current protection
> Nov 15 17:26:29 whocares kernel: hub.c: Port indicators are not supported
> Nov 15 17:26:29 whocares kernel: hub.c: power on to power good time: 2ms
> Nov 15 17:26:29 whocares kernel: hub.c: hub controller current requirement:
> 0mA
> Nov 15 17:26:29 whocares kernel: hub.c: port removable status: RR
> Nov 15 17:26:29 whocares kernel: hub.c: local power source is good
> Nov 15 17:26:29 whocares kernel: hub.c: no over-current condition exists
> Nov 15 17:26:29 whocares kernel: hub.c: enabling power on all ports
> Nov 15 17:26:29 whocares kernel: usb.c: hub driver claimed interface
> c1847a40 Nov 15 17:26:29 whocares kernel: hub.c: port 1 connection change
> Nov 15 17:26:29 whocares kernel: hub.c: port 1, portstatus 100, change 3,
> 12 Mb/s
> Nov 15 17:26:29 whocares kernel: hub.c: port 2 connection change
> Nov 15 17:26:29 whocares kernel: hub.c: port 2, portstatus 300, change 3,
> 1.5 Mb/s
> Nov 15 17:26:29 whocares kernel: hub.c: port 1 enable change, status 100
> Nov 15 17:26:29 whocares kernel: hub.c: port 2 enable change, status 300
> Nov 15 17:26:29 whocares kernel: usb.c: kmalloc IF c1847c40, numif 1
> Nov 15 17:26:29 whocares kernel: usb.c: new device strings: Mfr=0,
> Product=2, SerialNumber=1
> Nov 15 17:26:29 whocares kernel: usb.c: USB device number 1 default
> language ID
> 0x0
> Nov 15 17:26:29 whocares kernel: hub.c: standalone hub
> Nov 15 17:26:29 whocares kernel: hub.c: ganged power switching
> Nov 15 17:26:30 whocares kernel: hub.c: global over-current protection
> Nov 15 17:26:30 whocares kernel: hub.c: Port indicators are not supported
> Nov 15 17:26:30 whocares kernel: hub.c: power on to power good time: 2ms
> Nov 15 17:26:30 whocares kernel: hub.c: hub controller current requirement:
> 0mA
> Nov 15 17:26:30 whocares kernel: hub.c: port removable status: RR
> Nov 15 17:26:30 whocares kernel: hub.c: local power source is good
> Nov 15 17:26:30 whocares kernel: hub.c: no over-current condition exists
> Nov 15 17:26:30 whocares kernel: hub.c: enabling power on all ports
> Nov 15 17:26:30 whocares kernel: usb.c: hub driver claimed interface
> c1847c40 Nov 15 17:26:30 whocares kernel: hub.c: port 1 connection change
> Nov 15 17:26:30 whocares kernel: hub.c: port 1, portstatus 100, change 3,
> 12 Mb/s
> Nov 15 17:26:30 whocares kernel: hub.c: port 2 connection change
> Nov 15 17:26:31 whocares kernel: hub.c: port 2, portstatus 100, change 3,
> 12 Mb/s
> Nov 15 17:26:31 whocares kernel: hub.c: port 1 enable change, status 100
> Nov 15 17:26:31 whocares kernel: hub.c: port 2 enable change, status 100
>
> When attaching the cam:
> -----------------------
> Nov 15 17:33:04 whocares kernel: hub.c: port 1 connection change
> Nov 15 17:33:04 whocares kernel: hub.c: port 1, portstatus 100, change 3,
> 12 Mb/s
> Nov 15 17:33:04 whocares kernel: hub.c: port 1 enable change, status 100
> Nov 15 17:33:07 whocares kernel: hub.c: port 1 connection change
> Nov 15 17:33:07 whocares kernel: hub.c: port 1, portstatus 101, change 1,
> 12 Mb/s
> Nov 15 17:33:07 whocares kernel: hub.c: port 1, portstatus 103, change 0,
> 12 Mb/s
> Nov 15 17:33:07 whocares kernel: usb.c: kmalloc IF dd5d3d80, numif 1
> Nov 15 17:33:07 whocares kernel: usb.c: new device strings: Mfr=1,
> Product=2, SerialNumber=3
> Nov 15 17:33:07 whocares kernel: usb.c: USB device number 2 default
> language ID
> 0x409
> Nov 15 17:33:08 whocares kernel: WARNING: USB Mass Storage data integrity
> not assured
> Nov 15 17:33:08 whocares kernel: USB Mass Storage device found at 2
> Nov 15 17:33:08 whocares kernel: usb.c: usb-storage driver claimed
> interface dd5d3d80
>
>
> ---------------------------------------------------
> /var/log/messages messages
> --------------------------
> At bootup:
> ----------
> Nov 15 17:26:28 whocares kernel: usb.c: registered new driver usbdevfs
> Nov 15 17:26:28 whocares kernel: usb.c: registered new driver hub
> Nov 15 17:26:28 whocares kernel: usb-uhci.c: $Revision: 1.268 $ time
> 17:23:58 Nov 15 2001
> Nov 15 17:26:28 whocares kernel: usb-uhci.c: High bandwidth mode enabled
> Nov 15 17:26:28 whocares kernel: usb-uhci.c: USB UHCI at I/O 0xd800, IRQ 4
> Nov 15 17:26:28 whocares kernel: usb.c: new USB bus registered, assigned
> bus number 1
> Nov 15 17:26:28 whocares kernel: Product: USB UHCI Root Hub
> Nov 15 17:26:28 whocares kernel: SerialNumber: d800
> Nov 15 17:26:28 whocares kernel: hub.c: USB hub found
> Nov 15 17:26:28 whocares kernel: hub.c: 2 ports detected
> Nov 15 17:26:29 whocares kernel: usb-uhci.c: USB UHCI at I/O 0xdc00, IRQ 4
> Nov 15 17:26:29 whocares kernel: usb.c: new USB bus registered, assigned
> bus number 2
> Nov 15 17:26:29 whocares kernel: Product: USB UHCI Root Hub
> Nov 15 17:26:29 whocares kernel: SerialNumber: dc00
> Nov 15 17:26:29 whocares kernel: hub.c: USB hub found
> Nov 15 17:26:29 whocares kernel: hub.c: 2 ports detected
> Nov 15 17:26:30 whocares kernel: usb-uhci.c: v1.268:USB Universal Host
> Controller Interface driver
> Nov 15 17:26:30 whocares kernel: Initializing USB Mass Storage driver...
> Nov 15 17:26:30 whocares kernel: usb.c: registered new driver usb-storage
> Nov 15 17:26:30 whocares kernel: USB Mass Storage support registered.
>
> When attaching the cam:
> -----------------------
> Nov 15 17:33:07 whocares kernel: hub.c: USB new device connect on bus1/1,
> assigned device number 2
> Nov 15 17:33:07 whocares kernel: Manufacturer: Hewlett-Packard
> Nov 15 17:33:07 whocares kernel: Product: HP PhotoSmart 618 (MSDC)
> Nov 15 17:33:07 whocares kernel: SerialNumber: 00030A4510A1
> Nov 15 17:33:08 whocares kernel: scsi1 : SCSI emulation for USB Mass
> Storage devices
> Nov 15 17:33:08 whocares kernel:  sda: sda1
>
> so it sees it, and it assigns sda1 to the VFAT partition on it
>
> Then I try to mount the camera with:
> mount /dev/sda1 /mnt/camera -t vfat (as root)
>
> which works with usb compiled in the kernel, but not as modules
>
> when attempting to copy something of the cam
> cp /mnt/camera/camera01/* /tmp (for instance), the process hangs. I've
> noticed though, that it hangs sometimes immediately (no files are copied)
> and sometimes it copies one or two files and hangs.
>
> I've been unable to recreate the Oops lately, since my system just won't
> shut down. I have to use the SysRq to get my system down in a safe state
> when i've tried using the cam.
>
> Kernel config appended.
>
> Thanks for any advice.

I just noticed this... After mounting the cam and executing the cp command, 
the computers load keeps mounting, even though nothing visible is happening. 
No swap usage, no cpu usage, memory stays the same...

It's mounted from 0.2 to 11.9 in under 2 minutes now. I don't notice 
anything...

I've also activated the usb-storage verbose mode, and i'll append the new 
info here (the point where it hangs)

The following message is also seen in /var/log/syslog:

Nov 15 19:13:28 whocares kernel: usb-uhci.c: ENXIO 80000280, flags 0, urb 
db7aad40, burb db7aac40

a LOT.

Thanks again

DK

-- 
devilkin@gmx.net

--------------Boundary-00=_7MUUDLCMTNFX032YRX2X
Content-Type: application/x-gzip;
  name="USB2.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="USB2.gz"

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
z6uUvOpEXsVt59WYvCKvzM+rMXnVibxKWs4rxyKvyCvj80pupuRVF/IqbTuvbPKKvDI/r2zyqhN5
NW47rxzyirwyP68c8qoLeeW1vf7Kcckr8sr8vHLJq07kld12XpVvFkNekVcG5lX9HXnIK5Pyymk7
r8r34iGvyCsD86r+njzklUl55badV+U78pBX5JWBeeWTV53IK0+VV461W16Vb+qzMa+avZgir5TF
ts4r/cpb5NVuzVbklR6wXl4pa+nllV6TFHnVqEhVXtXf0EejuGZeKeuo80pZQiOvmjSjJq+UJXTz
SlmonFeDtvOqfHsb8oq8MjCvNt1DiLwyJ6/8tvOqfN8g8oq8MjCvNt2cyZS8cq1jS/UIRVVe6dRQ
5JVOCa280ilUzqtgY17pVFTkVfnWTPV51fjFNuWVTrHt8qpR5aZ5tXOzN+WVNrBGXunU0sgr7SZt
yqumRaryKqrLK53iOnnVMCjIq+q8CtvOK/37X5FX5NXB8qr2/lfklVF5tfn+V3vIK/37X5FX5NXB
8qr2/lfklVF5tfn+V3vIK/37X5FX5NXB8qr2/lfklVF5tfn+V3vIK/37X5FX5NXB8qr2/lfklVF5
tfn+V3vIK/37X5FX5NXB8qr2/lfklVF5tfn+V7vnlat//yvyirw6VF65tfe/Iq+MyqvN97/aQ17p
3/+KvCKvDpZXtfe/Iq9Myitn8/0Z9pBX+ve/Iq/Iq4PlVe39r8zKK9vePa+UNdR5pSyhm1fKQuXx
1eb79elUVOSV/v2vGr+YIq+UxbbOK/3KW+TVbs1W5JUesF5eKWvp5ZVekxR51ahIVV7V3v9Kp7hm
XjUJCvKqMq+CYn37/YNT95xX5ftf2b4bet1JLM8a+m1GVl7/KP9iUmjBAgss9Pxb9fy1d5Kj5zep
5x8WPb8bttTzl+8k54R+0KG5Si9DCxZYYIEFFlgYPh9i+Fx7Y1OGzyYNn+PiQL/f1vD5pxubuo4X
Mnw2OrRggQUWWGCBBRZYYIEFFlj6zNLXAzm1T3zgQI45B3Js4RbnQeO2DuSUn/hgW44nX4YjOSan
FiywwAILLLDAAgsssMACCyywwAILLLDAAgsssMACCyz9ZOnr2e3a54Nzdtuks9vj4jKFu2/2fXa7
/Hxw27UGPme3zU4tWGCBBRZYYIEFFlhggQUWWGCBBRZYYIEFFlgOz+K0x6JdejuWnVoOCyywwAIL
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


--------------Boundary-00=_7MUUDLCMTNFX032YRX2X--
