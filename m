Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbTD3Tv5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 15:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbTD3Tv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 15:51:57 -0400
Received: from muss.CIS.mcmaster.ca ([130.113.64.9]:28085 "EHLO
	cgpsrv1.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S262366AbTD3Tvz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 15:51:55 -0400
From: Gabriel Devenyi <devenyga@mcmaster.ca>
To: sfrench@us.ibm.com
Subject: [PATCH] Linux 2.5.68 - Fix FreeXid after return in fs/cifs/inode.c
Date: Thu, 1 May 2003 16:04:13 -0400
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305011604.14175.devenyga@mcmaster.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch applies to 2.5.68, it is listed at kbugs.org. FreeXid(xid); is after return so it is never executed.

Please CC me with any discussion.
- -- 
Building the Future,
Gabriel Devenyi
devenyga@mcmaster.ca

- ---FILE---

- --- linux-2.5.68/fs/cifs/inode.c	2003-04-19 22:48:49.000000000 -0400
+++ linux-2.5.68-changed/fs/cifs/inode.c	2003-05-01 15:10:32.000000000 -0400
@@ -450,10 +450,10 @@
 	cifs_sb_source = CIFS_SB(source_inode->i_sb);
 	pTcon = cifs_sb_source->tcon;
 
- -	if (pTcon != cifs_sb_target->tcon) {    
+	if (pTcon != cifs_sb_target->tcon) {
+		FreeXid(xid);
 		return -EXDEV;	/* BB actually could be allowed if same server, but
                      different share. Might eventually add support for this */
- -        	FreeXid(xid);
 	}
 
 	fromName = build_path_from_dentry(source_direntry);

- ---ENDFILE---
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+sX297I5UBdiZaF4RAmZdAKCMDNHfhNlT3aUsuuVvPAp3Qae7TwCbBXJe
JfPpUBFc/wfsuUa9WfBFuZk=
=wm6g
-----END PGP SIGNATURE-----

