Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267461AbUH3TAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267461AbUH3TAE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 15:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268820AbUH3S5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 14:57:35 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:32847 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S268383AbUH3S4T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 14:56:19 -0400
Date: Mon, 30 Aug 2004 11:52:23 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Jim Houston <jim.houston@comcast.net>
Cc: linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jack Steiner <steiner@sgi.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       rusty@rustcorp.com.au
Subject: Re: [RFC&PATCH] Alternative RCU implementation
Message-ID: <20040830185223.GF1243@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <m3brgwgi30.fsf@new.localdomain> <20040830004322.GA2060@us.ibm.com> <1093886020.984.238.camel@new.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093886020.984.238.camel@new.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2004 at 01:13:41PM -0400, Jim Houston wrote:
> I know that I'm questioning one of your design goals for RCU by adding
> overhead to the read-side.  I have read everything I could find on RCU.
> My belief is that the cost of the xchg() instruction is small 
> compared to the cache benifit of freeing memory more quickly.
> I think it's more interesting to look at the impact of the xchg() at the
> level of an entire system call.  Adding 30 nanoseconds to a open/close
> path that tasks 3 microseconds seems reasonable.  It is hard to measure
> the benefit of reusing the a dcache entry more quickly.

Hello, Jim,

The other thing to keep in mind is that reducing the grace-period
duration increases the per-access overhead, since each grace period
incurs a cost.  So there is a balance that needs to be struck between
overflowing memory with a too-long grace period and incurring too
much overhead with a too-short grace period.

How does the rest of the kernel work with all interrupts to
a particular CPU shut off?  For example, how do you timeslice?

						Thanx, Paul

PS.  My concerns with some aspects of your design aside, your
     getting a significant change to the RCU infrastructure to
     work reasonably well is quite impressive!
