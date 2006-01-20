Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbWATLgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbWATLgr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 06:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbWATLgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 06:36:47 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:53974 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750731AbWATLgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 06:36:46 -0500
Date: Fri, 20 Jan 2006 12:36:26 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>,
       George Anzinger <george@wildturkeyranch.net>,
       Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 4/7] [hrtimers] Fix posix-timer requeue race
In-Reply-To: <20060120021342.813743000@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.61.0601201218530.11765@scrub.home>
References: <20060120021336.134802000@tglx.tec.linutronix.de>
 <20060120021342.813743000@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 20 Jan 2006, Thomas Gleixner wrote:

> CPU0 expires a posix-timer and runs the callback function.
> The signal is queued.
> After releasing the posix-timer lock and before returning to
> hrtimer_run_queue CPU0 gets interrupted.
> CPU1 delivers the queued signal and rearms the timer.
> CPU0 comes back to hrtimer_run_queue and sets the timer state to expired.
> The next modification of the timer can result in an oops, because the state
> information is wrong.

Thomas, this is exactly what I meant with overloaded state machines,
enumerated states are very hard to get right with concurrent processes.
Please get rid of the state field and at least use a flag field instead.

bye, Roman
