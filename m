Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbTJAV5B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 17:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262667AbTJAV5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 17:57:00 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:55817 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262665AbTJAV47
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 17:56:59 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.0-test6 scheduling(?) oddness
Date: 1 Oct 2003 21:47:29 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <blfi1h$jd0$1@gatekeeper.tmr.com>
References: <20031001032238.GB1416@Master> <20030930215512.1df59be3.akpm@osdl.org> <20031001051008.GD1416@Master>
X-Trace: gatekeeper.tmr.com 1065044849 19872 192.168.12.62 (1 Oct 2003 21:47:29 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031001051008.GD1416@Master>,
Murray J. Root <murrayr@brain.org> wrote:
| On Tue, Sep 30, 2003 at 09:55:12PM -0700, Andrew Morton wrote:
| > "Murray J. Root" <murrayr@brain.org> wrote:
| > >
| > > The render finishes in the same 30 minutes, then oowriter starts.
| > >  oowriter takes about 3 seconds to load if no rendering is going on.
| > 
| > OpenOffice uses sched_yield() in strange ways which causes it to
| > get hopelessly starved on 2.6 kernels.  I think RH have a fixed version,
| > but I don't know if that has propagated into the upstream yet.
| > 
| > So...  Don't worry about OpenOffice too much.  Is the problem reproducible
| > with other applications?
| 
| Nope - even tried it with KDE apps.
| Write it off to OpenOffice, not test6.

I wish I could just write off programs like that, but if a program is
running, and doing legitimate system calls, and it stops running
(totally or usefully), I'd like to be sure that the kernel doesn't have
some unintended behaviour before I just pass on the program.

Particularly when OO is what allows lots of people to avoid running that
other operating system.

| 
| That doesn't explain the major time increase of the render, though.
| 200% for 2.5.65 vs 2.6.0-test6 or 150% for 2.6.0-test5 vs 2.6.0-test6 is a 
| bit extreme.

The vmstat sure didn't show a big increase in contenxt switches, but if
there's nothing elese wanting the CPU I would expect the render to be
what's running, and at the same speed as test5.

Suggestion: could you run 'top' in the text output mode to see if for
some reason the CPU is going to some odd process. The revised nice
handling can't make a user process lower priority than the idle loop or
something odd like that, can it?
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
