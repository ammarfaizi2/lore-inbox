Return-Path: <linux-kernel-owner+w=401wt.eu-S1751284AbXAIKUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbXAIKUT (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 05:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbXAIKUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 05:20:18 -0500
Received: from smtp.osdl.org ([65.172.181.24]:55486 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751284AbXAIKUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 05:20:16 -0500
Date: Tue, 9 Jan 2007 02:15:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: vatsa@in.ibm.com
Cc: Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH] flush_cpu_workqueue: don't flush an empty ->worklist
Message-Id: <20070109021551.b7781c53.akpm@osdl.org>
In-Reply-To: <20070109100925.GA22080@in.ibm.com>
References: <20070106163851.GA13579@in.ibm.com>
	<20070106111117.54bb2307.akpm@osdl.org>
	<20070107110013.GD13579@in.ibm.com>
	<20070107115957.6080aa08.akpm@osdl.org>
	<20070107210139.GA2332@tv-sign.ru>
	<20070108155428.d76f3b73.akpm@osdl.org>
	<20070109050417.GC589@in.ibm.com>
	<20070108212656.ca77a3ba.akpm@osdl.org>
	<20070109093302.GE589@in.ibm.com>
	<20070109015152.d5021254.akpm@osdl.org>
	<20070109100925.GA22080@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2007 15:39:26 +0530
Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:

> I just hope the latency of freeze_processes() is tolerable ..

It'll be roughly proportional to the number of processes, I guess: if we
have 100,000 processes (or threads) doing sleep(1000000) then yeah, it'll
take some time to wake them all up and capture them in refrigerator().

But I suspect a suitable fix for any problems which arise there is to
implement gang-offlining and onlining, rather than the present
one-cpu-at-a-time.  That'd be pretty simple to do: we already have sysfs
interfaces which take a cpumask.
