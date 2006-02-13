Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbWBMT5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWBMT5w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 14:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWBMT5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 14:57:52 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:17095 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964827AbWBMT5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 14:57:51 -0500
Date: Mon, 13 Feb 2006 20:55:50 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, John Stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH 01/13] hrtimer: round up relative start time
Message-ID: <20060213195550.GB30679@elte.hu>
References: <Pine.LNX.4.61.0602130207560.23745@scrub.home> <1139827927.4932.17.camel@localhost.localdomain> <Pine.LNX.4.61.0602131208050.30994@scrub.home> <20060213130143.GA10771@elte.hu> <Pine.LNX.4.61.0602131441110.9696@scrub.home> <20060213144403.GA21317@elte.hu> <Pine.LNX.4.61.0602131643290.30994@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602131643290.30994@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> Hi,
> 
> On Mon, 13 Feb 2006, Ingo Molnar wrote:
> 
> > In other words: your patch re-introduces half of the bug on low-res 
> > platforms. Users doing a series of one-shot itimer calls would be 
> > exposed to the same kind of (incorrect and unnecessary) summing-up 
> > errors. What's the point?
> 
> I don't fully agree with the interval behaviour either, [...]

i.e. you'd want to reintroduce the comulative interval rounding bug that 
users noticed? Or do you have some other way to change it? I really dont 
see your point.

> [...] but here one could at least say it's correct on average. [...]

i'm not sure i understand. Are you implying by this that some current 
code is not "correct on average"?

> Since hrtimer is also used for nanosleep(), which I consider more 
> important (as e.g. posix timer), this one should at least be correct 
> and consistent with previous 2.6 releases. [...]

for me it's simple: i dont think we should reintroduce the same type of 
concept that was clearly causing regressions in previous 2.6 releases.  
Thomas, what do you think?

	Ingo
