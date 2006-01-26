Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbWAZTnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWAZTnF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 14:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWAZTnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 14:43:05 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:1701 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932232AbWAZTnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 14:43:04 -0500
Date: Fri, 27 Jan 2006 01:12:33 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/2] rcu batch tuning
Message-ID: <20060126194233.GG4166@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060126184010.GD4166@in.ibm.com> <20060126184127.GE4166@in.ibm.com> <20060126193317.GD6182@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126193317.GD6182@us.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 11:33:17AM -0800, Paul E. McKenney wrote:
> On Fri, Jan 27, 2006 at 12:11:27AM +0530, Dipankar Sarma wrote:
> > 
> > This patch adds new tunables for RCU queue and finished batches.
> > There are two types of controls - number of completed RCU updates
> > invoked in a batch (blimit) and monitoring for high rate of
> > incoming RCUs on a cpu (qhimark, qlowmark). By default,
> > the per-cpu batch limit is set to a small value. If
> > the input RCU rate exceeds the high watermark, we do two things -
> > force quiescent state on all cpus and set the batch limit
> > of the CPU to INTMAX. Setting batch limit to INTMAX forces all
> > finished RCUs to be processed in one shot. If we have more than
> > INTMAX RCUs queued up, then we have bigger problems anyway.
> > Once the incoming queued RCUs fall below the low watermark, the batch limit
> > is set to the default.
> 
> Looks good to me!  We might have to have more sophisticated adjustment
> of blimit, but starting simple is definitely the right way to go.

Yes. Once I am set up to do latency measurements, I will look at
the possible need for more sophisticated adjustment of blimit.

Thanks
Dipankar
