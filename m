Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262448AbVC3UIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbVC3UIk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 15:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbVC3UII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 15:08:08 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:38037 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S262433AbVC3UGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 15:06:11 -0500
Date: Wed, 30 Mar 2005 13:06:01 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: David Malone <dwmalone@maths.tcd.ie>
Cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Directory link count wrapping on Linux/XFS/i386?
Message-ID: <20050330200601.GG1753@schnapps.adilger.int>
Mail-Followup-To: David Malone <dwmalone@maths.tcd.ie>,
	linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
References: <200503302043.aa27223@salmon.maths.tcd.ie>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CGDBiGfvSTbxKZlW"
Content-Disposition: inline
In-Reply-To: <200503302043.aa27223@salmon.maths.tcd.ie>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CGDBiGfvSTbxKZlW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar 30, 2005  20:43 +0100, David Malone wrote:
> It seems that internally xfs uses a 32 bit field for the link count,
> and the stat64 syscalls use a 32 bit field. These fields are copied
> via the vattr structure in xfs_vnode.h, which uses a nlink_t for
> the link count. However, in the kernel, I think this field is
> actually of type __kernel_nlink_t which seems to be 16 bits on many
> platforms.
>=20
> I've tested this on an i386 2.6.11 kernel and it seems that the
> link count presented to userland wraps after 65536 subdirectories.
> This naturally doesn't let you screw up the filesystem or anything,
> but it does let you can hide files from find/fts, as demonstrated
> below.

The correct fix, used for reiserfs (and a patch for ext3 also) is to
set i_nlink =3D 1 in case the filesystem count has wrapped.  When nlink=3D=
=3D1
the fts/find code no longer optimizes subdirectory traversal and checks
each entries filetype to see if it should recurse.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.


--CGDBiGfvSTbxKZlW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFCSwappIg59Q01vtYRAm6HAJ93NGtAajrQcZp4dU33Pnoo8bgb3ACgjrRY
HalV/OqWSYF2+IoGsJIMtBc=
=1VrQ
-----END PGP SIGNATURE-----

--CGDBiGfvSTbxKZlW--
