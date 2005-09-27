Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbVI0Opm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbVI0Opm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 10:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbVI0Opl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 10:45:41 -0400
Received: from tiere.net.avaya.com ([198.152.12.100]:50130 "EHLO
	tiere.net.avaya.com") by vger.kernel.org with ESMTP id S964938AbVI0Opl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 10:45:41 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC PATCH] New SA_NOPRNOTIF sigaction flag
Date: Tue, 27 Sep 2005 08:45:07 -0600
Message-ID: <21FFE0795C0F654FAD783094A9AE1DFC086EFADA@cof110avexu4.global.avaya.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH] New SA_NOPRNOTIF sigaction flag
Thread-Index: AcXDZFdRsJIQiAKtQbyveBSXo4sPZQADTJ/w
From: "Davda, Bhavesh P \(Bhavesh\)" <bhavesh@avaya.com>
To: "Daniel Jacobowitz" <dan@debian.org>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Daniel Jacobowitz [mailto:dan@debian.org] 
> Sent: Tuesday, September 27, 2005 7:07 AM
> To: Davda, Bhavesh P (Bhavesh)
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [RFC PATCH] New SA_NOPRNOTIF sigaction flag
> 
> On Mon, Sep 26, 2005 at 11:39:40AM -0600, Bhavesh P. Davda wrote:
> > 
> > Sometimes when a task is being ptraced (e.g. by a 
> debugger), one would
> > like to handle a certain signal (e.g. SIGSEGV) within the 
> task without
> > having to notify the ptracing task.
> > 
> > An example of this is if one would like to detect the rate 
> at which pages
> > are being modified, and therefore mprotect() the pages. The SIGSEGV
> > handler just keeps track of how many writes are happening 
> on each of the
> > mprotect()ed pages, but you don't want to bother the 
> debugger with these
> > SIGSEGVs.
> > 
> > I'm proposing the addition of a new SA_NOPRNOTIF flag to 
> struct sigaction
> > { sa_flags }, which makes the kernel skip notifying the 
> ptracing parent if
> > the flag is set for a sighandler for a particular signal.
> > 
> > This trivial patch achieves just that.
> > 
> > Comments?
> 
> No way!  It needs to work the other way: allow the debugger to
> short-circuit a signal for performance reasons if it wants to.  Ptrace
> is supposed to report all signals and debuggers expect it to do so.
> It'd be pretty confusing if, say, you were trying to debug the SIGSEGV
> handler in an application which did this.
> 
> -- 
> Daniel Jacobowitz
> CodeSourcery, LLC
> 


Then propose an alternative way where a real-time (SCHED_FIFO/SCHED_RR)
CPU bound application getting lots of SEGVs for normal operation doesn't
cause a priority inversion with the debugger getting SIGCHLDs for every
SEGV and deciding to ignore it?

This way avoids the unnecessary context switch to the debugger, and is
intended for use only by someone who knows darn sure that s/he will
handle the signal safely, and don't mind if the debugger is not notified
(in fact would love it if that's the case) on specific signals.

IMHO this is a perfectly safe capability...

- Bhavesh

Bhavesh P. Davda | Distinguished Member of Technical Staff | Avaya |
1300 West 120th Avenue | B3-B03 | Westminster, CO 80234 | U.S.A. |
Voice/Fax: 303.538.4438 | bhavesh@avaya.com 
