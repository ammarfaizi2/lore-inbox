Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750845AbWAQEY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbWAQEY2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 23:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWAQEY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 23:24:28 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:53604 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750834AbWAQEY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 23:24:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=SFw3vHf6Kuv2tWEK5LagiW75AnMGa7wEgDRhP6phqVLrDuypj0+x7NeoMvZTZSujM0/vE07LtE1fgt3a7FrMo5vKGKp9nOo/++QzwJI0dtOckmjsOs4SVxh4YlyFa4tW3uRt7q8ybmpI/IsyyGQo4ArIbeMsh3Ym+6AOQWuKcMM=  ;
Message-ID: <43CC7169.6030301@yahoo.com.au>
Date: Tue, 17 Jan 2006 15:24:09 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Diego Calleja <diegocg@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops with current linus' git tree
References: <20060116191556.bd3f551c.diegocg@gmail.com> <43CC7094.9040404@yahoo.com.au>
In-Reply-To: <43CC7094.9040404@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------080408030703090808040408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080408030703090808040408
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Nick Piggin wrote:
> Diego Calleja wrote:
> 
>> I'm having two noticeable problems with the current linus' tree
>>
>> 1) Oops while watching a DVD with kaffeine (kde based video player),
>>    oops pasted below.
>>
> 
>  From your oops it looks as though the radix_tree_lookup in find_get_page
> has returned 0x40. It could be a flipped bit - is your memory OK?
> 
> Can you apply the attached patch and try to reproduce the oops?
> 

Really attached now.

-- 
SUSE Labs, Novell Inc.


--------------080408030703090808040408
Content-Type: text/plain;
 name="radix-tree-debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="radix-tree-debug.patch"

Index: linux-2.6/lib/radix-tree.c
===================================================================
--- linux-2.6.orig/lib/radix-tree.c	2006-01-03 19:05:57.000000000 +1100
+++ linux-2.6/lib/radix-tree.c	2006-01-17 15:17:36.000000000 +1100
@@ -233,6 +233,8 @@ int radix_tree_insert(struct radix_tree_
 	int offset;
 	int error;
 
+	BUG_ON((unsigned long)item < PAGE_OFFSET);
+
 	/* Make sure the tree is high enough.  */
 	if ((!index && !root->rnode) ||
 			index > radix_tree_maxindex(root->height)) {
@@ -334,6 +336,8 @@ void *radix_tree_lookup(struct radix_tre
 	void **slot;
 
 	slot = __lookup_slot(root, index);
+	if (slot && *slot)
+		BUG_ON((unsigned long)(*slot) < PAGE_OFFSET);
 	return slot != NULL ? *slot : NULL;
 }
 EXPORT_SYMBOL(radix_tree_lookup);

--------------080408030703090808040408--
Send instant messages to your online friends http://au.messenger.yahoo.com 
