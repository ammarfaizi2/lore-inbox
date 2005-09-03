Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161031AbVICBkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161031AbVICBkj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 21:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161074AbVICBki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 21:40:38 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:31608 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1161031AbVICBki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 21:40:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=h0Os0tBbw51AiT7QC3AHMD3Kpwxr+HMRB36at4Tqo00JjtXpQrlfm6a4gG3nlcTwpYQEMnewWpIP3hFX1iMvFsy20YCedeRZ6UcpQM2xfzdl1ItZRelQxE4UsdMPn5QQoPjXikYVYV5kJOKzQuodZhZ4sCYIS0HKQHaZ3WrdaTw=  ;
Message-ID: <4318FF2B.6000805@yahoo.com.au>
Date: Sat, 03 Sep 2005 11:40:59 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andi Kleen <ak@suse.de>, Linux Memory Management <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.13] lockless pagecache 2/7
References: <4317F071.1070403@yahoo.com.au> <4317F0F9.1080602@yahoo.com.au>	 <4317F136.4040601@yahoo.com.au>	 <1125666486.30867.11.camel@localhost.localdomain>	 <p73k6hzqk1w.fsf@verdi.suse.de>  <4318C28A.5010000@yahoo.com.au> <1125705471.30867.40.camel@localhost.localdomain>
In-Reply-To: <1125705471.30867.40.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>but I suspect that SMP isn't supported on those CPUs without ll/sc,
>>and thus an atomic_cmpxchg could be emulated by disabling interrupts.
> 
> 
> It's obviously emulatable on any platform - the question is at what
> cost. For x86 it probably isn't a big problem as there are very very few
> people who need to build for 386 any more and there is already a big
> penalty for such chips.
> 
> 

Thanks Alan, Dave, others.

We'll see how things go. I'm fairly sure that for my usage it will
be a win even if it is costly. It is replacing an atomic_inc_return,
and a read_lock/read_unlock pair.

But if it does one day get merged, and proves to be very costly on
some architectures then we'll need to be careful about where it gets
used.

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
