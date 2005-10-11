Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbVJKDTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbVJKDTt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 23:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbVJKDTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 23:19:48 -0400
Received: from main.gmane.org ([80.91.229.2]:45457 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751368AbVJKDTs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 23:19:48 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joe Seigh <jseigh_02@xemaps.com>
Subject: Re: SMP syncronization on AMD processors (broken?)
Date: Mon, 10 Oct 2005 23:20:23 -0400
Message-ID: <difarq$c6a$1@sea.gmane.org>
References: <434520FF.8050100@sw.ru> <20051006192106.A13978@castle.nmd.msu.ru> <20051010175920.21018fac.akpm@osdl.org> <200510110320.28302.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: stenquists.hsd1.ma.comcast.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
In-Reply-To: <200510110320.28302.ak@suse.de>
Cc: discuss@x86-64.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Tuesday 11 October 2005 02:59, Andrew Morton wrote:
> 
> 
>>> I'm not advocating for changing spinlock implementation, it's just a
>>> thought...
>>
>>It would make sense in these cases if there was some primitive which we
>>could call which says "hey, I expect+want another CPU to grab this lock in
>>preference to this CPU".
> 
> 
> I just don't know how to implement such a primitive given the guarantees
> of the x86 architecture. It might be possible to do something that
> works on specific CPUs, but that will likely break later.
> 

I thought that's what the WBINVD did.  Either the problem is the delayed
write buffer or the fact that the store makes the lock cache line exclusive
which gives the processor unfair advantage if it immediately tries to
reacquire the lock.  WBINVD solves both of those problems.

Or you could use a spin lock implementation that didn't have that problem
to begin with.

--
Joe Seigh



