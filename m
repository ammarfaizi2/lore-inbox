Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964968AbWIENw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbWIENw6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 09:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964989AbWIENw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 09:52:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20203 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964968AbWIENwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 09:52:54 -0400
Subject: Re: [PATCH 10/16] GFS2: Logging and recovery
From: Steven Whitehouse <swhiteho@redhat.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
In-Reply-To: <Pine.LNX.4.61.0609041856030.28823@yvahk01.tjqt.qr>
References: <1157031466.3384.803.camel@quoit.chygwyn.com>
	 <Pine.LNX.4.61.0609041856030.28823@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Tue, 05 Sep 2006 14:58:33 +0100
Message-Id: <1157464713.3384.1007.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2006-09-04 at 19:44 +0200, Jan Engelhardt wrote:
> >+		a = (old_tail <= ai->ai_first);
> >+		b = (ai->ai_first < new_tail);
> 
> >+	if (!(!error && dbn)) {
> >+		printk(KERN_INFO "error=%d, dbn=%llu lbn=%u", error, (unsigned long long)dbn, lbn);
> >+	}
> 
> error || dbn
> -{}
> 
ok. error || !dbn though

> >+#if 0
> >+	unsigned int d;
> >+
> >+	d = log_distance(sdp, sdp->sd_log_flush_head, sdp->sd_log_head);
> >+
> >+	gfs2_assert_withdraw(sdp, d + 1 == sdp->sd_log_blks_reserved);
> >+#endif
> 
now removed.

> >+		if (lb->lb_real) {
> >+			while (atomic_read(&bh->b_count) != 1)  /* Grrrr... */
> >+				schedule();
> 
> Grrr? Someone stole us the b_count?
> 
I guess. I think I'll add that to the list to look at more closely as
its not immediately clear to me when this might happen.

> >+	unsigned int offset = sizeof(struct gfs2_log_descriptor);
> >+	offset += (sizeof(__be64)-1);
> >+	offset &= ~(sizeof(__be64)-1);
> ()
> 
> 
> Jan Engelhardt
ok, plus one or two others I spotted at the same time:

http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6.git;a=commitdiff;h=a67cdbd4579c387c021a17c7447da8b88f2a94f4

Steve.


