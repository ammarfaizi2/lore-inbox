Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbUDCOUp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 09:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbUDCOUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 09:20:45 -0500
Received: from mail.gmx.de ([213.165.64.20]:48852 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261745AbUDCOUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 09:20:41 -0500
X-Authenticated: #294883
Message-ID: <406EC833.4080909@gmx.de>
Date: Sat, 03 Apr 2004 16:20:35 +0200
From: Hans-Georg Esser <h.g.esser@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.20 and 2.4.21, Firewire, 160 GB Harddisk, 134 GB barrier
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello list,

I found an earlier thread ("KERNEL 2.6.3 and MAXTOR 160 GB", March 2004)
dealing with a 137 GB barrier (that I guess meant: 137xxx MB) for a Maxtor
160 GB drive in Kernel 2.6.x. I'd like to add my personal observation to
that (for Kernel 2.4.20/21):

My drive (Western Digital WD1600BB-32DWA0) works well when directly
connected to the IDE controller, but doesn't like using an external firewire
connection ("Pyro 1394 Drive Kit" of Adstech.com). The firewire stuff
worked well with an 80 GB disk, but with the 160 GB disk I'm only getting
134 GB (or 137439 MB).

This may be related to the other post I mentioned, cause of the same
"barrier" number. I haven't tried a newer kernel yet, this was with the
standard kernel that came with the distro:

# uname -a
Linux server 2.4.21-99-default #1 Wed Sep 24 13:30:51 UTC 2003 i686 i686 i386
GNU/Linux
# lspci -v
03:08.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller
(rev 46) (prog-if 10 [OHCI])
~        Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
~        Flags: bus master, stepping, medium devsel, latency 32, IRQ 9
~        Memory at e9000000 (32-bit, non-prefetchable) [size=2K]
~        I/O ports at 9800 [size=128]
~        Capabilities: [50] Power Management version 2

Is this a known problem of the 2.4.x line and should I move to 2.6 to make
it go away? (A test with a 2.4.20 kernel gave the same results, minus the
"non-standard ROM format" stuff.)

Following snippet shows what is being logged when connecting the external
drive.

Thanks,
Hans-Georg


<snip "/var/log/messages">
Apr  3 13:19:46 server kernel: ieee1394: Node 0-00:1023 has non-standard ROM
format (0 quads), cannot parse
Apr  3 13:19:57 server kernel: ieee1394: Node added: ID:BUS[0-00:1023]
GUID[0008b502000500c8]
Apr  3 13:20:02 server kernel: sbp2: $Rev: 1018 $ Ben Collins <bcollins@debian.org>
Apr  3 13:20:02 server kernel: scsi1 : SCSI emulation for IEEE-1394 SBP-2 Devices
Apr  3 13:20:02 server kernel: blk: queue d137fa14, I/O limit 4095Mb (mask
0xffffffff)
Apr  3 13:20:03 server kernel: ieee1394: sbp2: Logged into SBP-2 device
Apr  3 13:20:03 server kernel: ieee1394: sbp2: Node 0-00:1023: Max speed [S400]
- - Max payload [2048]
Apr  3 13:20:03 server insmod: Using
/lib/modules/2.4.21-99-default/kernel/drivers/ieee1394/sbp2.o
Apr  3 13:20:03 server insmod: Symbol version prefix ''
Apr  3 13:20:03 server kernel: scsi singledevice 1 0 0 0
Apr  3 13:20:03 server kernel:   Vendor: WDC WD16  Model: 00BB-32DWA0       Rev:
Apr  3 13:20:03 server kernel:   Type:   Direct-Access                      ANSI
SCSI revision: 06
Apr  3 13:20:03 server kernel: blk: queue d137f414, I/O limit 4095Mb (mask
0xffffffff)
Apr  3 13:20:03 server kernel: Attached scsi disk sda at scsi1, channel 0, id 0,
lun 0
Apr  3 13:20:03 server kernel: SCSI device sda: 268435455 512-byte hdwr sectors
(137439 MB)
Apr  3 13:20:03 server kernel:  sda: sda1 sda2
Apr  3 13:20:03 server kernel: scsi singledevice 1 0 1 0
Apr  3 13:20:03 server kernel: scsi singledevice 1 0 2 0
Apr  3 13:20:03 server kernel: scsi singledevice 1 0 3 0
Apr  3 13:20:03 server kernel: scsi singledevice 1 0 4 0
Apr  3 13:20:03 server kernel: scsi singledevice 1 0 5 0
Apr  3 13:20:03 server kernel: scsi singledevice 1 0 6 0
Apr  3 13:20:03 server kernel: scsi singledevice 1 0 7 0
</snip>

- --
Hans-Georg Eßer  -  http://privat.hgesser.com  -  Tel. 089 99248380
GPG Fingerprint: F319 10C0 76E2 DAAD DDFA  F017 4CAD BB99 A4A9 9E53
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFAbsgzTK27maSpnlMRAnD+AJ9muCgK3T/LIxoeZGL6V8a4L6/C6wCeOpEP
WXsRyQEg+H+udDiOOT30atM=
=SfzQ
-----END PGP SIGNATURE-----
