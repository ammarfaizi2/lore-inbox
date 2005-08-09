Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932483AbVHIJ3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbVHIJ3m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 05:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbVHIJ3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 05:29:41 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:30848 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932483AbVHIJ3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 05:29:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=D2a1bNH3dwS047/gFuCLeENgJJZ0hWzjlVv9ZySkT5XCf5BaD/dG845nUvRnL8hXlF3HoRrBxVtW04s1OoWBs5xb6eXNWInMPZnro1i3DxaRRWANea9h1gan6BO3AxPxGoW/kQtWfBjas7ONCD42LDld1tOgA+1LHaM62VlIUzk=  ;
Message-ID: <42F8777A.2090609@yahoo.com.au>
Date: Tue, 09 Aug 2005 19:29:30 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: ncunningham@cyclades.com, Daniel Phillips <phillips@arcor.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
References: <42F57FCA.9040805@yahoo.com.au> <200508090710.00637.phillips@arcor.de> <1123562392.4370.112.camel@localhost> <42F83849.9090107@yahoo.com.au> <20050809080853.A25492@flint.arm.linux.org.uk>
In-Reply-To: <20050809080853.A25492@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Tue, Aug 09, 2005 at 02:59:53PM +1000, Nick Piggin wrote:
> 
>>That would work for swsusp, but there are other users that want to
>>know if a struct page is valid ram (eg. ioremap), so in that case
>>swsusp would not be able to mess with the flag.
> 
> 
> The usage of "valid ram" here is confusing - that's not what PageReserved
> is all about.  It's about valid RAM which is managed by method other
> than the usual page counting.  Non-reserved RAM is also valid RAM, but
> is managed by the kernel in the usual way.
> 

Well that is one usage of the PageReserved flag. That one tends
to be easily covered by VM_RESERVED (ie. it is no longer used that
way after the patches).

The remaining problem is, in fact, these "other" uses of PageReserved.
One usage definitely appears to be "is this page valid RAM?".

> The former is available for remap_pfn_range and ioremap, the latter is
> not.
> 

I thought ioremap was attempting to avoid remapping physical
RAM with that check. All drivers I have looked at which allocate
physical memory then SetPageReserved the pages use remap_pfn_range
but I admit that's not a huge number (that I have looked at).

> On the other hand, the validity of an apparant RAM address can only be
> tested using its pfn with pfn_valid().
> 

I'm fairly sure that's not the case on i386 at least. I think
pfn_valid will be true if the pfn points to a struct page.
See arch/i386/mm/init.c:one_highpage_init()

> Can we straighten out the terminology so it's less confusing please?
> 

That's what I'm aiming for. I admit it is confusing and I haven't
looked at all drivers or architectures, so if I'm missing a vital
clue then I wouldn't be too surprised ;)

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
