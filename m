Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWARG3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWARG3t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 01:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWARG3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 01:29:49 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:6558 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751347AbWARG3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 01:29:48 -0500
Date: Tue, 17 Jan 2006 22:29:43 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Keith Owens <kaos@sgi.com>, John Hesterberg <jh@sgi.com>,
       Matt Helsley <matthltc@us.ibm.com>,
       Jes Sorensen <jes@trained-monkey.org>,
       Shailabh Nagar <nagar@watson.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Jay Lan <jlan@engr.sgi.com>, LKML <linux-kernel@vger.kernel.org>,
       elsa-devel@lists.sourceforge.net, lse-tech@lists.sourceforge.net,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, Paul Jackson <pj@sgi.com>,
       Erik Jacobson <erikj@sgi.com>, Jack Steiner <steiner@sgi.com>
Subject: Re: [Lse-tech] Re: [ckrm-tech] Re: [PATCH 00/01] Move Exit Connectors
Message-ID: <20060118062943.GC10765@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060117172617.GA9283@us.ibm.com> <22822.1137542267@ocs3.ocs.com.au> <20060118024948.GA10407@us.ibm.com> <1137552907.3587.49.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137552907.3587.49.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2006 at 09:55:06PM -0500, Lee Revell wrote:
> On Tue, 2006-01-17 at 18:49 -0800, Paul E. McKenney wrote:
> > - * softirq handlers will have completed, since in some kernels
> > + * softirq handlers will have completed, since in some kernels, these
> > + * handlers can run in process context, and can block.
> >   * 
> 
> I was under the impression that softirq handlers can run in process
> context in all kernels.  Specifically, in realtime variants softirqs
> always run in process context, and in mainline this only happens under
> high load.

We might be talking past each other on this one.  If I am not getting
too confused, it is possible to configure a mainline kernel so that
the load cannot rise high enough to force softirqs into process
context.  Although looking at 2.6.15, it appears that this would
require rebuilding after hand-editing the value of MAX_SOFTIRQ_RESTART,
which some might feel too-brutal of tweaking to be considered mere
"configuration".

In any case, the key point of the comment is that synchronize_sched()
is not guaranteed to wait for all pending softirq handlers to complete.
Does the comment make that sufficiently clear?

						Thanx, Paul
