Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262315AbUK3VAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbUK3VAc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 16:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbUK3VAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 16:00:24 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:31962 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S262320AbUK3U5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 15:57:25 -0500
Date: Tue, 30 Nov 2004 13:57:22 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Barry Bouwsma <linuxbugs@dyndns.dk>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: UFS1 filesystem compatibility problem under Linux
Message-ID: <20041130205722.GD22547@schnapps.adilger.int>
Mail-Followup-To: Barry Bouwsma <linuxbugs@dyndns.dk>,
	Linux Kernel mailing list <linux-kernel@vger.kernel.org>
References: <200411301423.iAUENK601275@Mail.NOSPAM.DynDNS.dK>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KDt/GgjP6HVcx58l"
Content-Disposition: inline
In-Reply-To: <200411301423.iAUENK601275@Mail.NOSPAM.DynDNS.dK>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KDt/GgjP6HVcx58l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 30, 2004  15:23 +0100, Barry Bouwsma wrote:
> I've had absolutely no problems under FreeBSD (apart from possibly
> finding one or two bits of code that needed to be fixed) when I've
> made regular use of fragment sizes up to and including the block
> size (as large as 65536 bytes), so long as fsize is within the range
> of bsize/8 to bsize.
>=20
> Question:  Is there a reason that the Linux UFS code would be unable
> to handle frag sizes larger than 4k, or is this simply an arbitrary

Linux requires blocksize <=3D PAGE_SIZE, so basically all filesystems
use blocksize <=3D 4096 unless they implement support internally for
reading/writing partial disk blocks from the page or buffer cache.

With ext2/3 it is possible to change the number of inodes allocated
without changing the blocksize (less inodes per block group).  If you
care about mounting under Linux it might be worthwhile seeing if UFS
can do the same.

>           + (REG) Maximum file size depends on the block size on your
>             filesystem. For ext2 (and UFS, SysVFS and similar
>             filesystems), the limits are:
> Block size      Maximum file size (GiBytes)
> 512 B           2
> 1   kiB         16
> 2   kiB         128
> 4   kiB         1024
> 8   kiB         8192   (PAGE_SIZE must be >=3D 8 kiB)

This is it exactly.

> Hmmm, this reference to PAGE_SIZE is interesting -- the reason
> I'm asking all these stupid questions is to know whether some
> out-of-the-box on-CD-or-similar Linux could be expected to be
> able to handle my UFS1 filesystem as described above, with no
> need for a custom or tweaked kernel.

It seems unlikely (though not impossible, I haven't checked the UFS
code) than it is possible to mount your filesystem without serious
hacking to the filesystem/VFS/VM, unless of course you are mounting
on an ia64 machine (or similar) with 64kB PAGE_SIZE.  Sadly, x86_64
does not support a larger PAGE_SIZE than 4096 (until you get to 4MB
or something like that).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--KDt/GgjP6HVcx58l
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFBrN6ypIg59Q01vtYRAq5WAJ4xr/k1DRa1MvrKwEY2RghRJ03miQCdHaDX
woPRvLrpbfv7p6+DNDjpBO4=
=gUXd
-----END PGP SIGNATURE-----

--KDt/GgjP6HVcx58l--
