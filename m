Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWDJKAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWDJKAA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 06:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWDJKAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 06:00:00 -0400
Received: from mail.gmx.de ([213.165.64.20]:64160 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751108AbWDJJ77 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 05:59:59 -0400
X-Authenticated: #14349625
Subject: Re: [patch][rfc] quell interactive feeding frenzy
From: Mike Galbraith <efault@gmx.de>
To: bert hubert <bert.hubert@netherlabs.nl>
Cc: Con Kolivas <kernel@kolivas.org>, lkml <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
In-Reply-To: <20060410091248.GA32468@outpost.ds9a.nl>
References: <1144402690.7857.31.camel@homer>
	 <200604072256.27665.kernel@kolivas.org> <1144417064.8114.26.camel@homer>
	 <200604072356.03580.kernel@kolivas.org> <1144419294.14231.7.camel@homer>
	 <20060409111436.GA26533@outpost.ds9a.nl> <1144582778.13991.10.camel@homer>
	 <20060409121436.GA28075@outpost.ds9a.nl> <1144606061.7408.14.camel@homer>
	 <20060410091248.GA32468@outpost.ds9a.nl>
Content-Type: text/plain
Date: Mon, 10 Apr 2006 12:00:42 +0200
Message-Id: <1144663242.8040.27.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-10 at 11:12 +0200, bert hubert wrote:
> On Sun, Apr 09, 2006 at 08:07:41PM +0200, Mike Galbraith wrote:
> > Rare?  What exactly is rare about a number of tasks serving data?  I
> > don't care if it's a P4 serving gigabit.  If you have to divide your
> > server into pieces (you do, and you know it) you're screwed. 
> 
> You've not detailed your load. I assume it consists of lots of small files
> being transferred over 10 apache processes? I also assume you max out your
> system using apachebench?

It's just retrieving the directory, so it's all cached.  Yes, it's ab.  

If it had to hit disk constantly, I'd probably be able to login, because
the stock scheduler blocks IO bound tasks from achieving max priority.

> In general, Linux systems are not maxed out as they will disappoint that way
> (like any system running with id=0). 
> 
> So yes, what you do is a 'rare load' as anybody trying to do this will
> disappoint his users.

Ok, it's rare... if you buy your hardware 10 sizes too large ;-)

The load just doesn't matter though, this apache load is by the
scheduler's own standard a cpu hog.  If you eliminate the man made
sleep, those httpds drop right down where they belong.

> And any tweak you make to the scheduler this way is bound to affect another
> load.

It's not a tweak, it's a bug fix, and course it will affect other loads.
As things stand, that code is contributing to interactivity, and
fairness, but is also contributing heavily to grotesque _unfairness_ to
the point of starvation in the extreme.

You may not like the testcase, but it remains a bug exposing testcase.

	-Mike

