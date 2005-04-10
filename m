Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbVDJKcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVDJKcX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 06:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVDJKcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 06:32:23 -0400
Received: from mx2.elte.hu ([157.181.151.9]:51642 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261466AbVDJKcT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 06:32:19 -0400
Date: Sun, 10 Apr 2005 12:31:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
Message-ID: <20050410103134.GA6234@elte.hu>
References: <1112273378.3691.228.camel@localhost.localdomain> <20050331141040.GA2544@elte.hu> <1112290916.12543.19.camel@localhost.localdomain> <20050331174927.GA11483@elte.hu> <1112317173.28076.10.camel@localhost.localdomain> <20050401044307.GB22753@elte.hu> <1112332426.28076.21.camel@localhost.localdomain> <20050401051947.GA23990@elte.hu> <1112358445.28076.23.camel@localhost.localdomain> <1112908910.22577.54.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112908910.22577.54.camel@localhost.localdomain>
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

> > > yeah - i think Andrew said that a global lock at that particular place 
> > > might not be that much of an issue.
> > 
> > OK, I'll start stripping it out of my kernel today and make a clean
> > patch for you.
> 
> Ingo, I haven't forgotten about this, I just been heavily bug wacking 
> lately and just haven't had the time to do this.
> 
> I've pulled out both the lock_bh_state and lock_bh_journal_head and 
> made them two global locks.  I haven't noticed any slowing down here, 
> but then again I haven't ran any real benchmarks.  There's a BH flag 
> set to know when the lock is pending on a specific buffer head.
> 
> I don't know how acceptable this patch is. Take a look and if you have 
> any better ideas then let me know.  I prefer this patch over the 
> wait_on_bit patch I sent you earlier since this patch still accounts 
> for priority inheritance, as the wait_on_bits don't.

looks much cleaner than earlier ones. Would it be possible to make the 
locks per journal? I've applied it to the -44-05 kernel so that it gets 
some testing.

	Ingo
