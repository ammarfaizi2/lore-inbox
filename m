Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266212AbUFPIHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266212AbUFPIHc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 04:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266214AbUFPIHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 04:07:32 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:459 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S266212AbUFPIHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 04:07:30 -0400
Date: Wed, 16 Jun 2004 10:07:40 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dave Kleikamp <shaggy@austin.ibm.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: JFS compilation fix [was Re: Linux 2.6.7]
Message-ID: <20040616080740.GC23998@louise.pinerecords.com>
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun-15 2004, Tue, 22:56 -0700
Linus Torvalds <torvalds@osdl.org> wrote:

> Summary of changes from v2.6.7-rc3 to v2.6.7
[snip]

Here's a trivial patch to fix JFS compilation in 2.6.7.  The error
only happens in specific configs -- one such config can be found here:
http://www.pinerecords.com/kala/_nonpub/.config.louise26

I don't have the time to narrow the problem down to the config
entry that gets jfs_dtree.c to include jfs_dtree.h (jfs_dtree.c
itself doesn't have any relevat ifdefs).

-- 
Tomas Szepe <szepe@pinerecords.com>


diff -urN a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
--- a/fs/jfs/jfs_dtree.c	2004-06-16 09:29:58.000000000 +0200
+++ b/fs/jfs/jfs_dtree.c	2004-06-16 09:56:23.000000000 +0200
@@ -108,6 +108,7 @@
 #include "jfs_dmap.h"
 #include "jfs_unicode.h"
 #include "jfs_debug.h"
+#include "jfs_dtree.h"
 
 /* dtree split parameter */
 struct dtsplit {
@@ -374,6 +375,8 @@
 		return index;
 	}
 	if (index == (MAX_INLINE_DIRTABLE_ENTRY + 1)) {
+		struct dir_table_slot temp_table[12];
+
 		/*
 		 * It's time to move the inline table to an external
 		 * page and begin to build the xtree
@@ -385,7 +388,6 @@
 		 * Save the table, we're going to overwrite it with the
 		 * xtree root
 		 */
-		struct dir_table_slot temp_table[12];
 		memcpy(temp_table, &jfs_ip->i_dirtable, sizeof(temp_table));
 
 		/*
