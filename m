Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030257AbWGFREa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbWGFREa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 13:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWGFREa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 13:04:30 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:15803 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750793AbWGFRE3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 13:04:29 -0400
Message-ID: <44AD4296.6070303@garzik.org>
Date: Thu, 06 Jul 2006 13:04:22 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
References: <20060705114630.GA3134@elte.hu> <20060705101059.66a762bf.akpm@osdl.org> <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org> <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org> <20060705204727.GA16615@elte.hu> <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org> <20060705214502.GA27597@elte.hu> <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org> <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org> <20060706081639.GA24179@elte.hu> <Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com> <Pine.LNX.4.64.0607060856080.12404@g5.osdl.org> <Pine.LNX.4.64.0607060911530.12404@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607060911530.12404@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 6 Jul 2006, Linus Torvalds wrote:
>> Any other use of "volatile" is almost certainly a bug, or just useless. 
> 
> Side note: it's also totally possible that a volatiles _hides_ a bug, ie 
> removing the volatile ends up having bad effects, but that's because the 
> software itself isn't actually following the rules (or, more commonly, the 
> rules are broken, and somebody added "volatile" to hide the problem).
> 
> That's not just a theoretical notion, btw. We had _tons_ of these kinds of 
> "volatile"s in the original old networking code. They were _all_ wrong. 
> Every single one.

I see precisely what you describe in newly submitted network _drivers_, 
too.  People use volatile to cover up missing barriers; to attempt to 
cover up missing flushes (needing readl after a writel); to hide the 
fact that the driver sometimes uses writel() and sometimes just does a 
direct de-ref into MMIO space.

To my view, seeing "volatile" in code is often a "I was too lazy to 
debug the code" or "I was too lazy to make my code portable" situation.

	Jeff



