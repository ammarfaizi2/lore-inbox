Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264931AbSJ3VQp>; Wed, 30 Oct 2002 16:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264938AbSJ3VQp>; Wed, 30 Oct 2002 16:16:45 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:35343 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S264931AbSJ3VQn>; Wed, 30 Oct 2002 16:16:43 -0500
Date: Wed, 30 Oct 2002 16:22:28 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Bernhard Kaindl <bk@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: linux-kernel@vger.kernel.org
In-Reply-To: <3DC01D91.9020307@colorfullife.com>
Message-ID: <Pine.LNX.3.96.1021030162033.14229C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2002, Manfred Spraul wrote:

> You are right, there is a race in pipelined_send, but slightly different 
> than in your description:
> pipelined_send is carefull not to read the msr pointer after 
> wake_up_process, but it does rely on the contents of the msr structure 
> after setting msr->r_msg.

> Is that possible? Do you apps use signals?
> 
> Your fix solves the problem, but I'd prefer to keep the current,
> lockless receive path - it avoids 50% of the spinlock operations.  I'll
> write a patch that adds the missing memory barriers and copies the
> fields before setting msr->r_msg. 

Don't know about his, my app does, it's only a benchmark, but I do see bad
behaviour from time to time (total lockups) on SMP machines.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

