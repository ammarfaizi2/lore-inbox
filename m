Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbTIOEEf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 00:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbTIOEEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 00:04:35 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:55309 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262434AbTIOEEd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 00:04:33 -0400
Date: Sun, 14 Sep 2003 23:55:29 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
In-Reply-To: <Pine.LNX.4.53.0309142058120.5140@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.3.96.1030914233016.16842A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Sep 2003, Zwane Mwaikambo wrote:

> On Sun, 14 Sep 2003, bill davidsen wrote:
> 
> > We just got a start on making Linux smaller to encourage embedded use, I
> > don't see adding 300+ bytes of wasted code so people can run
> > misconfigured kernels.
> > 
> > I rather have to patch this in for my Athlon kernels than have people
> > who aren't cutting corners trying to avoid building matching kernels
> > have to live with the overhead.
> 
> Overhead? Really you could save more memory by cleaning up a lot of 
> drivers. Andi already said it before, there are better places to be 
> looking at.

The best way to remove overhead is not to add it. Putting in 300+ bytes of
code which is pure overhead on anything but an Athlon is silly. And to
justify it because it save effort for people who don't want to bother
building the correct distribution is pure hubris. The Athlon is not so
important that making it run a tiny bit faster justifies taking extra
space on every machine which doesn't benefit.
> 
> Also 'patching' for Athlon kernels doesn't cut it for people who need to 
> distribute kernels which run on various hardware (such as distros). This 
> alone is benefit enough to justify this supposed 'bloat'.

You clearly think that a kernel will not run on Athlon without this
patch. In real life kernel built for 386, 486, Ppro, etc will run
nicely on every CPU except those less featureful, including the
precious Athlon.

That being the case, there is no justification for forcing the code on
every build rather than putting ifdefs around it. Any vendor who wants
to make Athlon a tiny bit faster at the expense of making every other
system use more memory for code which is never executed can just use the
config option to include the support.

Let's try the facts agin:
1 - the code is not needed for Athlon, prefetch is turned off on broken
    CPUs now. A generic kernel runs fine on Athlon.
2 - the discussion is not on having the code or not, but on putting
    ifdefs around this code so it is only generated if wanted.

Let's not continue to pollute the kernel with architecture dependent
code, we have subtrees for that.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

