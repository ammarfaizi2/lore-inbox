Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262659AbTJAWad (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 18:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbTJAWad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 18:30:33 -0400
Received: from mx1.it.wmich.edu ([141.218.1.89]:10205 "EHLO mx1.it.wmich.edu")
	by vger.kernel.org with ESMTP id S262659AbTJAWaa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 18:30:30 -0400
Message-ID: <3F7B5584.6070604@wmich.edu>
Date: Wed, 01 Oct 2003 18:30:28 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030908 Debian/1.4-4
X-Accept-Language: en
MIME-Version: 1.0
To: bill davidsen <davidsen@tmr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test6 scheduling(?) oddness
References: <20031001032238.GB1416@Master> <20030930215512.1df59be3.akpm@osdl.org> <20031001051008.GD1416@Master> <blfi1h$jd0$1@gatekeeper.tmr.com>
In-Reply-To: <blfi1h$jd0$1@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bill davidsen wrote:
> In article <20031001051008.GD1416@Master>,
> Murray J. Root <murrayr@brain.org> wrote:
> | On Tue, Sep 30, 2003 at 09:55:12PM -0700, Andrew Morton wrote:
> | > "Murray J. Root" <murrayr@brain.org> wrote:
> | > >
> | > > The render finishes in the same 30 minutes, then oowriter starts.
> | > >  oowriter takes about 3 seconds to load if no rendering is going on.
> | > 
> | > OpenOffice uses sched_yield() in strange ways which causes it to
> | > get hopelessly starved on 2.6 kernels.  I think RH have a fixed version,
> | > but I don't know if that has propagated into the upstream yet.
> | > 
> | > So...  Don't worry about OpenOffice too much.  Is the problem reproducible
> | > with other applications?
> | 
> | Nope - even tried it with KDE apps.
> | Write it off to OpenOffice, not test6.
> 
> I wish I could just write off programs like that, but if a program is
> running, and doing legitimate system calls, and it stops running
> (totally or usefully), I'd like to be sure that the kernel doesn't have
> some unintended behaviour before I just pass on the program.
> 
> Particularly when OO is what allows lots of people to avoid running that
> other operating system.

it isn't doing something legitimate since as he said, it was the only 
program that exibited the behavior. Perhaps openoffice was exploiting a 
characteristic of the old schedular to increase it's performance, 
perhaps it's just the way they ended up coding it.  But if it's the only 
one then that's that.


> | 
> | That doesn't explain the major time increase of the render, though.
> | 200% for 2.5.65 vs 2.6.0-test6 or 150% for 2.6.0-test5 vs 2.6.0-test6 is a 
> | bit extreme.
> 
> The vmstat sure didn't show a big increase in contenxt switches, but if
> there's nothing elese wanting the CPU I would expect the render to be
> what's running, and at the same speed as test5.
> 
> Suggestion: could you run 'top' in the text output mode to see if for
> some reason the CPU is going to some odd process. The revised nice
> handling can't make a user process lower priority than the idle loop or
> something odd like that, can it?


Why would you trust what top says about cpu usage? It lies it lies it 
lies. At best a rough estimate.



Con's scheduler fixes are quite nice. Make sure if you want something to 
hog the cpu to nice it down, otherwise it has to play nice.  Just 
because programs use very little cpu, doesn't mean they wont need some 
in a given time, and that of course will slow down any app that needs 
cpu but is being forced to share, the stop and go even though it's for a 
short time takes time and happens a lot with the more processes being 
run. This is how a multi-user OS should  behave, a render process 
shouldn't be allowed to lag the rest of the system for the sake of it's 
own performance unless you explicitly allow it. Having a loss of speed 
even at nice -20 however, is a problem.

