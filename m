Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265905AbUGHIJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265905AbUGHIJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 04:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265907AbUGHIJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 04:09:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:42905 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265905AbUGHIJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 04:09:56 -0400
Date: Thu, 8 Jul 2004 01:08:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: nigelenki@comcast.net, linux-kernel@vger.kernel.org
Subject: Re: Autoregulate swappiness & inactivation
Message-Id: <20040708010842.2064a706.akpm@osdl.org>
In-Reply-To: <cone.1089273505.418287.4554.502@pc.kolivas.org>
References: <40EC13C5.2000101@kolivas.org>
	<40EC1930.7010805@comcast.net>
	<40EC1B0A.8090802@kolivas.org>
	<20040707213822.2682790b.akpm@osdl.org>
	<cone.1089268800.781084.4554.502@pc.kolivas.org>
	<20040708001027.7fed0bc4.akpm@osdl.org>
	<cone.1089273505.418287.4554.502@pc.kolivas.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> Andrew Morton writes:
> 
> > Con Kolivas <kernel@kolivas.org> wrote:
> >>
> >>  Ah what the heck. They can only be knocked back to where they already are.
> > 
> > hm.  You get an eGrump for sending two patchs in one email.  Surprisingly
> > nice numbers though.
> > 
> > How come vm_swappiness gets squared?  That's the mysterious "bias
> > downwards", yes?  What's the theory there?
> 
> No real world feedback mechanism is linear. As the pressure grows the 
> positive/negative feedback grows exponentially.

That takes me back.  The classic control system is PID:
Proportional/Integral/Derivative - they refer to the way in which the error
term (output-desired output) is fed back to the input:

Proportional: the bigger the error, the more input drive

Integral: feeding back a bit of the integral of the error prevents
permanent output skew due to non-infinite forward gain.

Derivative: feeding back -(rate of change) provides damping.

You can live without I and D - the main thing is to feed back the -error.

IOW: linear works just fine :)

Your answer didn't help me understand the design though.

> > Please define this new term "application pages"?
> 
> errm it's fuzzy to say the least. It's the closest I can come to 
> representing what end users understand as "non-cached" pages.

Isn't that mapped pages?

> > Those si_swapinfo() and si_meminfo() calls need to come out of there.
> 
> I'm game. I had the idea but not the skill. Anyone wanna help me with that?

Need to work out what cen be removed first.  The freeswap/totalswap can go.
 That leaves us needing what?  totalram and freeram.  If the algorithm can
be flipped over to use nr_mapped, we'd be looking good.

