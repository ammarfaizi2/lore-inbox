Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUCIBvi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 20:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbUCIBvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 20:51:38 -0500
Received: from ozlabs.org ([203.10.76.45]:26073 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261451AbUCIBvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 20:51:36 -0500
Subject: Re: more efficient current_is_keventd macro? [was Re: [lhcs-devel]
	Re: Kthread_create() never returns when called from worker_thread]
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: vatsa@in.ibm.com, mingo@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20040308143658.25c1d378.akpm@osdl.org>
References: <20040308123030.GA7428@in.ibm.com>
	 <20040308143658.25c1d378.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1078797038.18171.707.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 09 Mar 2004 12:50:39 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-09 at 09:36, Andrew Morton wrote:
> Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:
> > int current_is_keventd(void)
> > {
> > +       int cpu = smp_processor_id();
> > +	cwq = keventd_wq->cpu_wq + cpu;
> > +	if (current == cwq->thread)
> > +		return 1;
> > +	else
> > +		return 0;
> > }
> 
> Is racy in the presence of preemption.

Actually, it's not, because if current *is* keventd we're nailed to the
CPU, and if it's not, we're going to return false either way.

But it *should* be fixed, simply as an example to others.

Cheers,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

