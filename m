Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261605AbSKHEY5>; Thu, 7 Nov 2002 23:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261617AbSKHEY5>; Thu, 7 Nov 2002 23:24:57 -0500
Received: from holomorphy.com ([66.224.33.161]:2984 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261605AbSKHEY4>;
	Thu, 7 Nov 2002 23:24:56 -0500
Date: Thu, 7 Nov 2002 20:29:25 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Robert Love <rml@tech9.net>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Alexander Viro <viro@math.psu.edu>,
       mbligh@aracnet.com, ahu@ds9a.nl, peter@chubb.wattle.id.au,
       jw@pegasys.ws, linux-kernel@vger.kernel.org
Subject: Re: ps performance sucks (was Re: dcache_rcu [performance results])
Message-ID: <20021108042925.GD23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Robert Love <rml@tech9.net>, Rusty Russell <rusty@rustcorp.com.au>,
	Alexander Viro <viro@math.psu.edu>, mbligh@aracnet.com, ahu@ds9a.nl,
	peter@chubb.wattle.id.au, jw@pegasys.ws,
	linux-kernel@vger.kernel.org
References: <32290000.1036545797@flay> <Pine.GSO.4.21.0211051932140.6521-100000@steklov.math.psu.edu> <20021107230613.5194156c.rusty@rustcorp.com.au> <20021108035724.GB22031@holomorphy.com> <1036729047.765.2887.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036729047.765.2887.camel@phantasy>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-07 at 22:57, William Lee Irwin III wrote:
>> I'm not sure RCU would help this any; I'd be very much afraid of the
>> writes being postponed indefinitely or just too long in the presence
>> of what's essentially perpetually in-progress read access. Does RCU
>> have a guarantee of forward progress for writers?

On Thu, Nov 07, 2002 at 11:17:21PM -0500, Robert Love wrote:
> I am not sure I like the idea of RCU for the tasklist_lock.
> I do agree 100% with your first point, though - the problem is
> ill-behaved readers.  I think the writing vs. reading is such that the
> rw-lock we have now is fine, we just need to make e.g. /proc play way
> way more fair.

This is only feasible for small numbers of cpus. Any compensation
provided by algorithmic improvements on the read-side is outweighed by
NR_CPUS. Making readers well-behaved only solves half of the issue.
Whether the other half is addressible in a 2.6.x time scale is an open
question, but a question I'd like to see answered in favor of fixing
the livelocks sooner rather than later (esp. as 2.7+ issues are unlikely
to be resolved in line with hardware release schedules). I have a
strong bias toward code which works everywhere, all the time.

Bill
