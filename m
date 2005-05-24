Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbVEXQDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVEXQDi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 12:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbVEXQAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 12:00:52 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:24996 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262156AbVEXQAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 12:00:05 -0400
Message-ID: <42934F80.9040001@yahoo.com.au>
Date: Wed, 25 May 2005 02:00:00 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] remove set_tsk_need_resched() from init_idle()
References: <20050524121541.GA17049@elte.hu> <20050524140623.GA3500@elte.hu> <4293420C.8080400@yahoo.com.au> <20050524150537.GA11829@elte.hu> <42934748.8020501@yahoo.com.au> <20050524152759.GA15411@elte.hu> <20050524154230.GA17814@elte.hu>
In-Reply-To: <20050524154230.GA17814@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

> --
> 
> this patch (ontop of the current -mm scheduler patchset) tweaks 
> cpu_idle() semantics a bit: it changes the idle loops (that do 
> preemption) to call the first schedule() unconditionally.
> 
> the advantage is that as a result we dont have to set the idle thread's 
> NEED_RESCHED flag in init_idle(), which in turn makes cond_resched() 
> even more of an invariant: it can be called even from init code without 
> it having any effect. A cond resched in the init codepath hangs 
> otherwise.
> 
> this patch, while having no negative side-effects, enables wider use of 
> cond_resched()s. (which might happen in the stock kernel too, but it's 
> particulary important for voluntary-preempt) (note that for now this 
> patch only covers architectures that use kernel/Kconfig.preempt, but all 
> other architectures will work just fine too.)
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 

Looks fine.
Acked-by: Nick Piggin <nickpiggin@yahoo.com.au>


