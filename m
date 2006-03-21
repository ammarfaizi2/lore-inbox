Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751724AbWCUOj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbWCUOj4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 09:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751716AbWCUOj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 09:39:56 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:58891 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751140AbWCUOj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 09:39:56 -0500
Date: Tue, 21 Mar 2006 15:39:41 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: Mike Galbraith <efault@gmx.de>, Ingo Molnar <mingo@elte.hu>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       bugsplatter@gmail.com
Subject: Re: interactive task starvation
Message-ID: <20060321143941.GD26171@w.ods.org>
References: <1142592375.7895.43.camel@homer> <200603220053.53595.kernel@kolivas.org> <1142950651.7807.95.camel@homer> <200603220119.50331.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603220119.50331.kernel@kolivas.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2006 at 01:19:49AM +1100, Con Kolivas wrote:
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
> What you're fixing with unfairness is worth pursuing. The 'ls' issue just 
> blows my mind though for reasons I've just said. Where are the magic cycles 
> going when nothing else is running that make it take ten times longer?

Con, those cycles are not "magic", if you look at the numbers, the time is
not spent in the process itself. From what has been observed since the
beginning, it is spent :
  - in other processes which are starvating the CPU (eg: X11 when xterm
    scrolls)
  - in context switches when you have a pipe somewhere and the CPU is
    bouncing between tasks.

Concerning your angriness about me being OK with (0,0) and still
asking for tunables, it's precisely because I know that *my* workload
is not everyone else's, and I don't want to conclude too quickly that
there are only two types of workloads. Maybe you're right, maybe you're
wrong. At least you're right for as long as no other workload has been
identified. But thinking like this is like some time ago when we thought
that "if it runs XMMS without skipping, it'll be OK for everyone".

> Cheers,
> Con

Cheers,
Willy

