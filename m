Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVCZQcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVCZQcQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 11:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbVCZQcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 11:32:16 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:28823 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261159AbVCZQcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 11:32:12 -0500
Date: Sat, 26 Mar 2005 11:31:56 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Ingo Molnar <mingo@elte.hu>
cc: Esben Nielsen <simlo@phys.au.dk>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
In-Reply-To: <20050325061907.GA20242@elte.hu>
Message-ID: <Pine.LNX.4.58.0503261125420.27746@localhost.localdomain>
References: <20050324113912.GA20911@elte.hu> <Pine.OSF.4.05.10503242307330.25274-100000@da410.phys.au.dk>
 <20050325061907.GA20242@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 25 Mar 2005, Ingo Molnar wrote:
> * Esben Nielsen <simlo@phys.au.dk> wrote:
>
> > I like the idea of having the scheduler take care of it - it is a very
> > optimal coded queue-system after all. That will work on UP but not on
> > SMP. Having the unlock operation to set the mutex in a "partially
> > owned" state will work better. The only problem I see, relative to
> > Ingo's implementation, is that then the awoken task have to go in and
> > change the state of the mutex, i.e. it has to lock the wait_lock
> > again. Will the extra schedulings being the problem happen offen
> > enough in practise to have the extra overhead?
>
> i think this should be covered by the 'unschedule/unwakeup' feature,
> mentioned in the latest mails.
>

The first implementation would probably just be the setting of a "pending
owner" bit. But the better one may be to unschedule. But, what would the
overhead be for unscheduling. Since you need to grab the run queue locks
for that. This might make for an interesting case study. The waking up of
a process who had the lock stolen may not happen that much.  The lock
stealing, would (as I see in my runs) happen quite a bit though. But on
UP, the waking of the robbed owner, would never happen, unless it also
owned a lock that a higher priority process wanted.

-- Steve

