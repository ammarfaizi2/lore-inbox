Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263528AbTDWVQy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 17:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263619AbTDWVQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 17:16:54 -0400
Received: from freesurfmta02.sunrise.ch ([194.230.0.17]:7912 "EHLO
	freesurfmail.sunrise.ch") by vger.kernel.org with ESMTP
	id S263528AbTDWVQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 17:16:52 -0400
Date: Wed, 23 Apr 2003 23:27:13 +0200
To: linux-kernel@vger.kernel.org
Subject: problem with a cobalt RaQ550 system and DMA (Serverworks OSB4 in impossible state)
Message-ID: <20030423212713.GD21689@puck.ch>
Mail-Followup-To: bol, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline
X-From: Olivier Bornet <Olivier.Bornet@puck.ch>
X-Url: http://puck.ch/
User-Agent: Mutt/1.5.3i
From: Olivier Bornet <Olivier.Bornet@puck.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I'm trying to install Debian on 4 RaQ550 with each 2 80GB disks. All
seems OK with 3 of RaQ, but with one, it crash when I put the two disks
in a RAID1 meta device. In fact, it as crash at about 6% before the 70GB
partition is fully synchronized.

The error message is:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Serverworks OSB4 in impossible state.
Disable UDMA or if you are using Seagate then try switching disk types
on this controller. Please report this event to osb4-bug@ide.cabal.tm
OSB4: continuing might cause disk corruption.=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I have also send the same email as this one to osb4-bug@ide.cabal.tm.

After some search, it seems I must enable MWDMA for my disks. (ref:
http://www.cs.helsinki.fi/linux/linux-kernel/2002-33/0836.html )

Here is the configuration : 2 IDE 80GB disks, one on hda, one on hdc.
The kernel is the stock 2.4.20, with cobalt patches. The cobalt patches
don't modify the drivers/ide/serverworks.c.

IDE part of lspci -v:

00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 92) (prog-if 8f=
 [Master SecP SecO PriP PriO])
        Subsystem: Sun Microsystems Computer Corp.: Unknown device c000
        Flags: bus master, medium devsel, latency 64
        I/O ports at fcd8 [size=3D8]
        I/O ports at fcd4 [size=3D4]
        I/O ports at fcc8 [size=3D8]
        I/O ports at fcc4 [size=3D4]
        I/O ports at fcb0 [size=3D16]
        I/O ports at fcac [size=3D4]

/proc/ide/hda and /proc/ide/hdc say it's a ST380021A. (I have no
physical access to the system now...)

I have try to set the DMA of the disks with:
    hdparm -X66 -d 1 /dev/hda
    hdparm -X66 -d 1 /dev/hdc
but this has cause a direct hangup (with the same message "Serverworks
OSB4 in impossible state...."). Maybe I don't use correctly hdparm, as
this is my first attempt with it.

At this time, I have disabled the dma with:
    hdparm -d 0 /dev/hda
    hdparm -d 0 /dev/hdc
and the sync in in the way (but say we need about 6 hours to finish,
comparing to the unmodifed test giving about 1 hour).

So my questions are :

- what can I do ?
- may this problem come also with the others RaQ we have (as far as I
  know, they are the same, and they are ordered at the same time)
- is the system safe without dma ?

Thanks in advance for any help, or any pointer to a solution. (Of
course, I can apply a patch to the kernel if this may correct the
problem).

		Olivier
--=20
Olivier Bornet                 |      fran=E7ais : http://puck.ch/f
Swiss Ice Hockey Results       |      english  : http://puck.ch/e
http://puck.ch/                |      deutsch  : http://puck.ch/g
Olivier.Bornet@puck.ch         |      italiano : http://puck.ch/i
Get my PGP-key at http://puck.ch/pgp or at http://wwwkeys.pgp.net

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+pwUxdj3R/MU9khgRApX/AJ9JRKRrSUTFMtPDmCq+W58xsawEFwCfZoG4
8124lClI5+p4QfESl29A6RA=
=yrBp
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
