Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422951AbWAMU6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422951AbWAMU6W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 15:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422954AbWAMU6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 15:58:22 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:16856 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1422951AbWAMU6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 15:58:21 -0500
Subject: Re: Dual core Athlons and unsynced TSCs
From: Steven Rostedt <rostedt@goodmis.org>
To: thockin@hockin.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Sven-Thorsten Dietrich <sven@mvista.com>
In-Reply-To: <20060113193234.GA20519@hockin.org>
References: <1137104260.2370.85.camel@mindpipe>
	 <20060113180620.GA14382@hockin.org> <1137175117.15108.18.camel@mindpipe>
	 <20060113181631.GA15366@hockin.org> <1137175792.15108.26.camel@mindpipe>
	 <20060113185533.GA18301@hockin.org>
	 <1137178574.2536.13.camel@localhost.localdomain>
	 <20060113193234.GA20519@hockin.org>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 15:58:08 -0500
Message-Id: <1137185888.6731.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-13 at 11:32 -0800, thockin@hockin.org wrote:
> On Fri, Jan 13, 2006 at 10:56:13AM -0800, Sven-Thorsten Dietrich wrote:
> > On Fri, 2006-01-13 at 10:55 -0800, thockin@hockin.org wrote:
> > > unless we can re-sync the TSCs often enough that apps don't notice.
> > 
> > You'd have to quantify that somehow, in terms of the max drift rate
> > (ppm), and the max resolution available (< tsc frequency).  
> > 
> > Either that, or track an offset, and use one TSC as truth, and update
> > the correction factor for the other TSCs as often as needed, maybe?
> > 
> > This is kind of analogous to the "drift" NTP calculates against a
> > free-running oscillator. 
> > 
> > So you'd be pushing that functionality deeper into the OS-core.
> > 
> > Dave Mills had that "hardpps" stuff in there for a while, it might be a
> > starting point.
> > 
> > Just some thoughts for now... 
> 
> There's some chatter here about a solution involving a lazy sync of TSCs
> to the HPET (or other) whenever an app calls rdtsc after a potentially
> unsyncing event.
> 
> For example, 'hlt' will initiate C1 which may cause clock ramping (and TSC
> skew).  We can trap rdtsc after a hlt and re-sync the TSCs to some truly
> monotonic source, like HPET.
> 
> I don't have all the details, some problems remain, and the work is not
> quite done yet, but it looks promising.
> 
> Even if we eventually get synced TSCs, it's too little too late.
> basically, anything in-kernel that uses rdtsc is bound to break, and any
> app that uses rdtsc had better be using CPU affinity.

I know this might be somewhat of an overhead, but what about resyncing
on wakeup of the idle function?  Isn't that where they fall apart?

-- Steve


