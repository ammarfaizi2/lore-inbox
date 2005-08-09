Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750943AbVHIFAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbVHIFAH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 01:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbVHIFAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 01:00:07 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:31604 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750941AbVHIFAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 01:00:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=yW9j4v/ftXjUDtalcv9p2r0NipSdd4X4Rixrq4i1ECuNqHQYCEqnhhuRKgcXOr2VpbVL6VAxRJtFYq1RKQ6D1mKO7MRJG5FJkFkL4qV4l47g3QxGRN5ThD/YiWsfeWhl+lNI8mc9k0a7DBgJmjH8L8mGlbMaHwxSjVzLRRSSMd4=  ;
Message-ID: <42F83849.9090107@yahoo.com.au>
Date: Tue, 09 Aug 2005 14:59:53 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: ncunningham@cyclades.com
CC: Daniel Phillips <phillips@arcor.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
References: <42F57FCA.9040805@yahoo.com.au>	 <200508090710.00637.phillips@arcor.de> <1123562392.4370.112.camel@localhost>
In-Reply-To: <1123562392.4370.112.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:
> Hi.
> 
> On Tue, 2005-08-09 at 07:09, Daniel Phillips wrote:
> 
>>>It doesn't look like they'll be able to easily free up a page
>>>flag for 2 reasons. First, PageReserved will probably be kept
>>>around for at least one release. Second, swsusp and some arch
>>>code (ioremap) wants to know about struct pages that don't point
>>>to valid RAM - currently they use PageReserved, but we'll probably
>>>just introduce a PageValidRAM or something when PageReserved goes.
> 
> 
> Changing the e820 code so it sets PageNosave instead of PageReserved,
> along with a couple of modifications in swsusp itself should get rid of
> the swsusp dependency.
> 

That would work for swsusp, but there are other users that want to
know if a struct page is valid ram (eg. ioremap), so in that case
swsusp would not be able to mess with the flag.

I do think swsusp should (and can, quite easily though I may have
missed something) consolidate PG_nosave and PG_nosave_free, however
that's out of the scope of this patch.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
