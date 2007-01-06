Return-Path: <linux-kernel-owner+w=401wt.eu-S1751427AbXAFQjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbXAFQjG (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 11:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbXAFQjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 11:39:05 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:56694 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427AbXAFQjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 11:39:03 -0500
Date: Sat, 6 Jan 2007 22:08:51 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH] fix-flush_workqueue-vs-cpu_dead-race-update
Message-ID: <20070106163851.GA13579@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20061217223416.GA6872@tv-sign.ru> <20061218162701.a3b5bfda.akpm@osdl.org> <20061219004319.GA821@tv-sign.ru> <20070104113214.GA30377@in.ibm.com> <20070104142936.GA179@tv-sign.ru> <20070104091850.c1feee76.akpm@osdl.org> <20070106151036.GA951@tv-sign.ru> <20070106154506.GC24274@in.ibm.com> <20070106163035.GA2948@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070106163035.GA2948@tv-sign.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2007 at 07:30:35PM +0300, Oleg Nesterov wrote:
> Stupid me. Thanks.
> 
> I'll try to do something else tomorrow. Do you see a simple soulution?

Sigh ..I dont see a simple solution, unless we have something like
lock_cpu_hotplug() ..

Andrew,
	This workqueue problem has exposed a classic example of how 
tough/miserable it can be to write hotplug safe code w/o something like
lock_cpu_hotplug() ..Are you still inclined towards banning it? :)

FYI, the lock_cpu_hotplug() rewrite proposed by Gautham at
http://lkml.org/lkml/2006/10/26/65 may still need refinement to avoid
all the kind of deadlocks we have unearthed with workqueue example. I
can review that design with Gautham if there is some interest to
revive lock_cpu_hotplug() ..

> The current usage of workqueue_mutex (I mean stable kernel) is broken
> and deadlockable. We really need to change it.

Yep ..

-- 
Regards,
vatsa
