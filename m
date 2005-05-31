Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbVEaQ3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbVEaQ3K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 12:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbVEaQ0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 12:26:52 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:49640 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261941AbVEaQTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 12:19:23 -0400
Subject: Re: RT patch acceptance
From: Steven Rostedt <rostedt@goodmis.org>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, hch@infradead.org,
       dwalker@mvista.com, Ingo Molnar <mingo@elte.hu>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, Andi Kleen <ak@muc.de>,
       "Bill Huey (hui)" <bhuey@lnxw.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       James Bruce <bruce@andrew.cmu.edu>
In-Reply-To: <Pine.OSF.4.05.10505311347290.1707-100000@da410.phys.au.dk>
References: <Pine.OSF.4.05.10505311347290.1707-100000@da410.phys.au.dk>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 31 May 2005 12:18:03 -0400
Message-Id: <1117556283.2569.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-31 at 14:09 +0200, Esben Nielsen wrote:
> On Tue, 31 May 2005, James Bruce wrote:

> > It is only better in that if you need provable hard-RT *right now*, then 
> > you have to use a nanokernel.  
> 
> What do you mean by "provable"? Security critical? Forget about
> nanokernels then. The WHOLE system has to be validated. If you want to a
> system good enough to put (a lot of) money on it: Test, test, test.

Interesting. I use to work for Martin Mariette in the early 90s testing
modules for aircraft engine controls.  The code was about ten years old,
and that is because it was going under ten years of testing.  The
operating system was custom made since at the time there were no
commercially available (that I knew) RTOS that could go under the
scrutiny of the Military Specs.

Later, while working at Lockheed, we had WindRiver over and they would
only give a small broken down (basically all features removed) OS that
Lockheed would be responsible for testing.

When someone mentions Hard-RT, this is what I think about.  These are
the RTOS that control the airplanes that people fly in. If something
were to go wrong, people will die.  

I no longer deal with that type of RT, now I still work with
applications that run on aircraft, but would not have the plane crash if
something was to go wrong.  The system still had to be of a softer-RT to
give the required response, usually navigational.  This is someplace
that a Linux with -RT or a nano kernel can go.  The -RT patch may be
nicer since some applications are first written generically, and then
later need to become -RT for some reason or another.  With the nano
approach this may take more effort.  But at the moment, I'm working to
get -RT with some extra features for other things, but this is what I've
heard from others.

> I can't see it would be easier prove that a nano-kernel with various
> needed mutex and queuing mechanism works correct than it is to prove that
> the Linux scheduler with mutex and queueing mechanisms works correctly.
> Both systems does the same thing and is most likely based on the same
> principles!

Since the nano-kernel would be much smaller than the kernel, you don't
need to worry about a bad design as much that can cause a problem.  I
don't know how easy it would be to separate all the paths that an RT
task uses, and make sure that there's not a lock that an RT task takes
that isn't taken someplace else that a non RT task can take for a long
time (even with PI).  It's just that the kernel is so big to find
everything.  This isn't impossible, but very difficult to check out.

-- Steve

