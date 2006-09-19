Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbWISSzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbWISSzb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 14:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751933AbWISSza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 14:55:30 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:8593 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751009AbWISSza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 14:55:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=j4mOjZtJLfx6qNNzDvhh6h/is4TfzyNOFE4ObCzz986ww2xyxebb+GeJiH4193JTB/LaJMLrKO5ZSgPkoVADKxAorLnpOs+PiXvusxR7YxJ56l5tL9FR5Z0WlDKiFDwGkzRvlSKNf5X2Qa9LNv+hI56LEZT0aWWJSxj8yXf7814=  ;
Message-ID: <45103D1D.20702@yahoo.com.au>
Date: Wed, 20 Sep 2006 04:55:25 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Willy Tarreau <w@1wt.eu>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: Linux 2.4.34-pre3
References: <20060919173253.GA25470@hera.kernel.org> <45102BEE.9000501@yahoo.com.au> <20060919181738.GA3467@1wt.eu>
In-Reply-To: <20060919181738.GA3467@1wt.eu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> Hi Nick,
> 
> On Wed, Sep 20, 2006 at 03:42:06AM +1000, Nick Piggin wrote:
> 
> [cut -pre3 advertisement]
> 
> 
>>I wonder if 2.4 doesn't need the memory ordering fix to prevent pagecache
>>corruption in reclaim? (http://www.gatago.com/linux/kernel/14682626.html)
>>
>>What would need to be done is to test page_count before testing PageDirty,
>>and putting an smp_rmb between the two.
> 
> 
> I've read the thread, and Linus proposed to add an smp_wmb() in
> set_page_dirty() too.

I think that isn't needed because put_page is a RMW, which is defined
to order memory. And presumably you wouldn't set the page dirty without
a reference to the page.

> I see that an smp_rmb() is already present
> in shrink_cache() with the adequate comment.

So there is! My mistake then, I was confused and looking at
try_to_swap_out, but I see that doesn't actually free the page. Fine,
I think 2.4 is OK then.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
