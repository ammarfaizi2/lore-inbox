Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbUKPVgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbUKPVgv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 16:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbUKPVfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 16:35:00 -0500
Received: from mx2.elte.hu ([157.181.151.9]:9944 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261829AbUKPVeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 16:34:09 -0500
Date: Tue, 16 Nov 2004 23:36:08 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Dean Nelson <dcn@sgi.com>
Cc: Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] export sched_setscheduler() for kernel module use
Message-ID: <20041116223608.GA27550@elte.hu>
References: <4198F70D.mailxMSZ11J00J@aqua.americas.sgi.com> <20041115105801.T14339@build.pdx.osdl.net> <20041115203343.GA32173@sgi.com> <20041116104821.GA31395@elte.hu> <20041116201841.GA29687@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041116201841.GA29687@sgi.com>
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


* Dean Nelson <dcn@sgi.com> wrote:

> > could you make sched_setscheduler() also include a parameter for the
> > nice value, so that ->static_prio could be set at the same time too
> > (which would have relevance if SCHED_OTHER is used)? This would make it
> > a generic kernel-internal API to change all the priority parameters.
> > Looks good otherwise.
> 
> Yeah, I can do that. I'll probably be getting back to you with a
> question or two, if what you're after isn't obvious once I start
> making the changes for the nice parameter.

another potential API would be to use the linear priority range that the
scheduler has internally, from 0 (RT prio 99) to 140 (nice +19). I'm not
sure which solution is the better one. Using the linear priority has the
advantage of not having to pass any policy value - priorities between 0
and 99 implicitly mean SCHED_FIFO, priorities above that would mean
SCHED_NORMAL, a pretty natural and compact interface.

	Ingo
