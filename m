Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266867AbUIOAYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266867AbUIOAYG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 20:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266362AbUIOAXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 20:23:21 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:2978 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265805AbUIOAW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 20:22:26 -0400
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: William Lee Irwin III <wli@holomorphy.com>, Robert Love <rml@ximian.com>,
       Andrea Arcangeli <andrea@novell.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1095189593.16988.72.camel@localhost.localdomain>
References: <20040914114228.GD2804@elte.hu> <4146EA3E.4010804@yahoo.com.au>
	 <20040914132225.GA9310@elte.hu> <4146F33C.9030504@yahoo.com.au>
	 <20040914140905.GM4180@dualathlon.random> <41470021.1030205@yahoo.com.au>
	 <20040914150316.GN4180@dualathlon.random>
	 <1095185103.23385.1.camel@betsy.boston.ximian.com>
	 <20040914185212.GY9106@holomorphy.com>
	 <1095188569.23385.11.camel@betsy.boston.ximian.com>
	 <20040914192104.GB9106@holomorphy.com>
	 <1095189593.16988.72.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1095207749.2406.36.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 14 Sep 2004 20:22:29 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-14 at 15:19, Alan Cox wrote:
> Fix the data structure locking starting at the lowest level is how I've
> always tackled these messes. When the low level locking is right the
> rest just works (usually 8)).
> 
> 	"Lock data not code"
> 

Although, there is at least one case (reiser3) where we know which data
structures the BKL is supposed to be protecting, because the code does
something like reiserfs_write_lock(foo_data_structure) which gets
define'd away to lock_kernel().  And apparently some of the best and
brightest on LKML have tried and failed to fix it, and even Hans says
"it's HARD, the fix is reiser4".

So, maybe some of the current uses should be tagged as WONTFIX.

Lee

