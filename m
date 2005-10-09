Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbVJIX7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbVJIX7H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 19:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbVJIX7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 19:59:07 -0400
Received: from h80ad2497.async.vt.edu ([128.173.36.151]:14743 "EHLO
	h80ad2497.async.vt.edu") by vger.kernel.org with ESMTP
	id S932308AbVJIX7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 19:59:06 -0400
Message-Id: <200510092358.j99NwlQj021703@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Al Viro <viro@ftp.linux.org.uk>
Cc: jmerkey <jmerkey@utah-nac.org>, Linus Torvalds <torvalds@osdl.org>,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix ext3 warning for unused var 
In-Reply-To: Your message of "Sun, 09 Oct 2005 23:08:38 BST."
             <20051009220838.GN7992@ftp.linux.org.uk> 
From: Valdis.Kletnieks@vt.edu
References: <20051009195850.27237.90873.stgit@zion.home.lan> <Pine.LNX.4.64.0510091314200.31407@g5.osdl.org> <43497533.6090106@utah-nac.org> <20051009212916.GM7992@ftp.linux.org.uk> <43497B09.3020102@utah-nac.org>
            <20051009220838.GN7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1128902326_2746P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 09 Oct 2005 19:58:46 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1128902326_2746P
Content-Type: text/plain; charset=us-ascii

On Sun, 09 Oct 2005 23:08:38 BST, Al Viro said:

> Since when does fsck run fsck.ext3 on filesystems that are not marked
> as ext3 in /etc/fstab?

Part of the problem is that if a partition is formatted with mkfs.ext3,
it gets an ext3 magic number scribbled at a known offset into the partition.
If you then reformat it with mkfs.reiserfs, that scribbles a different
magic number elsewhere on the partition, but leaves the ext3 magic number
intact.  As a result, if you forget to update /etc/fstab, fsck.ext3 checks
for its magic number, finds it, concludes it's probably an ext3, and then
discovers that everything is totally scrogged.....

Yes, it's pilot error, but it's definitely hitting your feet with much larger
caliber rounds than you would have expected... :)

--==_Exmh_1128902326_2746P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDSa61cC3lWbTT17ARAsgMAKC3GKMc6da2ISzCxv0jSjMlfXxFYQCg8eBm
mYbMVtlqF2rf/xBURBqRRdA=
=pDyO
-----END PGP SIGNATURE-----

--==_Exmh_1128902326_2746P--
