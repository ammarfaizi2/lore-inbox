Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265650AbSLBHsg>; Mon, 2 Dec 2002 02:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265656AbSLBHsg>; Mon, 2 Dec 2002 02:48:36 -0500
Received: from viola.sinor.ru ([217.70.106.9]:53417 "EHLO viola.sinor.ru")
	by vger.kernel.org with ESMTP id <S265650AbSLBHse>;
	Mon, 2 Dec 2002 02:48:34 -0500
Date: Mon, 2 Dec 2002 13:57:25 +0600
From: "Andrey R. Urazov" <coola@ngs.ru>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: a bug in autofs
Message-ID: <20021202075725.GC1459@ktulu>
References: <20021201071612.GA936@ktulu> <1038799532.15370.301.camel@ixodes.goop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+nBD6E3TurpgldQp"
Content-Disposition: inline
In-Reply-To: <1038799532.15370.301.camel@ixodes.goop.org>
User-Agent: Mutt/1.4i
X-PGP-public-key: pub 1024D/02B49FF2
X-PGP-fingerprint: A1CE D50E 0CF3 C0EF BA35  CBEC 87D7 4A2B 02B4 9FF2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+nBD6E3TurpgldQp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 01, 2002 at 07:25:32PM -0800, Jeremy Fitzhardinge wrote:
> What happens if you try to manually mount the cdrom when there's nothing
> in the drive?
[root@ktulu coola]# en mount -o ro -t iso9660 /dev/cdrom /mnt
mount: No medium found

with this attempt a new line reading `cdrom: open failed' is appended to
the dmesg output

> > 2) under /misc/summer there resides an ntfs volume with thousands of
> > files. And when I run=20
> >=20
> >         find /misc/summer
> >=20
> >    the system becames unusable after some amount of files is scanned.
> >    Usually it just hangs. But one time "find" terminated with the
> >    segmentation fault and then after 5 seconds or so the system hung.
>=20
> Can you reproduce this with some other filesystem type (something which
> is less flaky than NTFS)?
Tried with fat32 and found no problems, everything is okay in this case.
>=20
> How many files are on the NTFS filesystem?
To test for the bug I used the following command:

    find /misc/summer | tee /dev/tty | wc

in most cases I didn't see the output of wc, but two times I managed to
(in this cases `find' managed to terminate before the system hung).

24849 files, 1712874 total characters (in filenames)
25087 files, 1737450 characters

> > The problem does not existed if the volumes are mounted through
> > "mount".  Only automounting causes problems.
Sorry for misinforming you. When this was written I tried manual
mounting only once and all was okay during this trial. But when
I repeated the test, the system crashed as in the case of automounting.
And I didn't manage to perform a succesful find over ntfs volume once
more. So the problem here is probably in the ntfs driver, not autofs.
>=20
> Does this comment also apply to the cdrom case?
This applies to cdrom case. Just tested it. I.e. the system doesn't
crash when I invoke xmms with a playlist referring to nonexistent cd.

> What mount options are you using to mount these filesystems?  Are they
> the same when you do it manually and using autofs?
Tried different combinations. Does not matter.

> What does the "dentry_cache" line say in /proc/slabinfo while you're
> running the find on the NTFS filesystem?
It varies so I'm including several snapshots:

[coola@ktulu coola]$ cat /proc/slabinfo|grep dentry
dentry_cache        2069   4380    128  146  146    1
[coola@ktulu coola]$ cat /proc/slabinfo|grep dentry
dentry_cache        5311   5340    128  178  178    1
[coola@ktulu coola]$ cat /proc/slabinfo|grep dentry
dentry_cache        2901   4200    128  140  140    1
[coola@ktulu coola]$ cat /proc/slabinfo|grep dentry
dentry_cache        5383   5400    128  180  180    1
[coola@ktulu coola]$ cat /proc/slabinfo|grep dentry
dentry_cache        1358   4080    128  136  136    1
[coola@ktulu coola]$ cat /proc/slabinfo|grep dentry
dentry_cache        3110   4080    128  136  136    1
[coola@ktulu coola]$ cat /proc/slabinfo|grep dentry
dentry_cache        3731   4920    128  164  164    1
[coola@ktulu coola]$ cat /proc/slabinfo|grep dentry
dentry_cache        4068   4920    128  164  164    1
[coola@ktulu coola]$ cat /proc/slabinfo|grep dentry
dentry_cache        4132   4920    128  164  164    1
[coola@ktulu coola]$ cat /proc/slabinfo|grep dentry
dentry_cache        4192   4920    128  164  164    1
[coola@ktulu coola]$ cat /proc/slabinfo|grep dentry
dentry_cache        4258   4920    128  164  164    1


=20
> Thanks,
> 	J
That's me who should thank you.



Best regards,
  Andrey Urazov
--=20
Lying is an indispensable part of making life tolerable.
		-- Bergan Evans
--
lundi 02 d=E9cembre, 2002, 10:06:15 +0600 - Andrey R. Urazov (mailto:coola@=
ngs.ru)


--+nBD6E3TurpgldQp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE96xJkh9dKKwK0n/IRAtYpAKCvvZ7dejbRSeALEhvAuxPTDWpoNACgkvUg
nysCwOp57NuVD++UFdUh3CQ=
=5Y0Q
-----END PGP SIGNATURE-----

--+nBD6E3TurpgldQp--
