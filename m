Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262035AbUKJTPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbUKJTPK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 14:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbUKJTPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 14:15:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:12972 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262035AbUKJTPF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 14:15:05 -0500
Date: Wed, 10 Nov 2004 11:14:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: dcn@sgi.com (Dean Nelson)
Cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       Christoph Hellwig <hch@lst.de>
Subject: Re: kthread realtime priorities and exporting 
 sys_sched_setscheduler()
Message-Id: <20041110111452.1724b353.akpm@osdl.org>
In-Reply-To: <4192424B.mailxNJY11KR1G@aqua.americas.sgi.com>
References: <4192424B.mailxNJY11KR1G@aqua.americas.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dcn@sgi.com (Dean Nelson) wrote:
>
> I'm trying to push XP[C|NET] out to the community. (For further details:
> http://marc.theaimsgroup.com/?l=linux-ia64&m=109337050919186&w=2 )
> 
> An objection was raised over the exporting and calling of
> sys_sched_setscheduler(), which XPC calls to make its kthreads
> run at realtime priorities. Without this change we found that it
> was possible for user processes to be given a higher effective
> priority than the kthreads used by XPC. The upshot of this was
> that the latencies incurred by XPC increased 300 times in the
> test example given. If XPC's kthreads were given realtime
> priorities this did not happen. (For further details:
> http://marc.theaimsgroup.com/?l=linux-ia64&m=109337503100067&w=2 )

I'd disagree with Christoph on that.  Being able to set the scheduling
policy from a module-based kernel thread is a sensible thing to be able to
do, and you can do it by issuing a direct trap anyway.

EXPORT_SYMBOL_GPL() would be preferred.

Possibly it could be done by adding a variant of kthread_create() which has
a new `policy' argument, but it doesn't really seem worth the fuss.
