Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751758AbWCOLVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758AbWCOLVf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 06:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbWCOLVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 06:21:35 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:48066 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1751756AbWCOLVf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 06:21:35 -0500
Date: Wed, 15 Mar 2006 12:21:26 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Thomas Gleixner <tglx@linutronix.de>
cc: Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16-rc6-rt1
In-Reply-To: <1142374937.19916.665.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.0603151128510.32591-100000@lifa01.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2006, Thomas Gleixner wrote:

> On Tue, 2006-03-14 at 23:11 +0100, Ingo Molnar wrote:
> > > > no. We have to run deadlock detection to avoid things like circular lock
> > > > dependencies causing an infinite schedule+wakeup 'storm' during priority
> > > > boosting. (like possible with your wakeup based method i think)
> > > No, all tasks would just settle on the highest priority and then the
> > > wakeups would stop.
> >
> > you are right, that shouldnt be possible. But how about other, SMP
> > artifacts? What if the woken up task runs on another CPU, and the whole
> > chain of boosting is thus delayed?
>
> And it does not solve the problem of ad hoc deadlock detection at all.
>

I have a feeling that it can't be done without a global lock.
The idea I have with releasing the all locks in each iteration might not
give reliable results for deadlocking.

Esben

> 	tglx
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

