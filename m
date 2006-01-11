Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbWAKVqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWAKVqE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 16:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbWAKVqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 16:46:04 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:13749 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1750910AbWAKVqC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 16:46:02 -0500
Date: Wed, 11 Jan 2006 22:45:42 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Ingo Molnar <mingo@elte.hu>, david singleton <dsingleton@mvista.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: RT Mutex patch and tester [PREEMPT_RT]
In-Reply-To: <Pine.LNX.4.58.0601111240020.31180@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.44L0.0601112229540.16715-100000@lifa01.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 11 Jan 2006, Steven Rostedt wrote:

>
> On Wed, 11 Jan 2006, Esben Nielsen wrote:
> [snip]
>
> If I get time, I might be able to finish this up, if the changes look
> decent, and don't cause too much overhead.

This was the answer I was hoping for!  I'll try to get time to test and
improve myself ofcourse.
As for optimization: I take and release the current->pi_lock and
owner->pi_lock a lot because it isn't allowed to have both locks. Some
code restructuring could probably improve it such that it first finishes
what it has to finish under current->pi_lock then does what it has to do
under the owner->pi_lock - or the other way around.
In a few places pi_lock is taken without just to be sure. It might be
removed.

But first we have to establish the principle. Then optimization can begin.

Esben

>
> -- Steve
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

