Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318327AbSHMRkq>; Tue, 13 Aug 2002 13:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318968AbSHMRjY>; Tue, 13 Aug 2002 13:39:24 -0400
Received: from mx2.elte.hu ([157.181.151.9]:54998 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318975AbSHMRjB>;
	Tue, 13 Aug 2002 13:39:01 -0400
Date: Tue, 13 Aug 2002 19:42:48 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] kwaitd, 2.5.31-A1
In-Reply-To: <3D59436F.3DFAFA36@zip.com.au>
Message-ID: <Pine.LNX.4.44.0208131939070.4369-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Andrew Morton wrote:

> Andrea's kernels have keventd running SCHED_RR, and that's appropriate
> to this application also.  Not sure about AIO though.

actually, the default (non-RT) priority of kwaitd is a feature. If there's
lots of exit() activity with lots or running threads (which is the typical
case on an exit-all for threads) then the kwaitd work will nicely cluster
up due it *not* always having the highest priority. This makes the cost of
kwaitd equivalent to the cost of per-CPU lists, asymptotically.

	Ingo

