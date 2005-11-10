Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbVKJWdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbVKJWdk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 17:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbVKJWdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 17:33:40 -0500
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:62383 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932210AbVKJWdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 17:33:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=xA1VcOnxifUMT9bPN/WZ4rZUu6mJCce+udbm+2eY8RRacoaq1q2CJ38UxxBV2XlpG4VoSo5/n/JbN1ZoLTqKOKyJjNa8ZT2v6pMnSxmbxWYHBS5CQScC9geS8YL/pP3wNLJkThwVzxhsGNOI19SUldZs1wHZ6FVtr7yhq3p7K/c=  ;
Message-ID: <4373CB4C.6070602@yahoo.com.au>
Date: Fri, 11 Nov 2005 09:35:56 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] as-iosched: update alias handling
References: <20051110140859.GA26030@htj.dyndns.org> <20051110171743.GE3699@suse.de>
In-Reply-To: <20051110171743.GE3699@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Thu, Nov 10 2005, Tejun Heo wrote:
> 
>>Unlike other ioscheds, as-iosched handles alias by chaing them using
>>rq->queuelist.  As aliased requests are very rare in the first place,
>>this complicates merge/dispatch handling without meaningful
>>performance improvement.  This patch updates as-iosched to dump
>>aliased requests into dispatch queue as other ioscheds do.
>>
>>Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> 
> In theory the way 'as' handles the aliases is faster since we postpone
> pushing them to the dispatch list at the same point (and they have
> strong (if not identical) locality). But it is much simpler to just
> shove the offending requests onto the dispatch list.
> 
> It's really up to Nick - what do you think? Leaving patch below.
> 

I thought this was pretty cool, but in reality it could be that the
cost / benefit actually goes the wrong way due to added complexity
and rarity of alised requests.

Hmm... I can't bear to ack it ;) I'll close my eyes and let Jens
make the call!

> 
>>---
>>
>>Jens, I've tested this change for several hours, but it might be
>>better to postpone this change to next release.  It's your call.
>>

It could go into mm now, but probably leave it for 2.6.16 unless
you have some other reason to really need it.

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
