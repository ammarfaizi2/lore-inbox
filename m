Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267644AbTAHBRd>; Tue, 7 Jan 2003 20:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267653AbTAHBRc>; Tue, 7 Jan 2003 20:17:32 -0500
Received: from antivirus.uni-rostock.de ([139.30.8.12]:60169 "EHLO
	antivirus.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S267644AbTAHBR3>; Tue, 7 Jan 2003 20:17:29 -0500
Date: Wed, 08 Jan 2003 02:25:50 +0100
From: Andreas Pakulat <ap125@informatik.uni-rostock.de>
Subject: problems while burning
To: linux-kernel@vger.kernel.org
Message-id: <20030108012550.GA16970@debian.pakulat>
MIME-version: 1.0
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-disposition: inline
Mail-Followup-To: linux-kernel@vger.kernel.org
User-Agent: Mutt/1.4i
X-OriginalArrivalTime: 08 Jan 2003 01:25:59.0705 (UTC) FILETIME=[E67C0090:01C2B6B4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I'm new to this list and already searched the archive, but didn't find
anything that helped.

My Problem is the following:

I've got a LiteOn Lt12101B IDE CD Burner here and it causes Kernel
Panics once in a while. I cannot reproduce this safely, but it comes up
when the PC not only does the burning, but a make or a galeon session
also.=20

The first mysterious thing is that as far as I've tested until now, it
only comes up with cdrecord, cdrdao burns images without kernel panic.

For the hardware and that stuff:

I've got a PIII 500 MHz on a Tyan Tsunami AT (PIIX4 Chip). The primary
master is a SAMSUNG SV4002H with the following from
/proc/ide/hda/settings:
name		value		min	max	mode
----		-----		---	---	----
current_speed	66		0	69	rw
init_speed	66		0	69	rw
io_32bit	1		0	3	rw
multcount	16		0	16	rw
pio_mode	write-only	0	255	w
using_dma	1		0	1	rw

primary slave is a Mistumi FX4820T with settings:
name		value		min	max	mode
----		-----		---	---	----
current_speed	66		0	69	rw
init_speed	66		0	69	rw
io_32bit	1		0	3	rw
pio_mode	write-only	0	255	w
using_dma	1		0	1	rw

secondary master is the LITE-ON LTR-12101B
with setting:
name		value		min	max	mode
----		-----		---	---	----
current_speed	34		0	69	rw
init_speed	34		0	69	rw
io_32bit	0		0	3	rw
pio_mode	write-only	0	255	w
using_dma	1		0	1	rw

and the secondary Slave is a Maxtor 91360U4 with settings:
name		value		min	max	mode
----		-----		---	---	----
current_speed	66		0	69	rw
init_speed	66		0	69	rw
io_32bit	1		0	3	rw
multcount	16		0	16	rw
pio_mode	write-only	0	255	w
using_dma	1		0	1	rw

The Image lies on the primary HDD and the cdrecord call is:

| cdrecord -VVVV debug=3D7 -kd=3D7 -vvvv -fs=3D16m dev=3D0,1,0 \
| timeout=3D60 driveropts=3Dburnfree -xa2 iso.bin

The Bin-Iso-image was made with cdrdao, but it also happens with
mkisofs-created ones. I can also remove all switches and it still
hapens.

Sometimes there is somethins in /var/log/messages:

In some cases I get:
| Dec 19 18:06:38 debian kernel: scsi : aborting command due to timeout :
| pid 4561
| , scsi0, channel 0, id 1, lun 0 0x2a 00 00 01 f0 ba 00 00 1f 00=20
| Dec 19 18:06:38 debian kernel: hdc: timeout waiting for DMA
| Dec 19 18:06:38 debian kernel: ide_dmaproc: chipset supported
| ide_dma_timeout fu
| nc only: 14
| Dec 19 18:06:38 debian kernel: hdc: status timeout: status=3D0xd8 { Busy }
| Dec 19 18:06:38 debian kernel: hdc: drive not ready for command
| Dec 19 18:07:08 debian kernel: hdc: ATAPI reset timed-out, status=3D0x88
| Dec 19 18:07:08 debian kernel: hdd: DMA disabled
| Dec 19 18:07:13 debian kernel: scsi : aborting command due to timeout :
| pid 4561
| , scsi0, channel 0, id 1, lun 0 0x2a 00 00 01 f0 ba 00 00 1f 00=20
| Dec 19 18:07:13 debian kernel: SCSI host 0 abort (pid 4561) timed out -
| resetting

And so on, until I reset the system.

And 2 times in the last 4 I got:
| Jan  7 20:40:17 debian kernel: scsi : aborting command due to timeout :
| pid 1356
| 4, scsi0, channel 0, id 1, lun 0 0x2a 00 00 00 4c 69 00 00 1f 00=20
| Jan  7 20:40:17 debian kernel: hdc: timeout waiting for DMA
| Jan  7 20:40:17 debian kernel: ide_dmaproc: chipset supported
| ide_dma_timeout fu
| nc only: 14
| Jan  7 20:40:17 debian kernel: hdd: status timeout: status=3D0xd8 { Busy }
| Jan  7 20:40:17 debian kernel: hdd: DMA disabled
| Jan  7 20:40:17 debian kernel: hdd: drive not ready for command
| Jan  7 20:40:17 debian kernel: ide1: reset: master: error (0x00?)

I havn't got the time to try to disable dma with hdparm -d0 or to reduce
the speed of the cdburner to something below 34 (which is mdma? right).

Is there something else that can be done about this?

Ooops I forgot: Kernel is 2.4.20 from debian packages, I can send the
config if it is needed.

Andreas

--=20
Gut ist auch das Emporkommen von Linux als Herausforderer von Microsoft.
		-- CDU-Vorsitzende Angela Merkel

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+G34dEeTwtO5zjFYRAif9AJoC3h/LqyYBB2cVHTM7g2UfFUNlTACeJAK1
2OmAANL3VydzijNp4EfRWyU=
=h4du
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
