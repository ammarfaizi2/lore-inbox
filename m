Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937072AbWLDQTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937072AbWLDQTj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937071AbWLDQTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:19:38 -0500
Received: from gateway-1237.mvista.com ([63.81.120.155]:8283 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S937072AbWLDQTf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:19:35 -0500
Message-ID: <45744AF5.2040508@ru.mvista.com>
Date: Mon, 04 Dec 2006 19:21:09 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, dwalker@mvista.com
Subject: Re: [PATCH] 2.6.18-rt7: fix more issues with 32-bit cycles_t in	latency_trace.c
 (take 3)
References: <200611132252.58818.sshtylyov@ru.mvista.com> <457326A2.2020402@ru.mvista.com> <20061204095131.GE7872@elte.hu> <4574149B.5070602@ru.mvista.com> <20061204153949.GA9350@elte.hu>
In-Reply-To: <20061204153949.GA9350@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Ingo Molnar wrote:

>>>i'd suggest to redo it - but please keep it simple and clean. Those 
>>>dozens of casts to u64 are quite ugly.

>>   Alas, there's *nothing* I can do about it with 32-bit cycles_t. 
>>[...]

> there's *always* a way to do such things more cleanly - such as the 
> patch below. Could you try to fix it up for 32-bit cycles_t platforms? I 
> bet the hackery will be limited to now() and maybe the conversion 
> routines, instead of spreading all around latency_trace.c.

    I'm not sure what you want me to do... You've switched to clocksource 
specific cycle_t (which is u64), do you want me to use the clocksource 
interface to get the cycles from now on?

> Index: linux/kernel/latency_trace.c
> ===================================================================
> --- linux.orig/kernel/latency_trace.c
> +++ linux/kernel/latency_trace.c
[...]
> @@ -1721,7 +1722,7 @@ check_critical_timing(int cpu, struct cp
>  	T2 = get_monotonic_cycles();
>  
>  	/* check for buggy clocks, handling wrap for 32-bit clocks */
> -	if (TYPE_EQUAL(cycles_t, unsigned long)) {
> +	if (TYPE_EQUAL(cycle_t, unsigned long)) {
>  		if (time_after((unsigned long)T1, (unsigned long)T2))
>  			printk("bug: %08lx < %08lx!\n",
>  				(unsigned long)T2, (unsigned long)T1);

    This earlier fix by Kevin woulnd't have sense anymore with cycle_t...

WBR, Sergei
