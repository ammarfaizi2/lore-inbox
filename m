Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbVCHFuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbVCHFuX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 00:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbVCHFuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 00:50:22 -0500
Received: from mx1.elte.hu ([157.181.1.137]:52929 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261533AbVCHFuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 00:50:03 -0500
Date: Tue, 8 Mar 2005 06:49:31 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>,
       paul@linuxaudiosystems.com, joq@io.com, cfriesen@nortelnetworks.com,
       chrisw@osdl.org, hch@infradead.org, rlrevell@joe-job.com,
       arjanv@redhat.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050308054931.GA20200@elte.hu>
References: <20050112185258.GG2940@waste.org> <200501122116.j0CLGK3K022477@localhost.localdomain> <20050307195020.510a1ceb.akpm@osdl.org> <20050308043349.GG3120@waste.org> <20050307204044.23e34019.akpm@osdl.org> <422D3AB2.9020409@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422D3AB2.9020409@bigpond.net.au>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Williams <pwil3058@bigpond.net.au> wrote:

> I don't object to rlimits per se and I think that they are useful but
> not as a sole solution to this problem.  Being able to give a task
> preferential treatment is a permissions issue and should be solved as
> one.
> 
> Having RT cpu usage limits on tasks is a useful tool to have when
> granting normal users the privilege of running tasks as RT tasks so
> that you can limit the damage that they can do BUT the presence of a
> limit on a task is not a very good criterion for granting that
> privilege.

i think you are talking about my rlimit patch (the 'RT CPU limit' patch)
- but that one is not in discussion here.

what is being discussed currently is the other rlimit patch (from Chris
Wright and Matt Mackall) which implements a simple rlimit ceiling for
the RT (and nice) priorities a task can set. The rlimit defaults to 0,
meaning no change in behavior by default. A value of 50 means RT
priority levels 1-50 are allowed. A value of 100 means all 99 privilege
levels from 1 to 99 are allowed. CAP_SYS_NICE is blanket permission.
It's all pretty finegrained and and it's a quite straightforward
extension of what we have today. The patch does not attempt to do any
"damage control" of abuse caused by RT tasks, and is hence much simpler
than my patch or Con's SCHED_ISO patch. ("damage control" could be done
from userspace anyway)

	Ingo
