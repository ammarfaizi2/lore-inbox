Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265632AbTIDXE0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 19:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265633AbTIDXEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 19:04:25 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:55556 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S265632AbTIDXEX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 19:04:23 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH] Nick's scheduler policy v10
Date: 4 Sep 2003 22:55:40 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bj8ftc$ikl$1@gatekeeper.tmr.com>
References: <3F5044DC.10305@cyberone.com.au>
X-Trace: gatekeeper.tmr.com 1062716140 19093 192.168.12.62 (4 Sep 2003 22:55:40 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3F5044DC.10305@cyberone.com.au>,
Nick Piggin  <piggin@cyberone.com.au> wrote:

| This is quite a big change from v8. Fixes a few bugs in child priority,
| and adds a small lower bound on the amount of history that is kept. This
| should improve "fork something" times hopefully, and stops new children
| being able to fluctuate priority so wildly.
| 
| Eliminates "timeslice backboost" and only uses "priority backboost". This
| decreases scheduling latency quite nicely - I can only measure 130ms for
| a very low priority task, with a make -j3 and wildly moving an xterm around
| in front of a mozilla window.
| 
| Makes a fairly fundamental change to how sleeping/running is accounted.
| It now takes into account time on the runqueue. This hopefully will keep
| priorities more stable under varying loads.
| 
| Includes an upper bound on the amount of priority a task can get in one
| sleep. Hopefully this catches freak long sleeps like a SIGSTOP or unexpected
| swaps. This change breaks the priority calculation a little bit. I'm 
| thinking
| about how to fix it.
| 
| Feedback welcome! Its against 0-test4, as usual.

I've been running it for a while on a dog-slow machine, 350MHz
Pentium-II with 96MB RAM, I was running V7, and I'm not sure it's an
improvement, at least on this system. while I'm doing things like a
kernel build (no -j on this box!) it feels perhaps a bit less smooth
than v7, and I do see some occasional artifact on the screen which I
didn't see with v7.

I'll be switching back and forth for a bit, and I have no working sound,
2.6.0-test4 just doesn't like the old Soundblaster, which works with
Redhat 2.4.18 whatever from RH 7.3 install. I'm trying to get a clean
oops to report when loading the aha152x module, and I want to generate
it without *any* patches, in case someone ever cares. Other than that I
do my security stuff on it, since the crypto loopback is working for me.

The v10 is better than stock test4, but I do think v7 was better. I'll
tune a few things (suggestions?) but memory isn't a big problem under my
light usage.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
