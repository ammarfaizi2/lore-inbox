Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbUKPRTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUKPRTQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 12:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbUKPRS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 12:18:59 -0500
Received: from mx1.elte.hu ([157.181.1.137]:60845 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262043AbUKPRSf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 12:18:35 -0500
Date: Tue, 16 Nov 2004 11:48:21 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Dean Nelson <dcn@sgi.com>
Cc: Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] export sched_setscheduler() for kernel module use
Message-ID: <20041116104821.GA31395@elte.hu>
References: <4198F70D.mailxMSZ11J00J@aqua.americas.sgi.com> <20041115105801.T14339@build.pdx.osdl.net> <20041115203343.GA32173@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041115203343.GA32173@sgi.com>
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

> On Mon, Nov 15, 2004 at 10:58:01AM -0800, Chris Wright wrote:
> > * Dean Nelson (dcn@sgi.com) wrote:
> > > +int do_sched_setscheduler(pid_t pid, int policy, struct sched_param __user *param)
> > 
> > this should be static.
> 
> You're right. I made another change in that one now passes the
> task_struct pointer to sched_setscheduler() instead of the pid. This
> requires that the caller of sched_setscheduler() hold the
> tasklist_lock. The new patch for people's feedback follows.

could you make sched_setscheduler() also include a parameter for the
nice value, so that ->static_prio could be set at the same time too
(which would have relevance if SCHED_OTHER is used)? This would make it
a generic kernel-internal API to change all the priority parameters.
Looks good otherwise.

	Ingo
