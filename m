Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265223AbUAETDI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 14:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263891AbUAETCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 14:02:51 -0500
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:14223 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S265320AbUAETCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 14:02:09 -0500
Date: Mon, 5 Jan 2004 11:02:04 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Javier Marcet <javier@marcet.info>
Cc: linux-kernel@vger.kernel.org, usb-storage@one-eyed-alien.net,
       linux-usb-users@lists.sourceforge.net
Subject: Re: usb-storage && iRIVER flash player problem
Message-ID: <20040105190204.GA4547@one-eyed-alien.net>
Mail-Followup-To: Javier Marcet <javier@marcet.info>,
	linux-kernel@vger.kernel.org, usb-storage@one-eyed-alien.net,
	linux-usb-users@lists.sourceforge.net
References: <20040105125948.GA9257@hiroshi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <20040105125948.GA9257@hiroshi>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It looks like your device is choking over the ALLOW_MEDIUM_REMOVAL command
-- I've never seen a device broken in this particular way before.

If you edit drivers/scsi/sd.c to remove the sending of that command (it's
normally used to lock the media-eject button on devices that support it),
we should be able to test this theory.  If this is the case, then we may
need to modify the SCSI layer to only send that command if the RMB bit is
set.

Matt

On Mon, Jan 05, 2004 at 01:59:48PM +0100, Javier Marcet wrote:
>=20
> I'm trying to get an iRIVER iFP-599T aduio player, with the Universal
> Mass Storage firmware.
>=20
> I've tried with 2.6.1-rc1-mm1 & 2.4.22.
>=20
> The device is seen, but there is no way to mount it, nor re-partition
> the thing.
>=20
> I have it working from Windows and MacOS (I tried once on this). At
> first look, it seems there is only one whole partition, but fdisk
> reports 4 mangled ones, and some users who said they got it to work
> under 2.4, explain that the mountable vfat partition under linux is the
> fourth one (/dev/sda4 on my system).
>=20
> There is no way here. I've recompiled with USBm usb-storage && scsi
> debugging enabled and not as modules, directly into the kernel. For your
> info I'm using udev.
>=20
> See the attached dmesg, and some info from /proc, if there is anything
> else which could come in handy to find where the problem might be,
> please ask :)
>=20
> P.S Other than the linux-kernel, please cross-post to my e-mail address
> since I'm not subscribed.
>=20
>=20
> --=20
> Javier Marcet <javier@marcet.info>

> cted: Hauppauge WinTV [card=3D10], PCI subsystem ID is 0070:13eb
> bttv0: using: Hauppauge (bt878) [card=3D10,autodetected]
> bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
> bttv0: Hauppauge eeprom: model=3D44354, tuner=3DTemic 4009FR5 (20), radio=
=3Dyes
> bttv0: using tuner=3D20
> bttv0: i2c: checking for MSP34xx @ 0x80... found
> msp34xx: init: chip=3DMSP3415D-B3 +nicam +simple
> msp3410: daemon started
> registering 0-0040
> bttv0: i2c: checking for TDA9875 @ 0xb0... not found
> bttv0: i2c: checking for TDA7432 @ 0x8a... not found
> tvaudio: TV audio decoder + audio/video mux driver
> tvaudio: known chips: tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300=
,tea6420,tda8425,pic16c54 (PV951),ta8874z
> tuner: chip found @ 0xc2
> tuner: type set to 20 (Temic PAL_BG (4009 FR5) or PAL_I (4069 FR5))
> registering 0-0061
> bttv0: registered device video0
> bttv0: registered device vbi0
> bttv0: registered device radio0
> bttv0: PLL: 28636363 =3D> 35468950 .. ok
> registering 1-002d
> registering 1-0049
> registering 1-0048
> found reiserfs format "3.6" with standard journal
> Reiserfs journal params: device hda8, size 8192, journal first block 18, =
max trans len 1024, max batch 900, max commit age 30, max trans age 30
> reiserfs: checking transaction log (hda8) for (hda8)
> Using r5 hash to sort names
> found reiserfs format "3.6" with standard journal
> Reiserfs journal params: device hda9, size 8192, journal first block 18, =
max trans len 1024, max batch 900, max commit age 30, max trans age 30
> reiserfs: checking transaction log (hda9) for (hda9)
> b44: eth0: Link is down.
> Using r5 hash to sort names
> found reiserfs format "3.6" with standard journal
> Reiserfs journal params: device hda10, size 8192, journal first block 18,=
 max trans len 1024, max batch 900, max commit age 30, max trans age 30
> reiserfs: checking transaction log (hda10) for (hda10)
> Using r5 hash to sort names
> found reiserfs format "3.6" with standard journal
> Reiserfs journal params: device hda11, size 8192, journal first block 18,=
 max trans len 1024, max batch 900, max commit age 30, max trans age 30
> reiserfs: checking transaction log (hda11) for (hda11)
> Using r5 hash to sort names
> found reiserfs format "3.6" with standard journal
> b44: eth0: Link is up at 100 Mbps, full duplex.
> b44: eth0: Flow control is on for TX and on for RX.
> Reiserfs journal params: device hda13, size 8192, journal first block 18,=
 max trans len 1024, max batch 900, max commit age 30, max trans age 30
> reiserfs: checking transaction log (hda13) for (hda13)
> Using r5 hash to sort names
> PCI: Found IRQ 4 for device 0000:00:11.5
> PCI: Setting latency timer of device 0000:00:11.5 to 64
> tvmixer: MSP3415D-B3 (bt878 #0 [sw]) registered with minor 16
> btaudio: driver version 0.7 loaded [digital+analog]
> PCI: Enabling device 0000:00:0c.1 (0004 -> 0006)
> PCI: Found IRQ 11 for device 0000:00:0c.1
> PCI: Sharing IRQ 11 with 0000:00:0c.0
> btaudio: Bt878 (rev 17) at 00:0c.1, irq: 11, latency: 64, mmio: 0xd6800000
> btaudio: using card config "default"
> btaudio: registered device dsp2 [digital]
> btaudio: registered device dsp3 [analog]
> btaudio: registered device mixer2
> Disabled Privacy Extensions on device c0377a40(lo)
> eth0: no IPv6 routers present
> Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> nfs warning: mount version older than kernel
> nfs warning: mount version older than kernel
> nfs warning: mount version older than kernel
> nfs warning: mount version older than kernel
> nfs warning: mount version older than kernel
> nfs warning: mount version older than kernel
> nfs warning: mount version older than kernel
> nfs warning: mount version older than kernel
> nfs warning: mount version older than kernel
> nfs warning: mount version older than kernel
> nfs warning: mount version older than kernel
> nfs warning: mount version older than kernel
> nfs warning: mount version older than kernel
> nfs warning: mount version older than kernel
> request_module: failed /sbin/modprobe -- char-major-226-0. error =3D 256
> [drm] Initialized radeon 1.9.0 20020828 on minor 0
> agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
> agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
> agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
> agpgart: Putting AGP V2 device at 0000:01:00.1 into 4x mode
> [drm] Loading R200 Microcode
> PCI: Found IRQ 11 for device 0000:01:00.0
> atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/ser=
io0).
> atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/ser=
io0).
> ehci_hcd 0000:00:10.3: GetStatus port 6 status 001803 POWER sig=3Dj  CSC =
CONNECT
> hub 1-0:1.0: port 6, status 501, change 1, 480 Mb/s
> hub 1-0:1.0: debounce: port 6: delay 100ms stable 4 status 0x501
> ehci_hcd 0000:00:10.3: port 6 full speed --> companion
> ehci_hcd 0000:00:10.3: GetStatus port 6 status 003801 POWER OWNER sig=3Dj=
  CONNECT
> drivers/usb/host/uhci-hcd.c: 9800: wakeup_hc
> hub 4-0:1.0: port 2, status 101, change 1, 12 Mb/s
> hub 4-0:1.0: debounce: port 2: delay 100ms stable 4 status 0x101
> hub 4-0:1.0: new USB device on port 2, assigned address 2
> usb 4-2: new device strings: Mfr=3D0, Product=3D0, SerialNumber=3D0
> drivers/usb/core/usb.c: usb_hotplug
> usb 4-2: registering 4-2:1.0 (config #1, interface 0)
> drivers/usb/core/usb.c: usb_hotplug
> usb-storage 4-2:1.0: usb_probe_interface
> usb-storage 4-2:1.0: usb_probe_interface - got id
> usb-storage: USB Mass Storage device detected
> usb-storage: act_altsetting is 0, id_index is 86
> usb-storage: -- associate_dev
> usb-storage: Transport: Bulk
> usb-storage: Protocol: Transparent SCSI
> usb-storage: Endpoints: In: 0xdd291c94 Out: 0xdd291c80 Int: 0x00000000 (P=
eriod 0)
> usb-storage: usb_stor_control_msg: rq=3Dfe rqtype=3Da1 value=3D0000 index=
=3D00 len=3D1
> usb-storage: GetMaxLUN command result is -32, data is 0
> usb-storage: *** thread sleeping.
> scsi2 : SCSI emulation for USB Mass Storage devices
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command INQUIRY (6 bytes)
> usb-storage:  12 00 00 00 24 00
> usb-storage: Bulk Command S 0x43425355 T 0x41 L 36 F 128 Trg 0 LUN 0 CL 6
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=3D0
> usb-storage: usb_stor_bulk_transfer_buf: xfer 36 bytes
> usb-storage: Status code 0; transferred 36/36
> usb-storage: -- transfer complete
> usb-storage: Bulk data transfer result 0x0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result =3D 0
> usb-storage: Bulk Status S 0x53425355 T 0x41 R 0 Stat 0x0
> usb-storage: Fixing INQUIRY data to show SCSI rev 2 - was 0
> usb-storage: scsi cmd done, result=3D0x0
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command INQUIRY (6 bytes)
> usb-storage:  12 00 00 00 7a 00
> usb-storage: Bulk Command S 0x43425355 T 0x42 L 122 F 128 Trg 0 LUN 0 CL 6
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=3D0
> usb-storage: usb_stor_bulk_transfer_buf: xfer 122 bytes
> usb-storage: Status code 0; transferred 122/122
> usb-storage: -- transfer complete
> usb-storage: Bulk data transfer result 0x0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result =3D 0
> usb-storage: Bulk Status S 0x53425355 T 0x42 R 0 Stat 0x0
> usb-storage: Fixing INQUIRY data to show SCSI rev 2 - was 0
> usb-storage: scsi cmd done, result=3D0x0
> usb-storage: *** thread sleeping.
>   Vendor: iRiver    Model: iFP Mass Driver   Rev: 1.00
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command TEST_UNIT_READY (6 bytes)
> usb-storage:  00 00 00 00 00 00
> usb-storage: Bulk Command S 0x43425355 T 0x43 L 0 F 0 Trg 0 LUN 0 CL 6
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=3D0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result =3D 0
> usb-storage: Bulk Status S 0x53425355 T 0x43 R 0 Stat 0x0
> usb-storage: scsi cmd done, result=3D0x0
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command READ_CAPACITY (10 bytes)
> usb-storage:  25 00 00 00 00 00 00 00 00 00
> usb-storage: Bulk Command S 0x43425355 T 0x44 L 8 F 128 Trg 0 LUN 0 CL 10
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=3D0
> usb-storage: usb_stor_bulk_transfer_buf: xfer 8 bytes
> usb-storage: Status code 0; transferred 8/8
> usb-storage: -- transfer complete
> usb-storage: Bulk data transfer result 0x0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result =3D 0
> usb-storage: Bulk Status S 0x53425355 T 0x44 R 0 Stat 0x0
> usb-storage: scsi cmd done, result=3D0x0
> usb-storage: *** thread sleeping.
> SCSI device sda: 2048000 512-byte hdwr sectors (1049 MB)
> sda: assuming Write Enabled
> sda: assuming drive cache: write through
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command TEST_UNIT_READY (6 bytes)
> usb-storage:  00 00 00 00 00 00
> usb-storage: Bulk Command S 0x43425355 T 0x45 L 0 F 0 Trg 0 LUN 0 CL 6
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=3D0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result =3D 0
> usb-storage: Bulk Status S 0x53425355 T 0x45 R 0 Stat 0x0
> usb-storage: scsi cmd done, result=3D0x0
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command ALLOW_MEDIUM_REMOVAL (6 bytes)
> usb-storage:  1e 00 00 00 01 00
> usb-storage: Bulk Command S 0x43425355 T 0x46 L 0 F 0 Trg 0 LUN 0 CL 6
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=3D0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result =3D 0
> usb-storage: Bulk Status S 0x53425355 T 0x46 R 0 Stat 0x1
> usb-storage: -- transport indicates command failure
> usb-storage: Issuing auto-REQUEST_SENSE
> usb-storage: Bulk Command S 0x43425355 T 0x80000046 L 18 F 128 Trg 0 LUN =
0 CL 6
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=3D0
> usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
> usb-storage: Status code 0; transferred 18/18
> usb-storage: -- transfer complete
> usb-storage: Bulk data transfer result 0x0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result =3D 0
> usb-storage: Bulk Status S 0x53425355 T 0x80000046 R 0 Stat 0x0
> usb-storage: -- Result from auto-sense is 0
> usb-storage: -- code: 0x70, key: 0x6, ASC: 0x29, ASCQ: 0x0
> usb-storage: Unit Attention: Power on, reset, or bus device reset occurred
> usb-storage: scsi cmd done, result=3D0x2
> usb-storage: *** thread sleeping.
>  sda:<3>Buffer I/O error on device sda, logical block 0
> Buffer I/O error on device sda, logical block 0
>  unable to read partition table
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command ALLOW_MEDIUM_REMOVAL (6 bytes)
> usb-storage:  1e 00 00 00 00 00
> usb-storage: Bulk Command S 0x43425355 T 0x47 L 0 F 0 Trg 0 LUN 0 CL 6
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=3D0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result =3D 0
> usb-storage: Bulk Status S 0x53425355 T 0x47 R 0 Stat 0x1
> usb-storage: -- transport indicates command failure
> usb-storage: Issuing auto-REQUEST_SENSE
> usb-storage: Bulk Command S 0x43425355 T 0x80000047 L 18 F 128 Trg 0 LUN =
0 CL 6
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=3D0
> usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
> usb-storage: Status code 0; transferred 18/18
> usb-storage: -- transfer complete
> usb-storage: Bulk data transfer result 0x0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result =3D 0
> usb-storage: Bulk Status S 0x53425355 T 0x80000047 R 0 Stat 0x0
> usb-storage: -- Result from auto-sense is 0
> usb-storage: -- code: 0x70, key: 0x6, ASC: 0x29, ASCQ: 0x0
> usb-storage: Unit Attention: Power on, reset, or bus device reset occurred
> usb-storage: scsi cmd done, result=3D0x2
> usb-storage: *** thread sleeping.
> Attached scsi removable disk sda at scsi2, channel 0, id 0, lun 0
> Attached scsi generic sg0 at scsi2, channel 0, id 0, lun 0,  type 0
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Bad target number (1:0)
> usb-storage: scsi cmd done, result=3D0x40000
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Bad target number (2:0)
> usb-storage: scsi cmd done, result=3D0x40000
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Bad target number (3:0)
> usb-storage: scsi cmd done, result=3D0x40000
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Bad target number (4:0)
> usb-storage: scsi cmd done, result=3D0x40000
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Bad target number (5:0)
> usb-storage: scsi cmd done, result=3D0x40000
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Bad target number (6:0)
> usb-storage: scsi cmd done, result=3D0x40000
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Bad target number (7:0)
> usb-storage: scsi cmd done, result=3D0x40000
> usb-storage: *** thread sleeping.
> WARNING: USB Mass Storage data integrity not assured
> USB Mass Storage device found at 2

> e 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result =3D 0
> usb-storage: Bulk Status S 0x53425355 T 0x12e R 0 Stat 0x1
> usb-storage: -- transport indicates command failure
> usb-storage: Issuing auto-REQUEST_SENSE
> usb-storage: Bulk Command S 0x43425355 T 0x8000012e L 18 F 128 Trg 0 LUN =
0 CL 6
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=3D0
> usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
> usb-storage: Status code 0; transferred 18/18
> usb-storage: -- transfer complete
> usb-storage: Bulk data transfer result 0x0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result =3D 0
> usb-storage: Bulk Status S 0x53425355 T 0x8000012e R 0 Stat 0x0
> usb-storage: -- Result from auto-sense is 0
> usb-storage: -- code: 0x70, key: 0x6, ASC: 0x29, ASCQ: 0x0
> usb-storage: Unit Attention: Power on, reset, or bus device reset occurred
> usb-storage: scsi cmd done, result=3D0x2
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command TEST_UNIT_READY (6 bytes)
> usb-storage:  00 00 00 00 00 00
> usb-storage: Bulk Command S 0x43425355 T 0x12f L 0 F 0 Trg 0 LUN 0 CL 6
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=3D0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result =3D 0
> usb-storage: Bulk Status S 0x53425355 T 0x12f R 0 Stat 0x0
> usb-storage: scsi cmd done, result=3D0x0
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command TEST_UNIT_READY (6 bytes)
> usb-storage:  00 00 00 00 00 00
> usb-storage: Bulk Command S 0x43425355 T 0x130 L 0 F 0 Trg 0 LUN 0 CL 6
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=3D0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result =3D 0
> usb-storage: Bulk Status S 0x53425355 T 0x130 R 0 Stat 0x0
> usb-storage: scsi cmd done, result=3D0x0
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command READ_CAPACITY (10 bytes)
> usb-storage:  25 00 00 00 00 00 00 00 00 00
> usb-storage: Bulk Command S 0x43425355 T 0x131 L 8 F 128 Trg 0 LUN 0 CL 10
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=3D0
> usb-storage: usb_stor_bulk_transfer_buf: xfer 8 bytes
> usb-storage: Status code 0; transferred 8/8
> usb-storage: -- transfer complete
> usb-storage: Bulk data transfer result 0x0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result =3D 0
> usb-storage: Bulk Status S 0x53425355 T 0x131 R 0 Stat 0x0
> usb-storage: scsi cmd done, result=3D0x0
> usb-storage: *** thread sleeping.
> SCSI device sda: 2048000 512-byte hdwr sectors (1049 MB)
> sda: assuming Write Enabled
> sda: assuming drive cache: write through
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command ALLOW_MEDIUM_REMOVAL (6 bytes)
> usb-storage:  1e 00 00 00 01 00
> usb-storage: Bulk Command S 0x43425355 T 0x132 L 0 F 0 Trg 0 LUN 0 CL 6
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=3D0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result =3D 0
> usb-storage: Bulk Status S 0x53425355 T 0x132 R 0 Stat 0x1
> usb-storage: -- transport indicates command failure
> usb-storage: Issuing auto-REQUEST_SENSE
> usb-storage: Bulk Command S 0x43425355 T 0x80000132 L 18 F 128 Trg 0 LUN =
0 CL 6
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=3D0
> usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
> usb-storage: Status code 0; transferred 18/18
> usb-storage: -- transfer complete
> usb-storage: Bulk data transfer result 0x0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result =3D 0
> usb-storage: Bulk Status S 0x53425355 T 0x80000132 R 0 Stat 0x0
> usb-storage: -- Result from auto-sense is 0
> usb-storage: -- code: 0x70, key: 0x6, ASC: 0x29, ASCQ: 0x0
> usb-storage: Unit Attention: Power on, reset, or bus device reset occurred
> usb-storage: scsi cmd done, result=3D0x2
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command TEST_UNIT_READY (6 bytes)
> usb-storage:  00 00 00 00 00 00
> usb-storage: Bulk Command S 0x43425355 T 0x133 L 0 F 0 Trg 0 LUN 0 CL 6
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=3D0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result =3D 0
> usb-storage: Bulk Status S 0x53425355 T 0x133 R 0 Stat 0x0
> usb-storage: scsi cmd done, result=3D0x0
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command READ_CAPACITY (10 bytes)
> usb-storage:  25 00 00 00 00 00 00 00 00 00
> usb-storage: Bulk Command S 0x43425355 T 0x134 L 8 F 128 Trg 0 LUN 0 CL 10
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=3D0
> usb-storage: usb_stor_bulk_transfer_buf: xfer 8 bytes
> usb-storage: Status code 0; transferred 8/8
> usb-storage: -- transfer complete
> usb-storage: Bulk data transfer result 0x0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result =3D 0
> usb-storage: Bulk Status S 0x53425355 T 0x134 R 0 Stat 0x0
> usb-storage: scsi cmd done, result=3D0x0
> usb-storage: *** thread sleeping.
> SCSI device sda: 2048000 512-byte hdwr sectors (1049 MB)
> sda: assuming Write Enabled
> sda: assuming drive cache: write through
>  sda:<3>Buffer I/O error on device sda, logical block 0
> Buffer I/O error on device sda, logical block 0
>  unable to read partition table
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command TEST_UNIT_READY (6 bytes)
> usb-storage:  00 00 00 00 00 00
> usb-storage: Bulk Command S 0x43425355 T 0x135 L 0 F 0 Trg 0 LUN 0 CL 6
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=3D0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result =3D 0
> usb-storage: Bulk Status S 0x53425355 T 0x135 R 0 Stat 0x0
> usb-storage: scsi cmd done, result=3D0x0
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command TEST_UNIT_READY (6 bytes)
> usb-storage:  00 00 00 00 00 00
> usb-storage: Bulk Command S 0x43425355 T 0x136 L 0 F 0 Trg 0 LUN 0 CL 6
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=3D0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result =3D 0
> usb-storage: Bulk Status S 0x53425355 T 0x136 R 0 Stat 0x0
> usb-storage: scsi cmd done, result=3D0x0
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command READ_CAPACITY (10 bytes)
> usb-storage:  25 00 00 00 00 00 00 00 00 00
> usb-storage: Bulk Command S 0x43425355 T 0x137 L 8 F 128 Trg 0 LUN 0 CL 10
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=3D0
> usb-storage: usb_stor_bulk_transfer_buf: xfer 8 bytes
> usb-storage: Status code 0; transferred 8/8
> usb-storage: -- transfer complete
> usb-storage: Bulk data transfer result 0x0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result =3D 0
> usb-storage: Bulk Status S 0x53425355 T 0x137 R 0 Stat 0x0
> usb-storage: scsi cmd done, result=3D0x0
> usb-storage: *** thread sleeping.
> SCSI device sda: 2048000 512-byte hdwr sectors (1049 MB)
> sda: assuming Write Enabled
> sda: assuming drive cache: write through
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command TEST_UNIT_READY (6 bytes)
> usb-storage:  00 00 00 00 00 00
> usb-storage: Bulk Command S 0x43425355 T 0x138 L 0 F 0 Trg 0 LUN 0 CL 6
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=3D0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result =3D 0
> usb-storage: Bulk Status S 0x53425355 T 0x138 R 0 Stat 0x0
> usb-storage: scsi cmd done, result=3D0x0
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command READ_CAPACITY (10 bytes)
> usb-storage:  25 00 00 00 00 00 00 00 00 00
> usb-storage: Bulk Command S 0x43425355 T 0x139 L 8 F 128 Trg 0 LUN 0 CL 10
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=3D0
> usb-storage: usb_stor_bulk_transfer_buf: xfer 8 bytes
> usb-storage: Status code 0; transferred 8/8
> usb-storage: -- transfer complete
> usb-storage: Bulk data transfer result 0x0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result =3D 0
> usb-storage: Bulk Status S 0x53425355 T 0x139 R 0 Stat 0x0
> usb-storage: scsi cmd done, result=3D0x0
> usb-storage: *** thread sleeping.
> SCSI device sda: 2048000 512-byte hdwr sectors (1049 MB)
> sda: assuming Write Enabled
> sda: assuming drive cache: write through
>  sda:<7>usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command READ_10 (10 bytes)
> usb-storage:  28 00 00 00 00 00 00 00 08 00
> usb-storage: Bulk Command S 0x43425355 T 0x13a L 4096 F 128 Trg 0 LUN 0 C=
L 10
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=3D0
> usb-storage: usb_stor_bulk_transfer_sglist: xfer 4096 bytes, 1 entries
> usb-storage: Status code 0; transferred 4096/4096
> usb-storage: -- transfer complete
> usb-storage: Bulk data transfer result 0x0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result =3D 0
> usb-storage: Bulk Status S 0x53425355 T 0x13a R 0 Stat 0x0
> usb-storage: scsi cmd done, result=3D0x0
> usb-storage: *** thread sleeping.
>  sda1 sda2 sda3 sda4
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command READ_10 (10 bytes)
> usb-storage:  28 00 00 00 00 08 00 00 78 00
> usb-storage: Bulk Command S 0x43425355 T 0x13b L 61440 F 128 Trg 0 LUN 0 =
CL 10
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=3D0
> usb-storage: usb_stor_bulk_transfer_sglist: xfer 61440 bytes, 15 entries
> usb-storage: Status code 0; transferred 61440/61440
> usb-storage: -- transfer complete
> usb-storage: Bulk data transfer result 0x0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result =3D 0
> usb-storage: Bulk Status S 0x53425355 T 0x13b R 0 Stat 0x0
> usb-storage: scsi cmd done, result=3D0x0
> usb-storage: *** thread sleeping.
> usb-storage: queuecommand called
> usb-storage: *** thread awakened.
> usb-storage: Command ALLOW_MEDIUM_REMOVAL (6 bytes)
> usb-storage:  1e 00 00 00 00 00
> usb-storage: Bulk Command S 0x43425355 T 0x13c L 0 F 0 Trg 0 LUN 0 CL 6
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=3D0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result =3D 0
> usb-storage: Bulk Status S 0x53425355 T 0x13c R 0 Stat 0x1
> usb-storage: -- transport indicates command failure
> usb-storage: Issuing auto-REQUEST_SENSE
> usb-storage: Bulk Command S 0x43425355 T 0x8000013c L 18 F 128 Trg 0 LUN =
0 CL 6
> usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=3D0
> usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
> usb-storage: Status code 0; transferred 18/18
> usb-storage: -- transfer complete
> usb-storage: Bulk data transfer result 0x0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> usb-storage: Status code 0; transferred 13/13
> usb-storage: -- transfer complete
> usb-storage: Bulk status result =3D 0
> usb-storage: Bulk Status S 0x53425355 T 0x8000013c R 0 Stat 0x0
> usb-storage: -- Result from auto-sense is 0
> usb-storage: -- code: 0x70, key: 0x6, ASC: 0x29, ASCQ: 0x0
> usb-storage: Unit Attention: Power on, reset, or bus device reset occurred
> usb-storage: scsi cmd done, result=3D0x2
> usb-storage: *** thread sleeping.

>=20
> T:  Bus=3D04 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12  M=
xCh=3D 2
> B:  Alloc=3D  0/900 us ( 0%), #Int=3D  0, #Iso=3D  0
> D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
> P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 2.06
> S:  Manufacturer=3DLinux 2.6.1-rc1-mm1 uhci_hcd
> S:  Product=3DUHCI Host Controller
> S:  SerialNumber=3D0000:00:10.2
> C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D40 MxPwr=3D  0mA
> I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
> E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D255ms
>=20
> T:  Bus=3D04 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D01 Dev#=3D  2 Spd=3D12  M=
xCh=3D 0
> D:  Ver=3D 1.10 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
> P:  Vendor=3D4102 ProdID=3D1105 Rev=3D 1.00
> C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3Dc0 MxPwr=3D  0mA
> I:  If#=3D 0 Alt=3D 0 #EPs=3D 2 Cls=3D08(stor.) Sub=3D06 Prot=3D50 Driver=
=3Dusb-storage
> E:  Ad=3D03(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
> E:  Ad=3D83(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
>=20
> T:  Bus=3D03 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12  M=
xCh=3D 2
> B:  Alloc=3D  0/900 us ( 0%), #Int=3D  0, #Iso=3D  0
> D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
> P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 2.06
> S:  Manufacturer=3DLinux 2.6.1-rc1-mm1 uhci_hcd
> S:  Product=3DUHCI Host Controller
> S:  SerialNumber=3D0000:00:10.1
> C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D40 MxPwr=3D  0mA
> I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
> E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D255ms
>=20
> T:  Bus=3D02 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12  M=
xCh=3D 2
> B:  Alloc=3D  0/900 us ( 0%), #Int=3D  0, #Iso=3D  0
> D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
> P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 2.06
> S:  Manufacturer=3DLinux 2.6.1-rc1-mm1 uhci_hcd
> S:  Product=3DUHCI Host Controller
> S:  SerialNumber=3D0000:00:10.0
> C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D40 MxPwr=3D  0mA
> I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
> E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D255ms
>=20
> T:  Bus=3D01 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D480 M=
xCh=3D 6
> B:  Alloc=3D  0/800 us ( 0%), #Int=3D  0, #Iso=3D  0
> D:  Ver=3D 2.00 Cls=3D09(hub  ) Sub=3D00 Prot=3D01 MxPS=3D 8 #Cfgs=3D  1
> P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 2.06
> S:  Manufacturer=3DLinux 2.6.1-rc1-mm1 ehci_hcd
> S:  Product=3DEHCI Host Controller
> S:  SerialNumber=3D0000:00:10.3
> C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D40 MxPwr=3D  0mA
> I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
> E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D256ms

> Attached devices:
> Host: scsi2 Channel: 00 Id: 00 Lun: 00
>   Vendor: iRiver   Model: iFP Mass Driver  Rev: 1.00
>   Type:   Direct-Access                    ANSI SCSI revision: 02

>    Host scsi2: usb-storage
>        Vendor: Unknown
>       Product: Unknown
> Serial Number: None
>      Protocol: Transparent SCSI
>     Transport: Bulk
>        Quirks:

>=20
> Disk /dev/sda: 1048 MB, 1048576000 bytes
> 33 heads, 61 sectors/track, 1017 cylinders
> Units =3D cylinders of 2013 * 512 =3D 1030656 bytes
>=20
>    Device Boot      Start         End      Blocks   Id  System
> /dev/sda1   ?      386556      953625   570754815+  72  Unknown
> Partition 1 has different physical/logical beginnings (non-Linux?):
>      phys=3D(357, 116, 40) logical=3D(386555, 11, 23)
> Partition 1 has different physical/logical endings:
>      phys=3D(357, 32, 45) logical=3D(953624, 6, 61)
> Partition 1 does not end on cylinder boundary.
> /dev/sda2   ?       83801     1045563   968014120   65  Novell Netware 386
> Partition 2 has different physical/logical beginnings (non-Linux?):
>      phys=3D(288, 115, 43) logical=3D(83800, 2, 1)
> Partition 2 has different physical/logical endings:
>      phys=3D(367, 114, 50) logical=3D(1045562, 23, 53)
> Partition 2 does not end on cylinder boundary.
> /dev/sda3   ?      928903     1890666   968014096   79  Unknown
> Partition 3 has different physical/logical beginnings (non-Linux?):
>      phys=3D(366, 32, 33) logical=3D(928902, 28, 32)
> Partition 3 has different physical/logical endings:
>      phys=3D(357, 32, 43) logical=3D(1890665, 16, 36)
> Partition 3 does not end on cylinder boundary.
> /dev/sda4   ?           1     1806869  1818613248    d  Unknown
> Partition 4 has different physical/logical beginnings (non-Linux?):
>      phys=3D(372, 97, 50) logical=3D(0, 0, 1)
> Partition 4 has different physical/logical endings:
>      phys=3D(0, 10, 0) logical=3D(1806868, 19, 53)
> Partition 4 does not end on cylinder boundary.
>=20
> Partition table entries are not in disk order


--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Department of Justice agent.  I have come to purify the flock.
					-- DOJ agent
User Friendly, 5/22/1998

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/+bSsIjReC7bSPZARAhBWAKCklwTvrypr12q4wCjGEgP7N7eEFgCglw84
OD5yluMq8CS401ZGT7Jdisg=
=7yZb
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
