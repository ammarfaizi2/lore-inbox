Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265433AbUF2Eop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265433AbUF2Eop (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 00:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265410AbUF2Eop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 00:44:45 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:11402 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265440AbUF2Eoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 00:44:38 -0400
Message-ID: <40E0F3B1.2030906@yahoo.com.au>
Date: Tue, 29 Jun 2004 14:44:33 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
CC: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Con Kolivas <kernel@kolivas.org>, Michael Buesch <mbuesch@freenet.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Willy Tarreau <willy@w.ods.org>
Subject: Re: [PATCH] Staircase scheduler v7.4
References: <200406251840.46577.mbuesch@freenet.de> <200406261929.35950.mbuesch@freenet.de> <1088363821.1698.1.camel@teapot.felipe-alfaro.com> <200406272128.57367.mbuesch@freenet.de> <1088373352.1691.1.camel@teapot.felipe-alfaro.com> <Pine.LNX.4.58.0406281013590.11399@kolivas.org> <1088412045.1694.3.camel@teapot.felipe-alfaro.com> <40DFDBB2.7010800@yahoo.com.au> <40E0A7FC.3030200@bigpond.net.au>
In-Reply-To: <40E0A7FC.3030200@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Nick Piggin wrote:
> 
>> Felipe Alfaro Solana wrote:
>>
>>> I have tested 2.6.7-bk10 plus from_2.6.7_to_staircase_7.7 patch and,
>>> while it's definitively better than previous versions, it still feels a
>>> little jerky when moving windows in X11 wrt to -mm3. Renicing makes it a
>>> little bit smoother, but not as much as -mm3 without renicing.
>>>
>>
>> You know, if renicing X makes it smoother, then that is a good thing
>> IMO. X needs large amounts of CPU and low latency in order to get
>> good interactivity, which is something the scheduler shouldn't give
>> to a process unless it is told to.
> 
> 
> I agree.  Although the X servers CPU usage is usually relatively low 
> (less than 5%) it does have periods when it can get quite high (greater 
> than 80%) for reasonably long periods.  This makes it difficult to come 
> up with a set of rules for CPU allocation that makes sure the X server 
> gets what it needs (when it needs it) without running the risk of giving 
> other tasks with similar load patterns unnecessary and unintentional 
> preferential treatment.
> 

Well exactly. This is what the standard scheduler tries to do, and
it does have weird starvation and priority problems that pop up.

> However, I think that there is still a need for automatic boosts for 
> some tasks.  For instance, programs such as xmms and other media 
> streamers are ones whose performance could worsen as a result of the X 
> server being reniced unless it is treated specially and the boost they 
> are given needs to be enough to put them before the X server in priority 
> order.  But renicing X would enable a tightening of the rules that 
> govern the automatic dispensing of preferential treatment to tasks that 
> are perceived to be interactive which should be good for overall system 
> performance.

I agree renicing X is helpful.
