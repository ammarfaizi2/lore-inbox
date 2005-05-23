Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261859AbVEWHj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbVEWHj4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 03:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVEWHj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 03:39:56 -0400
Received: from mx2.elte.hu ([157.181.151.9]:32643 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261859AbVEWHjx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 03:39:53 -0400
Date: Mon, 23 May 2005 09:39:32 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: William Weston <weston@sysex.net>, linux-kernel@vger.kernel.org,
       dwalker@mvista.com
Subject: Re: BUGs in 2.6.12-rc2-RT-V0.7.45-01
Message-ID: <20050523073932.GA4717@elte.hu>
References: <Pine.LNX.4.58.0504121443310.3023@echo.lysdexia.org> <20050412230921.GA22360@elte.hu> <Pine.LNX.4.58.0504141352490.14125@echo.lysdexia.org> <20050415080138.GA25262@elte.hu> <Pine.LNX.4.58.0504151721410.18107@echo.lysdexia.org> <1115839742.7763.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115839742.7763.14.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Hi Ingo,
> 
> I've seen lots of complaining about the yield BUG produced by 
> kstopmachine, and since I'm now starting to test this on an SMP 
> machine, I'm seeing it too.  So I've looked further into this, and 
> here's what I've found.
> 
> The kstopmachine creates one thread per CPU to run on each CPU.  It 
> sets this thread to the lowest RT priority and then spins on yield, 
> each thread expects to be on its designated CPU and spin until all 
> threads check in (all threads are on their expected CPU).  The yield 
> is only to allow one of the other threads (of same priority) to 
> migrate to their expected CPU if it started on the wrong CPU.  So the 
> use of yield here is actually correct!
> 
> So for this special case, I've included a patch here (attached) to 
> allow for a call of yield when it is actually OK for a RT task to call 
> yield. It's called rt_yield.  Take a look and see what you think.  I 
> patched this against 45-01 since that's what I'm currently working 
> with.

agreed - i've applied your patch and i've reworked it to be 
yield()/__yield(). (making it more of an internal interface - this is a 
valid but still quite unrobust use of scheduling features.)

	Ingo
