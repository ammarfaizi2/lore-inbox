Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268045AbUGWUpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268045AbUGWUpX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 16:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268046AbUGWUpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 16:45:23 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:24023 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268045AbUGWUpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 16:45:08 -0400
From: zanussi@us.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16641.30883.655066.942277@tut.ibm.com>
Date: Fri, 23 Jul 2004 15:44:19 -0500
To: Roger Luethi <rl@hellgate.ch>
Cc: zanussi@us.ibm.com, linux-kernel@vger.kernel.org, karim@opersys.com,
       richardj_moore@uk.ibm.com, bob@watson.ibm.com,
       michel.dagenais@polymtl.ca
Subject: Re: LTT user input
In-Reply-To: <20040723191900.GA2817@k3.hellgate.ch>
References: <16640.10183.983546.626298@tut.ibm.com>
	<20040723100101.GA22440@k3.hellgate.ch>
	<16641.19483.708016.320557@tut.ibm.com>
	<20040723191900.GA2817@k3.hellgate.ch>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Luethi writes:
 > On Fri, 23 Jul 2004 12:34:19 -0500, zanussi@us.ibm.com wrote:
 > > I agree that it would make sense for all these tools to at least share
 > > a common set of hooks in the kernel; it would be great if a single
 > > framework could serve them all too.  The question at the summit was
 > > 'why not use the auditing framework for tracing?'.  I haven't had a
 > > chance to look much at the code, but the performance numbers published
 > > for tracing syscalls using the auditing framework aren't encouraging
 > > for an application as intensive as tracing the entire system, as LTT
 > > does.
 > > 
 > > http://marc.theaimsgroup.com/?l=linux-kernel&m=107826445023282&w=2
 > 
 > Looking for a common base was certainly easier before one tracing
 > framework got merged. I don't claim to know if a common basic framework
 > would be beneficial, but I am somewhat amazed that not more effort has
 > gone into exploring this.

I didn't know the auditing framework was a tracing framework.  It
certainly doesn't seem light-weight enough for real system tracing,
which was the question.  Are there other frameworks we should consider
tracing on top of?

 > 
 > >  > When considering which tracing functionlity should be in
 > >  > mainline, performance measurments for user-space come in
 > >  > pretty much at the bottom of my list: Questions like "which
 > >  > process is overwriting this config file behind my back" seem a
 > >  > lot more common and more likely to be asked by people not
 > >  > willing or capable of compiling a patched kernel for that
 > >  > purpose. And tools that are useful for kernel developers
 > >  > (while unpopular with the powers that be) are nice to have in
 > >  > mainline because as a kernel hacker, you often _have_ to debug
 > >  > the latest kernel for which your favorite debug tool is not
 > >  > working yet. An argument for adding security auditing to
 > >  > mainline is that it helps convince the conservative and
 > >  > cautious security folks that the functionality is accepted and
 > >  > here to stay.
 > >  > 
 > > 
 > > OK, so peformance isn't that important for your application, but for
 > 
 > What is important to me is irrelevant. Both Linus and Andrew have stated
 > that demonstrated usefulness for many people is one key criteria for
 > merging new stuff.

And where was the 'demonstrated usefulness for many people' of the
auditing framework?

 > 
 > > LTT it is, the idea being that tracing the system should disrupt it as
 > 
 > That's your problem right there. Nobody cares if LTT is happy. It is
 > people who matter. LTT users.
 > 

Right, so LTT is the only potential user of the framework that would
care about performance.  I guess we and anyone else who does can't use
it then.

 > > little as possible and be able to deal with large numbers of events
 > > efficiently.  That's also why the base LTT tracer doesn't do things in
 > > the kernel that some of these other tools do, such as filtering on
 > > param values for instance.  That type of filtering in the kernel can
 > 
 > Which seems reasonable. It would be nice though if adding parameter
 > filters became easier with a basic framework merged.

I don't see why it would be too hard to add to any basic framework.

 > 
 > > even a C compiler that allows you to define your probes in C and
 > > access arbitrary kernel data symbolically, including function params
 > > and locals.
 > 
 > Heh, don't tell Linus. You may want to tout other benefits instead.

Well, this is what DTrace does too and in almost exactly the same way,
using an in-kernel interpreter similar to a stripped-down JVM where
nothing malicious can get out and alter the system.  It's basically
where all the 'magic' of DTrace happens.  I know, trying to get
something like this into mainline would be a hard sell, but if you
know of anything less scary that would let us do thing as exciting as
DTrace does, let me know...

 > 
 > >  > [1] You could take a page from how DTrace was introduced:
 > >  >     http://www.sun.com/bigadmin/content/dtrace/
 > > 
 > > Yes, dtrace is interesting.  It has a lot of bells and whistles, but
 > > the basic architecture seems very similar to the pieces we already
 > > have and have had for awhile:
 > > 
 > > - basic infrastructure (LTT)
 > > - static tracepoints via something like kernel hooks
 > >   (http://www-124.ibm.com/developerworks/oss/linux/projects/kernelhooks/)
 > > - dynamic tracepoints via something like dprobes
 > >   (http://www-124.ibm.com/developerworks/oss/linux/projects/dprobes/)
 > > - low-level probe language something like dprobes' rpn language
 > > - high-level probe language something like the dprobes C compiler
 > > 
 > > I too would like to have a polished 400 page manual with copious usage
 > > examples but there are only so many hours in the day... ;-)
 > 
 > What got many people interested in DTrace was hardly a polished 400
 > page manual. Most of the excitement I've seen was based on one usenet
 > posting and the Usenix paper.
 > 
 > Here's a challenge: Take the "Introducing DTrace" usenet posting and
 > let us know how much closer you can get to those results compared to
 > Linux mainline. Bonus points for explaining which components from your
 > list quoted above were required for each result. I suspect that merging
 > whatever might be realistically considered for mainline will not result
 > in functionality even remotely comparable to DTrace.
 > 
 > Roger

-- 
Regards,

Tom Zanussi <zanussi@us.ibm.com>
IBM Linux Technology Center/RAS

