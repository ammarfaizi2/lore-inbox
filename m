Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161254AbWALUpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161254AbWALUpH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 15:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161255AbWALUpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 15:45:07 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:65505 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1161254AbWALUpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 15:45:06 -0500
Message-Id: <200601122044.k0CKihol003230@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: jack@suse.cz, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.15-mm3 - make useless quota error message informative
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1137098683_2950P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 12 Jan 2006 15:44:43 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1137098683_2950P
Content-Type: text/plain; charset=us-ascii

fs/quota_v2.c can, under some conditions, issue a kernel message that
says, in totality, 'failed read'.  This patch does the following:

1) Gives a hint who issued the error message, so people reading the logs
don't have to go grepping the entire kernel tree (with 11 false positives).

2) Say what amount of data we expected, and actually got.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
---
--- linux-2.6.15-mm3/fs/quota_v2.c.quot-bug	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15-mm3/fs/quota_v2.c	2006-01-12 15:26:43.000000000 -0500
@@ -35,7 +35,8 @@ static int v2_check_quota_file(struct su
  
 	size = sb->s_op->quota_read(sb, type, (char *)&dqhead, sizeof(struct v2_disk_dqheader), 0);
 	if (size != sizeof(struct v2_disk_dqheader)) {
-		printk("failed read\n");
+		printk("quota_v2: failed read expected=%d got=%d\n",
+			sizeof(struct v2_disk_dqheader), size);
 		return 0;
 	}
 	if (le32_to_cpu(dqhead.dqh_magic) != quota_magics[type] ||
 

--==_Exmh_1137098683_2950P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDxr+7cC3lWbTT17ARAnEzAJ9a9+Z0eD0kvND0uIAG1HQLRFYpZgCg75B1
0ykzvthUmzUQOnSu+/yxH4A=
=hK0x
-----END PGP SIGNATURE-----

--==_Exmh_1137098683_2950P--
