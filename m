Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264117AbUFPQ2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264117AbUFPQ2K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 12:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264153AbUFPQ2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 12:28:10 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:58251 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264117AbUFPQ2C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 12:28:02 -0400
Subject: Re: PROBLEM: 2.6.7 does not compile (jfs errors)
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Perlbroker <minime@sdf.lonestar.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040616133944.GA1987@8128.biz>
References: <20040616133944.GA1987@8128.biz>
Content-Type: text/plain
Message-Id: <1087403262.29041.25.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 16 Jun 2004 11:27:42 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-16 at 08:39, Perlbroker wrote:

> CC [M]  fs/jfs/jfs_dtree.o
> fs/jfs/jfs_dtree.c: In function `add_index':
> fs/jfs/jfs_dtree.c:388: parse error before `struct'
> fs/jfs/jfs_dtree.c:389: `temp_table' undeclared (first use in this function)
> fs/jfs/jfs_dtree.c:389: (Each undeclared identifier is reported only once
> fs/jfs/jfs_dtree.c:389: for each function it appears in.)
> make[3]: *** [fs/jfs/jfs_dtree.o] Error 1
> make[2]: *** [fs/jfs] Error 2
> make[1]: *** [fs] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.6.7'

This was reported in another thread by Tomas Szepe.  I don't know why
this sometimes compiles cleanly, but this patch should fix it:

diff -urp linux-2.6.7/fs/jfs/jfs_dtree.c linux/fs/jfs/jfs_dtree.c
--- linux-2.6.7/fs/jfs/jfs_dtree.c	2004-06-16 07:38:20.244688936 -0500
+++ linux/fs/jfs/jfs_dtree.c	2004-06-16 07:46:38.210986552 -0500
@@ -374,6 +374,8 @@ static u32 add_index(tid_t tid, struct i
 		return index;
 	}
 	if (index == (MAX_INLINE_DIRTABLE_ENTRY + 1)) {
+		struct dir_table_slot temp_table[12];
+
 		/*
 		 * It's time to move the inline table to an external
 		 * page and begin to build the xtree
@@ -385,7 +387,6 @@ static u32 add_index(tid_t tid, struct i
 		 * Save the table, we're going to overwrite it with the
 		 * xtree root
 		 */
-		struct dir_table_slot temp_table[12];
 		memcpy(temp_table, &jfs_ip->i_dirtable, sizeof(temp_table));
 
 		/*

-- 
David Kleikamp
IBM Linux Technology Center

