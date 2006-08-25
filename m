Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422837AbWHYEzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422837AbWHYEzb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 00:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161004AbWHYEzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 00:55:31 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:60257 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161003AbWHYEza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 00:55:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=D5cvi0dBQGSrlM+04dtr5ckt3pBfrKCcjy8Z9I43swR97Xo9YsuQdjVQxOKYqqthwRbVFdLgenhLxYEsm0RjRHHAj0FS6ADNCMFdHTmKUmK8WEe/BKNw01c5Alg0d1lqD71wh0kPtrbSUL8MO/IcvrPZPLRNQ0s3aNs0DbcTTa4=  ;
Message-ID: <44EE829C.10606@yahoo.com.au>
Date: Fri, 25 Aug 2006 14:54:52 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@linux.intel.com>
CC: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org,
       len.brown@intel.com, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFC] maximum latency tracking infrastructure
References: <1156441295.3014.75.camel@laptopd505.fenrus.org> <200608241408.03853.jbarnes@virtuousgeek.org> <44EE1801.3060805@linux.intel.com>
In-Reply-To: <44EE1801.3060805@linux.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> Jesse Barnes wrote:
> 
>> On Thursday, August 24, 2006 10:41 am, Arjan van de Ven wrote:
>>
>>> The reason for adding this infrastructure is that power management in
>>> the idle loop needs to make a tradeoff between latency and power
>>> savings (deeper power save modes have a longer latency to running code
>>> again).
>>
>>
>> What if a processor was already in a sleep state when a call to 
>> set_acceptable_latency() latency occurs? 
> 
> 
> there's nothing sane that can be done in that case; any wake up already 
> will cause the unwanted latency!
> A premature wakeup is only making it happen *now*, but now is as 
> inconvenient a time as any...
> (in fact it may be a worst case time scenario, say, an audio interrupt...)

Surely you would call set_acceptable_latency() *before* running such
operation that requires the given latency? And that set_acceptable_latency
would block the caller until all CPUs are set to wake within this latency.

That would be the API semantics I would expect, anyway.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
