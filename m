Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbVJPFD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbVJPFD4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 01:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbVJPFD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 01:03:56 -0400
Received: from xenotime.net ([66.160.160.81]:15027 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751288AbVJPFDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 01:03:55 -0400
Date: Sat, 15 Oct 2005 22:03:50 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, sct@redhat.com
Subject: [PATCH] jbd doc: fix some kernel-doc warnings
Message-Id: <20051015220350.342553fc.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Add structure fields kernel-doc for 2 fields in struct journal_s.

Warning(/var/linsrc/linux-2614-rc4//include/linux/jbd.h:808): No description found for parameter 'j_wbuf'
Warning(/var/linsrc/linux-2614-rc4//include/linux/jbd.h:808): No description found for parameter 'j_wbufsize'

Convert fs/jbd/recovery.c non-static functions to kernel-doc format.

fs/jbd/recovery.c doesn't export any symbols, so it should use
!I instead of !E to eliminate this warning message:

Warning(/var/linsrc/linux-2614-rc4//fs/jbd/recovery.c): no structured comments found

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 Documentation/DocBook/journal-api.tmpl |    2 +-
 fs/jbd/recovery.c                      |    4 ++--
 include/linux/jbd.h                    |    3 +++
 3 files changed, 6 insertions(+), 3 deletions(-)

diff -Naurp linux-2614-rc4/Documentation/DocBook/journal-api.tmpl~doc_journal_api linux-2614-rc4/Documentation/DocBook/journal-api.tmpl
--- linux-2614-rc4/Documentation/DocBook/journal-api.tmpl~doc_journal_api	2005-10-14 17:31:21.000000000 -0700
+++ linux-2614-rc4/Documentation/DocBook/journal-api.tmpl	2005-10-15 21:34:55.000000000 -0700
@@ -306,7 +306,7 @@ an example.
 </para>
 	<sect1><title>Journal Level</title>
 !Efs/jbd/journal.c
-!Efs/jbd/recovery.c
+!Ifs/jbd/recovery.c
 	</sect1>
 	<sect1><title>Transasction Level</title>
 !Efs/jbd/transaction.c	
diff -Naurp linux-2614-rc4/fs/jbd/recovery.c~doc_journal_api linux-2614-rc4/fs/jbd/recovery.c
--- linux-2614-rc4/fs/jbd/recovery.c~doc_journal_api	2005-08-28 16:41:01.000000000 -0700
+++ linux-2614-rc4/fs/jbd/recovery.c	2005-10-15 21:24:01.000000000 -0700
@@ -210,7 +210,7 @@ do {									\
 } while (0)
 
 /**
- * int journal_recover(journal_t *journal) - recovers a on-disk journal
+ * journal_recover - recovers a on-disk journal
  * @journal: the journal to recover
  * 
  * The primary function for recovering the log contents when mounting a
@@ -266,7 +266,7 @@ int journal_recover(journal_t *journal)
 }
 
 /**
- * int journal_skip_recovery() - Start journal and wipe exiting records 
+ * journal_skip_recovery - Start journal and wipe exiting records 
  * @journal: journal to startup
  * 
  * Locate any valid recovery information from the journal and set up the
diff -Naurp linux-2614-rc4/include/linux/jbd.h~doc_journal_api linux-2614-rc4/include/linux/jbd.h
--- linux-2614-rc4/include/linux/jbd.h~doc_journal_api	2005-10-14 17:31:29.000000000 -0700
+++ linux-2614-rc4/include/linux/jbd.h	2005-10-15 21:18:06.000000000 -0700
@@ -611,6 +611,9 @@ struct transaction_s 
  * @j_revoke: The revoke table - maintains the list of revoked blocks in the
  *     current transaction.
  * @j_revoke_table: alternate revoke tables for j_revoke
+ * @j_wbuf: array of buffer_heads for journal_commit_transaction
+ * @j_wbufsize: maximum number of buffer_heads allowed in j_wbuf, the
+ *	number that will fit in j_blocksize
  * @j_private: An opaque pointer to fs-private information.
  */
 


---
