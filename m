Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbUDXGxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbUDXGxQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 02:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbUDXGxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 02:53:16 -0400
Received: from outmx005.isp.belgacom.be ([195.238.2.102]:15020 "EHLO
	outmx005.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S261993AbUDXGxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 02:53:12 -0400
Subject: RE: [PATCH] 2.6.6-rc2 nfs_fsync() breaks "cvs update"
From: FabF <Fabian.Frederick@skynet.be>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-V06zrcqxLR29R1hXxX06"
Message-Id: <1082789860.4676.24.camel@bluerhyme.real3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 24 Apr 2004 08:57:40 +0200
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (outmx005.isp.belgacom.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-V06zrcqxLR29R1hXxX06
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Jim,

	Maybe we could add some explicit comment here ?

Regards,
Fabian

--=-V06zrcqxLR29R1hXxX06
Content-Disposition: attachment; filename=nfscommitinode2.diff
Content-Type: text/x-patch; name=nfscommitinode2.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -Naur orig/fs/nfs/write.c edited/fs/nfs/write.c
--- orig/fs/nfs/write.c	2004-04-21 18:10:52.000000000 +0200
+++ edited/fs/nfs/write.c	2004-04-24 08:53:46.000000000 +0200
@@ -357,8 +357,11 @@
 			goto out;
 	}
 	err = nfs_commit_inode(inode, 0, 0, wb_priority(wbc));
-	if (err > 0)
+	if (err > 0){
 		wbc->nr_to_write -= err;
+		/* nfs_scan_list returned processed requests => no error */
+		err = 0;
+	}
 out:
 	clear_bit(BDI_write_congested, &bdi->state);
 	wake_up_all(&nfs_write_congestion);

--=-V06zrcqxLR29R1hXxX06--

