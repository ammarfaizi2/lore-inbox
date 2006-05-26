Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWEZL2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWEZL2m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 07:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWEZL2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 07:28:42 -0400
Received: from mail.gmx.de ([213.165.64.20]:56796 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932306AbWEZL2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 07:28:41 -0400
X-Authenticated: #14349625
Subject: Re: [RFC 2/5] sched: Add CPU rate soft caps
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Peter Williams <pwil3058@bigpond.net.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
In-Reply-To: <200605262117.41806.kernel@kolivas.org>
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>
	 <200605262048.53131.kernel@kolivas.org> <1148642155.7602.19.camel@homer>
	 <200605262117.41806.kernel@kolivas.org>
Content-Type: text/plain
Date: Fri, 26 May 2006 13:30:19 +0200
Message-Id: <1148643019.7602.30.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-26 at 21:17 +1000, Con Kolivas wrote:
> On Friday 26 May 2006 21:15, Mike Galbraith wrote:
> > On Fri, 2006-05-26 at 20:48 +1000, Con Kolivas wrote:
> > > On Friday 26 May 2006 14:20, Peter Williams wrote:
> > > > 3. Enforcement of caps is not as strict as it could be in order to
> > > > reduce the possibility of a task being starved of CPU while holding
> > > > an important system resource with resultant overall performance
> > > > degradation.  In effect, all runnable capped tasks will get some amount
> > > > of CPU access every active/expired swap cycle.  This will be most
> > > > apparent for small or zero soft caps.
> > >
> > > The array swap happens very frequently if there are nothing but heavily
> > > cpu bound tasks, which is not an infrequent workload. I doubt the zero
> > > caps are very effective in that environment.
> >
> > Hmm.  I think that came out kinda back-assward.  You meant "the array
> > swap happens very frequently _unless_..."  No?
> 
> No I didn't. If all you are doing is compiling code then the array swap will 
> happen often as they will always use up their full timeslice and expire. 
> Therefore an array swap will follow shortly afterwards.

Afterward being possibly ages.  Frequent array switch happens when you
have mostly sleepy processes, not cpu bound.  But whatever.

> > But anyway, I can't think of any reason to hold back an uncontested
> > resource.
> 
> If you are compiling applications it's a contested resource.

These zero capped tasks are at the bottom of the heap.  They won't be
selected if there's any other runnable task, so it's not contested.

	-Mike

