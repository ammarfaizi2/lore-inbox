Return-Path: <linux-kernel-owner+w=401wt.eu-S932799AbWLNPUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932799AbWLNPUZ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 10:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932801AbWLNPUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 10:20:25 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:55918 "EHLO
	ms-smtp-02.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932799AbWLNPUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 10:20:24 -0500
Date: Thu, 14 Dec 2006 10:20:18 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: tike64 <tike64@yahoo.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: realtime-preempt and arm
In-Reply-To: <813680.16966.qm@web59212.mail.re1.yahoo.com>
Message-ID: <Pine.LNX.4.58.0612140928020.19074@gandalf.stny.rr.com>
References: <813680.16966.qm@web59212.mail.re1.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 14 Dec 2006, tike64 wrote:

> Steven Rostedt <rostedt@goodmis.org> wrote:
> > ...
> > it's ok for the timer to be a little over, but it must never be a
> > little under.
> > ...
> > So we make sure the timer goes off in (n+1) ms, and not just (n).

Oops, that should have read (n+1) 10ms, or +1 res. But you got the point
anyway ;)

>
> Ok, this makes sense - thanks.
>
> What confuses / confused me is that I have 4 combinations:
> without-rt/with-rt X select/nanosleep; I first tried the
> without-rt/select combination and right after that with-rt combinations
> skipping the without-rt/nanosleep case. The first one was the one (the
> only one) which gives me the 10ms average delay. And after your
> explanations that fact bugs me even more.

Actually, I just ran your prog on a ia32 -rt kernel, with highres, and
using select, I get return times of less than 5ms. So this looks like a
bug.  On 2.6.17 vanilla, I also got under 5ms. But it might be ok for
select to return early. I'm not sure on this one.  But using nansleep
never returned early on either system.

>
> But that is a side issue. The real problem is now: how do I get rid of
> the multi-ms jitter?
>

So you got a big jitter using nanosleep???  If that's the case, could you
post the times you got. I'll also boot a kernel with the latest -rt patch,
without highres compiled, and see if I can reproduce the same on x86.

-- Steve

