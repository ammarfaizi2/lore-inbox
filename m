Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266755AbSKHEMT>; Thu, 7 Nov 2002 23:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266756AbSKHEMS>; Thu, 7 Nov 2002 23:12:18 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:28938
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S266755AbSKHEMR>; Thu, 7 Nov 2002 23:12:17 -0500
Subject: Re: ps performance sucks (was Re: dcache_rcu [performance results])
From: Robert Love <rml@tech9.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Alexander Viro <viro@math.psu.edu>,
       mbligh@aracnet.com, ahu@ds9a.nl, peter@chubb.wattle.id.au,
       jw@pegasys.ws, linux-kernel@vger.kernel.org
In-Reply-To: <20021108035724.GB22031@holomorphy.com>
References: <32290000.1036545797@flay>
	<Pine.GSO.4.21.0211051932140.6521-100000@steklov.math.psu.edu>
	<20021107230613.5194156c.rusty@rustcorp.com.au> 
	<20021108035724.GB22031@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 Nov 2002 23:17:21 -0500
Message-Id: <1036729047.765.2887.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-07 at 22:57, William Lee Irwin III wrote:

> One way to at least "postpone" having to do things like making a fair
> tasklist_lock is to make readers well-behaved. /proc/ is the worst
> remaining offender left with its quadratic (!) get_pid_list(). After
> "kernel, you're being bad and spinning in near-infinite loops with the
> tasklist_lock readlocked" is (completely?) solved, then we can wait for
> boxen with higher cpu counts to catch fire anyway when the arrival rate
> of readers * hold time of readers > 1, which will happen because arrival
> rates are O(cpus), and cpus will grow without bound as machines advance.
> 
> I'm not sure RCU would help this any; I'd be very much afraid of the
> writes being postponed indefinitely or just too long in the presence
> of what's essentially perpetually in-progress read access. Does RCU
> have a guarantee of forward progress for writers?

I am not sure I like the idea of RCU for the tasklist_lock.

I do agree 100% with your first point, though - the problem is
ill-behaved readers.  I think the writing vs. reading is such that the
rw-lock we have now is fine, we just need to make e.g. /proc play way
way more fair.

	Robert Love

