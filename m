Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965102AbVHPFIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965102AbVHPFIk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 01:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965105AbVHPFIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 01:08:40 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:55044 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S965102AbVHPFIj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 01:08:39 -0400
Message-ID: <430174D5.20209@vmware.com>
Date: Mon, 15 Aug 2005 22:08:37 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
Cc: akpm@osdl.org, chrisl@vmware.com, hpa@zytor.com,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org, zwane@arm.linux.org.uk
Subject: Re: [PATCH 2/6] i386 virtualization - Remove some dead debugging
 code
References: <200508152259.j7FMx9qZ005312@zach-dev.vmware.com> <20050816043843.GT7762@shell0.pdx.osdl.net>
In-Reply-To: <20050816043843.GT7762@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Aug 2005 05:08:37.0750 (UTC) FILETIME=[8F582960:01C5A220]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:

>* zach@vmware.com (zach@vmware.com) wrote:
>  
>
>>This code is quite dead.  Release_thread is always guaranteed that the mm has
>>already been released, thus dead_task->mm will always be NULL.
>>
>>Signed-off-by: Zachary Amsden <zach@vmware.com>
>>Index: linux-2.6.13/arch/i386/kernel/process.c
>>===================================================================
>>--- linux-2.6.13.orig/arch/i386/kernel/process.c	2005-08-15 10:46:18.000000000 -0700
>>+++ linux-2.6.13/arch/i386/kernel/process.c	2005-08-15 10:48:51.000000000 -0700
>>@@ -421,17 +421,7 @@
>> 
>> void release_thread(struct task_struct *dead_task)
>> {
>>-	if (dead_task->mm) {
>>-		// temporary debugging check
>>-		if (dead_task->mm->context.size) {
>>-			printk("WARNING: dead process %8s still has LDT? <%p/%d>\n",
>>-					dead_task->comm,
>>-					dead_task->mm->context.ldt,
>>-					dead_task->mm->context.size);
>>-			BUG();
>>-		}
>>-	}
>>-
>>+	BUG_ON(dead_task->mm);
>>    
>>
>
>This BUG_ON() has different semantics than old dead one.  Is there a
>point?  exit_mm() has already reset this to NULL, no?
>  
>

Yes, completely.  This BUG() could be eliminated entirely, as trivial 
inspection shows.  I can't fathom a single reason why it should still 
exist, but the presence of it in the first place made be wonder if there 
may be some erudite reason for it.  Thus I raised the BUG to a higher 
power - obviously the LDT is gone if the MM is gone.

Zach
