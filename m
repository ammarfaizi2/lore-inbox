Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265859AbUFIR6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265859AbUFIR6Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 13:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265894AbUFIR6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 13:58:23 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:64201 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S265859AbUFIR6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 13:58:17 -0400
Date: Wed, 9 Jun 2004 11:58:15 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Goldwyn Rodrigues <goldwyn_r@myrealbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Breaking Ext3/VFS file size limit
Message-ID: <20040609175815.GI24042@schnapps.adilger.int>
Mail-Followup-To: Goldwyn Rodrigues <goldwyn_r@myrealbox.com>,
	linux-kernel@vger.kernel.org
References: <1086787280.98272bfcgoldwyn_r@myrealbox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k9xkV0rc9XGsukaG"
Content-Disposition: inline
In-Reply-To: <1086787280.98272bfcgoldwyn_r@myrealbox.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k9xkV0rc9XGsukaG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 09, 2004  18:51 +0530, Goldwyn Rodrigues wrote:
> I am building a custom kernel which could break the max file size limit f=
rom
> 2TB. I found the dependancy on number of 512-byte blocks, as i_blocks.
>=20
> i_blocks is a 32 bit unsigned long in structures struct inode and
> struct ext3_inode. I changed it to unsigned long long in struct inode (in
> fs.h) and used a reserved field in ext3_inode to carry the higher order b=
its.

Just FYI, this should all be made conditional upon CONFIG_LBD so that the
majority of users who don't have/need such large files do not consume excess
space in their inodes.

> Also changed a checking function which returns the maximun possible size
> as 2TB.

Again FYI, the next limit for ext3 is 4TB for 4kB block size when you run o=
ut
of space for indirect blocks.

> My question is:
> Would changing the data type of i_blocks in struct inode (in fs.h) result
> in any breakdowns. It could happen if the inode structure is directly map=
ped
> to some other structure.

If you don't also fix the stat code you won't be able to stat such files.

> PS: I am posting for the first time, so please forgive me (but do tell me,
> personally if possible) if I commit a mistake.

It is usually good to include a patch with any discussion (diff -up format).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/                 http://members.shaw.ca/goli=
nux/


--k9xkV0rc9XGsukaG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAx0+3pIg59Q01vtYRAhrNAKCdYQKC7juEQVNDIeti2F5SAXRAxgCfWtJR
X1W0VbyVaUmZyzL+IORl10k=
=YW/C
-----END PGP SIGNATURE-----

--k9xkV0rc9XGsukaG--
