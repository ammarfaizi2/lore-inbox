Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932534AbVHINP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbVHINP6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 09:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVHINP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 09:15:58 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:28289 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932534AbVHINP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 09:15:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Ljgl5fzCu4LI1udc+ZWK3Tz2rvjNGLxU2J+Y2pwmj1ohcw1WlRj0l7dl551LdrUDyvgYx+ChcI+LAWVUojdq2hFMoLdGPwcTVSURD5FLVdqHWy6U11LgW6XhRLl7faMnjQMJUBZcDdTyDxdi7nHJ3JTGSCCnyKiPVkt+xniLg1o=  ;
Message-ID: <42F8AC87.5060403@yahoo.com.au>
Date: Tue, 09 Aug 2005 23:15:51 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Russell King <rmk+lkml@arm.linux.org.uk>, ncunningham@cyclades.com,
       Daniel Phillips <phillips@arcor.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
References: <42F57FCA.9040805@yahoo.com.au> <200508090710.00637.phillips@arcor.de> <1123562392.4370.112.camel@localhost> <42F83849.9090107@yahoo.com.au> <20050809080853.A25492@flint.arm.linux.org.uk> <Pine.LNX.4.61.0508091012480.10693@goblin.wat.veritas.com> <42F88514.9080104@yahoo.com.au> <Pine.LNX.4.61.0508091145570.11660@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0508091145570.11660@goblin.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Tue, 9 Aug 2005, Nick Piggin wrote:

>>But in either case: I agree that it is probably not a great loss
>>to remove the check, although considering it will be needed for
>>swsusp anyway...
> 
> 
> swsusp (and I think crashdump has a similar need) is a very different
> case: it's approaching memory from the zone/mem_map end, with no(?) idea
> of how the different pages are used: needs to save all the info while
> avoiding those areas which would give trouble.  I can well imagine it
> needs either a page flag or a table lookup to decide that.
> 

Yep.

> But ioremap and remap_pfn_range are coming from drivers which (we hope)
> know what they're mapping these particular areas for.  If it's provable
> that the meaning which swsusp needs is equally usable for a little sanity
> check in ioremap, okay, but I'm sceptical.
> 

I understand what you mean, and I agree. Though as far away from the
business end of the drivers I am, I tend to get the feeling that
drivers need the most hand holding.

Anyway, I guess the way to understand the problem is finding the
reason why ioremap checks PageReserved, and whether or not ioremap
should be expected (or allowed) to remap physical RAM in use by
the kernel.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
