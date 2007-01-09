Return-Path: <linux-kernel-owner+w=401wt.eu-S932230AbXAIQqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbXAIQqX (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 11:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbXAIQqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 11:46:22 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:51461 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932230AbXAIQqV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 11:46:21 -0500
Date: Tue, 9 Jan 2007 22:16:04 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH] flush_cpu_workqueue: don't flush an empty ->worklist
Message-ID: <20070109164604.GA17915@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20070106111117.54bb2307.akpm@osdl.org> <20070107110013.GD13579@in.ibm.com> <20070107115957.6080aa08.akpm@osdl.org> <20070107210139.GA2332@tv-sign.ru> <20070108155428.d76f3b73.akpm@osdl.org> <20070109050417.GC589@in.ibm.com> <20070108212656.ca77a3ba.akpm@osdl.org> <20070109150755.GB89@tv-sign.ru> <20070109155908.GD22080@in.ibm.com> <20070109163815.GA208@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109163815.GA208@tv-sign.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 07:38:15PM +0300, Oleg Nesterov wrote:
> We can't do this. We should thaw cwq->thread (which was bound to the
> dead CPU) to complete CPU_DEAD event. So we still need some changes.

I noticed that, but I presumed kthread_stop() will post a wakeup which
will bring it out of frozen state. Looking at refrigerator(), I realize
that is not possible. 

So CPU_DEAD should do a thaw_process on the kthread before doing a
kthread_stop?

-- 
Regards,
vatsa
