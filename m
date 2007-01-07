Return-Path: <linux-kernel-owner+w=401wt.eu-S932613AbXAGRcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932613AbXAGRcf (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 12:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932617AbXAGRcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 12:32:35 -0500
Received: from mail.screens.ru ([213.234.233.54]:43793 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932613AbXAGRcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 12:32:35 -0500
Date: Sun, 7 Jan 2007 20:33:34 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH] fix-flush_workqueue-vs-cpu_dead-race-update
Message-ID: <20070107173334.GC238@tv-sign.ru>
References: <20070106151036.GA951@tv-sign.ru> <20070106154506.GC24274@in.ibm.com> <20070106163035.GA2948@tv-sign.ru> <20070106163851.GA13579@in.ibm.com> <20070106173416.GA3771@tv-sign.ru> <20070107104328.GC13579@in.ibm.com> <20070107125603.GA74@tv-sign.ru> <20070107142246.GA149@tv-sign.ru> <20070107164344.GB6800@in.ibm.com> <20070107170158.GC6800@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070107170158.GC6800@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07, Srivatsa Vaddagiri wrote:
>
> On Sun, Jan 07, 2007 at 10:13:44PM +0530, Srivatsa Vaddagiri wrote:
> 
> I guess you could have cwq->thread flush only it's cpu's workqueue by
> running on another cpu,

yes, this is what I meant,

>                           which will avoid the need to synchronize
> between worker threads. I am not 100% sure if that breaks workqueue
> model in any way (since we could have two worker threads running on the
> same CPU, but servicing different queues). Hopefully it doesnt.

We are already doing this on CPU_DEAD->kthread_stop().

> However the concern expressed below remains ..
> 
> > Finally, I am concerned about the (un)friendliness of this programming
> > model, where programmers are restricted in not having a stable access to
> > cpu_online_map at all -and- also requiring them to code in non-obvious
> > terms. Granted that writing hotplug-safe code is non-trivial, but the
> > absence of "safe access to online_map" will make it more complicated.

please see the previous message.

Srivatsa, I don't claim my idea is the best. Actually I still hope somebody
else will suggest something better and simpler :)

Oleg.

