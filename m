Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbWALLfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWALLfj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 06:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWALLfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 06:35:39 -0500
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:31213
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S964833AbWALLfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 06:35:38 -0500
Date: Thu, 12 Jan 2006 03:33:16 -0800
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       david singleton <dsingleton@mvista.com>, linux-kernel@vger.kernel.org,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: RT Mutex patch and tester [PREEMPT_RT]
Message-ID: <20060112113316.GA14416@gnuppy.monkey.org>
References: <Pine.LNX.4.44L0.0601111816360.16743-201000@lifa03.phys.au.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0601111816360.16743-201000@lifa03.phys.au.dk>
User-Agent: Mutt/1.5.11
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 06:25:36PM +0100, Esben Nielsen wrote:
> I have done 2 things which might be of interrest:
> 
> II) I changed the priority inheritance mechanism in rt.c,
> optaining the following goals:
> 3) Simpler code. rt.c was kind of messy. Maybe it still is....:-)

Awssome. The code was done in what seems like a hurry and mixes up a
bunch of things that should be seperate out into individual sub-sections.

The allocation of the waiter object on the thread's stack should undergo
some consideration of whether this should be move into a more permanent
store. I haven't looked at an implementation of turnstiles recently, but
I suspect that this is what it actually is and it would eliminate the
moving of waiters to the thread that's is actively running with the lock
path terminal mutex. It works, but it's sloppy stuff.

[loop trickery, priority leanding operations handed off to mutex owner]

> What is gained is that the amount of time where irq and preemption is off
> is limited: One task does it's work with preemption disabled, wakes up the
> next and enable preemption and schedules. The amount of time spend with
> preemption disabled is has a clear upper limit, untouched by how
> complicated and deep the lock structure is.

task_blocks_on_lock() is another place that one might consider seperating
out some bundled functionality into different places in the down()
implementation. I'll look at the preemption stuff next.

Just some ideas. Looks like a decent start.

bill

