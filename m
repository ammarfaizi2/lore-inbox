Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbUA0Ckg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 21:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbUA0Ckg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 21:40:36 -0500
Received: from dp.samba.org ([66.70.73.150]:43974 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261660AbUA0Cke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 21:40:34 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New NUMA scheduler and hotplug CPU 
In-reply-to: Your message of "Mon, 26 Jan 2004 15:24:31 -0800."
             <31860000.1075159471@flay> 
Date: Tue, 27 Jan 2004 13:36:33 +1100
Message-Id: <20040127024049.7B90B2C13D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <31860000.1075159471@flay> you write:
> > I think it mostly does a good job at making sure to only take
> > online cpus into account. If there are places where it doesn't
> > then it shouldn't be too hard to fix.
> 
> It'd make the code a damned sight simpler and cleaner if you dropped
> all that stuff, and updated the structures when you hotplugged a CPU,
> which is really the only sensible way to do it anyway ...

No, actually, it wouldn't.  Take it from someone who has actually
looked at the code with an eye to doing this.

Replacing static structures by dynamic ones for an architecture which
doesn't yet exist is NOT a good idea.

> For instance, if I remove cpu X, then bring back a new CPU on another node
> (or in another HT sibling pair) as CPU X, then you'll need to update all
> that stuff anyway. CPUs aren't fixed position in that map - the ordering
> handed out is arbitrary.

Sure, if they were stupid they'd do it this way.

If (when) an architecture has hotpluggable CPUs and NUMA
characteristics, they probably will have fixed CPU *slots*, and number
CPUs based on what slot they are in.  Since the slots don't move, all
your fancy dynamic logic will be wasted.

When someone really has dynamic hotplug CPU capability with variable
attributes, *they* can code up the dynamic hierarchy.  Because *they*
can actually test it!

> > I guess so, but you'd still need NR_CPUS to be >= that arbitrary
> > number.
> 
> Yup ... but you don't have to enumerate all possible positions that way.
> See Linus' arguement re dynamic device numbers and ISCSI disks, etc.
> Same thing applies.

Crap.  When all the fixed per-cpu arrays have been removed from the
kernel, come back and talk about instantiation and location of
arbitrary CPUS.

You're way overdesigning: have you been sharing food with the AIX guys?

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
