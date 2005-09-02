Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161059AbVIBVni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161059AbVIBVni (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 17:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161060AbVIBVnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 17:43:37 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:28802 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1161059AbVIBVnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 17:43:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Bh8+IEoJIQLQ/kG0RiPmr1VPosTBGQuScKTDjp7hZBOtXxinzHCSPJASOA9WV//e/q6TcMH7hG/PNHNv0bJfFNauBs7+/CEljtK2U4RRTPC5zY4Xo1+XPsmrN6zfgY3B4NtgtWEtyEGD8Ba2WwCrxEcaNgbvjOm00zZTQ+cuntQ=  ;
Message-ID: <4318C79D.1050000@yahoo.com.au>
Date: Sat, 03 Sep 2005 07:43:57 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13] lockless pagecache 2/7
References: <4317F136.4040601@yahoo.com.au>	<1125666486.30867.11.camel@localhost.localdomain>	<p73k6hzqk1w.fsf@verdi.suse.de> <20050902.141255.50099210.davem@davemloft.net>
In-Reply-To: <20050902.141255.50099210.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bear with me Dave, I'll repeat myself a bit, for the benefit of lkml.


Andi Kleen wrote:
>>>Yeah quite a few. I suspect most MIPS also would have a problem in this
>>>area.
>>
>>cmpxchg can be done with LL/SC can't it? Any MIPS should have that.
> 
> 
> Right.
> 
> On PARISC, I don't see where they are emulating compare and swap
> as indicated.  They are doing the funny hashed spinlocks for the
> atomic_t operations and bitops, but that is entirely different.
> 

Yep, same as SPARC (at least, SPARC's 32-bit atomic_t).

> cmpxchg() has to operate in an environment where, unlike the atomic_t
> and bitops, you cannot control the accessors to the object at all.
> 
> The DRM is the only place in the kernel that requires cmpxchg()
> and you can thus make a list of what platform can provide cmpxchg()
> by which ones support DRM and thus provide the cmpxchg() macro already
> in asm/system.h
> 
> We really can't require support for this primitive kernel wide, it's
> simply not possible on a couple chips.

Not a generic cmpxchg, no. However, I _believe_ that those
architectures that are missing something like ll/sc or real
atomic cmpxchg should still be able to implement an
"atomic_cmpxchg" on their atomic type.

Sorry if I wasn't at all clear initially. What I'd be interested
in is an architecture that doesn't support ll/sc or real cmpxchg
*and* does not implement atomic_t operations with locks.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
