Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263077AbUKTEkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbUKTEkI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 23:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263113AbUKTEfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 23:35:14 -0500
Received: from holomorphy.com ([207.189.100.168]:58240 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262838AbUKTClO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:41:14 -0500
Date: Fri, 19 Nov 2004 18:41:04 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>, Christoph Lameter <clameter@sgi.com>,
       akpm@osdl.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Hugh Dickins <hugh@veritas.com>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V11 [0/7]: overview
Message-ID: <20041120024104.GE2714@holomorphy.com>
References: <Pine.LNX.4.58.0411181715280.834@schroedinger.engr.sgi.com> <419D581F.2080302@yahoo.com.au> <Pine.LNX.4.58.0411181835540.1421@schroedinger.engr.sgi.com> <419D5E09.20805@yahoo.com.au> <Pine.LNX.4.58.0411181921001.1674@schroedinger.engr.sgi.com> <1100848068.25520.49.camel@gaston> <Pine.LNX.4.58.0411190704330.5145@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0411191155180.2222@ppc970.osdl.org> <20041120020306.GA2714@holomorphy.com> <419EAB21.8020207@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419EAB21.8020207@yahoo.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> Unprivileged triggers for full-tasklist scans are NMI oops material.

On Sat, Nov 20, 2004 at 01:25:37PM +1100, Nick Piggin wrote:
> What about pushing the per-thread rss delta back into the global atomic
> rss counter in each schedule()?
> Pros:
> This would take the task exiting problem into its stride as a matter of
> course.
> Single atomic read to get rss.
> Cons:
> would just be moving the atomic op somewhere else if we don't get
> many page faults per schedule.
> Not really nice dependancies.
> Assumes schedule (not context switch) must occur somewhat regularly.
> At present this is not true for SCHED_FIFO tasks.
> Too nasty?

This doesn't sound too hot. There's enough accounting that can't be
done anywhere but schedule(), and this can be done elsewhere. Plus,
you're moving an already too-frequent operation to a more frequent
callsite.


-- wli
