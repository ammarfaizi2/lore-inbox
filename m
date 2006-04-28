Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030350AbWD1KBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030350AbWD1KBS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 06:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030351AbWD1KBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 06:01:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:65413 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030350AbWD1KBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 06:01:18 -0400
X-Authenticated: #14349625
Subject: Re: [ckrm-tech] Re: [PATCH 0/9] CPU controller
From: Mike Galbraith <efault@gmx.de>
To: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
In-Reply-To: <1146216552.8067.11.camel@homer>
References: <20060428013730.9582.9351.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
	 <1146201936.7523.15.camel@homer>
	 <20060428144859.a07bb5b2.maeda.naoaki@jp.fujitsu.com>
	 <1146207589.7551.7.camel@homer>
	 <20060428162612.7760628d.maeda.naoaki@jp.fujitsu.com>
	 <1146210069.7551.31.camel@homer>
	 <20060428165639.0e4f9a03.maeda.naoaki@jp.fujitsu.com>
	 <1146216552.8067.11.camel@homer>
Content-Type: text/plain
Date: Fri, 28 Apr 2006 12:01:09 +0200
Message-Id: <1146218469.8067.25.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-28 at 11:29 +0200, Mike Galbraith wrote:
> On Fri, 2006-04-28 at 16:56 +0900, MAEDA Naoaki wrote:
> > On Fri, 28 Apr 2006 09:41:09 +0200
> > Mike Galbraith <efault@gmx.de> wrote:
> > 
> > > On Fri, 2006-04-28 at 16:26 +0900, MAEDA Naoaki wrote:
> > > > On Fri, 28 Apr 2006 08:59:49 +0200
> > > > Mike Galbraith <efault@gmx.de> wrote:
> > > > > You simply cannot ignore interactive tasks.  At the very least, you have
> > > > > to disallow requeue if the resource limit has been exceeded, otherwise,
> > > > > this patch set is non-functional.
> > > > 
> > > > It can be easily implemented on top of the current code. Do you know a good
> > > > sample program that is judged as interactive but consumes lots of cpu?
> > > 
> > > X sometimes, Mozilla sometimes,... KDE konsole when scrolling,...
> > > anything that on average sleeps more than roughly 5% of it's slice can
> > > starve you to death either alone, or (worse) with peers.
> > 
> > They are true interactive tasks, aren't they? 
> > Oh! I should say "that is not interactive, but judged as interactive
> > and consumes lots of cpu". 
> 
> Why do you care?  There is only one thing that matters, and that is the
> fact that cpu can be used and remain utterly uncontrolled.  This renders
> your system non-functional for resource management.  Period.  All stop.

Here's an example: this is a snippet of me doing a modest parallel
kernel compile in an nfs mounted localhost directory.  What part of this
is truly interactive, and what part do you think should be excluded from
resource management?

14467 mikeg     16   0 17052  13m 3712 R 20.7  1.3   0:00.33 cc1
14498 mikeg     16   0 17052  13m 3708 S 19.7  1.3   0:00.35 cc1
14523 mikeg     16   0 14852  11m 3532 D 13.1  1.1   0:00.26 cc1
14445 mikeg     16   0 14716  11m 3692 S 12.2  1.2   0:00.25 cc1
14492 mikeg     16   0 15912  11m 3096 R  8.5  1.2   0:00.21 cc1
14469 mikeg     15   0 14892  10m 1988 D  7.5  1.0   0:00.19 cc1
14513 mikeg     25   0 11480 6508 1976 R  3.8  0.6   0:00.10 cc1
14579 mikeg     25   0  9128 4260 1908 R  3.8  0.4   0:00.04 cc1
14532 mikeg     15   0     0    0    0 Z  1.9  0.0   0:00.02 as



