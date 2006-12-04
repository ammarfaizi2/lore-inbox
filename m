Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937220AbWLDRIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937220AbWLDRIY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 12:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937224AbWLDRIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 12:08:24 -0500
Received: from gateway-1237.mvista.com ([63.81.120.155]:8502 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S937220AbWLDRIX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 12:08:23 -0500
Message-ID: <45745664.5040404@ru.mvista.com>
Date: Mon, 04 Dec 2006 20:09:56 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, dwalker@mvista.com,
       khilman@mvista.com
Subject: Re: [PATCH] 2.6.18-rt7: fix more issues with 32-bit cycles_t in	latency_trace.c
 (take 3)
References: <200611132252.58818.sshtylyov@ru.mvista.com> <457326A2.2020402@ru.mvista.com> <20061204095131.GE7872@elte.hu> <4574149B.5070602@ru.mvista.com> <20061204153949.GA9350@elte.hu> <45744AF5.2040508@ru.mvista.com> <20061204162300.GA23800@elte.hu>
In-Reply-To: <20061204162300.GA23800@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Ingo Molnar wrote:

>>>	/* check for buggy clocks, handling wrap for 32-bit clocks */
>>>-	if (TYPE_EQUAL(cycles_t, unsigned long)) {
>>>+	if (TYPE_EQUAL(cycle_t, unsigned long)) {
>>>		if (time_after((unsigned long)T1, (unsigned long)T2))
>>>			printk("bug: %08lx < %08lx!\n",
>>>				(unsigned long)T2, (unsigned long)T1);

>>   This earlier fix by Kevin woulnd't have sense anymore with cycle_t...

> yeah, indeed - i've zapped this one too.

    Moreover, it was somewhat incorrect from the very start since 'unsigned 
long' is 64-bit on 64-bit machines, and cycles_t is 'unsigned long' on both 
PPC32 and PPC64, so else branch would've *never* be executed...

> basically, what i'd like is the 32-bit clocks/cycles be handled 
> intelligently, and not adding to the cruft that already is in 
> kernel/latency_tracing.c.

    Yeah, I've looked at 2.6.19-rt2 and saw the new approach. But what's left 
to fix there, only the case of using PPC32 raw cycles? I guess you only need 
to cast a result of get_cycles() to cycle_t... wait, it'll be explicitly cast 
in the return stmt, won't it?

> 	Ingo

WBR, Sergei
