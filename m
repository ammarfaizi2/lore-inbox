Return-Path: <linux-kernel-owner+w=401wt.eu-S1751414AbXAFPZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbXAFPZh (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 10:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbXAFPZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 10:25:37 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:36096 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751414AbXAFPZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 10:25:36 -0500
Date: Sat, 6 Jan 2007 20:54:14 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH, RFC] reimplement flush_workqueue()
Message-ID: <20070106152413.GB24274@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20061217223416.GA6872@tv-sign.ru> <20061218162701.a3b5bfda.akpm@osdl.org> <20061219004319.GA821@tv-sign.ru> <20070104113214.GA30377@in.ibm.com> <20070104142936.GA179@tv-sign.ru> <20070104091850.c1feee76.akpm@osdl.org> <20070104180901.GA344@tv-sign.ru> <20070104103107.e33768d7.akpm@osdl.org> <20070105090347.GC18088@in.ibm.com> <20070105140717.GA81@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070105140717.GA81@tv-sign.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2007 at 05:07:17PM +0300, Oleg Nesterov wrote:
> How about block_cpu_down() ?

Maybe ..not sure 

If we do introduce such a function, we may need to convert several
preempt_disable() that are there already (with intent of blocking
cpu_down) to block_cpu_down() ..

> These cpu-hotplug races delayed the last workqueue patch I have in my queue.
> flush_workqueue() misses an important optimization: we don't need to insert
> a barrier and have an extra wake_up + wait_for_completion when cwq has no
> pending works. But we need ->current_work (introduced in the next patch) to
> implement this correctly.
> 
> I'll re-send the patch below later, when we finish with the bug you pointed
> out, but it would be nice if you can take a look now.

The patch seems fine to me, though I dont see any cpu hotplug
related problem being exposed/solved in this patch.

-- 
Regards,
vatsa
