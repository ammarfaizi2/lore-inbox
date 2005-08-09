Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932508AbVHIK1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbVHIK1n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 06:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbVHIK1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 06:27:43 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:938 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932508AbVHIK1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 06:27:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ej7c8pPjLYQjkxaAUswm39uvi4Wr/f/LwShfvk9ileOjggr17x7170TuSU/t4cqet6KuvGD6BZfQzBwxQNx7seqmtajKQro3EgwmEsFAEQ3QEfMnDO/kqZ5BukSDyX9MXPKhEmd86stO/duNOB4xGHgRgh31WRaT8t0A87CVP18=  ;
Message-ID: <42F88514.9080104@yahoo.com.au>
Date: Tue, 09 Aug 2005 20:27:32 +1000
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
References: <42F57FCA.9040805@yahoo.com.au> <200508090710.00637.phillips@arcor.de> <1123562392.4370.112.camel@localhost> <42F83849.9090107@yahoo.com.au> <20050809080853.A25492@flint.arm.linux.org.uk> <Pine.LNX.4.61.0508091012480.10693@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0508091012480.10693@goblin.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:

> 
> You're right (though I imagine might sometimes be holes rather than RAM).
> 

Yep. These holes are what I have in mind, and random other things
like the !(bad_ppro && page_kills_ppro(pfn)) check.

[...]

> I think Nick is treating the "use" of PageReserved in ioremap much too
> reverentially.  Fine to leave its removal from there to a later stage,
> but why shouldn't that also be removed?
> 

Well, as far as I had been able to gather, ioremap is trying to
ensure it does indeed only hit one of these holes, and not valid
RAM. I thought the fact that it *won't* bail out when encountering
kernel text or remap_pfn_range'ed pages was only due to PG_reserved
being the proverbial jack of all trades, master of none.

I could be wrong here though.

But in either case: I agree that it is probably not a great loss
to remove the check, although considering it will be needed for
swsusp anyway...

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
