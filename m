Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbVE3SdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVE3SdL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 14:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbVE3S3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 14:29:31 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:53646 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261672AbVE3S2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 14:28:41 -0400
Subject: Re: RT patch acceptance
From: Steven Rostedt <rostedt@goodmis.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, hch@infradead.org,
       dwalker@mvista.com, Ingo Molnar <mingo@elte.hu>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, Andi Kleen <ak@muc.de>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, James Bruce <bruce@andrew.cmu.edu>,
       kus Kusche Klaus <kus@keba.com>, Esben Nielsen <simlo@phys.au.dk>
In-Reply-To: <429B0003.5060803@yahoo.com.au>
References: <Pine.OSF.4.05.10505301306510.12471-100000@da410.phys.au.dk>
	 <429B0003.5060803@yahoo.com.au>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 30 May 2005 14:26:51 -0400
Message-Id: <1117477611.23910.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-30 at 21:58 +1000, Nick Piggin wrote:
> Esben Nielsen wrote:
> 
> > I do like the idea of guest kernels - especially the ability to enforce a
> > strict seperation of RT and non-RT. But you can't use _any_ part of the
> > Linux kernel in your RT application - not even drivers. I know a lot of
> 
> If you can't use the drivers, then presumably they're no good
> to be used as they are for realtime in Linux either, though :(
> 
> In which case, you may still be better off porting the driver
> over and rewriting it to be hard-realtime than rewriting Linux
> itself ;)
> 
> But I could be wrong. I don't pretend to have the answers (just
> questions!).

Sorry Nick, I know you want out of this thread but I figured I'll just
comment on this note alone. :-)

If a driver is well written in Linux then you don't need to rewrite it
for -RT.  The thing that Ingo's locks give us is that it makes the
kernel able to preempt in more locations.  When a normal driver calls
spin_lock_irqsave in the -RT kernel, it doesn't turn off interrupts or
preemption.  A low priority RT task can be using it when a higher
priority RT task wakes up, and this won't slow down the waking of the
higher prio task. Thus, a Linux driver can be used in the -RT kernel for
RT tasks.  As long as you know the effects of using it.

I only focus on the single kernel RT approach so I'm not going to give
any comments on the single verses nano- since I don't know enough about
the nano.  But I figured I'd just comment on some of the issues of a
driver in today's Linux compared to the -RT Linux, since that part I do
know.  Actually, including the -RT into mainline would probably have
more developers help out the maintainers of the devices.  If someone has
an issue with a driver in regards to RT, then an RT programmer would
have to be the one to work on it, and the ending result should be
something that works better for the non-RT kernel. 

OK, I'll let you get back to whatever you were doing now. ;-)

-- Steve


