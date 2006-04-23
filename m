Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbWDWPq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbWDWPq1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 11:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWDWPq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 11:46:27 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:6036 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751413AbWDWPq1 (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 23 Apr 2006 11:46:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=b6iFKDqsvOvfrDrzOrEunta57lpWxwjEsxp4kHwY9aC9XLqObSkdx6kEoPBKlv6Kz8vb3PsOHQALz1CR4JEeAZri1b0bgj05ihZib5Eou/rs/xjCP+cTtB4y+sJi2hiZaCqVW8GmQi3YUtt92jDXbB0CdktuKyiEgODQe1Xg9EY=  ;
Message-ID: <444BA150.7040907@yahoo.com.au>
Date: Mon, 24 Apr 2006 01:46:24 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [rfc][patch] radix-tree: small data structure
References: <444BA0A9.3080901@yahoo.com.au>
In-Reply-To: <444BA0A9.3080901@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------090004090206030103030004"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090004090206030103030004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Nick Piggin wrote:
> With the previous patch, the radix_tree_node budget on my 64-bit
> desktop is cut from 20MB to 10MB. This patch should cut it again
> by nearly a factor of 4 (haven't verified, but 98ish % of files
> are under 64K).
> 
> I wonder if this would be of any interest for those who enable
> CONFIG_BASE_SMALL?

Bah, wrong patch.

-- 
SUSE Labs, Novell Inc.

--------------090004090206030103030004
Content-Type: text/plain;
 name="radix-small.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="radix-small.patch"

This patch reduces radix tree node memory usage by about a factor of 4
on many small files (< 64K) scenarios, and results in perfect packing of
the index range into 32 and 64 bits. There are pointer traversal and
memory usage costs for large files with dense pagecache.

Index: linux-2.6/lib/radix-tree.c
===================================================================
--- linux-2.6.orig/lib/radix-tree.c
+++ linux-2.6/lib/radix-tree.c
@@ -33,7 +33,7 @@
 
 
 #ifdef __KERNEL__
-#define RADIX_TREE_MAP_SHIFT	6
+#define RADIX_TREE_MAP_SHIFT	(CONFIG_BASE_SMALL ? 4 : 6)
 #else
 #define RADIX_TREE_MAP_SHIFT	3	/* For more stressful testing */
 #endif

--------------090004090206030103030004--
Send instant messages to your online friends http://au.messenger.yahoo.com 
