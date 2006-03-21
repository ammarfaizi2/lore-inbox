Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030391AbWCUO1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030391AbWCUO1M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 09:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030404AbWCUO1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 09:27:12 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:31952 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030391AbWCUO1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 09:27:12 -0500
Date: Tue, 21 Mar 2006 15:25:04 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: Mike Galbraith <efault@gmx.de>, Willy Tarreau <willy@w.ods.org>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       bugsplatter@gmail.com
Subject: Re: interactive task starvation
Message-ID: <20060321142504.GA31258@elte.hu>
References: <1142592375.7895.43.camel@homer> <200603220053.53595.kernel@kolivas.org> <1142950651.7807.95.camel@homer> <200603220119.50331.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603220119.50331.kernel@kolivas.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Con Kolivas <kernel@kolivas.org> wrote:

> On Wednesday 22 March 2006 01:17, Mike Galbraith wrote:
> > On Wed, 2006-03-22 at 00:53 +1100, Con Kolivas wrote:
> > > The yardstick for changes is now the speed of 'ls' scrolling in the
> > > console. Where exactly are those extra cycles going I wonder? Do you
> > > think the scheduler somehow makes the cpu idle doing nothing in that
> > > timespace? Clearly that's not true, and userspace is making something
> > > spin unnecessarily, but we're gonna fix that by modifying the
> > > scheduler.... sigh
> >
> > *Blink*
> >
> > Are you having a bad hair day??
> 
> My hair is approximately 3mm long so it's kinda hard for that to happen. 
> 
> What you're fixing with unfairness is worth pursuing. The 'ls' issue 
> just blows my mind though for reasons I've just said. Where are the 
> magic cycles going when nothing else is running that make it take ten 
> times longer?

i believe such artifacts are due to array switches not happening (due to 
the workload getting queued back to rq->active, not rq->expired), and 
'ls' only gets a timeslice once in a while, every STARVATION_LIMIT
times. I.e. such workloads penalize the CPU-bound 'ls' process quite 
heavily.

	Ingo
