Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316402AbSEZUuH>; Sun, 26 May 2002 16:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316427AbSEZUo4>; Sun, 26 May 2002 16:44:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56080 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316404AbSEZUoV>;
	Sun, 26 May 2002 16:44:21 -0400
Message-ID: <3CF149E2.39267363@zip.com.au>
Date: Sun, 26 May 2002 13:47:30 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 15/18] move BH_JBD out of buffer_head.h
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



For historical reasons, ext3 has a private BH state bit which has
global scope.  This patch moves it inside ext3.


=====================================

--- 2.5.18/include/linux/buffer_head.h~bh_jbd	Sat May 25 23:25:51 2002
+++ 2.5.18-akpm/include/linux/buffer_head.h	Sat May 25 23:25:51 2002
@@ -23,7 +23,6 @@ enum bh_state_bits {
 	BH_Async_Read,	/* Is under end_buffer_async_read I/O */
 	BH_Async_Write,	/* Is under end_buffer_async_write I/O */
 
-	BH_JBD,		/* Has an attached ext3 journal_head */
 	BH_Boundary,	/* Block is followed by a discontiguity */
 	BH_PrivateStart,/* not a state bit, but the first bit available
 			 * for private allocation by other entities
--- 2.5.18/include/linux/jbd.h~bh_jbd	Sat May 25 23:25:51 2002
+++ 2.5.18-akpm/include/linux/jbd.h	Sat May 25 23:25:51 2002
@@ -226,12 +226,13 @@ void buffer_assertion_failure(struct buf
 #endif		/* JBD_ASSERTIONS */
 
 enum jbd_state_bits {
-	BH_JWrite
-	  = BH_PrivateStart,	/* 1 if being written to log (@@@ DEBUGGING) */
-	BH_Freed,		/* 1 if buffer has been freed (truncated) */
-	BH_Revoked,		/* 1 if buffer has been revoked from the log */
-	BH_RevokeValid,		/* 1 if buffer revoked flag is valid */
-	BH_JBDDirty,		/* 1 if buffer is dirty but journaled */
+	BH_JBD			/* Has an attached ext3 journal_head */
+	  = BH_PrivateStart,	
+	BH_JWrite,		/* Being written to log (@@@ DEBUGGING) */
+	BH_Freed,		/* Has been freed (truncated) */
+	BH_Revoked,		/* Has been revoked from the log */
+	BH_RevokeValid,		/* Revoked flag is valid */
+	BH_JBDDirty,		/* Is dirty but journaled */
 };
 
 BUFFER_FNS(JBD, jbd)

-
