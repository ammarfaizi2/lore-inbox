Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030581AbVIPDMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030581AbVIPDMF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 23:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030582AbVIPDMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 23:12:05 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:40373 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030581AbVIPDME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 23:12:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=s3xETbpiLzZeP8wJdJ4PTzkMuBN4Gu9AND92JLQogC5zlNxASHFUkzvJbnkja5Zlrw190RJUsBjt1x2MBq+8j0DXeCtsSy0zcHpqMOtXA5+ZDZqY1KeWYMkyqBz3Q3qwD/9+dRfQw+fIGo5jKU9xCe6wDEehPNWjKOuXJGk2CNs=  ;
Message-ID: <432A3810.9070600@yahoo.com.au>
Date: Fri, 16 Sep 2005 13:12:16 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: alokkataria1@gmail.com
CC: Linux Memory Management <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: New lockless pagecache
References: <4317F071.1070403@yahoo.com.au> <4317F50B.6080005@yahoo.com.au> <35f686220509151250e598fda@mail.gmail.com>
In-Reply-To: <35f686220509151250e598fda@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alok kataria wrote:
> Hi Nick,
> 
> I have collected performance numbers for the lock less page cache
> patch on the AIM - IO test.
> The performance numbers are collected for 1-100 tasks 1-50 tasks and
> 90-100 tasks  both for with and without your patch. This was done on
> 2.6.13 kernel.
> There's definite improvement when the tasks are small i.e ~50-70. But
> when the tasks go beyond 80, we see a large performance dip.
> I again profiled the 90-100 runs with spinlock's inlined, but couldn't
> understand the reason behind the performance difference.
> 
> Please find attached the performance numbers as well as the oprofile logs.
> 

Hi Alok,

Thanks very much for doing these numbers. Performance is improved
significantly at smaller numbers of tasks, as you say.

Unfortunately I can't pinpoint the reason why performance drops at
larger numbers. I could assume that the last remaining place that
used read_lock_irq for the tree_lock (wait_on_page_writeback_range)
got hurt when switching to spinlocks, but that would seem vary
unlikely.

I'll have to look into it further.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
