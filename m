Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbULNXP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbULNXP1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 18:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbULNXPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 18:15:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24039 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261648AbULNXI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 18:08:57 -0500
Date: Tue, 14 Dec 2004 15:08:46 -0800
Message-Id: <200412142308.iBEN8kEU011850@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Ulrich Drepper <drepper@redhat.com>, Christoph Lameter <clameter@sgi.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] cpu-timers: high-resolution CPU clocks for POSIX
 clock_* syscalls
In-Reply-To: Linus Torvalds's message of  Tuesday, 14 December 2004 14:44:47 -0800 <Pine.LNX.4.58.0412141441080.3279@ppc970.osdl.org>
Emacs: a Lisp interpreter masquerading as ... a Lisp interpreter!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> More interestingly (where "interesting" is defined as "could be really 
> nasty") it's likely to interact very badly in cases where we have some 
> _physically_ local clocks. Ie we might have some situation where we do 
> some node-local thing for intra-node scheduling, with some other clock for 
> inter-node scheduling. Exposing such a clock to a process that isn't 
> actually using it could result in the node-local clock source suddenly 
> needing to be exposed outside the node.

Not with the support I've written.  When you get the thread CPU time of any
thread but yourself, you just take ->sched_time as already stored and don't
do a sched_clock sample right then.  So you only see the amount of time
that has accrued as of that thread's last context switch or timer interrupt
(scheduler_tick), and not whatever amount is known only on the local CPU
where it is running right now.


Thanks,
Roland
