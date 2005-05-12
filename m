Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262066AbVELQbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbVELQbJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 12:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbVELQbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 12:31:08 -0400
Received: from fmr21.intel.com ([143.183.121.13]:26262 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S262066AbVELQbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 12:31:04 -0400
From: Jesse Barnes <jesse.barnes@intel.com>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] (How to) Let idle CPUs sleep
Date: Thu, 12 May 2005 09:28:55 -0700
User-Agent: KMail/1.8
Cc: Lee Revell <rlrevell@joe-job.com>, vatsa@in.ibm.com,
       Nick Piggin <nickpiggin@yahoo.com.au>, schwidefsky@de.ibm.com,
       jdike@addtoit.com, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
References: <20050507182728.GA29592@in.ibm.com> <1115913679.20909.31.camel@mindpipe> <20050512161636.GA15653@atomide.com>
In-Reply-To: <20050512161636.GA15653@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505120928.55476.jesse.barnes@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, May 12, 2005 9:16 am, Tony Lindgren wrote:
> * Lee Revell <rlrevell@joe-job.com> [050512 09:05]:
> > On Thu, 2005-05-12 at 14:16 +0530, Srivatsa Vaddagiri wrote:
> > > On Wed, May 11, 2005 at 11:03:49AM -0700, Tony Lindgren wrote:
> > > > Sorry to jump in late. For embedded stuff we should be able to
> > > > skip ticks until something _really_ happens, like an interrupt.
> > > >
> > > > So we need to be able to skip ticks several seconds at a time.
> > > > Ticks should be event driven. For embedded systems option B is
> > > > really the only way to go to take advantage of the power
> > > > savings.

That seems like a lot of added complexity.  Isn't it possible to go 
totally tickless and actually *remove* some of the complexity of the 
current design?  I know Linus has frowned upon the idea in the past, 
but I've had to deal with the tick code a bit in the past, and it seems 
like getting rid of ticks entirely might actually simplify things (both 
conceptually and code-wise).

Seems like we could schedule timer interrupts based solely on add_timer 
type stuff; the scheduler could use it if necessary for load balancing 
(along with fork/exec based balancing perhaps) on large machines where 
load imbalances hurt throughput a lot.  But on small systems if all 
your processes were blocked, you'd just go to sleep indefinitely and 
save a bit of power and avoid unnecessary overhead.

I haven't looked at the lastest tickless patches, so I'm not sure if my 
claims of simplicity are overblown, but especially as multiprocessor 
systems become more and more common it just seems wasteful to wakeup 
all the CPUs every so often only to have them find that they have 
nothing to do.

Jesse
