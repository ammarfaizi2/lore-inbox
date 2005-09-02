Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161045AbVIBVWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161045AbVIBVWB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 17:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161041AbVIBVWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 17:22:01 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:57250 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1161045AbVIBVWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 17:22:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=3woE2tmCiPdOybHMZdvpTZO3atesD+IjhrH+H6psIrzohHzAoRPEAv3OzYrKnn2Wqx9wTCPbIGAxs6++5zoinfpxYWTaI6Yh5lmGGhfLX/fKa5GeLOkdM+BZM+vb7WtX/WHkY6ZRqZi3IIBtrybqFzvgA+kRwyHzAlQm5QFm7lU=  ;
Message-ID: <4318C28A.5010000@yahoo.com.au>
Date: Sat, 03 Sep 2005 07:22:18 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Memory Management <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.13] lockless pagecache 2/7
References: <4317F071.1070403@yahoo.com.au> <4317F0F9.1080602@yahoo.com.au>	<4317F136.4040601@yahoo.com.au>	<1125666486.30867.11.camel@localhost.localdomain> <p73k6hzqk1w.fsf@verdi.suse.de>
In-Reply-To: <p73k6hzqk1w.fsf@verdi.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> 
>>On Gwe, 2005-09-02 at 16:29 +1000, Nick Piggin wrote:
>>
>>>2/7
>>>Implement atomic_cmpxchg for i386 and ppc64. Is there any
>>>architecture that won't be able to implement such an operation?
>>
>>i386, sun4c, ....
> 
> 
> Actually we have cmpxchg on i386 these days - we don't support
> any SMP i386s so it's just done non atomically.
>  

Yes, I guess that's what Alan must have meant.

This atomic_cmpxchg, unlike a "regular" cmpxchg, has the advantage
that the memory altered should always be going through the atomic_
accessors, and thus should be implementable with spinlocks.

See for example, arch/sparc/lib/atomic32.c

At least, that's what I'm hoping for.

> 
>>Yeah quite a few. I suspect most MIPS also would have a problem in this
>>area.
> 
> 
> cmpxchg can be done with LL/SC can't it? Any MIPS should have that.
> 

Yes, and indeed it does. However it also tests for "cpu_has_llsc",
but I suspect that SMP isn't supported on those CPUs without ll/sc,
and thus an atomic_cmpxchg could be emulated by disabling interrupts.

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
