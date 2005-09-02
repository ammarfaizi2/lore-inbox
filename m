Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161068AbVIBVrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161068AbVIBVrW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 17:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161072AbVIBVrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 17:47:22 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:40634 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1161068AbVIBVrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 17:47:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=JDpz2Nc5WSsVeJTaZ/epY+6SS+W2XXMwCoyueIwQ7l4jwxegqBh8kTjAkO1NFcGYC2RM1SrPQUOINcL/+bMqdd1QH8UjgAAhI9hJ2VWUwXTvPmbKKKcEPDyOhap1WHtyofj7PLQrIV4Y66zzsSchKz3+GLcX1c9nvlHo3xhgKi0=  ;
Message-ID: <4318C884.3050607@yahoo.com.au>
Date: Sat, 03 Sep 2005 07:47:48 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: ak@suse.de, alan@lxorguk.ukuu.org.uk, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13] lockless pagecache 2/7
References: <1125666486.30867.11.camel@localhost.localdomain>	<p73k6hzqk1w.fsf@verdi.suse.de>	<4318C28A.5010000@yahoo.com.au> <20050902.143149.08652495.davem@davemloft.net>
In-Reply-To: <20050902.143149.08652495.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> From: Nick Piggin <nickpiggin@yahoo.com.au>
> Date: Sat, 03 Sep 2005 07:22:18 +1000
> 
> 
>>This atomic_cmpxchg, unlike a "regular" cmpxchg, has the advantage
>>that the memory altered should always be going through the atomic_
>>accessors, and thus should be implementable with spinlocks.
>>
>>See for example, arch/sparc/lib/atomic32.c
>>
>>At least, that's what I'm hoping for.
> 
> 
> Ok, as long as the rule is that all accesses have to go
> through accessor macros, it would work.  This is not true
> for existing uses of cmpxchg() btw, userland accesses shared
> locks with the kernel would using any kind of accessors we
> can control.
> 
> This means that your atomic_cmpxchg() cannot be used for locking
> objects shared with userland, as DRM wants, since the hashed spinlock
> trick does not work in such a case.
> 

So neither could currently supported atomic_t ops be shared with
userland accesses?

Then I think it would not be breaking any interface rule to do an
atomic_t atomic_cmpxchg either. Definitely for my usage it will
not be shared with userland.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
