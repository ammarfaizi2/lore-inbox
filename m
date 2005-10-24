Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbVJXMty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbVJXMty (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 08:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbVJXMty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 08:49:54 -0400
Received: from kokytos.rz.ifi.lmu.de ([141.84.214.13]:8074 "EHLO
	kokytos.rz.ifi.lmu.de") by vger.kernel.org with ESMTP
	id S1750811AbVJXMtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 08:49:53 -0400
From: Michael Brade <brade@informatik.uni-muenchen.de>
Organization: =?iso-8859-15?q?Universit=E4t?= =?iso-8859-15?q?_M=FCnchen?=, Institut =?iso-8859-15?q?f=FCr?= Informatik
To: linux-kernel@vger.kernel.org
Subject: ieee1394: sbp2: sbp2util_node_write_no_wait failed
Date: Mon, 24 Oct 2005 14:51:03 +0200
User-Agent: KMail/1.8.90
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4108098.En7lidD6PS";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510241451.27320.brade@informatik.uni-muenchen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4108098.En7lidD6PS
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I get the above message frequently while copying data (around 200000 mail=20
files, 2GB) from my laptop to an external harddisk via ieee1394. The ieee=20
system completely deadlocked with 2.6.13 without the chance to umount or=20
reuse the device. Now I upgraded to 2.6.14-rc5 and I still get the error=20
followed by a 10sec pause or so, but then the copying continues. I will hav=
e=20
to check if it copied all data correctly, though.

When attaching the device this is what the kernel says:

kernel: ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting=
=2E..
kernel: ieee1394: Error parsing configrom for node 0-00:1023
kernel: ieee1394: Node changed: 0-00:1023 -> 0-01:1023
kernel: ieee1394: Node added: ID:BUS[0-00:1023]  GUID[0000000e000031d1]
kernel: scsi1 : SCSI emulation for IEEE-1394 SBP-2 Devices
kernel: ieee1394: sbp2: Logged into SBP-2 device
kernel: ieee1394: Node 0-00:1023: Max speed [S400] - Max payload [2048]
kernel:   Vendor: WDC WD20  Model: 00JB-00GVC0       Rev:
kernel:   Type:   Direct-Access-RBC                  ANSI SCSI revision: 04
kernel: Attached scsi generic sg0 at scsi1, channel 0, id 0, lun 0,  type 14
kernel: SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
kernel: sda: asking for cache data failed
kernel: sda: assuming drive cache: write through
kernel: SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
kernel: sda: asking for cache data failed
kernel: sda: assuming drive cache: write through
kernel:  sda: sda1 sda2 sda3 sda4
kernel: Attached scsi disk sda at scsi1, channel 0, id 0, lun 0

And the complete error message:

kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed.
kernel:
kernel: ieee1394: sbp2: aborting sbp2 command
kernel: scsi1 : destination target 0, lun 0
kernel:         command: cdb[0]=3D0x2a: 2a 00 09 76 04 73 00 00 01 00
kernel: ieee1394: sbp2: sbp2util_node_write_no_wait failed.
kernel:
kernel: ieee1394: sbp2: aborting sbp2 command
kernel: scsi1 : destination target 0, lun 0
kernel:         command: cdb[0]=3D0x2a: 2a 00 08 5f 83 54 00 00 01 00

[lots more of that, the command hex code changes everytime]

I have a preemt kernel:
CONFIG_PREEMPT=3Dy
CONFIG_PREEMPT_BKL=3Dy

and the 1000hz timer:
CONFIG_HZ_1000=3Dy
CONFIG_HZ=3D1000
CONFIG_PHYSICAL_START=3D0x100000

and the following is the ieee config:
CONFIG_IEEE1394=3Dm
CONFIG_IEEE1394_OHCI1394=3Dm

CONFIG_IEEE1394_VIDEO1394=3Dm
CONFIG_IEEE1394_SBP2=3Dm
CONFIG_IEEE1394_SBP2_PHYS_DMA=3Dy
# CONFIG_IEEE1394_ETH1394 is not set
CONFIG_IEEE1394_DV1394=3Dm
CONFIG_IEEE1394_RAWIO=3Dm
# CONFIG_IEEE1394_CMP is not set

Please tell me if you need more info, I'd like to provide all the help need=
ed=20
to fix this issue.

Cheers,
=2D-=20
Michael Brade;                 KDE Developer, Student of Computer Science
  |-mail: echo brade !#|tr -d "c oh"|s\e\d 's/e/\@/2;s/$/.org/;s/bra/k/2'
  =B0--web: http://www.kde.org/people/michaelb.html

KDE 3: The Next Generation in Desktop Experience

--nextPart4108098.En7lidD6PS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDXNjPdK2tAWD5bo0RAkx6AJ4uNii+rbBxqLzJrcdCE2rtpAf9CACgmLrI
pmDBrxnRD1zQFHvNuYQrU4k=
=oqVQ
-----END PGP SIGNATURE-----

--nextPart4108098.En7lidD6PS--
