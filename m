Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269605AbUINT26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269605AbUINT26 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 15:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269725AbUINT1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 15:27:04 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:18625 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S269703AbUINTZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 15:25:53 -0400
Date: Tue, 14 Sep 2004 21:25:13 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Robert Love <rml@ximian.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
Message-ID: <20040914192512.GA3365@dualathlon.random>
References: <20040914114228.GD2804@elte.hu> <4146EA3E.4010804@yahoo.com.au> <20040914132225.GA9310@elte.hu> <4146F33C.9030504@yahoo.com.au> <20040914140905.GM4180@dualathlon.random> <41470021.1030205@yahoo.com.au> <20040914150316.GN4180@dualathlon.random> <1095185103.23385.1.camel@betsy.boston.ximian.com> <20040914185212.GY9106@holomorphy.com> <1095188569.23385.11.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095188569.23385.11.camel@betsy.boston.ximian.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On Tue, Sep 14, 2004 at 03:02:49PM -0400, Robert Love wrote:
> 	- you can safely call schedule() while holding it
> 	- you can grab it recursively
> 	- you cannot use it in interrupt handlers

the latter won't make it harder to get rid of at least ;)

> 
> Getting rid of these, or at least better delineating them, will move the
> BKL closer to being just a very granular lock.
> 
> cond_resched_bkl() is a step toward that.

yes, I don't think it will make thing worse in respect of dropping the
bkl, if something it should help.

probably the bkl is still there because removing it won't bring much
further value to the kernel at runtime, it'd probably only make the
kernel a bit cleaner and simpler.
