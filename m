Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbVCVU2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbVCVU2A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 15:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVCVU17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 15:27:59 -0500
Received: from mail.dif.dk ([193.138.115.101]:50611 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261949AbVCVUYv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 15:24:51 -0500
Date: Tue, 22 Mar 2005 21:26:39 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <smfrench@austin.rr.com>
Cc: Steven French <sfrench@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH][5/6] cifs: readdir.c cleanup - avoid needless casting
Message-ID: <Pine.LNX.4.62.0503222123250.2683@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Explicit casts between  type <whatever> and void  or to/from the 
same type is pointless.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc1-mm1/fs/cifs/readdir.c.with_patch4	2005-03-22 20:45:09.000000000 +0100
+++ linux-2.6.12-rc1-mm1/fs/cifs/readdir.c	2005-03-22 20:46:03.000000000 +0100
@@ -37,7 +37,7 @@
 	struct cifsFileInfo *cf;
 
 	if (file) {
-		cf = (struct cifsFileInfo *)file->private_data;
+		cf = file->private_data;
 		if (cf == NULL) {
 			cFYI(1, ("empty cifs private file data"));
 			return;
@@ -292,7 +292,7 @@ static int initiate_cifs_search(const in
 	} else {
 		memset(file->private_data, 0, sizeof(struct cifsFileInfo));
 	}
-	cifsFile = (struct cifsFileInfo *)file->private_data;
+	cifsFile = file->private_data;
 	cifsFile->invalidHandle = TRUE;
 	cifsFile->srch_inf.endOfSearch = FALSE;
 
@@ -452,8 +452,7 @@ static int find_cifs_entry(const int xid
 	int pos_in_buf = 0;
 	loff_t first_entry_in_buffer;
 	loff_t index_to_find = file->f_pos;
-	struct cifsFileInfo *cifsFile =
-		(struct cifsFileInfo *)file->private_data;
+	struct cifsFileInfo *cifsFile = file->private_data;
 
 	/* check if index in the buffer */
 	if ((cifsFile == NULL) || (ppCurrentEntry == NULL) ||
@@ -799,7 +798,7 @@ int cifs_readdir(struct file *file, void
 			FreeXid(xid);
 			return rc;
 		}
-		cifsFile = (struct cifsFileInfo *)file->private_data;
+		cifsFile = file->private_data;
 		if (cifsFile->srch_inf.endOfSearch) {
 			if (cifsFile->srch_inf.emptyDir) {
 				cFYI(1, ("End of search, empty dir"));



