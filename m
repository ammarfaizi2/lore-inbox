Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312480AbSDNXOm>; Sun, 14 Apr 2002 19:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312494AbSDNXOl>; Sun, 14 Apr 2002 19:14:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50441 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312480AbSDNXOl>;
	Sun, 14 Apr 2002 19:14:41 -0400
Message-ID: <3CBA1B99.138CA8D3@zip.com.au>
Date: Sun, 14 Apr 2002 17:15:21 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "jfs-discussion@www-126.southbury.usf.ibm.com" 
	<jfs-discussion@www-126.southbury.usf.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [patch] JFS build fix for 2.5.8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Missed a page->buffers -> page->private conversion.
Apologies..

--- 2.5.8/fs/jfs/jfs_metapage.c~dallocbase-35-pageprivate_fixes	Sun Apr 14 17:04:11 2002
+++ 2.5.8-akpm/fs/jfs/jfs_metapage.c	Sun Apr 14 17:04:11 2002
@@ -515,7 +515,7 @@ static inline void sync_metapage(metapag
 	lock_page(page);
 
 	/* we're done with this page - no need to check for errors */
-	if (page->buffers) {
+	if (page_has_buffers(page)) {
 		writeout_one_page(page);
 		waitfor_one_page(page);
 	}


-
