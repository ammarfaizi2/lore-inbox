Return-Path: <linux-kernel-owner+w=401wt.eu-S1751079AbXACA2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbXACA2G (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 19:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751561AbXACA2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 19:28:06 -0500
Received: from smtp.osdl.org ([65.172.181.25]:49222 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751079AbXACA2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 19:28:03 -0500
Date: Tue, 2 Jan 2007 16:27:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>,
       Gautham R Shenoy <ego@in.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/2] fix flush_workqueue() vs CPU_DEAD race
Message-Id: <20070102162727.9ce2ae2b.akpm@osdl.org>
In-Reply-To: <20061230161031.GA101@tv-sign.ru>
References: <20061230161031.GA101@tv-sign.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Dec 2006 19:10:31 +0300
Oleg Nesterov <oleg@tv-sign.ru> wrote:

> "[PATCH 1/2] reimplement flush_workqueue()" fixed one race when CPU goes down
> while flush_cpu_workqueue() plays with it. But there is another problem, CPU
> can die before flush_workqueue() has a chance to call flush_cpu_workqueue().
> In that case pending work_structs can migrate to CPU which was already checked,
> so we should redo the "for_each_online_cpu(cpu)" loop.
> 

I have a mental note that these:

extend-notifier_call_chain-to-count-nr_calls-made.patch
extend-notifier_call_chain-to-count-nr_calls-made-fixes.patch
extend-notifier_call_chain-to-count-nr_calls-made-fixes-2.patch
define-and-use-new-eventscpu_lock_acquire-and-cpu_lock_release.patch
define-and-use-new-eventscpu_lock_acquire-and-cpu_lock_release-fix.patch
eliminate-lock_cpu_hotplug-in-kernel-schedc.patch
eliminate-lock_cpu_hotplug-in-kernel-schedc-fix.patch
handle-cpu_lock_acquire-and-cpu_lock_release-in-workqueue_cpu_callback.patch

should be scrapped.  But really I forget what their status is.  Gautham,
can you please remind us where we're at?

