Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVBLBD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVBLBD5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 20:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbVBLBD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 20:03:57 -0500
Received: from smtp08.auna.com ([62.81.186.18]:36534 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S261161AbVBLBDj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 20:03:39 -0500
Date: Sat, 12 Feb 2005 01:03:32 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: udev::cdsymlinks does not consider a 'cdrw' as a 'cdrom'
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Greg KH <gregkh@suse.de>
X-Mailer: Balsa 2.3.0
Message-Id: <1108170212l.5587l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-4N8gOV1npYlCu6UbNzVH"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-4N8gOV1npYlCu6UbNzVH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi...

I have a little problem with udev. I have udev-051, but have tried
cdsymlinks.c from 053 and is the same.

It does not give 'cdrom' or 'dvd' for DVD writers.
In one box, hdb is a DVD, and hdc is a DVDRW:

werewolf:/proc/sys/dev/cdrom> cat info
CD-ROM information, Id: cdrom.c 3.20 2003/12/17

drive name:             hdc     hdb
drive speed:            40      48
drive # of slots:       1       1
Can close tray:         1       1
Can open tray:          1       1
Can lock tray:          1       1
Can change speed:       1       1
Can select disk:        0       0
Can read multisession:  1       1
Can read MCN:           1       1
Reports media changed:  1       1
Can play audio:         1       1
Can write CD-R:         1       0
Can write CD-RW:        1       0
Can read DVD:           1       1
Can write DVD-R:        1       0
Can write DVD-RAM:      1       0
Can read MRW:           1       1
Can write MRW:          1       1
Can write RAM:          1       1

werewolf:/proc/sys/dev/cdrom> cdsymlinks hdb
 cdrom dvd
werewolf:/proc/sys/dev/cdrom> cdsymlinks hdc
 cdrw dvdrw dvdram
werewolf:/proc/sys/dev/cdrom> cdsymlinks hdc -d
Devices: hdb hdc
DVDRAM : 0 1 hdc
DVDRW  : 0 1 hdc
DVD    : 1 1 hdb hdc
CDRW   : 0 1 hdc
CDR    : 0 1 hdc
CDWMRW :
CDMRW  :
CDROM  : (all) hdb hdc
 cdrw dvdrw dvdram

(btw, I did not know my DVD _reader_ can write anything like MRW or RAM)

In other box that just has also a combo drive (DVD + DVDRW 4.7):

nada:/proc/sys/dev/cdrom# cat info
CD-ROM information, Id: cdrom.c 3.20 2003/12/17

drive name:             hdh
drive speed:            32
drive # of slots:       1
Can close tray:         1
Can open tray:          1
Can lock tray:          1
Can change speed:       1
Can select disk:        0
Can read multisession:  1
Can read MCN:           1
Reports media changed:  1
Can play audio:         1
Can write CD-R:         1
Can write CD-RW:        1
Can read DVD:           1
Can write DVD-R:        1
Can write DVD-RAM:      1
Can read MRW:           1
Can write MRW:          1
Can write RAM:          1

nada:~> cdsymlinks hdh  =20

nada:~> cdsymlinks hdh -d
Devices: hdh

DVDRAM : 1
 hdh

DVDRW  : 1
 hdh

DVD    : 1
 hdh

CDRW   : 1
 hdh

CDR    : 1
 hdh

CDWMRW :
CDMRW  :
CDROM  : (all) hdh

And now that I realize it, why the different debug output ???

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-jam9 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-3mdk)) #1


--=-4N8gOV1npYlCu6UbNzVH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCDVXkRlIHNEGnKMMRAkIdAJ98slagGI3HqbsV+undgpu4xq6DcACgm8qL
rpXL7ANBNIUHRJyEMt5L+8g=
=jqF+
-----END PGP SIGNATURE-----

--=-4N8gOV1npYlCu6UbNzVH--

