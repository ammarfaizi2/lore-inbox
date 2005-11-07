Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbVKGA4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbVKGA4Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 19:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbVKGA4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 19:56:24 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:33714 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932395AbVKGA4X (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 6 Nov 2005 19:56:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=f/XbB3ca4Xfcm5mtwvuknDbcKpl+0mtz1trbyavTGgiR5R0O63E9k/hlxdPkzlZjSQz1lHWX7Nht99d+kWYZSkpT6Nygrh+S599fatot5/8XBk0uIKYS7DP8zCzewVrgs552GJ65qRyAeXoXeh/IBPxkPP6Mvf1rFtvxpMmSStM=  ;
Message-ID: <436EA6B2.3070807@yahoo.com.au>
Date: Mon, 07 Nov 2005 11:58:26 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Bob Picco <bob.picco@hp.com>
CC: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: [patch 7/14] mm: remove bad_range
References: <436DBAC3.7090902@yahoo.com.au> <436DBCBC.5000906@yahoo.com.au> <436DBCE2.4050502@yahoo.com.au> <436DBD11.8010600@yahoo.com.au> <436DBD31.8060801@yahoo.com.au> <436DBD82.2070500@yahoo.com.au> <436DBDA9.2040908@yahoo.com.au> <436DBDC8.5090308@yahoo.com.au> <20051106173732.GI28839@localhost.localdomain>
In-Reply-To: <20051106173732.GI28839@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Picco wrote:
> Nick Piggin wrote:	[Sun Nov 06 2005, 03:24:40AM EST]
> 
>>7/14
>>
>>-- 
>>SUSE Labs, Novell Inc.
>>
> 
> 
>>bad_range is supposed to be a temporary check. It would be a pity to throw
>>it out. Make it depend on CONFIG_DEBUG_VM instead.
>>
>>Index: linux-2.6/mm/page_alloc.c
>>===================================================================
>>--- linux-2.6.orig/mm/page_alloc.c
>>+++ linux-2.6/mm/page_alloc.c
>>@@ -78,6 +78,7 @@ int min_free_kbytes = 1024;
>> unsigned long __initdata nr_kernel_pages;
>> unsigned long __initdata nr_all_pages;
>> 
>>+#ifdef CONFIG_DEBUG_VM
>> static int page_outside_zone_boundaries(struct zone *zone, struct page *page)
>> {
>> 	int ret = 0;
>>@@ -119,6 +120,13 @@ static int bad_range(struct zone *zone, 
>> 	return 0;
>> }
>> 
>>+#else
>>+static inline int bad_range(struct zone *zone, struct page *page)
>>+{
>>+	return 0;
>>+}
>>+#endif
>>+
>> static void bad_page(const char *function, struct page *page)
>> {
>> 	printk(KERN_EMERG "Bad page state at %s (in process '%s', page %p)\n",
>>Index: linux-2.6/lib/Kconfig.debug
>>===================================================================
>>--- linux-2.6.orig/lib/Kconfig.debug
>>+++ linux-2.6/lib/Kconfig.debug
>>@@ -172,7 +172,8 @@ config DEBUG_VM
>> 	bool "Debug VM"
>> 	depends on DEBUG_KERNEL
>> 	help
>>-	  Enable this to debug the virtual-memory system.
>>+	  Enable this to turn on extended checks in the virtual-memory system
>>+          that may impact performance.
>> 
>> 	  If unsure, say N.
>> 
> 
> Nick,
> 
> I don't think you can do it this way. On ia64 VIRTUAL_MEM_MAP depends on 
> CONFIG_HOLES_IN_ZONE and the check within bad_range for pfn_valid. Holes in
> memory (MMIO and etc.) won't have a page structure.
> 

Hmm, right - in __free_pages_bulk.

Could we make a different call here, or is the full array of bad_range
checks required?

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
