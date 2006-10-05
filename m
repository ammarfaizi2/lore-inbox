Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbWJEUhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWJEUhK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 16:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWJEUhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 16:37:10 -0400
Received: from tomts43-srv.bellnexxia.net ([209.226.175.110]:1416 "EHLO
	tomts43-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751279AbWJEUhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 16:37:08 -0400
Date: Thu, 5 Oct 2006 16:31:45 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Walker <dwalker@mvista.com>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Karim Yaghmour <karim@opersys.com>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>, fche@redhat.com,
       Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: [RFC] The New and Improved Logdev (now with kprobes!)
Message-ID: <20061005203145.GA30746@Krystal>
References: <1160025104.6504.30.camel@localhost.localdomain> <20061005143133.GA400@Krystal> <Pine.LNX.4.58.0610051054300.28606@gandalf.stny.rr.com> <20061005170132.GA11149@Krystal> <Pine.LNX.4.58.0610051309090.30291@gandalf.stny.rr.com> <1160072999.6660.5.camel@c-67-180-230-165.hsd1.ca.comcast.net> <Pine.LNX.4.58.0610051438010.31280@gandalf.stny.rr.com> <1160074147.6660.10.camel@c-67-180-230-165.hsd1.ca.comcast.net> <20061005201820.GA1865@Krystal> <Pine.LNX.4.58.0610051623520.432@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0610051623520.432@gandalf.stny.rr.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 16:30:18 up 43 days, 17:38,  8 users,  load average: 0.20, 0.20, 0.26
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Steven Rostedt (rostedt@goodmis.org) wrote:
> 
> On Thu, 5 Oct 2006, Mathieu Desnoyers wrote:
> 
> >
> > Just as a detail : LTTng traces NMI, which can happen on top of a
> > xtime_lock. So yes, I have to consider the impact of this kind of lock when I
> > choose my time source, which is currently a per architecture TSC read,
> > or a read of the jiffies counter when the architecture does not have a
> > synchronised TSC over the CPUs. This is abstracted in include/asm-*/ltt.h.
> >
> 
> I'm curious.  How do you show the interactions between two CPUs when the
> TSC isn't in sync?  Using jiffies is not fast enough to know the order of
> events that happen within usecs.
> 

I shift the jiffies and OR that with a logical clock which increments atomically
and is shared across the CPUs. It is slow and ugly, but it works. :)

Mathieu

> -- Steve
> 
> 
> > I know it doesn't support dynamic ticks, I'm working on using the HRtimers
> > instead, but I must make sure that the seqlock read will fail if it nests over
> > a write seqlock.
> >
> > MAthieu
> >
> > OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
> > Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
> >
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
