Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbTLAKIO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 05:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbTLAKIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 05:08:14 -0500
Received: from mx2.elte.hu ([157.181.151.9]:49607 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262776AbTLAKIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 05:08:13 -0500
Date: Mon, 1 Dec 2003 11:08:17 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch] sched-HT-2.6.0-test11-A5
In-Reply-To: <1027750000.1069604762@[10.10.2.4]>
Message-ID: <Pine.LNX.4.58.0312011102540.3323@earth>
References: <20031117021511.GA5682@averell>
 <3FB83790.3060003@cyberone.com.au><20031117141548.GB1770@colin2.muc.de>
 <Pine.LNX.4.56.0311171638140.29083@earth><20031118173607.GA88556@colin2.muc.de>
 <Pine.LNX.4.56.0311181846360.23128@earth><20031118235710.GA10075@colin2.muc.de>
 <3FBAF84B.3050203@cyberone.com.au><501330000.1069443756@flay>
 <3FBF099F.8070403@cyberone.com.au><1010800000.1069532100@[10.10.2.4]>
 <3FC01817.3090705@cyberone.com.au><3FC0A0C2.90800@cyberone.com.au>
 <Pine.LNX.4.56.0311231300290.16152@earth> <1027750000.1069604762@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Nov 2003, Martin J. Bligh wrote:

> > have you seen my HT scheduler patches, in particular the HT scheduler
> > in Fedora Core 1, which is on top of a pretty recent 2.6 scheduler? Works
> > pretty well.
> 
> Do you have a pointer to an updated patch? I haven't seen a version of
> that for a while, and would like to play with it.

i've uploaded the HT scheduler patch against 2.6.0-test11 to:

    redhat.com/~mingo/O(1)-scheduler/sched-HT-2.6.0-test11-A5

note, the patch includes a fix to sync wakeups, which might hurt lat_ctx.  
I've attached the fix against vanilla 2.6.0-test11 as well.

	Ingo

--- linux/kernel/sched.c.orig	
+++ linux/kernel/sched.c	
@@ -646,7 +646,7 @@ repeat_lock_task:
 				 */
 				p->activated = -1;
 			}
-			if (sync)
+			if (sync && (task_cpu(p) == smp_processor_id()))
 				__activate_task(p, rq);
 			else {
 				activate_task(p, rq);
