Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268487AbTCFWy4>; Thu, 6 Mar 2003 17:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268492AbTCFWy4>; Thu, 6 Mar 2003 17:54:56 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:48132
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S268487AbTCFWyy>; Thu, 6 Mar 2003 17:54:54 -0500
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
From: Robert Love <rml@tech9.net>
To: "Dimitrie O. Paun" <dimi@intelliware.ca>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Ingo Molnar <mingo@elte.hu>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0303061725330.23356-100000@dimi.dssd.ca>
References: <Pine.LNX.4.44.0303061725330.23356-100000@dimi.dssd.ca>
Content-Type: text/plain
Organization: 
Message-Id: <1046991923.715.64.camel@phantasy.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 06 Mar 2003 18:05:23 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-06 at 17:31, Dimitrie O. Paun wrote:

> Right, being able to control this interactivity knob programmatically
> seems like a useful thing. That way, the window manager can boost the
> interactivity of the foreground window for example. It does seem that
> figuring out that something is interactive in the scheduler is tough,
> there is just not enough information, whereas a higher layer may know
> this for a fact. I guess this reduces my argument to just keeping the 
> interactivity setting separate from priority.

No no no.  Martin's point shows exactly that nothing but the kernel can
ever know whether a task is I/O or CPU bound.  What is bash?  Is it
interactive (when you are typing into it) or CPU bound (when its running
a script or doing other junk)?

Only the kernel knows exactly the sleep patterns of tasks, which is
essentially whether or not a task is interactive.

Finally, the windows manager idea is bad.  The foreground window may
have dependencies elsewhere, and giving it a boost only partially solves
the problem.

I think with Linus's patch, the problem is solved, because we boost both
I/O-bound tasks and tasks that help I/O bound tasks.

	Robert Love

