Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbWBJVjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWBJVjA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 16:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWBJVjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 16:39:00 -0500
Received: from mail.tmr.com ([64.65.253.246]:59533 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S932207AbWBJVi7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 16:38:59 -0500
Message-ID: <43ED089B.7080508@tmr.com>
Date: Fri, 10 Feb 2006 16:41:47 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ram Gupta <ram.gupta5@gmail.com>,
       Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RSS Limit implementation issue
References: <728201270602091310r67a3f2dcq4788199f26a69528@mail.gmail.com>
In-Reply-To: <728201270602091310r67a3f2dcq4788199f26a69528@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram Gupta wrote:
> I am working to implement enforcing RSS limits of a process. I am
> planning to make a check for rss limit when setting up pte. If the
> limit is crossed I see couple of  different ways of handling .
> 
> 1. Kill the process . In this case there is no swapping problem.

Since the process has little or no control over that it seems 
impractical. And works the wrong way, when there is a ton of free memory 
the process would get a large rss and be killed, while on a loaded 
system it would run.
> 
> 2. Dont kill the process but dont allocate the memory & do yield as we
> do for init process. Modify the scheduler not to chose the process
> which has already allocated rss upto its limit. When rss usage
> fallsbelow its limit then the scheduler may chose it again to run.
> Here there is a scenario when no page of the process has been freed or
> swapped out because there were enough free pages? Then we need a way
> to reschedule the process by forcefully freeing some pages or need to
> kill the process.
> 
> I am looking forward for your comments & pros/cons of both approach &
> any other alternatives you might come up with.

First, someone did some work on this a few years ago, you might be able 
to find info looking a rmap posts for the mid 2.4 days.

Second, I think this limitation needs to be enforced only when free 
memory is below some trigger point, when candidates for reclaim would be 
drawn from processes over their rss target.

Finally, it would be good to be aggressive about cleaning dirty pages of 
a process of the target, so pages clould be reclaimed quickly. There are 
a lot of factors in that, useless disk activity being one possible side 
effect.


-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
