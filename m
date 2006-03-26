Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWCZWFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWCZWFI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 17:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWCZWFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 17:05:08 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:3053 "EHLO lirs02.phys.au.dk")
	by vger.kernel.org with ESMTP id S932127AbWCZWFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 17:05:06 -0500
Date: Sun, 26 Mar 2006 23:04:59 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>, <tglx@linutronix.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rt7 and deadlock detection.
In-Reply-To: <Pine.LNX.4.44L0.0603262214060.8060-100000@lifa03.phys.au.dk>
Message-ID: <Pine.LNX.4.44L0.0603262255150.8060-100000@lifa03.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Mar 2006, Esben Nielsen wrote:

> I don't get any print outs of any deadlock detection with many of my
> tests.
> When there is a deadlock down() simply returns instead of blocking
> forever.

rt_mutex_slowlock seems to return -EDEADLK even though caller didn't ask
for deadlock detection (detect_deadlock=0). That is bad because then the
caller will not check for it. It ought to simply leave the task blocked.

It only happens with CONFIG_DEBUG_RT_MUTEXES. That one also messes up the
task->pi_waiters as earlier reported.

Esben

>
> Esben
>
>
>
> On Sun, 26 Mar 2006, Esben Nielsen wrote:
>
> > It just looks like also normal, non-rt tasks are boosting.
> >
> > Esben
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

