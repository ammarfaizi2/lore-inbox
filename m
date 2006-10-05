Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbWJEStO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbWJEStO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 14:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWJEStO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 14:49:14 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:58948 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1750830AbWJEStL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 14:49:11 -0400
Subject: Re: [RFC] The New and Improved Logdev (now with kprobes!)
From: Daniel Walker <dwalker@mvista.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       Karim Yaghmour <karim@opersys.com>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>, fche@redhat.com,
       Tom Zanussi <zanussi@us.ibm.com>
In-Reply-To: <Pine.LNX.4.58.0610051438010.31280@gandalf.stny.rr.com>
References: <1160025104.6504.30.camel@localhost.localdomain>
	 <20061005143133.GA400@Krystal>
	 <Pine.LNX.4.58.0610051054300.28606@gandalf.stny.rr.com>
	 <20061005170132.GA11149@Krystal>
	 <Pine.LNX.4.58.0610051309090.30291@gandalf.stny.rr.com>
	 <1160072999.6660.5.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <Pine.LNX.4.58.0610051438010.31280@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Thu, 05 Oct 2006 11:49:06 -0700
Message-Id: <1160074147.6660.10.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-05 at 14:38 -0400, Steven Rostedt wrote:
> On Thu, 5 Oct 2006, Daniel Walker wrote:
> 
> > On Thu, 2006-10-05 at 14:09 -0400, Steven Rostedt wrote:
> >
> > >
> > > My problem with using a timestamp, is that I ran logdev on too many archs.
> > > So I need to have a timestamp that I can get to that is always reliable.
> > > How does LTTng get the time for different archs?  Does it have separate
> > > code for each arch?
> > >
> >
> > I just got done updating a patchset that exposes the clocksources from
> > generic time to take low level time stamps.. But even without that you
> > can just call gettimeofday() directly to get a timestamp .
> >
> 
> unless you're tracing something that his holding the xtime_lock ;-)

That's part of the reason for the changes that I made to the clocksource
API . It makes it so instrumentation, with other things, can generically
read a low level cycle clock. Like on PPC you would read the
decrementer, and on x86 you would read the TSC . However, the
application has no idea what it's reading.

I submitted one version to LKML already, but I'm planning to submit
another version shortly.

Daniel

