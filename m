Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVFCIPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVFCIPs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 04:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVFCIPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 04:15:48 -0400
Received: from fire.osdl.org ([65.172.181.4]:20179 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261171AbVFCIPm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 04:15:42 -0400
Date: Fri, 3 Jun 2005 01:15:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 6/11] s390: in_interrupt vs. in_atomic.
Message-Id: <20050603011529.6171359d.akpm@osdl.org>
In-Reply-To: <OF70B2F27D.009D5702-ONC1257015.002B0625-C1257015.002B7793@de.ibm.com>
References: <20050602154333.33df8335.akpm@osdl.org>
	<OF70B2F27D.009D5702-ONC1257015.002B0625-C1257015.002B7793@de.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
>
> > > The condition for no context in do_exception checks for hard and
> > > soft interrupts by using in_interrupt() but not for preemption.
> > > This is bad for the users of __copy_from/to_user_inatomic because
> > > the fault handler might call schedule although the preemption
> > > count is != 0. Use in_atomic() instead in_interrupt().
> > >
> >
> > hm.  Under what circumstances do you expect this test to trigger?
> 
> e.g. by the following:
> 
> static inline int get_futex_value_locked(int *dest, int __user *from)
> {
>         int ret;
> 
>         inc_preempt_count();
>         ret = __copy_from_user_inatomic(dest, from, sizeof(int));
>         dec_preempt_count();
>         preempt_check_resched();
> 
>         return ret ? -EFAULT : 0;
> }
> 

OK, that's what it's designed for.   Just checking ;)
