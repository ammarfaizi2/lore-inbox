Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136091AbRD0QLX>; Fri, 27 Apr 2001 12:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136109AbRD0QLT>; Fri, 27 Apr 2001 12:11:19 -0400
Received: from hermes.sistina.com ([208.210.145.141]:12301 "HELO sistina.com")
	by vger.kernel.org with SMTP id <S136091AbRD0QJQ>;
	Fri, 27 Apr 2001 12:09:16 -0400
Date: Fri, 27 Apr 2001 11:09:36 -0500
From: AJ Lewis <lewis@sistina.com>
To: Goswin Brederlow <goswin.brederlow@student.uni-tuebingen.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: devfs and /proc/ide/hda
Message-ID: <20010427110935.C1632@sistina.com>
In-Reply-To: <3A9CCA76.3E6AB93A@optushome.com.au> <20010228161023.A19929@win.tue.nl> <20010301084133.C16667@sistina.com> <87snkov3uk.fsf@mose.informatik.uni-tuebingen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CblX+4bnyfN0pR09"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <87snkov3uk.fsf@mose.informatik.uni-tuebingen.de>; from goswin.brederlow@student.uni-tuebingen.de on Thu, Mar 08, 2001 at 01:32:03PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 08, 2001 at 01:32:03PM +0100, Goswin Brederlow wrote:
>      > What it should do is change based on whether devfs is mounted
>      > or not.  It doesn't make *any* sense to have
>      > /dev/ide/host0/foo/bar in your /proc/partitions entries if you
>      > aren't mounting devfs.  The /proc/partitions entry is the only
>      > way I know of for something like LVM to determine which devices
>      > to scan for Volume Groups.  If you can't read /proc/partitions,
>      > it has to attempt to scan all block devices it recognizes,
>      > regardless of whether they are actually on the system or not.
>      > This can take several minutes.
>=20
> First:
>=20
> % cat /proc/partitions=20
> major minor  #blocks  name
>=20
>    3     0   20010816 ide/host0/bus0/target0/lun0/disc
>    3     1     192748 ide/host0/bus0/target0/lun0/part1
>    3     2     249007 ide/host0/bus0/target0/lun0/part2
>    3     3          1 ide/host0/bus0/target0/lun0/part3
>    3     5     289138 ide/host0/bus0/target0/lun0/part5
>    3     6    1951866 ide/host0/bus0/target0/lun0/part6
>    3     7     979933 ide/host0/bus0/target0/lun0/part7
>    3     8   16346106 ide/host0/bus0/target0/lun0/part8
>   33     0   80043264 ide/host2/bus0/target0/lun0/disc
>   33     1   80035798 ide/host2/bus0/target0/lun0/part1
>=20
> So its already right.

Only if devfs is mounted.  That's my point.  Maybe it's an corner case to
have devfs compiled into the kernel, but not mounted, and so we can just
ignore this, but it seems to me that /proc/partitions should reflect which
/dev system is currently running.

> Secondly with devfs, why not just scan all /dev/discs/?
>=20
> % ls -l /dev/discs=20
> total 0
> lr-xr-xr-x    1 root     root           30 Jan  1  1970 disc0 -> ../ide/h=
ost0/bus0/target0/lun0/
> lr-xr-xr-x    1 root     root           30 Jan  1  1970 disc1 -> ../ide/h=
ost2/bus0/target0/lun0/
>=20
> Also if lvm opens all known devices by way of /dev/whatever while
> scanning, it will only find existing devices there with devfs.

Yeah, as long as devfs is running, that makes sense.

--=20
AJ Lewis
Sistina Software Inc.                  Voice:  612-379-3951
1313 5th St SE, Suite 111              Fax:    612-379-3952
Minneapolis, MN 55414                  E-Mail: lewis@sistina.com
http://www.sistina.com

Current GPG fingerprint =3D 3B5F 6011 5216 76A5 2F6B  52A0 941E 1261 0029 2=
648
Get my key at: http://www.sistina.com/~lewis/gpgkey
 (Unfortunately, the PKS-type keyservers do not work with multiple sub-keys)

-----Begin Obligatory Humorous Quote----------------------------------------
A computer without a Microsoft operating system is like a dog without bricks
tied to its head.
-----End Obligatory Humorous Quote------------------------------------------

--CblX+4bnyfN0pR09
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE66Zm/pE6/iGtdjLERAhIBAJ9ldJzoY7neqxrtrbgx5ep9Gu1dagCeLV05
27QS3Vk3PizGYO8hIzNxv58=
=RkNM
-----END PGP SIGNATURE-----

--CblX+4bnyfN0pR09--
