Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbTJXB4g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 21:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbTJXB4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 21:56:36 -0400
Received: from 76.Red-80-32-164.pooles.rima-tde.net ([80.32.164.76]:59080 "EHLO
	whiterabbit") by vger.kernel.org with ESMTP id S261953AbTJXB4W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 21:56:22 -0400
From: Vadim <lkml@vadim.ws>
To: linux-kernel@vger.kernel.org
Subject: USB Flash drive gets a new device every time
Date: Fri, 24 Oct 2003 03:57:40 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_dcIm/n0K+ksvmXN";
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200310240357.49367.lkml@vadim.ws>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_dcIm/n0K+ksvmXN
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

This is happening right now and is 100% reproducible on two=20
computers.

=46irst computer is a dual Athlon MP 2000+, running the Gentoo=20
2.4.20-gentoo-r7 kernel. The second one is a Toshiba 470CDT=20
laptop running the 2.4.22 vanilla kernel.

The laptop currently doesn't have a working network card so I'm=20
using a PQI TravelFlash card reader to exchange data.

The problem is that every time I remove the card reader and=20
insert it again it gets a new device. The old ones remain in=20
/proc/partitions and get set to 1GB size if I try to access=20
them. Otherwise they remain showing the 64MB of the removed card=20
reader.

=46or example, on the Athlon, /proc/partitions looks like this=20
after inserting and removing the card several times:

   8     0    1048575 scsi/host1/bus0/target0/lun0/disc 2 6 16 0=20
0 0 0 0 0 0 0
   8    16      61440 scsi/host1/bus0/target0/lun1/disc 160 6 174=20
484 23 4012 4035 26798 0 2866 27282
   8    17      61375 scsi/host1/bus0/target0/lun1/part1 159 3=20
166 478 23 4012 4035 26798 0 2860 27276
   8    32    1048575 scsi/host1/bus0/target0/lun2/disc 2 6 16 0=20
0 0 0 0 0 0 0
   8    48    1048575 scsi/host1/bus0/target0/lun3/disc 2 6 16 0=20
0 0 0 0 0 0 0
   8    64    1048575 scsi/host2/bus0/target0/lun0/disc 2 6 16 0=20
0 0 0 0 0 0 0
   8    80      61440 scsi/host2/bus0/target0/lun1/disc 1 3 8 6 0=20
0 0 0 0 6 6
   8    81      61375 scsi/host2/bus0/target0/lun1/part1 0 0 0 0=20
0 0 0 0 0 0 0
   8    96    1048575 scsi/host2/bus0/target0/lun2/disc 2 6 16 0=20
0 0 0 0 0 0 0
   8   112    1048575 scsi/host2/bus0/target0/lun3/disc 2 6 16 0=20
0 0 0 0 0 0 0
   8   128    1048575 scsi/host3/bus0/target0/lun0/disc 2 6 16 0=20
0 0 0 0 0 0 0
   8   144      61440 scsi/host3/bus0/target0/lun1/disc 1 3 8 6 0=20
0 0 0 0 6 6
   8   145      61375 scsi/host3/bus0/target0/lun1/part1 0 0 0 0=20
0 0 0 0 0 0 0

I have also noticed that in /proc/scsi/ there is a usb-storage-N=20
directory created every time I insert the card reader, with the=20
file inside having a content like:

   Host scsi2: usb-storage
       Vendor: Generic
      Product: USB Storage Device
Serial Number: 0AEC305000001A006
     Protocol: Transparent SCSI
    Transport: Bulk
         GUID: 0aec5010aec305000001a006
     Attached: No

Only the last one has 'Attached' set to 'Yes':

   Host scsi4: usb-storage
       Vendor: Generic
      Product: USB Storage Device
Serial Number: 0AEC305000001A008
     Protocol: Transparent SCSI
    Transport: Bulk
         GUID: 0aec5010aec305000001a008
     Attached: Yes

I'm guessing the kernel is keeping it there for some reason, but=20
I can't figure out why. I guess it might be trying to allow to=20
reinsert a device later, but if so, it's definitely not working.

Here are the USB lines from .config for the laptop.
CONFIG_USB=3Dy
CONFIG_USB_DEBUG=3Dy
CONFIG_USB_DEVICEFS=3Dy
CONFIG_USB_OHCI=3Dy
CONFIG_USB_STORAGE=3Dy
CONFIG_USB_STORAGE_DATAFAB=3Dy
CONFIG_USB_STORAGE_FREECOM=3Dy
CONFIG_USB_STORAGE_ISD200=3Dy
CONFIG_USB_STORAGE_DPCM=3Dy
CONFIG_USB_STORAGE_SDDR09=3Dy
CONFIG_USB_STORAGE_SDDR55=3Dy
CONFIG_USB_STORAGE_JUMPSHOT=3Dy
CONFIG_USB_PWC=3Dy
CONFIG_USB_USBNET=3Dy


Perhaps I'm missing something obvious here, but I googled for=20
this and didn't find anything. Other people seem to have had=20
this problem, but I haven't found any answers.

Thanks in advance

--Boundary-02=_dcIm/n0K+ksvmXN
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/mIcdvCkUtBccqkoRAjfaAJ43oAHrOxaDBpe0vMi4A3iM62rIuQCggZXl
xYl7Ju+VWXLRQjFZTBya84I=
=rudH
-----END PGP SIGNATURE-----

--Boundary-02=_dcIm/n0K+ksvmXN--

