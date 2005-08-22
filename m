Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbVHVUOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbVHVUOD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 16:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbVHVUOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 16:14:03 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:50911 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750804AbVHVUOC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 16:14:02 -0400
Date: Mon, 22 Aug 2005 10:50:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: tony.luck@intel.com
Cc: linux-kernel@vger.kernel.org, jasonuhl@sgi.com
Subject: Re: CONFIG_PRINTK_TIME woes
Message-Id: <20050822105053.29667b61.akpm@osdl.org>
In-Reply-To: <200508221742.j7MHgMJI020020@agluck-lia64.sc.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F042C7DA7@scsmsx401.amr.corp.intel.com>
	<20050821021322.3986dd4a.akpm@osdl.org>
	<200508221742.j7MHgMJI020020@agluck-lia64.sc.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tony.luck@intel.com wrote:
>
> At the other extreme ... the current use of sched_clock() with
>  potentially nano-second resolution is way over the top.  Logging
>  to a serial console at 115200 a typical line from printk will take
>  2-4 milli-seconds to print ... so there would seem to be little
>  benefit from a sub-millisecond resolution (in fact at 250HZ jiffies
>  are on the ragged edge of being good enough).
> 
>  If that isn't sufficient ... it should be possible to make a cut-down,
>  lockless version of do_gettimeofday that meets Andrew's suggestion
>  of good resolution with occasional theoretical weirdness.  But before
>  we go there ... I'd like to hear whether there are usage models that
>  really need better resolution than jiffies can provide?

I think so.  Say you're debugging or performance tuning filesystem requests
and I/O completions, etc.  You disable the console with `dmesg -n', run the
test then do `dmesg -s 1000000 > foo'.  Having somewhat-sub-millisecond
timestamping in the resulting trace is required.
