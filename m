Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbWDXR7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWDXR7h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 13:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbWDXR7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 13:59:37 -0400
Received: from aktaia.intevation.org ([212.95.126.10]:32922 "EHLO
	mail.intevation.de") by vger.kernel.org with ESMTP id S1751026AbWDXR7g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 13:59:36 -0400
Date: Mon, 24 Apr 2006 19:59:33 +0200
From: Bernhard Reiter <bernhard@intevation.de>
To: linux-kernel@vger.kernel.org, xfs-masters@oss.sgi.com, nathans@sgi.com
Subject: xfs bug, 2.6.17-rc2: unrepairable inode created
Message-ID: <20060424175933.GG29836@intevation.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=SHA1;
	protocol="application/pgp-signature"; boundary="Il7n/DHsA0sMLmDu"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Il7n/DHsA0sMLmDu
Content-Type: multipart/mixed; boundary="FN+gV9K+162wdwwF"
Content-Disposition: inline


--FN+gV9K+162wdwwF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2.6.17-rc2 on powerpc

Summary of failure:
        A bad inode was created that makes xfs stop on change attempts.
        xfs_repair cannot repair it.
        The creation most likely happened when running 2.6.17-rc2 on ppc.

Benjamin Herrenschmidt recommended to report this to lkml and xfs maintaine=
rs.
Attached my detailed report,=20
I have the 3 GByte partition copied as file and thus can do experiments
or send part to someone, if I get detailed instructions.

Please copy me on relevant replies, I am not subscribed to the list.

Bernhard
--
Professional Service for Free Software                 (intevation.net) =20
The FreeGIS Project                                       (freegis.org)
FSFE                                                    (fsfeurope.org)

--FN+gV9K+162wdwwF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="corruption-20060423-2.txt"
Content-Transfer-Encoding: quoted-printable

Details of XFS failure happening on 20060423
to Bernhard Reiter <bernhard@intevation.de>

Summary of failure:=20
	A bad inode was created that make xfs stop on change attempts.
	xfs_repair cannot repair it.
	The creation most likely happened when running 2.6.17-rc2 on ppc.

How the failure appeared:

Build and ran a 2.6.17-rc2 kernel on a ppc (PowerBook 5,6) for the first ti=
me.
gcc-Version 3.3.5 (Debian 1:3.3.5-13)

Used konqueror.

Later ran 2.6.12-rc6 to use omninet.o (which is broken in linux beyond 2.6.=
12).
This kernel was used often before in production without problems.

Trying to delete an entry from the inode leads to an XFS internal error.
This was a directory usually written by konqueror.


How to reproduce the bad behaviour now:

cd /var/bad/a.out
rm file.in.bad.dir

xfs_da_do_buf: bno 16777216
dir: inode 733
Filesystem "dm-6": XFS internal error xfs_da_do_buf(1) at line 2174 of file=
 fs/xfs/xfs_da_btree.c.  Caller 0xc00f2314
Call trace:
 [c0007ad0] dump_stack+0x18/0x28
 [c010024c] xfs_error_report+0x60/0x64
 [c00f20f8] xfs_da_do_buf+0x5b0/0x764
 [c00f2314] xfs_da_read_buf+0x2c/0x3c
 [c00fa238] xfs_dir2_leafn_remove+0x1bc/0x37c
 [c00fb1d8] xfs_dir2_node_removename+0xa0/0x114
 [c00f4644] xfs_dir2_removename+0x110/0x120
 [c0124d58] xfs_remove+0x21c/0x434
 [c0130ec4] linvfs_unlink+0x30/0x68
 [c0075924] vfs_unlink+0x13c/0x254
 [c0075b44] sys_unlink+0x108/0x1a8
 [c0004660] ret_from_syscall+0x0/0x44
xfs_force_shutdown(dm-6,0x8) called from line 1091 of file fs/xfs/xfs_trans=
=2Ec.Return address =3D 0xc013458c
Filesystem "dm-6": Corruption of in-memory data detected.  Shutting down fi=
lesystem: dm-6
Please umount the filesystem, and rectify the problem(s)


I have copied the partition in a file with dd and
the behaviour is consistant.

xfs_check says:
missing free index for data block 0 in dir ino 733
missing free index for data block 1 in dir ino 733
missing free index for data block 2 in dir ino 733
missing free index for data block 3 in dir ino 733
missing free index for data block 4 in dir ino 733
missing free index for data block 5 in dir ino 733
missing free index for data block 6 in dir ino 733
missing free index for data block 7 in dir ino 733
missing free index for data block 8 in dir ino 733
missing free index for data block 9 in dir ino 733
missing free index for data block 12 in dir ino 733
missing free index for data block 13 in dir ino 733
missing free index for data block 14 in dir ino 733


xfs_repair on-the-device

Phase 1 - find and verify superblock...
Phase 2 - using internal log
        - zero log...
        - scan filesystem freespace and inode maps...
        - found root inode chunk
Phase 3 - for each AG...
        - scan and clear agi unlinked lists...
        - process known inodes and perform inode discovery...
        - agno =3D 0
        - agno =3D 1
        - agno =3D 2
        - agno =3D 3
        - agno =3D 4
        - agno =3D 5
        - agno =3D 6
        - agno =3D 7
        - process newly discovered inodes...
Phase 4 - check for duplicate blocks...
        - setting up duplicate extent list...
        - clear lost+found (if it exists) ...
        - clearing existing "lost+found" inode
        - marking entry "lost+found" to be deleted
        - check for inodes claiming duplicate blocks...
        - agno =3D 0
        - agno =3D 1
        - agno =3D 2
        - agno =3D 3
        - agno =3D 4
        - agno =3D 5
        - agno =3D 6
        - agno =3D 7
Phase 5 - rebuild AG headers and trees...
        - reset superblock...
Phase 6 - check inode connectivity...
        - resetting contents of realtime bitmap and summary inodes
        - ensuring existence of lost+found directory
        - traversing filesystem starting at / ...
rebuilding directory inode 128

fatal error -- can't read block 16777216 for directory inode 733


Hypothesis: Block 16777216 is not within the valid range.

xfs_info /dev/mapper/vg0-var
meta-data=3D/var                   isize=3D256    agcount=3D8, agsize=3D983=
04 blks
         =3D                       sectsz=3D512
data     =3D                       bsize=3D4096   blocks=3D786432, imaxpct=
=3D25
         =3D                       sunit=3D0      swidth=3D0 blks, unwritte=
n=3D1
naming   =3Dversion 2              bsize=3D4096
log      =3Dinternal               bsize=3D4096   blocks=3D2560, version=3D1
         =3D                       sectsz=3D512   sunit=3D0 blks
realtime =3Dnone                   extsz=3D65536  blocks=3D0, rtextents=3D0

Additional information:

I am using xfsprogs from Debian Sarge 2.6.20-1. =20
Retested with a backport of 2.7.16-1, still cannot repair.

--FN+gV9K+162wdwwF--

--Il7n/DHsA0sMLmDu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBETRIFh9ag3dpKERYRAlqmAJ4qWmUzq4inQa+ONQkSCF6d8W5p3ACfT98c
WRMEQUD+9abLVHbzT+Dvy64=
=jj9H
-----END PGP SIGNATURE-----

--Il7n/DHsA0sMLmDu--
