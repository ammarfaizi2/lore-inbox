Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbUKSVYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbUKSVYm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 16:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbUKSVYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 16:24:03 -0500
Received: from nevyn.them.org ([66.93.172.17]:57529 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261571AbUKSVXw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 16:23:52 -0500
Date: Fri, 19 Nov 2004 16:23:28 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Eric Pouech <pouech-eric@wanadoo.fr>
Cc: Linus Torvalds <torvalds@osdl.org>, Roland McGrath <roland@redhat.com>,
       Mike Hearn <mh@codeweavers.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
Message-ID: <20041119212327.GA8121@nevyn.them.org>
Mail-Followup-To: Eric Pouech <pouech-eric@wanadoo.fr>,
	Linus Torvalds <torvalds@osdl.org>,
	Roland McGrath <roland@redhat.com>, Mike Hearn <mh@codeweavers.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	wine-devel <wine-devel@winehq.com>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com> <419E42B3.8070901@wanadoo.fr> <Pine.LNX.4.58.0411191119320.2222@ppc970.osdl.org> <419E4A76.8020909@wanadoo.fr> <Pine.LNX.4.58.0411191148480.2222@ppc970.osdl.org> <419E5A88.1050701@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419E5A88.1050701@wanadoo.fr>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 09:41:44PM +0100, Eric Pouech wrote:
> >Btw, does wine ever _use_ PTRACE_SINGLESTEP for any of the things it does?
> >
> >If it does, then that woulc certainly explain why my "fix" made no 
> >difference: my fix _only_ handles the case where the ptracer never 
> >actually asks for single-stepping, and single-stepping was started 
> >entirely by the program being run (ie by setting TF in eflags from within 
> >the program itself).
> >
> >But if wine ends up using PTRACE_SINGESTEP because wine actually wants to 
> >single-step over some instructions, then the kernel will set the PT_DTRACE 
> >bit, and start tracing through signal handlers too. The way Wine doesn't 
> >want..
> 
> wine mixes both approches, we have (to control what's generated inside the 
> various exception) to ptrace from our NT-kernel-like process (the ptracer) 
> to get the context of the exception. Restart from the ptracer is done with 
> PTRACE_SINGLESTEP.

I'm getting the feeling that the question of whether to step into
signal handlers is orthogonal to single-stepping; maybe it should be a
separate ptrace operation.

Platforms which don't implement PTRACE_SINGLESTEP would probably
appreciate this.  A "single step" which stops you after setting up the
signal trampoline and adjusting the PC, before executing any
instructions in the handler.

-- 
Daniel Jacobowitz
