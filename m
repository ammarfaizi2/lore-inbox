Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269709AbUINSSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269709AbUINSSV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 14:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269668AbUINSNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 14:13:19 -0400
Received: from peabody.ximian.com ([130.57.169.10]:17593 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S269639AbUINSGK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 14:06:10 -0400
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
From: Robert Love <rml@ximian.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20040914150316.GN4180@dualathlon.random>
References: <20040914105904.GB31370@elte.hu>
	 <20040914110237.GC31370@elte.hu> <20040914110611.GA32077@elte.hu>
	 <20040914112847.GA2804@elte.hu> <20040914114228.GD2804@elte.hu>
	 <4146EA3E.4010804@yahoo.com.au> <20040914132225.GA9310@elte.hu>
	 <4146F33C.9030504@yahoo.com.au> <20040914140905.GM4180@dualathlon.random>
	 <41470021.1030205@yahoo.com.au>  <20040914150316.GN4180@dualathlon.random>
Content-Type: text/plain
Date: Tue, 14 Sep 2004 14:05:03 -0400
Message-Id: <1095185103.23385.1.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-14 at 17:03 +0200, Andrea Arcangeli wrote:

> we simply need a cond_resched_bkl() for that, no? Very few places are
> still serialized with the BKL, so I don't think it would be a big issue
> to convert those few places to use cond_resched_bkl.

Yes, this is all we need to do.

cond_resched() goes away under PREEMPT.

cond_resched_bkl() does not.

I did this a looong time ago, but did not get much interest.

Explicitly marking places that use BKL's "I can always call schedule()"
assumption help make it easier to phase out that assumption, too.  Or at
least better mark it.

	Robert Love


