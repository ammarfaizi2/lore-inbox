Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269060AbUJEPXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269060AbUJEPXy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 11:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269057AbUJEPXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 11:23:54 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:35400 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S269060AbUJEPIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 11:08:44 -0400
Date: Tue, 5 Oct 2004 11:08:44 -0400
From: Jeffrey Mahoney <jeffm@novell.com>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] ReiserFS: Fix several missing reiserfs_write_unlock calls
Message-ID: <20041005150844.GE30046@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2hMgfIw2X+zgXrFs"
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.108-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2hMgfIw2X+zgXrFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch fixes several missing reiserfs_write_unlock() calls on=20
error paths not introduced by reiserfs-io-error-handling.diff

Signed-off-by: Jeff Mahoney <jeffm@novell.com>

 fs/reiserfs/namei.c |    2 ++
 1 files changed, 2 insertions(+)

diff -rup linux-2.6.8/fs/reiserfs/namei.c linux-2.6.8.fix/fs/reiserfs/namei=
=2Ec
--- linux-2.6.8/fs/reiserfs/namei.c	2004-09-13 14:06:42.000000000 -0400
+++ linux-2.6.8.fix/fs/reiserfs/namei.c	2004-09-13 16:37:20.101499264 -0400
@@ -341,6 +341,7 @@ static struct dentry * reiserfs_lookup (
             REISERFS_SB(dir->i_sb)->priv_root &&
             REISERFS_SB(dir->i_sb)->priv_root->d_inode &&
 	    de.de_objectid =3D=3D le32_to_cpu (INODE_PKEY(REISERFS_SB(dir->i_sb)-=
>priv_root->d_inode)->k_objectid)) {
+	  reiserfs_write_unlock (dir->i_sb);
 	  return ERR_PTR (-EACCES);
 	}
=20
@@ -1091,6 +1092,7 @@ static int reiserfs_link (struct dentry=20
 	return -EMLINK;
     }
     if (inode->i_nlink =3D=3D 0) {
+        reiserfs_write_unlock(dir->i_sb);
         return -ENOENT;
     }
=20

--2hMgfIw2X+zgXrFs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBYrj7LPWxlyuTD7IRAn8PAJ0UPfSPNrtsILlK+hbzDGYDev57lwCgqASF
Q4U/2Y4A2Ei7GDseZc58c28=
=p5s2
-----END PGP SIGNATURE-----

--2hMgfIw2X+zgXrFs--
