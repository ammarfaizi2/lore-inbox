Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbTFWWIa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 18:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265410AbTFWWIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 18:08:16 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:28166 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S265127AbTFWWFr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 18:05:47 -0400
Date: Tue, 24 Jun 2003 00:19:53 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Testing IDE-TCQ and Taskfile - doesn't work nicely:)
Message-ID: <20030623221953.GY6353@lug-owl.de>
Mail-Followup-To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	axboe@suse.de, linux-kernel@vger.kernel.org
References: <20030623194514.GW6353@lug-owl.de> <Pine.SOL.4.30.0306232315480.8078-200000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l7itP/1EBO9PCc/O"
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0306232315480.8078-200000@mion.elka.pw.edu.pl>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--l7itP/1EBO9PCc/O
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-06-23 23:18:00 +0200, Bartlomiej Zolnierkiewicz <B.Zolnierkiew=
icz@elka.pw.edu.pl>
wrote in message <Pine.SOL.4.30.0306232315480.8078-200000@mion.elka.pw.edu.=
pl>:
> On Mon, 23 Jun 2003, Jan-Benedict Glaw wrote:

> > I've played a bit with my "mirror" machine
> >
> > - 200MHz Pentium-MMX
> > - 64MB RAM
> > - jbglaw@mirror:~$ cat /proc/ide/hd*/model
> >   WDC AC2850F		# System drive
> >   IC35L040AVER07-0	# \
> >   IC35L120AVV207-0	#   > Storage (with DM/LVM)
> >   Maxtor 4W100H6	# /
> > - jbglaw@mirror:~$ lspci |grep IDE
> >   00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
> > - Linux v2.5.73
> > - <*> Intel PIIXn chipsets support
> >
> > Basically, if I enable Taskfile I/O, the box refuses to boot (basically,
> > the first drive sounds really broken like "clack   clack   clack" and no
> > data comes off the drive so there's no partition table, no root FS, but
> > a panic:) Is anybody interested in nailing this bug down?
>=20
> YES

What can I do about this one? I'll try to capture the lines... Taskfile
I/O seems to hit my drive(s) really hard:)

> > Disabling Taskfile lets me boot the box, but hdc doesn't like TCQ and
> > gives errors:
> >
> > ide_tcq_intr_timeout: timeout waiting for service interrupt
> > ide_tcq_intr_timeout: missing isr!
> > hdc: invalidating tag queue (0 commands)
> > hdc: drive_cmd: status=3D0x51 { DriveReady SeekComplete Error }
> > hdc: drive_cmd: error=3D0x04 { DriveStatusError }
> > [above messages repeat...]
>=20
> TCQ shouldn't be enabled on hdc, you have two drives on second ide
> channel and current TCQ driver design allows only one drive per channel,
> so proper fix is to not enable TCQ :-).
>=20
> Can you try attached patch?

I'll rebuild with your patch and give it a try (TCQ enabled, Taskfile
disabled...).

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--l7itP/1EBO9PCc/O
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+930IHb1edYOZ4bsRAuSxAJ9zO+hGYDhsAKKeb4d/PnO8dfaKGwCeOtPL
2P60DmCwH96RsZFPpLw9GHM=
=+rtE
-----END PGP SIGNATURE-----

--l7itP/1EBO9PCc/O--
