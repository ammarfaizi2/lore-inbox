Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265955AbUGIV70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265955AbUGIV70 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 17:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265958AbUGIV7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 17:59:25 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:24282 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S265955AbUGIV7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 17:59:05 -0400
Date: Fri, 9 Jul 2004 15:58:59 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Frank van Maarseveen <frankvm@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: strange "file system was modified" report from e2fsck
Message-ID: <20040709215859.GO23346@schnapps.adilger.int>
Mail-Followup-To: Frank van Maarseveen <frankvm@xs4all.nl>,
	linux-kernel@vger.kernel.org
References: <20040709163130.GA6361@janus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MsEL38XAg4rx1uDx"
Content-Disposition: inline
In-Reply-To: <20040709163130.GA6361@janus>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MsEL38XAg4rx1uDx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 09, 2004  18:31 +0200, Frank van Maarseveen wrote:
> mke2fs -j
> mount it
> Fill disk as root with one huge >150GB file
> umount it
> e2fsck -f -v: ok
> mount it
> rm 150 GB file
> umount it
> e2fsck -f -v: ***** FILE SYSTEM WAS MODIFIED *****
>=20
> After removing the big file and umounting the ext3 partition, e2fsck -f -v
> invariably reports that the file system has been modified. This doesn't
> happen for a small file.

The "RO_COMPAT_LARGE_FILE" flag is set when a > 2GB file is created, but
it can't be cleared when the file is removed since it isn't refcounted.
This can only be cleared by e2fsck if no other large files exist.

> Filesystem features:      has_journal filetype sparse_super

See no "large_file" flag.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--MsEL38XAg4rx1uDx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD4DBQFA7xUjpIg59Q01vtYRAhFyAJiPR/sEaFY7qPzygq9XKY7aP87TAKDRRdp0
7NxXeEh92xE/wFnr1KmvAA==
=k92Q
-----END PGP SIGNATURE-----

--MsEL38XAg4rx1uDx--
