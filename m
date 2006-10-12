Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161377AbWJLFyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161377AbWJLFyK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 01:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161409AbWJLFyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 01:54:10 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:32920 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161377AbWJLFyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 01:54:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=u4szTjj5SwTXMuW3HBENvcpqngr0Az0IHTeZGxazKp+x24CDOuSOAPoW1CtIweBRUW3JILBqriKf1cAO5fOm7fVmW2rwgSpkuJfKw7crfAUqHOizEOG5iI7kcTo8J3bSu7eWPwRcrEBmOi+dGHXwG+dxLO/4eXqfq6Wx9RWB/MU=  ;
Message-ID: <452DD88E.4030707@yahoo.com.au>
Date: Thu, 12 Oct 2006 15:54:22 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Amol Lad <amol@verismonetworks.com>,
       linux kernel <linux-kernel@vger.kernel.org>,
       kernel Janitors <kernel-janitors@lists.osdl.org>
Subject: Re: [PATCH] drivers/mmc/mmc.c: Replacing yield() with a better	alternative
References: <1160570743.19143.307.camel@amol.verismonetworks.com> <1160571491.3000.372.camel@laptopd505.fenrus.org>
In-Reply-To: <1160571491.3000.372.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Wed, 2006-10-11 at 18:15 +0530, Amol Lad wrote:
> 
>>In 2.6, the semantics of calling yield() changed from "sleep for a
>>bit" to "I really don't want to run for a while".  This matches POSIX
>>better, but there's a lot of drivers still using yield() when they mean
>>cond_resched(), schedule() or even schedule_timeout().
>>
>>For this driver cond_resched() seems to be a better
>>alternative
>>
> 
> 
> are you sure?
> 
> 
>>Tested compile only
>>
>>Signed-off-by: Amol Lad <amol@verismonetworks.com>
>>---
>>diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/drivers/mmc/mmc.c linux-2.6.19-rc1/drivers/mmc/mmc.c
>>--- linux-2.6.19-rc1-orig/drivers/mmc/mmc.c	2006-10-05 14:00:46.000000000 +0530
>>+++ linux-2.6.19-rc1/drivers/mmc/mmc.c	2006-10-11 17:57:02.000000000 +0530
>>@@ -454,7 +454,7 @@ static void mmc_deselect_cards(struct mm
>> static inline void mmc_delay(unsigned int ms)
>> {
>> 	if (ms < HZ / 1000) {
>>-		yield();
>>+		cond_resched();
>> 		mdelay(ms);
> 
> 
> 
> this probably wants msleep(), especially with hrtimers comming up; there
> the sleeps are always exact...

The condition looks broken too. It should be
if (ms < 1000 / HZ) {...}

Shouldn't it?
-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
