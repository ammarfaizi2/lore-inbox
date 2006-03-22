Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWCVDth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWCVDth (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 22:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWCVDth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 22:49:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:30914 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750721AbWCVDtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 22:49:36 -0500
X-Authenticated: #14349625
Subject: Re: interactive task starvation
From: Mike Galbraith <efault@gmx.de>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Willy Tarreau <willy@w.ods.org>, Ingo Molnar <mingo@elte.hu>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Con Kolivas <kernel@kolivas.org>, bugsplatter@gmail.com
In-Reply-To: <44208355.1080200@bigpond.net.au>
References: <1142592375.7895.43.camel@homer>
	 <1142615721.7841.15.camel@homer> <1142838553.8441.13.camel@homer>
	 <20060321064723.GH21493@w.ods.org> <1142927498.7667.34.camel@homer>
	 <20060321091353.GA25248@w.ods.org> <20060321091422.GA9207@elte.hu>
	 <20060321111552.GA25651@w.ods.org> <20060321111850.GA2776@elte.hu>
	 <1142942878.7807.9.camel@homer>  <20060321125900.GA25943@w.ods.org>
	 <1142947456.7807.53.camel@homer>  <44208355.1080200@bigpond.net.au>
Content-Type: text/plain
Date: Wed, 22 Mar 2006 04:49:42 +0100
Message-Id: <1142999382.11047.34.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-22 at 09:51 +1100, Peter Williams wrote:
> Mike Galbraith wrote:
> > On Tue, 2006-03-21 at 13:59 +0100, Willy Tarreau wrote:
> >>That would suit me perfectly. I think I would set them both to zero.
> >>It's not clear to me what workload they can help, it seems that they
> >>try to allow a sometimes unfair scheduling.
> > 
> > 
> > Correct.  Massively unfair scheduling is what interactivity requires.
> > 
> 
> Selective unfairness not massive unfairness is what's required.  The 
> hard part is automating the selectiveness especially when there are 
> three quite different types of task that need special treatment: 1) the 
> X server, 2) normal interactive tasks and 3) media streamers; each of 
> which has different behavioural characteristics.  A single mechanism 
> that classifies all of these as "interactive" will unfortunately catch a 
> lot of tasks that don't belong to any one of these types.

Yes, selective would be nice, but it's still massively unfair that is
required.  There is no criteria available for discrimination, so my
patches don't even try to classify, they only enforce the rules.  I
don't classify X as interactive, I merely provide a mechanism which
enables X to accumulate the cycles an interactive task needs to be able
to perform by actually _being_ interactive, by conforming to the
definition of sleep_avg.  Fortunately, it uses that mechanism.  I do
nothing more than trade stout rope for good behavior.  I anchor one end
to a boulder, the other to a task's neck.  The mechanism is agnostic.
The task determines whether it gets hung or not, and the user determines
how long the rope is.

	-Mike

