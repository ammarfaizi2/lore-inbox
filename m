Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265779AbTGLQWz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 12:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267874AbTGLQWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 12:22:55 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:1927 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265779AbTGLQWs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 12:22:48 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sat, 12 Jul 2003 09:30:04 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Miguel Freitas <miguel@cetuc.puc-rio.br>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] SCHED_SOFTRR linux scheduler policy ...
In-Reply-To: <1058027672.1196.105.camel@mf>
Message-ID: <Pine.LNX.4.55.0307120922450.4351@bigblue.dev.mcafeelabs.com>
References: <1058017391.1197.24.camel@mf>  <Pine.LNX.4.55.0307120735540.4351@bigblue.dev.mcafeelabs.com>
 <1058027672.1196.105.camel@mf>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jul 2003, Miguel Freitas wrote:

> I guess you are talking about mostly audio applications here. For video
> playback these timings are even tighter and there is very little the
> application itself can do to improve it (it's not a matter of increasing
> the buffer size).

Yes, it was audio I was talking about ...


> > I have to say that on my machine (P4 2.4GHz),
> > audio hardly skip during the typical load that my desktop sees, that in
> > turn is not so high. Like you can see in the couple of graphs that I
> > quickly dropped inside the SOFTRR page, typical latencies of 150ms are
> > very easy to obtain.
>
>
> 150ms latency would kill any video application.
>
> There is no equivalent of sound card's or kernel audio buffers for
> frames, the application just _have_ to be scheduled in time to display
> the frame (basicaly tell X to display a frame from shared memory, for
> example).

and yes, video is even more strict about timings.


> > The patch is trivially simple, like you
> > can see from the code, and it basically introduces an expiration policy
> > for realtime tasks (SOFTRR ones).
>
> yes, i saw that, pretty nice!
> i have yet to try it (i don't have any recent 2.5 on my machine)

It should be trivial to do something like that for the old scheduler.


> > Patch acceptance is
> > tricky and definitely would need more discussion and test.
>
> Sure. But let me add a voice of support here: I would be great if kernel
> provided a way to multimedia or interactive applications to request a
> better latency predictability (or hint the scheduler somehow) without
> need of being root. If that comes in a form of a new scheduler policy,
> or just allowing small negative nice values for non-root i don't mind...

You'd need a nice value that will keep you away from being caught by
interactive SCHED_OTHER. Otherwise yes, this is another solution. Did you
try it with xine under high load ?



- Davide

