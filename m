Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbWCRCqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbWCRCqi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 21:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932854AbWCRCqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 21:46:38 -0500
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:42624 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751011AbWCRCqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 21:46:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Wbsgr4cduPA3gXjd3dfJ29rFyrwhct1MoVmTWKQsHqoEX1EzuOsX/4qDP/mkb81AtohQAqFscsaiRS43HETtFKuJxsdnUCOWx4wibSFoJ3vfjm/ndYRLQlqDxZIWQWw4/UIY3RcqGHTmzxRxyl6WO/mezVhoVqnMoVL3HcrukLk=  ;
Message-ID: <441B7489.1090403@yahoo.com.au>
Date: Sat, 18 Mar 2006 13:46:33 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: steiner@sgi.com, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] - Reduce overhead of calc_load
References: <20060317145709.GA4296@sgi.com>	<20060317145912.GA13207@elte.hu>	<20060317152611.GA4449@sgi.com>	<20060317171538.3826eb41.akpm@osdl.org>	<441B6BD3.2030807@yahoo.com.au> <20060317183742.10431ba2.akpm@osdl.org>
In-Reply-To: <20060317183742.10431ba2.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:

>>Is there a need? Do they (except calc_load) use multiple values at
>>the same time?
> 
> 
> Don't know.  It might happen in the future.  And the additional cost is
> practically zero.
> 

Unless it happens to hit another cacheline (cachelines for all other
CPUs but our own will most likely be invalid on this cpu). In which
case the cost could double quite easily.

> 
>>>And then give get_sched_stuff() a hotplug handler (probably unneeded) and
>>
>>What would the hotplug handler do?
> 
> 
> Move the stats from the going-away CPU into the current CPU's runqueue.
> 

Oh, that. Yeah that is handled already for nr_uninterruptible (although,
ironically, it isn't needed because of the for_each_cpu loop there!)

>>I think it need only iterate over possible CPUs.
> 
> 
> Someone who has four online CPUs, sixteen present CPUs and 128 possible
> CPUs would be justifiably disappointed, no?
> 

Yes. Ingo? This can be changed, right?

> 
>>>IOW: this code's an inefficient mess and needs some caring for.
>>
>>What are the performance critical places that call the nr_blah() functions?
>>
> 
> 
> That depends upon the frequency with which userspace reads /proc/loadavg,
> /proc/stat or /proc/future-stuff.
> 
> 

I think it might be better to leave it for the moment. If something comes
up we can always take a look at it then (it isn't particularly tricky code).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
