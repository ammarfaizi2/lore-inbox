Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129655AbQLEMDT>; Tue, 5 Dec 2000 07:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129718AbQLEMDJ>; Tue, 5 Dec 2000 07:03:09 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:36756 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129655AbQLEMCy>; Tue, 5 Dec 2000 07:02:54 -0500
Date: Tue, 5 Dec 2000 03:31:52 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: Patch: linux-2.4.0-test12-pre5/fs/udf/inode.c writepage still had extra parameter
Message-ID: <20001205033152.A6613@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


	Apparently, in linux 2.4.0-test12-pre5,
address_space_operations->writepage went from having two parameters
to just one.  fs/udf/inode.c apparently was overlooked in the patch.
Here is the one line change.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="writepage.diffs"

Index: linux/fs/udf/inode.c
===================================================================
RCS file: /usr/src.repository/repository/linux/fs/udf/inode.c,v
retrieving revision 1.22
diff -u -r1.22 inode.c
--- linux/fs/udf/inode.c	2000/12/05 10:21:27	1.22
+++ linux/fs/udf/inode.c	2000/12/05 11:27:54
@@ -202,7 +202,7 @@
 	mark_buffer_dirty(bh);
 	udf_release_data(bh);
 
-	inode->i_data.a_ops->writepage(NULL, page);
+	inode->i_data.a_ops->writepage(page);
 	UnlockPage(page);
 	page_cache_release(page);
 

--pWyiEgJYm5f9v55/--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
