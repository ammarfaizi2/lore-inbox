Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270732AbUJURix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270732AbUJURix (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 13:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270768AbUJURiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 13:38:50 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:33682 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S270732AbUJURdl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 13:33:41 -0400
Date: Thu, 21 Oct 2004 13:33:02 -0400
To: john cooper <john.cooper@timesys.com>
Cc: "Eugeny S. Mints" <emints@ru.mvista.com>, Esben Nielsen <simlo@phys.au.dk>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Jens Axboe <axboe@suse.de>, Rui Nuno Capela <rncbc@rncbc.org>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041021173302.GA26318@yoda.timesys>
References: <Pine.OSF.4.05.10410211601500.11909-100000@da410.ifa.au.dk> <4177CD3C.9020201@timesys.com> <4177DA11.4090902@ru.mvista.com> <4177E89A.1090100@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4177E89A.1090100@timesys.com>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 12:49:30PM -0400, john cooper wrote:
> It would seem a mutex ownership list still needs to be maintained.
> Doing so in unordered priority will give a small fixed insertion
> time, but will require an exhaustive search in order to calculate
> maximum priority. Doing so in priority order will require an
> average of #mutex_owned / 2 for the insertion, and gives a fixed
> time for maximum priority calculation. The latter appears to offer
> a performance benefit to the degree the incoming priorities are
> random.

If you keep it in priority order, then you're paying the O(n) cost
every time you acquire a lock.  If you keep it unordered and only
search it when you need to recalculate a task's priority after a lock
has been released (or priorities have been changed), you pay the cost
much less often.  Plus, the number of locks held by any given thread
should generally be very small.

-Scott
