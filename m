Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277949AbRKMSVk>; Tue, 13 Nov 2001 13:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277942AbRKMSVa>; Tue, 13 Nov 2001 13:21:30 -0500
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:54796
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S277918AbRKMSVR>; Tue, 13 Nov 2001 13:21:17 -0500
Date: Tue, 13 Nov 2001 10:21:06 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel Developer List <linux-kernel@vger.kernel.org>
Subject: PATCH: scsi_scan.c: emulate windows behavior
Message-ID: <20011113102106.A23110@one-eyed-alien.net>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Kernel Developer List <linux-kernel@vger.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aVD9QWMuhilNxW9f
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I would have sworn we already patched this, but now I can find no record of
it.

Attached is a one-liner patch to scsi_scan.c, which changes the length of
the INQUIRY data request from 255 bytes to 36 bytes.  This subtle change
makes Linux act more like Win/MacOS and other popular OSes, and reduces
incompatibility with a broad range of out-of-spec devices that will simply
die if asked for more than the required minimum of 36 bytes.

Did we patch this before?  I can't find it in the l-k archives, but I'm
almost positive we have.  I remeber this because this problem plagues some
USB devices, which just crash if you ask for more than 36 bytes of data.

Patch is attached.  Please apply.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

G:  Let me guess, you started on the 'net with AOL, right?
C:  WOW! d00d! U r leet!
					-- Greg and Customer=20
User Friendly, 2/12/1999

--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="scsi_scan.patch"

--- linux/drivers/scsi/scsi_scan.old	Tue Nov 13 10:12:19 2001
+++ linux/drivers/scsi/scsi_scan.c	Tue Nov 13 10:13:58 2001
@@ -543,7 +543,7 @@
 		scsi_cmd[1] = 0;	/* SCSI_3 and higher, don't touch */
 	scsi_cmd[2] = 0;
 	scsi_cmd[3] = 0;
-	scsi_cmd[4] = 255;
+	scsi_cmd[4] = 36;		/* 36 bytes, just like Win/MacOS */
 	scsi_cmd[5] = 0;
 	SRpnt->sr_cmd_len = 0;
 	SRpnt->sr_data_direction = SCSI_DATA_READ;

--k1lZvvs/B4yU6o8G--

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE78WSSz64nssGU+ykRAtgOAKCUb7m1YaBOltXU8W8mL9DSNK3NrwCghvZX
Grti3poFhKO19Cc4eiIOCzs=
=U1Qd
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--
