Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbTESP5T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 11:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbTESP5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 11:57:19 -0400
Received: from mx2.elte.hu ([157.181.151.9]:44760 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id S261265AbTESP5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 11:57:04 -0400
Date: Mon, 19 May 2003 18:09:23 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Werner Almesberger <wa@almesberger.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched-cleanup-2.5.69-A0
In-Reply-To: <20030519121331.C1475@almesberger.net>
Message-ID: <Pine.LNX.4.44.0305191807260.13379-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 May 2003, Werner Almesberger wrote:

> > the attached scheduler cleanup (against BK-curr) removes the unused
> > requeueing code. Compiles & boots.
> 
> Ah, what a sweet way of getting rid of my nemesis :-)
> 
> The requeuing code troubled me quite a bit with umlsim, which makes all
> kinds of calls from the idle task, including calls to try_to_wake_up, or
> functions that eventually call it. Naturally, whenever the requeuing was
> used, it tripped over current->array. (And even with a fake array, it
> would have had ill effects.)
> 
> So the requeuing didn't do anything for processes other than the idle
> task ?

hm, it should in fact have been dead code from 2.5.68 on and upwards.  
Before that it was called quite often.

but doing stuff out of the idle thread is not nice i think, there's a fair
amount of code that does not work out of the idle task. Any reason you
dont start some really-low-prio thread instead? (i could suggest
SCHED_BATCH but the scheduler doesnt have it :-)

	Ingo

