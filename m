Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266054AbUAUEir (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 23:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266055AbUAUEg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 23:36:28 -0500
Received: from dp.samba.org ([66.70.73.150]:32225 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266053AbUAUEfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 23:35:53 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Tim Hockin <thockin@hockin.org>
Cc: vatsa@in.ibm.com, lhcs-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       rml@tech9.net
Subject: Re: CPU Hotplug: Hotplug Script And SIGPWR 
In-reply-to: Your message of "Tue, 20 Jan 2004 00:37:01 -0800."
             <20040120083700.GB15733@hockin.org> 
Date: Wed, 21 Jan 2004 11:12:46 +1100
Message-Id: <20040121043608.740302C10D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040120083700.GB15733@hockin.org> you write:
> > off).  There are no correctness concerns AFAICT with userspace not
> > being on a particular CPU, just performance.
> 
> Correctness does matter if an affined task violates that affinity.  If we
> are going to provide explicit affinity, we need to honor it under all
> conditions, or at least provide an option to honor it.

WHY?  Think of an example where this is actually a problem.

"Under all conditions" is not something we can ever implement for
anything.

> I agree about invasiveness.  Maybe a combo?  Send SIGPWR iff a task is
> actually handling it, otherwise mark it TASK_UNRUNNABLE and let hotplug
> handle it?

Well, I think that violating affinity given that (1) affinity in
userspace is only a performance issue, and (2) we've been explicitly
told to take the CPU down, is a valid solution.

OTOH making tasks unrunnable until hotplug gets around to servicing
them could equally be a disaster.  Given that this requires
infrastructure not in Linus' tree and the "simply unbind" solution
doesn't, I'm leaning towards unbinding everything which would become
unrunnable, SIGPWR if they handle it, and hotplug at the end.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
