Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbVHVUOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbVHVUOc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 16:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbVHVUOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 16:14:32 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:54751 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750828AbVHVUOa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 16:14:30 -0400
Date: Mon, 22 Aug 2005 10:42:22 -0700
From: tony.luck@intel.com
Message-Id: <200508221742.j7MHgMJI020020@agluck-lia64.sc.intel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jasonuhl@sgi.com
Subject: RE: CONFIG_PRINTK_TIME woes
In-Reply-To: <20050821021616.6bbf2a14.akpm@osdl.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F042C7DA7@scsmsx401.amr.corp.intel.com>
	<20050821021322.3986dd4a.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>jiffies wouldn't have sufficient resolution for this application.  Bear in
>mind that this is just a debugging thing - it's better to have good
>resolution with occasional theoretical weirdness than to have poor
>resolution plus super-consistency, IMO.

The majority of architectures currently use a sched_clock() that
just scales jiffies (but that may just mean they haven't gotten around
to implementing anything better yet).

But how much resolution we need is a very good question, as it will
affect our choice of clock.

In many cases I've been presented with a console log which has a
few warning messages, and then an OOPS ... the initial question
I would like to answer is were the warnings printed "just before"
the oops ... or days earlier.  For these cases having a 1 second
resolution would be a huge bonus over no time information at all.
Jiffies would be good enough for almost all cases (IMO).

At the other extreme ... the current use of sched_clock() with
potentially nano-second resolution is way over the top.  Logging
to a serial console at 115200 a typical line from printk will take
2-4 milli-seconds to print ... so there would seem to be little
benefit from a sub-millisecond resolution (in fact at 250HZ jiffies
are on the ragged edge of being good enough).

If that isn't sufficient ... it should be possible to make a cut-down,
lockless version of do_gettimeofday that meets Andrew's suggestion
of good resolution with occasional theoretical weirdness.  But before
we go there ... I'd like to hear whether there are usage models that
really need better resolution than jiffies can provide?

-Tony
