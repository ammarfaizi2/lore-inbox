Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270692AbUJVEnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270692AbUJVEnh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 00:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270768AbUJVElt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 00:41:49 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:21410 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S270692AbUJUSaD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 14:30:03 -0400
Date: Thu, 21 Oct 2004 14:29:32 -0400
To: "Eugeny S. Mints" <emints@ru.mvista.com>
Cc: Scott Wood <scott@timesys.com>, john cooper <john.cooper@timesys.com>,
       Esben Nielsen <simlo@phys.au.dk>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@suse.de>,
       Rui Nuno Capela <rncbc@rncbc.org>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       "Ext-Rt-Dev@Mvista. Com" <ext-rt-dev@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041021182932.GA26530@yoda.timesys>
References: <Pine.OSF.4.05.10410211601500.11909-100000@da410.ifa.au.dk> <4177CD3C.9020201@timesys.com> <4177DA11.4090902@ru.mvista.com> <4177E89A.1090100@timesys.com> <20041021173302.GA26318@yoda.timesys> <4177FB89.8030708@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4177FB89.8030708@ru.mvista.com>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 10:10:17PM +0400, Eugeny S. Mints wrote:
> Scott Wood wrote:
> >If you keep it in priority order, then you're paying the O(n) cost
> >every time you acquire a lock.  If you keep it unordered and only
> >search it when you need to recalculate a task's priority after a lock
> >has been released (or priorities have been changed), you pay the cost
> >much less often.  Plus, the number of locks held by any given thread
> >should generally be very small.
> As to locks held by any given thread - it's not always true - take a 
> look at mm/filemap.c locks nesting map in comments.

I guess it depends on the definition of "very small" and "generally".
:-)

A nesting of 5 locks is pushing the limits of "very small", but it's
still no big deal to iterate over once in a while.

-Scott
