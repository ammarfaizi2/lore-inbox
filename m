Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261868AbUKRIVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbUKRIVz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 03:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262669AbUKRIVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 03:21:54 -0500
Received: from host-3.tebibyte16-2.demon.nl ([82.161.9.107]:46852 "EHLO
	doc.tebibyte.org") by vger.kernel.org with ESMTP id S261868AbUKRIUX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 03:20:23 -0500
Message-ID: <419C5B45.2080100@tebibyte.org>
Date: Thu, 18 Nov 2004 09:20:21 +0100
From: Chris Ross <chris@tebibyte.org>
Organization: At home (Eindhoven, The Netherlands)
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: pt-br, pt
MIME-Version: 1.0
To: Werner Almesberger <wa@almesberger.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrea Arcangeli <andrea@novell.com>,
       Jesse Barnes <jbarnes@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <piggin@cyberone.com.au>,
       LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages / all_unreclaimable
 braindamage
References: <20041105200118.GA20321@logos.cnet> <200411051532.51150.jbarnes@sgi.com> <20041106012018.GT8229@dualathlon.random> <1099706150.2810.147.camel@thomas> <20041117195417.A3289@almesberger.net> <419BDE53.1030003@tebibyte.org> <20041117210410.R28844@almesberger.net> <419BECB0.70801@tebibyte.org> <20041117221419.S28844@almesberger.net>
In-Reply-To: <20041117221419.S28844@almesberger.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Werner Almesberger escreveu:
> The tricky bit is now to identify such part-time interactive tasks,
> i.e. the ones who won't receive a trigger for a while. To make
> things worse, there are those who may be happily doing something,
> like spinning some animated GIF, which would be perfectly fine
> being put to a long sleep. That in turn may make the X server idle,
> etc.

I don't think you need to be that subtle about it, though I agree 
perfection would be nice :) The present behaviour is just to kill 
something. All I'm advocating is just swapping something out if possible 
instead. Yes by definition we probably have picked something you would 
have preferred to leave running, but the machine simply cope with 
everything being asked of it at the moment and that something got the 
short straw. At least swapped out we will get round to running it when 
we can.

> Again, if you have such a clearly defined scenario, perhaps the
> cron jobs should just loudly announce that housekeeping is now
> starting and that this changes some of the rules. Or perhaps,
> there could be a SIGSWAP to swap out a process (maybe SIGSUSP it
> first so that it doesn't come back on its own).

Sounds like a job for priorities and sensible use of batch scheduling.

I still feel that special casing things is basically wrong. We could 
work around the specific example that the cron.daily on my test machines 
tends to cause things to be oom_killed, but it's better to fix the 
problem. What about when I try to build umlsim again -- my standard test 
case for triggering the oom killer ;)

Let's not forget that oom killing (when it works) is a last resort, 
something we do only if we have to to avoid a panic. Too often at 
present the machine just doesn't know what to do, runs around confused 
and makes things worse by shooting its own leg off. Which is pretty much 
a real-world definition of panicking*. Lets at least try to avoid 
causing permanent damage, such as killing off sshd.

[ * I just looked it up: "of, relating to, or resembling the mental or 
emotional state believed induced by the god Pan". Cool ]

Regards,
Chris R.
