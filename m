Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWC1UDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWC1UDT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 15:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWC1UDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 15:03:19 -0500
Received: from [212.76.87.71] ([212.76.87.71]:40972 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751275AbWC1UDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 15:03:19 -0500
From: Al Boldi <a1426z@gawab.com>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: scheduler starvation resistance patches for 2.6.16
Date: Tue, 28 Mar 2006 23:01:55 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200603272136.07908.a1426z@gawab.com> <1143522632.7441.16.camel@homer> <1143537120.10571.5.camel@homer>
In-Reply-To: <1143537120.10571.5.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603282301.55314.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> On Tue, 2006-03-28 at 07:10 +0200, Mike Galbraith wrote:
> > On Mon, 2006-03-27 at 21:36 +0300, Al Boldi wrote:
> > > It's not bad.  w/ credit_c1/2 set to 0 results in an improvement in
> > > running the MESA demos  "# gears & reflect & morph3d" .
> >
> > Hmm.  That's unexpected.
> >
> > > But a simple "# while :; do :; done &" (10x) makes a "# ping 10.1 -A
> > > -s8" choke.
> >
> > Ouch, so is that.  But thanks, testcases are great.  I'll look into it.
>
> OK, this has nothing to do with my patches.  The same slowdown happens
> with a stock kernel when running a few pure cpu hogs.  I suspect it has
> to do with softirqd, but am still investigating.

I think so too.

I played with some numbers inside sched.c.  Raising the MIN_TIMESLICE from 1 
to between 10-100  affects interactivity positively, although it does not 
fix it entirely.

It does look like there is an underlying problem (locking?) that may be 
worked-around by tuning the scheduler to some extent.

Also, MAX_TIMESLICE = 800 seems a bit high.  Can this be lowered?

Thanks!

--
Al

