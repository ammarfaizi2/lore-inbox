Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265817AbUHALW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265817AbUHALW2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 07:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265810AbUHALW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 07:22:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5592 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265817AbUHALWO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 07:22:14 -0400
Date: Sun, 1 Aug 2004 07:21:17 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Lee Revell <rlrevell@joe-job.com>
cc: Matt Mackall <mpm@selenic.com>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [Jackit-devel] Re: Statistical methods for latency profiling
In-Reply-To: <1091339954.20819.243.camel@mindpipe>
Message-ID: <Pine.LNX.4.58.0408010717290.23711@devserv.devel.redhat.com>
References: <1091251357.1677.116.camel@mindpipe>  <20040801025538.GY5414@waste.org>
  <1091330650.20819.163.camel@mindpipe> <1091339954.20819.243.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 1 Aug 2004, Lee Revell wrote:

> So stressing the filesystem moves the center to the right a bit, from
> 6-7 to 9-10, and *drastically* lengthens the 'tail'.

basically each codepath has a typical latency distribution, and when a
workload uses multiple codepaths then the latencies get intermixed almost
linearly.

> These numbers suggest to me that a lot of the latencies from 47 usecs
> and up are caused by one code path, because they are so uniformly
> distributed over the upper part of the histogram.  The prime suspect of
> course being the ide io completions.  I tested this theory by lowering
> max_sectors_kb from 64 to 32:

> These numbers all point to the ide sg completion code as the only thing
> on the system generating latencies over ~42 usecs.

yep, that's a fair assumption. Once the IO-APIC irq-redirection problems
are solved i'll try to further thread the IDE completion IRQ to remove
that ~100 usecs latency.

	Ingo
