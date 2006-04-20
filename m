Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWDUFpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWDUFpT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 01:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWDUFpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 01:45:19 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:30820 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750724AbWDUFpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 01:45:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=kUli9+ow3lRZ0wQBAVA8f3jHSnvWOPqV7hD5IBTrKzY+1CLtacYLk7qrWdqLzQcWdIZJfzgFotTyi1LGB7CBh2w3FS3ev3piJNLgGGAVKNNW1iGlDZGAQFqDgYUgoBfuZX9QqCiVBa/KPkBNKKqlXyqwCb1fgw28U8OJq+92WI0=  ;
Message-ID: <4447E86E.9000507@yahoo.com.au>
Date: Fri, 21 Apr 2006 06:00:46 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: markh@compro.net
CC: dmarkh@cfl.rr.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: get_user_pages ?
References: <44475DBA.7020308@cfl.rr.com> <44477585.4030508@yahoo.com.au> <4447E6C4.9070207@compro.net>
In-Reply-To: <4447E6C4.9070207@compro.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hounschell wrote:
> Nick Piggin wrote:

>>This area is going through some changes lately. If you want something to
>>quickly get things working, removing VM_PFNMAP from your vma flags should
>>work.
>>
> 
> 
> Yes, that actually does work while the task is running but as soon as I
> exit the task the machine freezes.

Hmm. Does it freeze, or oops? (ie. were you in X and missed the oops)
Can you get a sysrq backtrace?

Oh, hmm you'll need to increment the refcount of each page before
mapping it. That's probably the problem.

OK, I'd suggest either using vm_insert_page, or converting it all over
to a ->nopage handler then.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
