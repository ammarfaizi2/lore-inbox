Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275386AbRIZRtb>; Wed, 26 Sep 2001 13:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275389AbRIZRtQ>; Wed, 26 Sep 2001 13:49:16 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:9689 "EHLO
	e33.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S275385AbRIZRtC>; Wed, 26 Sep 2001 13:49:02 -0400
Date: Wed, 26 Sep 2001 10:48:00 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Ben LaHaise <bcrl@redhat.com>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: [patch] softirq performance fixes, cleanups, 2.4.10.
Message-ID: <20010926104800.A1143@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <Pine.LNX.4.33.0109261729570.5644-200000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0109261729570.5644-200000@localhost.localdomain>; from mingo@elte.hu on Wed, Sep 26, 2001 at 06:44:03PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2001 at 06:44:03PM +0200, Ingo Molnar wrote:
> +void __unwakeup_process(struct task_struct * p, long state)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&runqueue_lock, flags);
> +	if (!p->has_cpu && (p != current) && task_on_runqueue(p)) {
> +		del_from_runqueue(p);
> +		p->state = state;
> +	}
> +	spin_unlock_irqrestore(&runqueue_lock, flags);
> +}

Is it really possible for a task to be 'current' without having
'has_cpu' set?  If so, then don't you need to compare p to
'current' on all CPUs since 'current' is CPU specific?

-- 
Mike Kravetz                                  kravetz@us.ibm.com
IBM Linux Technology Center       (we're not at Sequent anymore)
