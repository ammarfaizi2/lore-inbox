Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131630AbRCXKWy>; Sat, 24 Mar 2001 05:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131631AbRCXKWo>; Sat, 24 Mar 2001 05:22:44 -0500
Received: from www.wen-online.de ([212.223.88.39]:35857 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S131630AbRCXKWZ>;
	Sat, 24 Mar 2001 05:22:25 -0500
Date: Sat, 24 Mar 2001 11:21:52 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <3ABC5143.167A649E@redhat.com>
Message-ID: <Pine.LNX.4.33.0103241039590.2310-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Mar 2001, Doug Ledford wrote:

[snip list of naughty behavior]

> What was that you were saying about "should *never* happen"?  Oh, and let's
> not overlook the fact that it killed off mostly system daemons to start off
> with while leaving the real culprits alone.  Once it did get around to the
> real culprits (diff and tar), it wasn't even killing them because they were
> overly large, it was killing them because it wasn't reclaiming space from the
> buffer cache and page cache.  All of the programs running on this machine were
> never more than roughly 256MB of program code, and this is a 1GB machine.
> This behavior is totally unacceptable and, as Alan put it, is a bug in the
> code.  It should never trigger the oom killer with 750+MB of cache sitting
> around, but it does.  If you want people to buy into the value of the oom
> killer, you've at least got to get it to quit killing shit when it absolutely
> doesn't need to.
>
> To those people that would suggest I send in code I only have this to say.
> Fine, I'll send in a patch to fix this bug.  It will make the oom killer call
> the cache reclaim functions and never kill anything.  That would at least fix
> the bug you see above.

That won't fix the problem, but merely paper it over.  The problem is
in the balancing code that lets swap be exausted while at the same time
allowing cache to become obscenely obese in the first place.  I can't
trigger that behavior here, but it obviously exists for some workloads.

General thread comment:
To those who are griping, and obviously rightfully so, Rik has twice
stated on this list that he could use some help with VM auto-balancing.
The responses (visible on this list at least) was rather underwhelming.
I noted no public exchange of ideas.. nada in fact.

Get off your lazy butts and do something about it.  Don't work on the
oom-killer though.. that's only a symptom.  Work on the problem instead.

	-Mike  (who doesn't give a rats ass if he gets flamed;-)

