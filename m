Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbTELOAS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 10:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262162AbTELOAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 10:00:18 -0400
Received: from 24-216-225-11.charter.com ([24.216.225.11]:3993 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S262160AbTELOAP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 10:00:15 -0400
Date: Mon, 12 May 2003 10:12:55 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Douglas Gilbert <dgilbert@interlog.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: removing a single device?
Message-ID: <20030512141255.GA30094@rdlg.net>
Mail-Followup-To: Douglas Gilbert <dgilbert@interlog.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3EBC43CC.3090808@interlog.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <3EBC43CC.3090808@interlog.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



Does it work on scsi-emulation devices such as 3Ware raid controllers?

I'm trying to swap out a failed IDE drive on a 3Ware card.  I went into
tw_cli and executed "maint remove c1 p1" and it shows the drive offline.
The disk is in what appears to be a hot-swap connection similar to SCA.
Do I need to do the line below to remove it since the 3ware card
registers the drive offline?

root@legato-disk4.acs:~# tw_cli info c1 p1
Controller 1, Port  1
----------------------
Status:    OFFLINE JBOD
Model:     Maxtor 4G160J8
Size:      163.92 GB (320173056 blocks)
Serial #:  G805DE1E
FW:        GAK819K0
Unit:       1

/proc/scsi/scsi does still show the device:

Host: scsi1 Channel: 00 Id: 01 Lun: 00
  Vendor: 3ware    Model: 3w-xxxx          Rev: 1.0=20
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff

and the echo, remove below doesn't remove it.  It does happily though
work on some other systems with SCA interfaces.

Thanks,
  Robert




Thus spake Douglas Gilbert (dgilbert@interlog.com):

> Robert L. Harris wrote:
> > A long time ago I used to be able to do:
> >
> > echo "scsi add-single-device 0 0 11 0" > /proc/scsi/scsi
> > echo "scsi remove-single-device 0 0 11 0" > /proc/scsi/scsi
> >
> > When I wanted to unplug a SCA scsi drive for replacement.  I tried this
> > recently on my 2.4.20 kernel and nothing happened.  No errors, no change
> > to /proc/scsi/scsi, no entry in dmsg, it just ignored it.  Has this been
> > deprecated for a new way of removing hotswap drives?
>=20
> Robert,
> It is not deprecated (and is still present in the lk 2.5
> development series since we still have no other way of
> doing this from the user space).
>=20
> The parsing of that expression is very rigid: no tabs
> or redundant spaces.
>=20
> Doug Gilbert

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+v6vn8+1vMONE2jsRAqsUAKDbasM2gk1650CqnUJg7xJoE4JNkACgjMhd
7U+0YmNLh/pLJwuCiUTrqTQ=
=/dWu
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
