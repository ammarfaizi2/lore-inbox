Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbWCQOGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbWCQOGr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 09:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932741AbWCQOGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 09:06:47 -0500
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:52899 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932745AbWCQOGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 09:06:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=3VhWslxHI71v58MiK/J86A2sXcJtSCp52awASn35N+GVOm3Y4eH0A3/XHPE1S2gGkPBXnnHQbLXyKQs9gStA98YIybqPXC+bEOoCn9axmTuN04QEFiHEVfSeuVt4Z5+ykkPGGqqle6dnHZROLVu4PWpSDA1L30q7TqmVqMy2GKI=  ;
Message-ID: <441AC25E.1050504@yahoo.com.au>
Date: Sat, 18 Mar 2006 01:06:22 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
CC: Con Kolivas <kernel@kolivas.org>, ck@vds.kolivas.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [ck] Re: [PATCH] sched: activate SCHED BATCH expired
References: <200603081013.44678.kernel@kolivas.org> <200603172338.10107.kernel@kolivas.org> <441AB8FA.10609@yahoo.com.au> <200603180036.11326.kernel@kolivas.org> <20060317134740.GA7121@rhlx01.fht-esslingen.de>
In-Reply-To: <20060317134740.GA7121@rhlx01.fht-esslingen.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Mohr wrote:
> Hi,
> 
> On Sat, Mar 18, 2006 at 12:36:10AM +1100, Con Kolivas wrote:
> 
>>I'm not attached to the style, just the feature. If you think it's warranted 
>>I'll change it.
> 
> 
> Seconded.
> 
> An even nicer way (this solution seems somewhat asymmetric) than
> 
>    prio_array_t *target = rq->active;
>    if (batch_task(p))
>      target = rq->expired;
>    enqueue_task(p, target);
> 
> may be
> 
>    prio_array_t *target;
>    if (batch_task(p))
>      target = rq->expired;
>    else
>      target = rq->active;
>    enqueue_task(p, target);
> 

It doesn't actually generate the same code here (I guess it is good
that gcc gives us this control).

I think my way is (ever so slightly) better because it gets the load
going earlier and comprises one less conditional jump (admittedly in
the slowpath). You'd probably never be able to measure a difference
between any of the variants, however ;)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
