Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261823AbVEPWxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbVEPWxN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 18:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbVEPWxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 18:53:13 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:39817 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261823AbVEPWxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 18:53:08 -0400
Message-ID: <42892447.5000304@yahoo.com.au>
Date: Tue, 17 May 2005 08:52:55 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] improve SMP reschedule and idle routines
References: <4288A55B.10F7240E@tv-sign.ru>
In-Reply-To: <4288A55B.10F7240E@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
> Nick Piggin wrote:
> 
>> void default_idle(void)
>> {
>>+	local_irq_enable();
>>+
> 
> 
> Stupid question. Why is this sti() needed?
> 
> Interrupts are enabled in start_secondary() before cpu_idle()
> call, and they can't be disabled after return from schedule().
> 
> The same question applies to poll_idle/mwait_idle.
> 

IIRC I tried to do that, but I think I ran into problems with
acpi_processor_idle which looks like it can call the cpu idle
routines with interrupts disabled. I definitely ran into problems
with something.

That should really be cleaned up though (whether we go one way
or the other doesn't matter as much as it being consistent),
I think.

But I wanted to try to keep this patch to a minimum.

-- 
SUSE Labs, Novell Inc.

