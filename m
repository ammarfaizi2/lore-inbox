Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbWDVT5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWDVT5F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWDVT5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:57:05 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:39109 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751109AbWDVT5D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:57:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=3AJdI86zfq6BK+xMOh+9ZLg8rHcj/QfnB75cxK9Tw8Gg7hIrIaQHvF65XDor+xkWTOWiO19YcME1+1D5FPVu5F2JCT7aJNMecHujUZ/62DqTwe8zLqwyGVl5BG1h/BnjIDb+3EL51bV4yuCl2JTPkZpVdKAOUySIt2Vt/JCXwz0=  ;
Message-ID: <4449AC79.2010509@yahoo.com.au>
Date: Sat, 22 Apr 2006 14:09:29 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: markh@compro.net
CC: dmarkh@cfl.rr.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: get_user_pages ?
References: <44475DBA.7020308@cfl.rr.com> <44477585.4030508@yahoo.com.au> <4447E6C4.9070207@compro.net> <4447E86E.9000507@yahoo.com.au> <4448D047.8070202@compro.net>
In-Reply-To: <4448D047.8070202@compro.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hounschell wrote:

>>OK, I'd suggest either using vm_insert_page, or converting it all over
>>to a ->nopage handler then.
>>
> 
> 
> I set the bit back on after get_user_pages and now I seem to be OK.
> 
> You've looked at the code some obviously. What is in my future WRT these
> changes being made that you referenced above and the depreciation of
> some of the calls in use. Given my situation, do you foresee anything
> that will keep me from being able to get valid bus addresses for my pte?

Well remap_pfn_range / io_remap_pfn_range is a good option, but it
shouldn't really support get_user_pages so I suspect you are just
lucky there (ie. on some platforms you might not have a struct page
for your bus address, and other times the final put_page will try
to free the page).

If you definitely have struct pages, vm_insert_page is an option,
unless the memory is allocated with dma_alloc_* or similar, in
which case you should probably be using remap_pfn_range.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
