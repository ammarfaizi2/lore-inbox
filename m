Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269711AbUINTd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269711AbUINTd6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 15:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269704AbUINTdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 15:33:38 -0400
Received: from peabody.ximian.com ([130.57.169.10]:4282 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S269333AbUINTa0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 15:30:26 -0400
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
From: Robert Love <rml@ximian.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20040914192512.GA3365@dualathlon.random>
References: <20040914114228.GD2804@elte.hu> <4146EA3E.4010804@yahoo.com.au>
	 <20040914132225.GA9310@elte.hu> <4146F33C.9030504@yahoo.com.au>
	 <20040914140905.GM4180@dualathlon.random> <41470021.1030205@yahoo.com.au>
	 <20040914150316.GN4180@dualathlon.random>
	 <1095185103.23385.1.camel@betsy.boston.ximian.com>
	 <20040914185212.GY9106@holomorphy.com>
	 <1095188569.23385.11.camel@betsy.boston.ximian.com>
	 <20040914192512.GA3365@dualathlon.random>
Content-Type: text/plain
Date: Tue, 14 Sep 2004 15:29:12 -0400
Message-Id: <1095190152.23385.31.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-14 at 21:25 +0200, Andrea Arcangeli wrote:

Hi, Andrea.

> On Tue, Sep 14, 2004 at 03:02:49PM -0400, Robert Love wrote:
> > 	- you can safely call schedule() while holding it
> > 	- you can grab it recursively
> > 	- you cannot use it in interrupt handlers
> 
> the latter won't make it harder to get rid of at least ;)

Indeed.  I should not of lumped the last property in with the "things to
get rid of", although it is one of the implicit rules of the BKL.

We probably don't want to actually start disabling interrupts for no
reason when we grab the BKL. ;-)

Although the locks that replace the BKL can certainly be BKL-safe locks.

> yes, I don't think it will make thing worse in respect of dropping the
> bkl, if something it should help.
> 
> probably the bkl is still there because removing it won't bring much
> further value to the kernel at runtime, it'd probably only make the
> kernel a bit cleaner and simpler.

I agree.  Barring a few worst-case examples, I think the only reason
going forward to reduce the BKL's use is cleanliness and simplicity.  It
is rather hard at times to find just what the BKL is locking.

	Robert Love


