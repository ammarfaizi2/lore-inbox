Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVCOMBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVCOMBE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 07:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbVCOMBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 07:01:04 -0500
Received: from mx2.elte.hu ([157.181.151.9]:61653 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261179AbVCOMBD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 07:01:03 -0500
Date: Tue, 15 Mar 2005 13:00:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
Message-ID: <20050315120053.GA4686@elte.hu>
References: <Pine.LNX.4.58.0503110754240.19798@localhost.localdomain> <20050311153817.GA32020@elte.hu> <Pine.LNX.4.58.0503111440190.22043@localhost.localdomain> <1110574019.19093.23.camel@mindpipe> <1110578809.19661.2.camel@mindpipe> <Pine.LNX.4.58.0503140214360.697@localhost.localdomain> <Pine.LNX.4.58.0503140427560.697@localhost.localdomain> <Pine.LNX.4.58.0503140509170.697@localhost.localdomain> <Pine.LNX.4.58.0503141024530.697@localhost.localdomain> <Pine.LNX.4.58.0503150641030.6456@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503150641030.6456@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> I've realized that my previous patch had too many problems with the
> way the journaling system works.  So I went back to my first approach
> but added the journal_head lock as one global lock to keep the buffer
> head size smaller. I only added the state lock to the buffer head.
> I've tested this for some time now, and it works well (for the test at
> least). I'll recompile it with PREEMPT_DESKTOP to see if that works
> too.

good progress - but the global lock may be a scalability worry on
upstream though. Would it be possible to just mirror much of the current
lock logic, but with spinlocks instead of bitlocks? And there should be
no #ifdefs on PREEMPT_RT.

	Ingo
