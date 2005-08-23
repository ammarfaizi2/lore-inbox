Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbVHWRir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbVHWRir (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 13:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbVHWRir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 13:38:47 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:41336 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932211AbVHWRiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 13:38:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=YZlFD19LMAmB0/YqG90Y5Xf60xZn72rViPbejhdBKZ8rfhpcue52Da0KJgO3uRCt61pcEnHdVrtwHZeIf6MvCt7mm7n6VsL25N67V5wGkNGcW7EdCiKf9cVm9FrtX5ncomsI3smA0D002Pj0c9+iFCzyCO04LrvgS+DIfcXPE0A=  ;
Message-ID: <430B3A54.7080501@yahoo.com.au>
Date: Wed, 24 Aug 2005 01:01:40 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: jasonuhl@sgi.com, tony.luck@intel.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PRINTK_TIME woes
References: <200508221742.j7MHgMJI020020@agluck-lia64.sc.intel.com>	<20050822.132052.65406121.davem@davemloft.net>	<20050822203306.GA897956@dragonfly.engr.sgi.com> <20050822.134226.35468933.davem@davemloft.net>
In-Reply-To: <20050822.134226.35468933.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

> This is a useful feature, please do not labotomize it just because
> it's difficult to implement on ia64.  Just make a
> "printk_get_timestamp_because_ia64_sucks()" interface or something
> like that :-)

I was a bit unclear when I raised this issue. It is not just an
ia64 problem.

The sched_clock() interface is allowed to return wildly different
values depending on which CPU it is called from, and currently
has fundamental problems at least on i386 where it can go fowards
and backwards arbitrary amounts of time (due to frequency scaling,
if I understand correctly), and also needn't be exactly nanoseconds
at the best of times.

The interface is like this so it can be per-cpu and lockless and
as fast as possible for the scheduler heuristics (which aren't too
picky).

I just don't want its usage spreading outside kernel/sched.c if we
can help it. Pragmatically it sounds like the best thing we have
for printk at this time, however I hope we can come up with
something slightly more appropriate even if it ends up being slower.

Send instant messages to your online friends http://au.messenger.yahoo.com 
