Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030281AbWD1G6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030281AbWD1G6Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 02:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030284AbWD1G6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 02:58:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:26601 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030281AbWD1G6O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 02:58:14 -0400
X-Authenticated: #14349625
Subject: Re: [PATCH 0/9] CPU controller
From: Mike Galbraith <efault@gmx.de>
To: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
In-Reply-To: <20060428144859.a07bb5b2.maeda.naoaki@jp.fujitsu.com>
References: <20060428013730.9582.9351.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
	 <1146201936.7523.15.camel@homer>
	 <20060428144859.a07bb5b2.maeda.naoaki@jp.fujitsu.com>
Content-Type: text/plain
Date: Fri, 28 Apr 2006 08:59:49 +0200
Message-Id: <1146207589.7551.7.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-28 at 14:48 +0900, MAEDA Naoaki wrote:
> Hi Mike,
> 
> On Fri, 28 Apr 2006 07:25:35 +0200
> Mike Galbraith <efault@gmx.de> wrote:
> 
> > On Fri, 2006-04-28 at 10:37 +0900, MAEDA Naoaki wrote:
> > > Andrew,
> > > 
> > > This patchset adds a CPU resource controller on top of Resource Groups. 
> > > The CPU resource controller manages CPU resources by scaling timeslice
> > > allocated for each task without changing the algorithm of the O(1)
> > > scheduler.
> > > 
> > > Please consider these for inclusion in -mm tree.
> > 
> > This patch set professes to be a resource controller, yet 100% of high
> > priority tasks are uncontrolled.  Distribution of CPU among high
> > priority tasks isn't important, but distribution of what they leave
> > behind is?
> 
> Do you mean niced tasks are uncontrolled by the controller? 
> TASK_INTERACTIVEs are left untouched intentionally, but niced tasks
> are also controlled.

Until they attain interactive status.  Note that attaining this status
requires only one sleep, and once attained, it can be sustained.  I
don't know what the current exact numbers are, but until recently, the
numbers were that once sleep_avg became full, a non-niced task could
sustain ~95% cpu indefinitely.

You simply cannot ignore interactive tasks.  At the very least, you have
to disallow requeue if the resource limit has been exceeded, otherwise,
this patch set is non-functional.

	-Mike

