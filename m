Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268175AbTCFRG4>; Thu, 6 Mar 2003 12:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268177AbTCFRG4>; Thu, 6 Mar 2003 12:06:56 -0500
Received: from mx2.elte.hu ([157.181.151.9]:31151 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S268175AbTCFRGz>;
	Thu, 6 Mar 2003 12:06:55 -0500
Date: Thu, 6 Mar 2003 18:17:11 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <3E6770F3.8030207@pobox.com>
Message-ID: <Pine.LNX.4.44.0303061814080.14035-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Mar 2003, Jeff Garzik wrote:

> Pardon the suggestion of a dumb hueristic, feel free to ignore me:  
> would it work to run-first processes that have modified their iopl()  
> level?  i.e. "if you access hardware directly, we'll treat you specially
> in the scheduler"?

we did this in the Red Hat kernel, just as a quick hack to boost X without
having to modify X (bleh). While it worked very well in practice, it's a
really bad idea from an interface design POV, because it singles out X
mostly based on a random characteristics of X, but leaves out some other
tasks that are 'suffering' from not being recognized as interactive, but
still having a user watching them (and expecting keypresses to react
fast): games, xine, XMMS, etc.

> An alternative is to encourage distros to set some sort of flag for
> processes like the X server, when it is run.  This sounds suspiciously
> like the existing "renice X server" hack, but it could be something like
> changing the X server from SCHED_OTHER to SCHED_HW_ACCESS instead.

yes, an ELF flag might work, or my suggestion to allow applications to
increase their priority (up until a certain degree).

	Ingo

