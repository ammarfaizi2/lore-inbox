Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261940AbVCVU1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbVCVU1H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 15:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVCVUYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 15:24:03 -0500
Received: from mail.dif.dk ([193.138.115.101]:12211 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261759AbVCVUVS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 15:21:18 -0500
Date: Tue, 22 Mar 2005 21:23:05 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <smfrench@austin.rr.com>
Cc: Steven French <sfrench@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH][4/6] cifs: readdir.c cleanup - kfree() changes
Message-ID: <Pine.LNX.4.62.0503222120250.2683@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes redundant NULL pointer checks before calling kfree().


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc1-mm1/fs/cifs/readdir.c.with_patch3	2005-03-22 20:14:37.000000000 +0100
+++ linux-2.6.12-rc1-mm1/fs/cifs/readdir.c	2005-03-22 20:15:40.000000000 +0100
@@ -330,8 +330,7 @@ static int initiate_cifs_search(const in
 			   &cifsFile->netfid, &cifsFile->srch_inf);
 	if (rc == 0)
 		cifsFile->invalidHandle = FALSE;
-	if (full_path)
-		kfree(full_path);
+	kfree(full_path);
 	return rc;
 }
 
@@ -471,10 +470,8 @@ static int find_cifs_entry(const int xid
 		cFYI(1, ("search backing up - close and restart search"));
 		cifsFile->invalidHandle = TRUE;
 		CIFSFindClose(xid, pTcon, cifsFile->netfid);
-		if (cifsFile->search_resume_name) {
-			kfree(cifsFile->search_resume_name);
-			cifsFile->search_resume_name = NULL;
-		}
+		kfree(cifsFile->search_resume_name);
+		cifsFile->search_resume_name = NULL;
 		if (cifsFile->srch_inf.ntwrk_buf_start) {
 			cFYI(1, ("freeing SMB ff cache buf on search rewind")); 
 			cifs_buf_release(cifsFile->srch_inf.ntwrk_buf_start);
@@ -813,10 +810,8 @@ int cifs_readdir(struct file *file, void
 			cifsFile->invalidHandle = TRUE;
 			CIFSFindClose(xid, pTcon, cifsFile->netfid);
 		} 
-		if (cifsFile->search_resume_name) {
-			kfree(cifsFile->search_resume_name);
-			cifsFile->search_resume_name = NULL;
-		} */
+		kfree(cifsFile->search_resume_name);
+		cifsFile->search_resume_name = NULL; */
 /* BB account for . and .. in f_pos */
 		/* dump_cifs_file_struct(file, "rdir after default "); */
 
@@ -866,8 +861,7 @@ int cifs_readdir(struct file *file, void
 				current_entry = nxt_dir_entry(current_entry,
 							      end_of_smb);
 		}
-		if (tmp_buf != NULL)
-			kfree(tmp_buf);
+		kfree(tmp_buf);
 		break;
 	} /* end switch */
 rddir2_exit:



