Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbVHKMSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbVHKMSc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 08:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbVHKMSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 08:18:31 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:56159 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932379AbVHKMSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 08:18:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:Content-Type:Content-Transfer-Encoding;
  b=gfBzIdul3vKAuFiac6HRxXKEDPXfqoOhHIWndfIkljrKzM5QVxJ5l0pr8YVay6dVoFpHjxv6J0+OygsrICknczVY6LSzqQTWJBwVmbk3DZwBro2pgwYf8j76AnqFysxg4w+dwqS8IYXeP3TWd8pq2R2enft+Uqu3AjKLLHPVYlA=  ;
Message-ID: <42FB4201.7080304@yahoo.com.au>
Date: Thu, 11 Aug 2005 22:18:09 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul McKenney <paul.mckenney@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch 0/7] lockless pagecache 2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is my second attempt at a lockless pagecache.

Patches are against 2.6.13-rc6, and have had reasonable
stressing (albeit on small SMPs).

Main changes since last seen:
* Code clarity and commenting improvement.

* Fix race where multiple concurrent failed speculative
   reference takers could be confused into thinking a free
   page wasn't free, due to the elevated refcounts.

* Convert radix tree node freeing over to RCU. I completely
   missed this problem in my first attempt. (My first real
   RCU attempt - completely wrong?).

* page_cache_get_speculative previously used only preempt_
   disable to stop the current CPU from entering the page
   allocator. Needs to turn off interrupts too.

   Paul picked this bug up without seeing the code, just a
   vague description of what I was trying to do. All I
   picked up was my jaw from the ground ;)

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
