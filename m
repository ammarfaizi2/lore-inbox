Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269075AbUINNhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269075AbUINNhM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 09:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269297AbUINNhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 09:37:12 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:58220 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269075AbUINNdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 09:33:55 -0400
Message-ID: <4146F33C.9030504@yahoo.com.au>
Date: Tue, 14 Sep 2004 23:33:48 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
References: <20040914101904.GD24622@elte.hu> <20040914102517.GE24622@elte.hu> <20040914104449.GA30790@elte.hu> <20040914105048.GA31238@elte.hu> <20040914105904.GB31370@elte.hu> <20040914110237.GC31370@elte.hu> <20040914110611.GA32077@elte.hu> <20040914112847.GA2804@elte.hu> <20040914114228.GD2804@elte.hu> <4146EA3E.4010804@yahoo.com.au> <20040914132225.GA9310@elte.hu>
In-Reply-To: <20040914132225.GA9310@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>Could these ones go up a level? We break down scanning into 32 page
>>chunks, so I don't think it needs to be checked every page.
> 
> 
> not really - we can occasionally get into high latencies even with a
> single page - if a single page is mapped by alot of processes.
> 

So doing it in the loop doesn't really give you a deterministic
maximum latency if somebody is out to cause trouble, does it?

OTOH, I guess libc or some shared memory segment may be mapped
into a lot of processes even on RT applictions.

Another thing, I don't mean this to sound like a rhetorical question,
but if we have a preemptible kernel, why is it a good idea to sprinkle
cond_rescheds everywhere? Isn't this now the worst of both worlds?
Why would someone who really cares about latency not enable preempt?
