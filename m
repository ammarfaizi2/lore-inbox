Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265656AbSLFUBh>; Fri, 6 Dec 2002 15:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265705AbSLFUBh>; Fri, 6 Dec 2002 15:01:37 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:52493
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S265656AbSLFUBg>; Fri, 6 Dec 2002 15:01:36 -0500
Subject: Re: Detecting threads vs processes with ps or /proc
From: Robert Love <rml@tech9.net>
To: Nick LeRoy <nleroy@cs.wisc.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200212061356.16022.nleroy@cs.wisc.edu>
References: <200212060924.02162.nleroy@cs.wisc.edu>
	 <1039204112.1943.2142.camel@phantasy>
	 <200212061356.16022.nleroy@cs.wisc.edu>
Content-Type: text/plain
Organization: 
Message-Id: <1039205353.1943.2191.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 06 Dec 2002 15:09:13 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-06 at 14:56, Nick LeRoy wrote:

> I was considerring doing something like this as well.  From your
> experience,  does it work reliably?

It never fails to detect threads (no false negatives).

It does sometimes detect child processes that forked but did not exec as
threads (false positives).  The failure case is when a program forks,
does not call exec, and the children go on to execute the exact same
code (so they look and act just like threads, but they have unique
addresses spaces).

One thing to note: if you can modify the kernel and procps, you can just
export the value of task->mm out of /proc.  It is a gross hack, and
perhaps a security issue, but that will work 100%.  Same ->mm implies
thread.

> Do you need to apply a small 'fudge factor' (aka 
> VMsize.1 ~= VMsize.2)?

No, they need to be exact.  The stats are pulled from the same structure
in the kernel so they need to be perfect.

> > It is the default behavior.  Flag `-m' turns it off.
> >
> > See thread_group() and flag_threads().
> 
> I assume these are functions in the tools themselves?

Yep.  Both ps and top have support.  There is a patch on the website
that added the feature, so you can take a look at that.

Red Hat 8.0 has support in their version of procps 2.0.7, too. 
Otherwise it was added in 2.0.8.  The current version is 2.0.10.

We have a mailing list at procps-list@redhat.com where this sort of
discussion is welcome.

	Robert Love

