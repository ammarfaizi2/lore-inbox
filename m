Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265034AbSKFNOH>; Wed, 6 Nov 2002 08:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265036AbSKFNOH>; Wed, 6 Nov 2002 08:14:07 -0500
Received: from ppp-217-133-223-118.dialup.tiscali.it ([217.133.223.118]:36992
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S265034AbSKFNNw>; Wed, 6 Nov 2002 08:13:52 -0500
Date: Wed, 6 Nov 2002 14:20:23 +0100
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Linux-USB-Users <linux-usb-users@lists.sourceforge.net>
Subject: USB broken in 2.5.4[56]
Message-ID: <20021106132022.GA2101@home.ldb.ods.org>
Mail-Followup-To: Linux-Kernel ML <linux-kernel@vger.kernel.org>,
	Linux-USB-Users <linux-usb-users@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In 2.5.4[56] USB has the following problems:
- Kernel and lsusb unable to get strings (empty in driverfs and lsusb
   gets EPIPE from usbdevfs)
- bAlternateSetting =3D=3D 0 on interface 1 of my SpeedTouch USB (this
   prevents loading the firmware to it)

Reverting all the USB changes in 2.5.45 fixes the problems.


Here is what happens with broken kernels:

lspci:

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (r=
ev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=3D256M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=3D31 SBA+ 64bit- FW- Rate=3Dx1,x2
		Command: RQ=3D0 SBA+ AGP+ 64bit- FW- Rate=3Dx2


lsusb:
=09
cannot get string descriptor 1, error =3D Broken pipe(32)
cannot get string descriptor 2, error =3D Broken pipe(32)
cannot get string descriptor 3, error =3D Broken pipe(32)
cannot get string descriptor 1, error =3D Broken pipe(32)
cannot get string descriptor 2, error =3D Broken pipe(32)

Bus 001 Device 003: ID 06b9:4061 Alcatel Telecom=20
  Language IDs: none (cannot get min. string descriptor; got len=3D-1, erro=
r=3D32:Broken pipe)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass          255 Vendor Specific Class
  bDeviceSubClass         0=20
  bDeviceProtocol         0=20
  bMaxPacketSize0         8
  idVendor           0x06b9 Alcatel Telecom
  idProduct          0x4061=20
  bcdDevice            0.00
  iManufacturer           1=20
  iProduct                2=20
  iSerial                 3=20
  bNumConfigurations      1
cannot get config descriptor 0, Broken pipe (32)
  Language IDs: none (cannot get min. string descriptor; got len=3D-1, erro=
r=3D32:Broken pipe)

Bus 001 Device 002: ID 045e:001e Microsoft Corp. IntelliMouse Explorer
  Language IDs: none (cannot get min. string descriptor; got len=3D-1, erro=
r=3D32:Broken pipe)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 Interface
  bDeviceSubClass         0=20
  bDeviceProtocol         0=20
  bMaxPacketSize0         8
  idVendor           0x045e Microsoft Corp.
  idProduct          0x001e IntelliMouse Explorer
  bcdDevice            1.14
  iManufacturer           1=20
  iProduct                2=20
  iSerial                 0=20
  bNumConfigurations      1
cannot get config descriptor 0, Broken pipe (32)
  Language IDs: none (cannot get min. string descriptor; got len=3D-1, erro=
r=3D32:Broken pipe)

Bus 001 Device 001: ID 0000:0000 Virtual Hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0=20
  bDeviceProtocol         0=20
  bMaxPacketSize0         8
  idVendor           0x0000 Virtual
  idProduct          0x0000 Hub
  bcdDevice            2.05
  iManufacturer           3 Linux 2.5.46 uhci-hcd
  iProduct                2 Intel Corp. 82371AB/EB/MB PIIX4 USB
  iSerial                 1 00:04.2
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
      bInterfaceSubClass      0=20
      bInterfaceProtocol      0=20
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          2
        bInterval             255
  Language IDs: (length=3D4)
     0409 English(US)


driverfs:

/sys/bus/usb/devices/1-2/1-2:0/bAlternateSetting:
 0

/sys/bus/usb/devices/1-2/1-2:0/bInterfaceClass:
00

/sys/bus/usb/devices/1-2/1-2:0/bInterfaceProtocol:
00

/sys/bus/usb/devices/1-2/1-2:0/bInterfaceSubClass:
00

/sys/bus/usb/devices/1-2/1-2:0/name:
usb-00:04.2-2 interface 0

/sys/bus/usb/devices/1-2/1-2:0/power:
0

/sys/bus/usb/devices/1-2/1-2:1/bAlternateSetting:
 0

/sys/bus/usb/devices/1-2/1-2:1/bInterfaceClass:
ff

/sys/bus/usb/devices/1-2/1-2:1/bInterfaceProtocol:
00

/sys/bus/usb/devices/1-2/1-2:1/bInterfaceSubClass:
00

/sys/bus/usb/devices/1-2/1-2:1/name:
usb-00:04.2-2 interface 1

/sys/bus/usb/devices/1-2/1-2:1/power:
0

/sys/bus/usb/devices/1-2/1-2:2/bAlternateSetting:
 0

/sys/bus/usb/devices/1-2/1-2:2/bInterfaceClass:
ff

/sys/bus/usb/devices/1-2/1-2:2/bInterfaceProtocol:
00

/sys/bus/usb/devices/1-2/1-2:2/bInterfaceSubClass:
00

/sys/bus/usb/devices/1-2/1-2:2/name:
usb-00:04.2-2 interface 2

/sys/bus/usb/devices/1-2/1-2:2/power:
0

/sys/bus/usb/devices/1-2/bcdDevice:
0000

/sys/bus/usb/devices/1-2/bConfigurationValue:
 1

/sys/bus/usb/devices/1-2/bDeviceClass:
ff

/sys/bus/usb/devices/1-2/bDeviceProtocol:
00

/sys/bus/usb/devices/1-2/bDeviceSubClass:
00

/sys/bus/usb/devices/1-2/bmAttributes:
80

/sys/bus/usb/devices/1-2/bMaxPower:
250mA

/sys/bus/usb/devices/1-2/bNumInterfaces:
 3

/sys/bus/usb/devices/1-2/idProduct:
4061

/sys/bus/usb/devices/1-2/idVendor:
06b9

/sys/bus/usb/devices/1-2/manufacturer:

/sys/bus/usb/devices/1-2/name:
Speed Touch USB  (ALCATEL)

/sys/bus/usb/devices/1-2/power:
0

/sys/bus/usb/devices/1-2/product:

/sys/bus/usb/devices/1-2/serial:

/sys/bus/usb/devices/1-2/speed:
12



Here is what happens with a working 2.5.44 kernel:

lspci:

00:04.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-=
if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at d400 [size=3D32]


lsusb:

Bus 001 Device 003: ID 06b9:4061 Alcatel Telecom=20
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass          255 Vendor Specific Class
  bDeviceSubClass         0=20
  bDeviceProtocol         0=20
  bMaxPacketSize0         8
  idVendor           0x06b9 Alcatel Telecom
  idProduct          0x4061=20
  bcdDevice            0.00
  iManufacturer           1 ALCATEL
  iProduct                2 Speed Touch USB=20
  iSerial                 3 [...]
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          147
    bNumInterfaces          3
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x80
    MaxPower              500mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0=20
      bInterfaceProtocol      0=20
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize         16
        bInterval              50
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0=20
      bInterfaceProtocol      0=20
      iInterface              0=20
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           3
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0=20
      bInterfaceProtocol      0=20
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x06  EP 6 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x07  EP 7 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x87  EP 7 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           3
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0=20
      bInterfaceProtocol      0=20
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x06  EP 6 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         32
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x07  EP 7 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         32
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x87  EP 7 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       3
      bNumEndpoints           3
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0=20
      bInterfaceProtocol      0=20
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x06  EP 6 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         16
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x07  EP 7 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         16
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x87  EP 7 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0=20
      bInterfaceProtocol      0=20
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x05  EP 5 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize          8
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x85  EP 5 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize          8
        bInterval               0
  Language IDs: (length=3D4)
     0409 English(US)


driverfs:

/sys/bus/usb/devices/1-2/1-2:0/bAlternateSetting:
 0

/sys/bus/usb/devices/1-2/1-2:0/bInterfaceClass:
ff

/sys/bus/usb/devices/1-2/1-2:0/bInterfaceProtocol:
00

/sys/bus/usb/devices/1-2/1-2:0/bInterfaceSubClass:
00

/sys/bus/usb/devices/1-2/1-2:0/name:
usb-00:04.2-2 interface 0

/sys/bus/usb/devices/1-2/1-2:0/power:
0

/sys/bus/usb/devices/1-2/1-2:1/bAlternateSetting:
 2

/sys/bus/usb/devices/1-2/1-2:1/bInterfaceClass:
ff

/sys/bus/usb/devices/1-2/1-2:1/bInterfaceProtocol:
00

/sys/bus/usb/devices/1-2/1-2:1/bInterfaceSubClass:
00

/sys/bus/usb/devices/1-2/1-2:1/name:
usb-00:04.2-2 interface 1

/sys/bus/usb/devices/1-2/1-2:1/power:
0

/sys/bus/usb/devices/1-2/1-2:2/bAlternateSetting:
 0

/sys/bus/usb/devices/1-2/1-2:2/bInterfaceClass:
ff

/sys/bus/usb/devices/1-2/1-2:2/bInterfaceProtocol:
00

/sys/bus/usb/devices/1-2/1-2:2/bInterfaceSubClass:
00

/sys/bus/usb/devices/1-2/1-2:2/name:
usb-00:04.2-2 interface 2

/sys/bus/usb/devices/1-2/1-2:2/power:
0

/sys/bus/usb/devices/1-2/bcdDevice:
0000

/sys/bus/usb/devices/1-2/bConfigurationValue:
 1

/sys/bus/usb/devices/1-2/bDeviceClass:
ff

/sys/bus/usb/devices/1-2/bDeviceProtocol:
00

/sys/bus/usb/devices/1-2/bDeviceSubClass:
00

/sys/bus/usb/devices/1-2/bmAttributes:
80

/sys/bus/usb/devices/1-2/bNumInterfaces:
 3

/sys/bus/usb/devices/1-2/idProduct:
4061

/sys/bus/usb/devices/1-2/idVendor:
06b9

/sys/bus/usb/devices/1-2/manufacturer:
ALCATEL

/sys/bus/usb/devices/1-2/MaxPower:
250mA

/sys/bus/usb/devices/1-2/name:
Speed Touch USB  (ALCATEL)

/sys/bus/usb/devices/1-2/power:
0

/sys/bus/usb/devices/1-2/product:
Speed Touch USB=20

/sys/bus/usb/devices/1-2/speed:
12

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE9yRcWdjkty3ft5+cRAgMEAKDekj6g5aukrqgYl7xhOhBRj2d0zwCg33DR
jAUyL3ev5+/vVPn+N9Eluc0=
=2hP/
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
