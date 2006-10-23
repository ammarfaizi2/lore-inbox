Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbWJWOqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbWJWOqc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 10:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbWJWOqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 10:46:32 -0400
Received: from systemlinux.org ([83.151.29.59]:60575 "EHLO m18s25.vlinux.de")
	by vger.kernel.org with ESMTP id S964899AbWJWOqc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 10:46:32 -0400
Date: Mon, 23 Oct 2006 16:45:57 +0200
From: Andre Noll <maan@systemlinux.org>
To: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger@clusterfs.com>,
       linux-kernel@vger.kernel.org
Subject: ext3: bogus i_mode errors with 2.6.18.1
Message-ID: <20061023144556.GY22487@skl-net.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ulNsWUvGrZAj8PMr"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ulNsWUvGrZAj8PMr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

stress tests on a 6.3T ext3 filesystem which runs on top of software
raid 6 revealed the following:

[663594.224641] init_special_inode: bogus i_mode (4412)
[663596.355652] init_special_inode: bogus i_mode (5123)
[663596.355832] init_special_inode: bogus i_mode (71562)

[many of these]

[663763.319514] EXT3-fs error (device md0): ext3_new_block: Allocating bloc=
k in system zone - blocks from 517570560, length 1
[663763.322680] Aborting journal on device md0.
[663763.331877] ext3_abort called.
[663763.333591] EXT3-fs error (device md0): ext3_journal_start_sb: Detected=
 aborted journal
[663763.337386] Remounting filesystem read-only
[663763.339423] EXT3-fs error (device md0): ext3_free_blocks: Freeing block=
s in system zones - Block =3D 517570560, count =3D 1
[663763.343880] EXT3-fs error (device md0) in ext3_free_blocks_sb: Journal =
has aborted
[663764.959828] __journal_remove_journal_head: freeing b_committed_data
[663764.962557] __journal_remove_journal_head: freeing b_committed_data
[663764.965257] __journal_remove_journal_head: freeing b_committed_data

This is kernel 2.6.18.1 on ppc64 (G5). The filesystem was created with

	mkfs.ext3 -b 4096 /dev/md0

This system is currently not in production use, so I can use it for tests A=
TM.

Andre

--=20
The only person who always got his work done by Friday was Robinson Crusoe

--ulNsWUvGrZAj8PMr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFPNWkWto1QDEAkw8RAjppAJ9n52m69yBsgVBFeccHjeigIp4JpACgpUjn
isWRtfwm0A5uYyCQOzlsrIk=
=Nsaj
-----END PGP SIGNATURE-----

--ulNsWUvGrZAj8PMr--
