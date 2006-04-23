Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbWDWPnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWDWPnl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 11:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWDWPnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 11:43:41 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:17571 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751411AbWDWPnk (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 23 Apr 2006 11:43:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:Content-Type;
  b=e8h3rzPez8VGNrEtlqAD8tpKfh4tYlWtucvNMFPI8H8PcaMiYms4CKAkH3Ms8qpMmHIQusRTfLLQ3lDfBoSYbKaTb4Os3itaqM4B6p9YyhXwkNR73dzNKu6+Tly+KUutnYN5VeAh04CNt7pCCR6hlu2+3w6+nv1E07/DdooQ8XA=  ;
Message-ID: <444BA0A9.3080901@yahoo.com.au>
Date: Mon, 24 Apr 2006 01:43:37 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: [rfc][patch] radix-tree: small data structure
Content-Type: multipart/mixed;
 boundary="------------000804080204000408010301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000804080204000408010301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

With the previous patch, the radix_tree_node budget on my 64-bit
desktop is cut from 20MB to 10MB. This patch should cut it again
by nearly a factor of 4 (haven't verified, but 98ish % of files
are under 64K).

I wonder if this would be of any interest for those who enable
CONFIG_BASE_SMALL?

-- 
SUSE Labs, Novell Inc.

--------------000804080204000408010301
Content-Type: text/plain;
 name="radix-tree-tag_get-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="radix-tree-tag_get-fix.patch"

Index: rtth/radix-tree.c
===================================================================
--- rtth.orig/radix-tree.c	2006-04-22 18:40:38.000000000 +1000
+++ rtth/radix-tree.c	2006-04-23 04:46:15.000000000 +1000
@@ -458,9 +458,8 @@ EXPORT_SYMBOL(radix_tree_tag_clear);
  *
  * Return values:
  *
- *  0: tag not present
+ *  0: tag not set or not present
  *  1: tag present, set
- * -1: tag present, unset
  */
 int radix_tree_tag_get(struct radix_tree_root *root,
 			unsigned long index, unsigned int tag)
@@ -494,7 +493,7 @@ int radix_tree_tag_get(struct radix_tree
 			int ret = tag_get(slot, tag, offset);
 
 			BUG_ON(ret && saw_unset_tag);
-			return ret ? 1 : -1;
+			return ret;
 		}
 		slot = slot->slots[offset];
 		shift -= RADIX_TREE_MAP_SHIFT;

--------------000804080204000408010301--
Send instant messages to your online friends http://au.messenger.yahoo.com 
