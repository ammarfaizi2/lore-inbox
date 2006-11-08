Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753872AbWKHCGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872AbWKHCGu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 21:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753881AbWKHCGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 21:06:50 -0500
Received: from dpc691978010.direcpc.com ([69.19.78.10]:63372 "EHLO
	third-harmonic.com") by vger.kernel.org with ESMTP id S1753872AbWKHCGt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 21:06:49 -0500
Message-ID: <45513BB6.4010308@third-harmonic.com>
Date: Tue, 07 Nov 2006 21:06:46 -0500
From: john cooper <john.cooper@third-harmonic.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Kevin Hilman <khilman@mvista.com>
CC: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org,
       john cooper <john.cooper@third-harmonic.com>
Subject: Re: 2.6.18-rt7: rollover with 32-bit cycles_t
References: <4551348B.6070604@mvista.com>
In-Reply-To: <4551348B.6070604@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Hilman wrote:
> On ARM, I'm noticing the 'bug' message from check_critical_timing()
> where two calls to get_cycles() are compared and the 2nd is assumed to
> be >= the first.
> 
> This isn't properly handling the case of rollover which occurs
> relatively often with fast hardware clocks and 32-bit cycle counters.
> 
> Is this really a bug?  If the get_cycles() can be assumed to run between
> 0 and (cycles_t)~0, using the right unsigned math could get a proper
> delta even in the rollover case.  Is this a safe assumption?

I was concerned about that as well back when I was getting the
instrumentation functional on the pxa270 as the rollover could
be as short as ~8s which wasn't really long enough for test
validation.  However there is a /64 prescaler on that ARM core
(and others) which can function as a bandaid and extend the range
to ~8minutes.

I wasn't able to convince myself in a quick read of the code if
roll over was being detected/corrected (though it certainly may).
But even if not the only requirement needed to do so would be to
assure any two consecutive data points logged per CPU were spaced
apart less than the counter's wrap interval.  Given the periodic
events being logged in the normal course of operation this condition
would certainly be met.

-john

-- 
john.cooper@third-harmonic.com
