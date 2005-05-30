Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbVE3WF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbVE3WF3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 18:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbVE3WF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 18:05:29 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:61705 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261762AbVE3WFN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 18:05:13 -0400
Date: Mon, 30 May 2005 15:10:07 -0700
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: James Bruce <bruce@andrew.cmu.edu>, "Bill Huey (hui)" <bhuey@lnxw.com>,
       Andi Kleen <ak@muc.de>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050530221007.GA9972@nietzsche.lynx.com>
References: <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au> <20050527120812.GA375@nietzsche.lynx.com> <429715DE.6030008@yahoo.com.au> <20050527233645.GA2283@nietzsche.lynx.com> <4297EB57.5090902@yahoo.com.au> <20050528054503.GA2958@nietzsche.lynx.com> <42981467.6020409@yahoo.com.au> <4299A98D.1080805@andrew.cmu.edu> <429ADEDD.4020805@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429ADEDD.4020805@yahoo.com.au>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2005 at 07:37:33PM +1000, Nick Piggin wrote:
> I reject the vague "complexity" argument. If your application
> is not fairly clear on what operations need to happen in a
> deterministic time and what aren't, or if you aren't easily able
> to get 2 communicating processes working, then I contend that you
> shouldn't be writing a realtime application.

yeah, but you're also saying a lot of stuff that indicates you've
never written an RT app before.

> The fact is, nobody seems to know quite what kind of deterministic
> functionality they want (and please, let's not continue the jokes
> about X11 and XFS, etc.). Which really surprises me.

Christopher is an overconfident narrow minded jackass. You should be
beyond that behavior and chronic lack of vision.

For this to happen in Linux, ksoftirq needs to run regularly to service
IO scheduler and the SCSI layer so that GRIO can happen. You still need
that thread to be immune to large kernel latencies especially under high
IO load, which also needs high amount of regular CPU time.  Guarantees
can't be met without it which means it's most definitely a kind of real
time task/thread. It's not just the lower level FS layers in question
that provides this solely. You should have intuited that from my
examples.

The details of which are more complicated than this once folk push into
that domain. I'm not an FS expert but I do know that RT is necessary
for any kind of QoS functionality like this. It's a fundamental that
must be in place.

I already told you the needs of X11/OpenGL. Buffer flipping during
vertical retrace. Additionally, it would be good to be able to determine
if a thread can get enough of a time slice to be able to render a
scene (quad/triangular mesh computation) for adaptive tessellation
or have a signal terminate that computation and flip it to the display.

Think about generalizing that for all OpenGL library implementation
and all drivers. This is not trivial for dual kernel set ups. Think
about how large X11 and running a task like that in a nanokernel
that can't sleep a task properly for swapping verse a single kernel
image that can already do it.

What was a simple read() wake up is now messaging FIFO queues it
a nanokernel set up. You'd have to retarget the apps and the drivers
to use that API instead of using limited Linux kernel facilities
via syscalls for some of this support.

> Yeah great. Can we stop with these misleading implications now?
> *A* programmer will have to write RT support in *either* scheme.
> *THE* programmer (you imply, a consumer of the userspace API)
> does not.

They'll have to clean up the driver and all upper layers. That's
easier than retargetting your app and layer to a nanokernel.

> There is absolutely no difference for the userspace programmer
> in terms of realtime services.

Except for the brickwall they run into when they need something
a bit more than an interrupt being serviced in a timely manner.

> "Nobody has even yet *suggested* any *slightly* credible reasons
> of why a single kernel might be better than a split-kernel for
> hard-RT"

Bullshit, multipule folks have. It's like you have this particular
view and can't or won't see it from another perpective. It's clearly
willfull.

> I hate to say but I find this almost dishonest considering
> assertions like "obviously superior" are being thrown around,
> along with such fine explanations as "start writing realtime apps
> and you'll find out".

Because it's true. Write a couple of these things and you'll see
what we mean by this. Consistently in this discussion, folks have
explained it to you but you can't take the ball and run with it in
a way that demonstrates that you really understand the media app
issues. It's like you're so locked into a neo-conservative way of
looking at these things that you don't know that this track can't
scale for our needs properly.

Really, most of us here have tried really really hard to get you
to understand it and the explanations are quite clear. There
isn't much we can do to change your mind since it wasn't really
there for change anyways.

bill

