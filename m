Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbVCXRvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVCXRvt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 12:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262641AbVCXRvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 12:51:48 -0500
Received: from mx1.elte.hu ([157.181.1.137]:22912 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261578AbVCXRvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 12:51:47 -0500
Date: Thu, 24 Mar 2005 18:51:27 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
Message-ID: <20050324175127.GA25108@elte.hu>
References: <20050322100153.GA23143@elte.hu> <20050322112856.GA25129@elte.hu> <20050323061601.GE1294@us.ibm.com> <20050323063317.GB31626@elte.hu> <20050324052854.GA1298@us.ibm.com> <20050324053456.GA14494@elte.hu> <Pine.LNX.4.58.0503240310490.18714@localhost.localdomain> <Pine.LNX.4.58.0503240341280.18714@localhost.localdomain> <20050324113912.GA20911@elte.hu> <Pine.LNX.4.58.0503240916210.18714@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503240916210.18714@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> > but i think i like the 'partial owner' (or rather 'owner pending')
> > technique a bit better, because it controls concurrency explicitly, and
> > it would thus e.g. allow another trick: when a new owner 'steals' a lock
> > from another in-flight task, then we could 'unwakeup' that in-flight
> > thread which could thus avoid two more context-switches on e.g. SMP
> > systems: hitting the CPU and immediately blocking on the lock. (But this
> > is a second-phase optimization which needs some core scheduler magic as
> > well, i guess i'll be the one to code it up.)
> 
> Darn! It seemed like fun to implement. I may do it myself anyway on my 
> kernel just to understand your implementation even better.

feel free to implement the whole thing. Unscheduling a task should be 
done carefully, for obvious reasons. (I've implemented it once 1-2 years 
ago for a different purpose, to unschedule ksoftirqd - it ought to be 
somewhere in the lkml archives.)

	Ingo
