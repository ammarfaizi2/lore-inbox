Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbVHKOH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbVHKOH2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 10:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbVHKOH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 10:07:28 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:27801 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750719AbVHKOH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 10:07:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=p8ton3+Ahl4X6evcHwiepHd3Ia0l5GP079mkQAKMBxFacDLmzHGPaBWEPxh8umBbikLczRdE6V/2cOqPyTuTBOtJFAWyVzAna37ty995VCYTa05rHxIWTezeB+vXieeXAT5am+wSifdhAQGWcVIqXGkFhlnOgHeP7jA/pCc2/B8=  ;
Message-ID: <42FB5B7F.3000307@yahoo.com.au>
Date: Fri, 12 Aug 2005 00:06:55 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Pekka Enberg <penberg@gmail.com>
CC: Paul McKenney <paul.mckenney@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 6/7] mm: lockless pagecache
References: <42FB4201.7080304@yahoo.com.au> <42FB42BD.6020808@yahoo.com.au>	 <42FB42EF.1040401@yahoo.com.au> <42FB4311.2070807@yahoo.com.au>	 <42FB43A8.8060902@yahoo.com.au> <42FB43CB.5080403@yahoo.com.au>	 <42FB4454.2010601@yahoo.com.au> <84144f0205081106586eb0d5cf@mail.gmail.com>
In-Reply-To: <84144f0205081106586eb0d5cf@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pekka,

Pekka Enberg wrote:
> Hi Nick,
> 
> On 8/11/05, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>+unsigned find_get_pages_nonatomic(struct address_space *mapping, pgoff_t start,
>>+                           unsigned int nr_pages, struct page **pages)
>>+{
>>+       unsigned int i;
>>+       unsigned int ret;
> 
> 
> Rename to nr_pages?
> 
> 
>>+       unsigned int ret2;
> 
> 
> Rename to ret?
> 
> 
>>+
>>+       /*
>>+        * We do some unsightly casting to use the array first for storing
>>+        * pointers to the page pointers, and then for the pointers to
>>+        * the pages themselves that the caller wants.
>>+        */
>>+       rcu_read_lock();
>>+       ret = radix_tree_gang_lookup_slot(&mapping->page_tree,
>>+                               (void ***)pages, start, nr_pages);
>>+       ret2 = 0;
>>+       for (i = 0; i < ret; i++) {
> 
> 
> Pretty please? :-)
> 

Hey that's not actually a bad idea.

I was thinking about how to make that function nicer,
but the voices in my head just kept telling me to rename
'i' to 'ret3' ;)

So, thanks!

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
