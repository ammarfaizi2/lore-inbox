Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267008AbSLPSQm>; Mon, 16 Dec 2002 13:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267010AbSLPSQm>; Mon, 16 Dec 2002 13:16:42 -0500
Received: from 216-42-72-142.ppp.netsville.net ([216.42.72.142]:34442 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id <S267008AbSLPSQl>;
	Mon, 16 Dec 2002 13:16:41 -0500
Subject: Re: [BK][PATCH] ReiserFS CPU and memory bandwidth efficient large
	writes
From: Chris Mason <mason@suse.com>
To: Oleg Drokin <green@namesys.com>
Cc: Andrew Morton <akpm@digeo.com>, Hans Reiser <reiser@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021214232520.A10786@namesys.com>
References: <3DFA2D4F.3010301@namesys.com> <3DFA53DA.DE6788C1@digeo.com>
	<20021214162108.A3452@namesys.com> <3DFB7B9E.FC404B6B@digeo.com>
	<20021214222053.A10506@namesys.com> <3DFB904F.2ADDE2D4@digeo.com> 
	<20021214232520.A10786@namesys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 16 Dec 2002 13:24:28 -0500
Message-Id: <1040063068.17501.31.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-12-14 at 15:25, Oleg Drokin wrote:

> reiserfs v3  was traditionally hungry on stack space I think.

Well, if you want to drop stack usage, kill some inlines from stree.c. 
I really doubt we gain anything from inlining these:

--- linux/fs/reiserfs/stree.c.1	Tue Sep 24 09:50:50 2002
+++ linux/fs/reiserfs/stree.c	Tue Sep 24 09:51:18 2002
@@ -340,7 +340,7 @@
 

 /* Get delimiting key of the buffer at the path and its right neighbor. */
-inline	const struct  key * get_rkey  (
+const struct  key * get_rkey  (
 	                const struct path         * p_s_chk_path,
                         const struct super_block  * p_s_sb
                       ) {
@@ -925,7 +925,7 @@
 

 // prepare for delete or cut of direct item
-static inline int prepare_for_direct_item (struct path * path,
+static int prepare_for_direct_item (struct path * path,
 					   struct item_head * le_ih,
 					   struct inode * inode,
 					   loff_t new_file_length,
@@ -970,7 +970,7 @@
 }
 

-static inline int prepare_for_direntry_item (struct path * path,
+static int prepare_for_direntry_item (struct path * path,
 					     struct item_head * le_ih,
 					     struct inode * inode,
 					     loff_t new_file_length,



