Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269830AbUJVIHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269830AbUJVIHR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 04:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269704AbUJVIGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 04:06:05 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:13190 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269849AbUJVIBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 04:01:46 -0400
Date: Fri, 22 Oct 2004 10:01:11 +0200
From: Jens Axboe <axboe@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Bill Huey <bhuey@lnxw.com>, Thomas Gleixner <tglx@linutronix.de>,
       Rui Nuno Capela <rncbc@rncbc.org>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041022080110.GG1820@suse.de>
References: <20041021095344.GA10531@suse.de> <1098352441.26758.30.camel@thomas> <20041021101103.GC10531@suse.de> <20041021195842.GA23864@nietzsche.lynx.com> <20041021201443.GF32465@suse.de> <20041021202422.GA24555@nietzsche.lynx.com> <20041021203350.GK32465@suse.de> <20041021203821.GA24628@nietzsche.lynx.com> <20041022061901.GM32465@suse.de> <20041022072908.GC10908@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022072908.GC10908@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22 2004, Ingo Molnar wrote:
> 
> * Jens Axboe <axboe@suse.de> wrote:
> 
> > It has to go, why? Because your deadlock detection breaks? Doesn't
> > seem a very strong reason to me at all, sorry.
> 
> no, this is no reason at all. I'm really sorry this issue came up in
> this context because now people appear to be arguing this as some sort
> of policy issue, implying that is somehow improper to use mutexes
> instead of completions, which it clearly is _not_. I very much wanted to
> avoid this particular type of flamewar :-)
> 
> Using mutexes for completion purposes is perfectly fine kernel code. 
> Full stop.
> 
> Using completions instead of mutexes in certain cases has some minor
> advantages for two simple reasons: it's slighly faster and it's also
> more readable.
> 
> here's an example: initially i made the scheduler's migration logic use
> semaphores in that fashion and Linus made me change it to completions,
> because, and i quote Linus here:
> 
>  [...]
>  Btw, should you not use completions here?
> 
>  Completions are optimized for the sleep (ie contention) case, while
>  semaphores are optimized for the non-contention case. It also makes 
>  more "sense" from a conceptual angle (you're waiting for something to
>  complete, not asking for an exclusive thing).
>  [...]
> 
> and i have to say the migration code did become cleaner. To signal some
> sort of event it's a more intuitive _symbol_ _name_ to use 'complete()'
> and 'wait_for_completion()' than to use 'up()' and 'down()'.
> 
> [ If you truly do not agree with this contention then please just look
> at one simple conversion we did and check out the previous and the new
> logic, by reading the full previous code and the full resulting code. I
> do believe that if anyone at that point still thinks that the
> semaphore-based code is just as readable (in that context!) as the
> completion-based code that then his brains are not made of neurons but
> silicon :) ]

I fully agree with everything in your mail so far. What annoyed me is
some people advocating their changes under the false pretense that
existing use was broken, which it isn't.

completions _do_ make cleaner code for the intended case. But your
writing above is very clear and already explains that very well.

Lets put the issue to rest and get back to more productive work!

-- 
Jens Axboe

