Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265206AbUATI3x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 03:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265246AbUATI3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 03:29:53 -0500
Received: from [66.35.79.110] ([66.35.79.110]:33706 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S265206AbUATI3w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 03:29:52 -0500
Date: Tue, 20 Jan 2004 00:29:43 -0800
From: Tim Hockin <thockin@hockin.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Rusty Russell <rusty@au1.ibm.com>, vatsa@in.ibm.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       rml@tech9.net
Subject: Re: CPU Hotplug: Hotplug Script And SIGPWR
Message-ID: <20040120082943.GA15733@hockin.org>
References: <20040116174446.A2820@in.ibm.com> <20040120060027.91CC717DE5@ozlabs.au.ibm.com> <20040120063316.GA9736@hockin.org> <400CCE2F.2060502@cyberone.com.au> <20040120065207.GA10993@hockin.org> <400CD4B5.6020507@cyberone.com.au> <20040120073032.GB12638@hockin.org> <400CDCA1.5070200@cyberone.com.au> <20040120075409.GA13897@hockin.org> <400CE354.8060300@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400CE354.8060300@cyberone.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 07:14:12PM +1100, Nick Piggin wrote:
> >Under what conditions?  Not arbitrary entropy, surely.  If a hotplug script
> >is present and does not blow up, it should be safe to assume it will be run
> >upon an event being delivered.  If not, we have a WAY bigger problem :)
> >
> 
> That assumption is not safe. The main problems are of course process limits
> and memory allocation failure.

If root has a process limit that make hotplug scripts fail to run, then
we're hosed in a lot of ways.  And if we fail to allocate memory, there
really ought to be some retry or something.  It seems to me that a failure
to run a hotplug script is a BAD THING.

> >Sending it a SIGPWR means you have to run it on a different CPU that it was
> >affined to, which is already a violation.
> 
> At least the task has the option to handle the problem.

But it is a violation of the affinity.  As the kernel we CAN NOT know what
the affinity really means.  Maybe there is some way for a task to indicate
it would like to receive SIGPWR in that case.  Or some other signal.  Can we
invent new signals?

That way a task that KNOWS about the CPU disappearing underneath it can be
wise, while everything else will not just get killed.
