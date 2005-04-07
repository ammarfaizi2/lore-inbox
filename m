Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261749AbVDGHVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbVDGHVe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 03:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261758AbVDGHVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 03:21:34 -0400
Received: from mx1.elte.hu ([157.181.1.137]:36747 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261749AbVDGHVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 03:21:21 -0400
Date: Thu, 7 Apr 2005 09:15:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [patch 5/5] sched: consolidate sbe sbf
Message-ID: <20050407071553.GB26607@elte.hu>
References: <425322E0.9070307@yahoo.com.au> <42532317.5000901@yahoo.com.au> <42532346.5050308@yahoo.com.au> <425323A1.5030603@yahoo.com.au> <42532427.3030100@yahoo.com.au> <20050406062723.GC5973@elte.hu> <4253993C.4020505@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4253993C.4020505@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> We could just do a set_cpus_allowed, or take the lock, 
> set_cpus_allowed, and take the new lock, but that's probably a bit 
> heavy if we can avoid it. In the interests of speed in this fast path, 
> do you think we can do this in sched_fork, before the task has even 
> been put on the tasklist?

yeah, that shouldnt be a problem. Technically we set cpus_allowed up 
under the tasklist lock just to be non-preemptible and to copy the 
parent's _current_ affinity to the child. But sched_fork() is called 
just before and if the parent got its affinity changed between the two 
calls, so what? I'd move all of this code into sched_fork().

> That would avoid all locking problems. Passing clone_flags into 
> sched_fork would not be a problem if we want to distinguish fork() and 
> clone(CLONE_VM).

sure, that was the plan all along with sched_fork() anyway. (i think the 
initial versions had the flag)

> Yes? I'll cut a new patch to do just that.

sure, fine by me.

	Ingo
