Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263688AbTKKSXC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 13:23:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263692AbTKKSXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 13:23:02 -0500
Received: from viriato2.servicios.retecal.es ([212.89.0.45]:3045 "EHLO
	viriato2.servicios.retecal.es") by vger.kernel.org with ESMTP
	id S263688AbTKKSWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 13:22:54 -0500
Subject: [2.6.0-test9-mm2] Error trying to read a cdrom disc
From: =?ISO-8859-1?Q?Ram=F3n?= Rey Vicente <ramon.rey@hispalinux.es>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-I2fMoX5fd+p+e9ZPPGO7"
Organization: Hispalinux - http://www.hispalinux.es
Message-Id: <1068574968.1450.6.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 11 Nov 2003 19:22:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-I2fMoX5fd+p+e9ZPPGO7
Content-Type: multipart/mixed; boundary="=-63Me1XaLCI7nYNak1zG8"


--=-63Me1XaLCI7nYNak1zG8
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Hi.

This problem appears in 2.6.0-test9-mm2 and 2.6.0-test9-bk16.

The issue is: my cdrom drive is on the secondary ide controller as
slave. I try to read the cdrom disc with two different ATAPI cdrom
drives (a Sansung drive and other ATAPI compatible drive) and in both
cases as slave of the secondary ide controller.

The problem appears trying to copy de contents of the cdrom disc to an
iso image in the hard disk.

With this command:

cat /dev/hdd > knoppix-es.iso

..and with this:

cp /dev/hdd knoppix-es.iso

and this other command:

dd if=3D/dev/hdd of=3Dknoppix-es.iso

... generate the same error than this, a problem with DMA, because the
drive is trying to access to a wrong part of the cdrom, because the
information the driver is reporting to the programs is not the correct
info about the media sizes of the cdroms discs in the drives connected
as slave of the secondary ide controller:

readcd dev=3D/dev/hdd f=3Dknoppix-es.iso
readcd: Warning: controller returns wrong size for CD capabilities page.
readcd: Warning: controller returns wrong size for CD capabilities page.
readcd: Warning: controller returns wrong size for CD capabilities page.
readcd: Warning: controller returns wrong size for CD capabilities page.
Read  speed:  2112 kB/s (CD  12x, DVD  1x).
Write speed:     0 kB/s (CD   0x, DVD  0x).
Capacity: 345646 Blocks =3D 691292 kBytes =3D 675 MBytes =3D 707 prMB
Sectorsize: 2048 Bytes
Copy from SCSI (0,0,0) disk to file 'knoppix-es.iso'
end:    345646
readcd: Success. read_g1: scsi sendcmd: no error
CDB:  28 00 00 05 46 12 00 00 1C 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 05 00 00 00 00 0A 00 00 00 00 64 00 00 00
Sense Key: 0x5 Illegal Request, Segment 0
Sense Code: 0x64 Qual 0x00 (illegal mode for this track) Fru 0x0
Sense flags: Blk 0 (not valid)=20
resid: 57344
cmd finished after 11.709s timeout 40s
readcd: Success. Cannot read source disk
readcd: Retrying from sector 345618

With my LG cdwriter (as master of the secondary ide controller) there is
no problem.
--=20
Ram=F3n Rey Vicente       <ramon dot rey at hispalinux dot es>
        jabber ID       <rreylinux at jabber dot org>
GPG public key ID 	0xBEBD71D5 -> http://pgp.escomposlinux.org/

--=-63Me1XaLCI7nYNak1zG8
Content-Disposition: inline; filename=via_controller
Content-Type: text/plain; name=via_controller; charset=us-ascii
Content-Transfer-Encoding: quoted-printable


--=-63Me1XaLCI7nYNak1zG8
Content-Disposition: inline; filename=ide_drivers
Content-Type: text/plain; name=ide_drivers; charset=ISO-8859-15
Content-Transfer-Encoding: base64

aWRlLWNkcm9tIHZlcnNpb24gNC41OS1hYzENCmlkZS1kaXNrIHZlcnNpb24gMS4xOA0K

--=-63Me1XaLCI7nYNak1zG8--

--=-I2fMoX5fd+p+e9ZPPGO7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/sSj4RGk68b69cdURAkuQAJ4zgLKEAxYEMWUNUnF6zaadnsfOvQCdFR7M
8CAKvGTO+Qy1+97V6lLjq4w=
=KEGR
-----END PGP SIGNATURE-----

--=-I2fMoX5fd+p+e9ZPPGO7--

