Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932944AbWFWIls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932944AbWFWIls (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 04:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932945AbWFWIls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 04:41:48 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:46218 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932944AbWFWIlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 04:41:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=C06cu6K5LD5ixxa0zV1OJFDqHWIfF94eFKmK3IEVa7di7blS0MpgHg/WBHa+rctY1QrVxkWFFctjZS73KQphxeSKmWo872my6Db1FiPha12aQ9dviiuGvz1kXpUuFI4kVqCOhTrzTNv5oXpVAv8JTvRofOZqv1Afalzme1kEOgM=  ;
Message-ID: <449BA94A.4030603@yahoo.com.au>
Date: Fri, 23 Jun 2006 18:41:46 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Nick Piggin <npiggin@suse.de>, paulmck@us.ibm.com,
       benh@kernel.crashing.org, Paul.McKenney@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch 3/3] radix-tree: RCU lockless readside
References: <20060408134635.22479.79269.sendpatchset@linux.site>	<20060408134707.22479.33814.sendpatchset@linux.site>	<20060622014949.GA2202@us.ibm.com>	<20060622154518.GA23109@wotan.suse.de>	<20060622163032.GC1295@us.ibm.com>	<20060622165551.GB23109@wotan.suse.de>	<20060622174057.GF1295@us.ibm.com>	<20060622181111.GD23109@wotan.suse.de> <20060623000901.bf8b46c5.akpm@osdl.org> <449BA8BB.3070402@yahoo.com.au>
In-Reply-To: <449BA8BB.3070402@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------060302010002000807020202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060302010002000807020202
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Nick Piggin wrote:

>>          shift -= RADIX_TREE_MAP_SHIFT;
>> -        slot = slot->slots[i];
>> +        slot = rcu_dereference(slot->slots[i]);
>> +        if (slot == NULL);
>> +            break;
>>      }
> 
> 
>                          ^^^^^^^^
> 
> Up there.
> 

And here's the patch.

-- 
SUSE Labs, Novell Inc.

--------------060302010002000807020202
Content-Type: text/plain;
 name="radix-tree-paul-review-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="radix-tree-paul-review-fix.patch"

Index: linux-2.6/lib/radix-tree.c
===================================================================
--- linux-2.6.orig/lib/radix-tree.c
+++ linux-2.6/lib/radix-tree.c
@@ -752,7 +752,7 @@ __lookup_tag(struct radix_tree_node *slo
 		}
 		shift -= RADIX_TREE_MAP_SHIFT;
 		slot = rcu_dereference(slot->slots[i]);
-		if (slot == NULL);
+		if (slot == NULL)
 			break;
 	}
 out:

--------------060302010002000807020202--
Send instant messages to your online friends http://au.messenger.yahoo.com 
