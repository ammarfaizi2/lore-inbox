Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWEVKZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWEVKZH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 06:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWEVKZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 06:25:06 -0400
Received: from thunk.org ([69.25.196.29]:5004 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750723AbWEVKYm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 06:24:42 -0400
To: ext2-devel@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix memory leak when the ext3's journal file is corrupted
From: "Theodore Ts'o" <tytso@mit.edu>
Phone: (781) 391-3464
Message-Id: <E1Fhx2I-0001lb-Gk@candygram.thunk.org>
Date: Sun, 21 May 2006 19:08:34 -0400
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix memory leak when the ext3's journal file is corrupted

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>

Index: linux-2.6/fs/jbd/recovery.c
===================================================================
--- linux-2.6.orig/fs/jbd/recovery.c	2006-05-21 18:39:27.000000000 -0400
+++ linux-2.6/fs/jbd/recovery.c	2006-05-21 18:39:34.000000000 -0400
@@ -531,6 +531,7 @@
 		default:
 			jbd_debug(3, "Unrecognised magic %d, end of scan.\n",
 				  blocktype);
+			brelse(bh);
 			goto done;
 		}
 	}
