Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbWBPTHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbWBPTHo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 14:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWBPTHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 14:07:44 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:63949 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S932319AbWBPTHn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 14:07:43 -0500
Date: Thu, 16 Feb 2006 20:06:48 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Ulrich Drepper <drepper@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 0/6] lightweight robust futexes: -V3 - Why in userspace?
In-Reply-To: <1140111257.21681.26.camel@localhost.localdomain>
Message-Id: <Pine.OSF.4.05.10602161956400.20911-100000@da410>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just jump into a thread somewhere to ask my question :-)

Why does the list have to be in userspace?

As I see it there can only be a problem when some thread has done
FUTEX_WAIT and is blocked. If no task is blocked (or on it's way to
being blocked) there is no problem. 

The solution I could imagine was the FUTEX_WAIT operation adds the
waiting task to a list of waiters attached to the mutex owner's task_t
(which is known by it's pid in the userspace flag) just before calling
schedule(). This list needs to be protected by a spinlock, ofcourse.
When a task dies it can wake up the waiters on it's list without relying
on the userspace.

What race conditions have I missed?

Esben




On Thu, 16 Feb 2006, Daniel Walker wrote:

> On Thu, 2006-02-16 at 18:24 +0100, Ingo Molnar wrote:
> > * Daniel Walker <dwalker@mvista.com> wrote:
> > 
> > > Another thing I noticed was that futex_offset on the surface looks 
> > > like a malicious users dream variable .. [...]
> > 
> > i have no idea what you mean by that - could you explain whatever threat 
> > you have in mind, in more detail?
> 
> 	As I said, "on the surface" you could manipulate the futex_offset to
> access memory unrelated to the futex structure . That's all I'm
> referring too .. 
> 
> Daniel
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

