Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264299AbUISVrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbUISVrp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 17:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264377AbUISVro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 17:47:44 -0400
Received: from mx2.elte.hu ([157.181.151.9]:34196 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264299AbUISVra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 17:47:30 -0400
Date: Sun, 19 Sep 2004 23:49:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm1-S1
Message-ID: <20040919214920.GA8616@elte.hu>
References: <200409192232.20139.annabellesgarden@yahoo.de> <20040919204841.GA7004@elte.hu> <200409192311.37639.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409192311.37639.annabellesgarden@yahoo.de>
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


* Karsten Wiese <annabellesgarden@yahoo.de> wrote:

> Am Sonntag 19 September 2004 22:48 schrieb Ingo Molnar:
> >
> > The point is to let gettimeofday(0,1) start tracing and
> > gettimeofday(0,0) stop tracing - a system-call-controlled tracing
> > facility (if trace_enabled=2). This was used to trace weird latencies
> > before, but it's not the normal mode of operation.
> >
> Ok. The other point is a page_fault being generated later on in 
> sys_gettimeofday() if tz is not reset:
> >>>>
> 	if (unlikely(tz != NULL)) {
>                      ^^
> 		if (copy_to_user(tz, &sys_tz, sizeof(sys_tz)))
> 			return -EFAULT;
> 	}
> <<<<

yeah - it's a bit ugly. The right thing is to return from that branch.

	Ingo
