Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262867AbUKXVc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262867AbUKXVc4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 16:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262864AbUKXVcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 16:32:43 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:16533 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262778AbUKXVa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 16:30:29 -0500
Subject: Re: Suspend 2 merge: 22/51: Suspend2 lowlevel code.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0411240931470.7171@musoma.fsmlabs.com>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101296166.5805.279.camel@desktop.cunninghams>
	 <Pine.LNX.4.61.0411240931470.7171@musoma.fsmlabs.com>
Content-Type: text/plain
Message-Id: <1101331206.3895.40.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 25 Nov 2004 08:20:06 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-11-25 at 03:42, Zwane Mwaikambo wrote:
> Ok,
> 	Do you see anything missing (from an implementation point of view) 
> for the following?
> 
> Suspend:
> 	1) suspend all cpus, save cpu0
> 	2) proceed with state saving on cpu0 only
> 	3) begin suspend
> 	
> Resume:
> 	1) begin resume
> 	2) offline all currently online cpus
> 	3) proceed with state restoring
> 	4) online all previously online cpus

That's roughly what we're doing now, apart from the offlining/onlining.
I had considered trying to take better advantage of SMP support (perhaps
run a decompression thread on one CPU and the writer on the other, eg),
so we might want to apply this just to the region immediately around the
atomic copy/restore. That makes me wonder, though, what the advantage is
to switching to using the hotplug functionality - is it x86 only, or
more cross platform? (If more cross platform, that might possibly be an
advantage over the current code).

> A lot of the subsystems which have work split across cpus will now have 
> work migrated across to cpu0, in that regard, which have you made swsusp 
> savvy? It looks like the timer changes might need looking at any others?

All of the other threads, including the migration threads, are frozen,
so I don't believe that anything gets migrated to CPU0. I'll double
check when I next suspend.

As to the timers, I fully agree. Thawing them needs a mechanism for
keeping the per-cpu timers staggered.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

