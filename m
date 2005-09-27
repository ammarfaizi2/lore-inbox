Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964991AbVI0Pz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbVI0Pz1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 11:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbVI0Pz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 11:55:27 -0400
Received: from nevyn.them.org ([66.93.172.17]:50099 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S964991AbVI0Pz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 11:55:26 -0400
Date: Tue, 27 Sep 2005 11:55:25 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Davda, Bhavesh P (Bhavesh)" <bhavesh@avaya.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] New SA_NOPRNOTIF sigaction flag
Message-ID: <20050927155525.GA5810@nevyn.them.org>
Mail-Followup-To: "Davda, Bhavesh P (Bhavesh)" <bhavesh@avaya.com>,
	linux-kernel@vger.kernel.org
References: <21FFE0795C0F654FAD783094A9AE1DFC086EFADA@cof110avexu4.global.avaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21FFE0795C0F654FAD783094A9AE1DFC086EFADA@cof110avexu4.global.avaya.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2005 at 08:45:07AM -0600, Davda, Bhavesh P (Bhavesh) wrote:
> > No way!  It needs to work the other way: allow the debugger to
> > short-circuit a signal for performance reasons if it wants to.  Ptrace
> > is supposed to report all signals and debuggers expect it to do so.
> > It'd be pretty confusing if, say, you were trying to debug the SIGSEGV
> > handler in an application which did this.

> Then propose an alternative way where a real-time (SCHED_FIFO/SCHED_RR)
> CPU bound application getting lots of SEGVs for normal operation doesn't
> cause a priority inversion with the debugger getting SIGCHLDs for every
> SEGV and deciding to ignore it?

Read my reply above again, please.  I did.  It needs to be under
control of the tracer.

Also, this is far from the only problem you're going to have if you run
your debugger with lower priority than your debuggee.

> This way avoids the unnecessary context switch to the debugger, and is
> intended for use only by someone who knows darn sure that s/he will
> handle the signal safely, and don't mind if the debugger is not notified
> (in fact would love it if that's the case) on specific signals.
> 
> IMHO this is a perfectly safe capability...

No.  Ptrace is considered a security barrier; the tracee should not be
able to control what the tracer sees.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
