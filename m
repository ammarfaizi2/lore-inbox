Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261893AbUJZBZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbUJZBZn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 21:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbUJZBUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:20:42 -0400
Received: from zeus.kernel.org ([204.152.189.113]:4051 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261911AbUJZBSQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:18:16 -0400
Message-ID: <417D87BF.6060803@mvista.com>
Date: Mon, 25 Oct 2004 16:09:51 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@kvack.org>
CC: john stultz <johnstul@us.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel/timer.c: xtime lock missing
References: <20041021190312.GA30847@kvack.org> <1098390198.20778.226.camel@cog.beaverton.ibm.com> <20041021202904.GB30847@kvack.org>
In-Reply-To: <20041021202904.GB30847@kvack.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> On Thu, Oct 21, 2004 at 01:23:32PM -0700, john stultz wrote:
> 
>>Looking at the comment above that function, the xtime_lock should
>>already be held when executing that code. timer_interrupt() should be
>>the function which grabs the lock and calls do_timer_interrupt() then
>>do_timer() then update_times().
>>
>>Or am I missing something?
> 
> 
> No, you're right; I'm blind.  That is a very distant chain between where 
> the lock is acquired and where it matters, perhaps a few more comments 
> are in order.

If memory serves, there is a problem here in that the lock is taken in arch code 
and not all archs are taking it.  I think a check of the several arch time.c 
callers might be in order.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

