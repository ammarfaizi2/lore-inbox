Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261345AbRELX0y>; Sat, 12 May 2001 19:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261346AbRELX0o>; Sat, 12 May 2001 19:26:44 -0400
Received: from adsl-63-199-250-45.dsl.sndg02.pacbell.net ([63.199.250.45]:53509
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S261345AbRELX01>; Sat, 12 May 2001 19:26:27 -0400
Date: Sat, 12 May 2001 16:25:01 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: BERECZ Szabolcs <szabi@inf.elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mount /dev/hdb2 /usr; swapon /dev/hdb2  keeps flooding
Message-ID: <20010512162501.A9471@one-eyed-alien.net>
Mail-Followup-To: BERECZ Szabolcs <szabi@inf.elte.hu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.A41.4.31.0105130055400.19270-100000@pandora.inf.elte.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.A41.4.31.0105130055400.19270-100000@pandora.inf.elte.hu>; from szabi@inf.elte.hu on Sun, May 13, 2001 at 01:00:39AM +0200
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I was under the impression that you need to call swapon on swap partitions,
and not on mounted filesystems.

Matt

On Sun, May 13, 2001 at 01:00:39AM +0200, BERECZ Szabolcs wrote:
> Hi!
>=20
> root@kama3:/home/szabi# cat /proc/mounts
> ...
> /dev/hdb2 /usr ext2 rw 0 0
> ...
> root@kama3:/home/szabi# swapon /dev/hdb2
> set_blocksize: b_count 1, dev ide0(3,66), block 2, from c0126b48
> set_blocksize: b_count 1, dev ide0(3,66), block 3, from c0126b48
> set_blocksize: b_count 1, dev ide0(3,66), block 4, from c0126b48
> set_blocksize: b_count 1, dev ide0(3,66), block 5, from c0126b48
> set_blocksize: b_count 1, dev ide0(3,66), block 6, from c0126b48
> set_blocksize: b_count 1, dev ide0(3,66), block 7, from c0126b48
> set_blocksize: b_count 1, dev ide0(3,66), block 8, from c0126b48
> set_blocksize: b_count 1, dev ide0(3,66), block 1, from c0126b48
> Unable to find swap-space signature
> swapon: /dev/hdb2: Invalid argument
> root@kama3:/home/szabi#
>=20
> and then set_blocksize keeps flooding the console, not continuously,
> but 20-40 lines at a time, then it sleeps a bit, sometimes half a
> minute (caused by kupdated?)
>=20
> root@kama3:/home/szabi# mount -o remount,ro /usr
> ll_rw_block: device 03:42: only 4096-char blocks implemented (1024)
> root@kama3:/home/szabi#
>=20
> once I got these:
> ll_rw_block: device 03:42: only 4096-char blocks implemented (1024)
> EXT2-fs error (device ide0(3,66)): ext2_write_inode: unable to read inode=
 block
> - inode=3D2084, block=3D8207
> ll_rw_block: device 03:42: only 4096-char blocks implemented (1024)
> EXT2-fs error (device ide0(3,66)): ext2_write_inode: unable to read inode=
 block
> - inode=3D6328, block=3D24609
> ...
>=20
> szabi@kama3:/hdc1/kernel/linux-2.4.4-ac6# gdb vmlinux
> (gdb) disas 0xc0126b48
> ...
> 0xc0126b43 <sys_swapon+371>:    call   0xc012bcc0 <set_blocksize>
> 0xc0126b48 <sys_swapon+376>:    mov    0xe8(%edi),%edi
> 0xc0126b4e <sys_swapon+382>:    mov    %edi,0xffffffd0(%ebp)
> ...
>=20
> I tried it on several partitions, and it worked on /dev/hdc,
> and did not work on /dev/hdb
> on /dev/hdb all the filesystems are ext2
> on /dev/hdc one fs is a new, clean ext2, the others are reiserfs
>=20
> so I really don't know what's the problem.
>=20
> do you need any other information?
>=20
> Bye,
> Szabi
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

C:  Like the Furby?
DP: He gives me the creeps.  Think the SPCA will take him?
					-- Cobb and Dust Puppy
User Friendly, 1/2/1999

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6/cZMz64nssGU+ykRAh/uAKDudwxk+ilFazTdXSJooR4zT7LK4gCgkXoV
AyAhFm93Kn3g7V6NZoF03h4=
=gdQE
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
