Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264511AbTLGUSJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 15:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264512AbTLGUSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 15:18:08 -0500
Received: from dp.samba.org ([66.70.73.150]:7080 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264511AbTLGUSG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 15:18:06 -0500
Date: Mon, 8 Dec 2003 07:17:15 +1100
From: Anton Blanchard <anton@samba.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Ingo Molnar <mingo@elte.hu>, Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched-HT-2.6.0-test11-A5
Message-ID: <20031207201715.GD19412@krispykreme>
References: <1027750000.1069604762@[10.10.2.4]> <Pine.LNX.4.58.0312011102540.3323@earth> <392900000.1070737269@[10.10.2.4]> <Pine.LNX.4.58.0312061601400.1758@montezuma.fsmlabs.com> <Pine.LNX.4.58.0312071433300.28463@earth> <20031207163914.GB19412@krispykreme> <1039560000.1070817418@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039560000.1070817418@[10.10.2.4]>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Im seeing bootup crashes every now and then on a ppc64 box too. A few
> > other things Ive noticed:
> 
> ALT+sysrq+t does nothing, but NMI watchdog gives me:

I seem to be seeing 2 different problems, the first is where we are
running on the cpu we are about to remap:

running on cpu 1
mapping CPU#1's runqueue to CPU#0's runqueue.
kernel BUG in sched_map_runqueue at kernel/sched.c:1460!

ie:

BUG_ON(rq1 == rq2 || rq2->nr_running || rq_idx(cpu1) != cpu1);
                     ^^^

We should bounce ourselves off cpu2 before merging the runqueues.

Anton
