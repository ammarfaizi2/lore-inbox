Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261840AbVANJVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbVANJVl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 04:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbVANJVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 04:21:41 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:61394 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261840AbVANJVd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 04:21:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ZXXhj3SB7uIvUl2+BoHutBIvsvT/YCyEHhPG9bjK96WFGRPNG5/r1QIItTv26cyoKx0i0wg5WUYb7kaQ9scNnL78zChDPPPCn5gs3tScRmu02Lefwi2n/fjNYksfD/+qxTjxJkP6Z0IvfG0nv5nAz2l1HZ6VZWrql8UM5L3GHcw=
Message-ID: <8e6f947205011401213c39b785@mail.gmail.com>
Date: Fri, 14 Jan 2005 04:21:33 -0500
From: Will Dyson <will.dyson@gmail.com>
Reply-To: Will Dyson <will.dyson@gmail.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       Paul Davis <paul@linuxaudiosystems.com>, lkml@s2y4n2c.de,
       rlrevell@joe-job.com, arjanv@redhat.com, joq@io.com, chrisw@osdl.org,
       mpm@selenic.com, hch@infradead.org, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <1105673482.5402.58.camel@npiggin-nld.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1105669451.5402.38.camel@npiggin-nld.site>
	 <200501140240.j0E2esKG026962@localhost.localdomain>
	 <20050113191237.25b3962a.akpm@osdl.org> <41E739F4.1030902@kolivas.org>
	 <1105673482.5402.58.camel@npiggin-nld.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jan 2005 14:31:21 +1100, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
 
> It sounds to me like both your proposals may be too complex and not
> sufficiently deterministic (I don't know for sure, maybe that's
> exactly what the RT people want).
> 
> I wouldn't have thought it is so much a matter of having real-time-ish
> scheduling available that tries to play nicely in a multi user machine.
> That must still imply that either the user is able to unduly tie up
> resources (and thus it has to be a privileged operation), or that it
> sometimes can't meet its "guarantees" (in which case, is it useful?).

The VM system with overcommit is in a similar pickle. It can't honor
the "guarantees" it makes. Yet, I think it is in wide use. Overcommit
is a useful behavior for many people, despite the fact that it allows
any user to turn loose the oom_killer on the system.

So I think many people would also find a best-effort-at-realtime
SCHED_ISO type thing pretty useful, even if it allowed unprivileged
users to tie up resources (while protecting the system from DOS).
Heck, we don't have to allow unprivileged users to tie up resources.
SCHED_ISO use could be limited to members of a certain group, possibly
implemented using some sort of LSM module... :)

Of course, suggesting that access to SCHED_ISO be limited pretty much
admits that running processes as SCHED_ISO should be a privileged
operation, like accessing /dev/dsp (a privilege that is granted
through group membership on most desktops).

> I was thinking that the solution might be more along the lines of
> a nice way to handle privileges for these guys.

A nice,  flexible way to hand out scheduler (and perhaps other)
privileges would be... nice. Are you thinking of something more
fine-grained than per-user?

-- 
Will Dyson
