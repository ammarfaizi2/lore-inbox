Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262304AbVGWCbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbVGWCbf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 22:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbVGWCbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 22:31:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40069 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262304AbVGWCbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 22:31:33 -0400
Date: Sat, 23 Jul 2005 12:30:00 +1000
From: Andrew Morton <akpm@osdl.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: arjan@infradead.org, domen@coderock.org, linux-kernel@vger.kernel.org,
       clucas@rotomalug.org
Subject: Re: [UPDATE PATCH] Add
 schedule_timeout_{interruptible,uninterruptible}_msecs() interfaces
Message-Id: <20050723123000.1808f3c4.akpm@osdl.org>
In-Reply-To: <20050723010801.GA4366@us.ibm.com>
References: <20050707213138.184888000@homer>
	<20050708160824.10d4b606.akpm@osdl.org>
	<20050723002658.GA4183@us.ibm.com>
	<1122078715.5734.15.camel@localhost.localdomain>
	<20050723010801.GA4366@us.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nishanth Aravamudan <nacc@us.ibm.com> wrote:
>
> 
> +/*
> + * schedule_timeout_msecs - sleep until timeout
> + * @timeout_msecs: timeout value in milliseconds
> + *
> + * A human-time (but otherwise identical) alternative to
> + * schedule_timeout() The state, therefore, *does* need to be set before
> + * calling this function, but this function should *never* be called
> + * directly. Use the nice wrappers, schedule_{interruptible,
> + * uninterruptible}_timeout_msecs().
> + *
> + * See the comment for schedule_timeout() for details.
> + */
> +inline unsigned int __sched schedule_timeout_msecs(unsigned int timeout_msecs)
> +{

Making this inline will add more kernel text.    Can't we uninline it?

I'm surprised that this function is not implemented as a call to the
existing schedule_timeout()?

> +	init_timer(&timer);
> +	timer.expires = expire_jifs;
> +	timer.data = (unsigned long) current;
> +	timer.function = process_timeout;

hm, if we add the needed typecast to TIMER_INITIALIZER() the above could be

	timer = TIMER_INITIALIZER(process_timeout, expire_jifs,
				(unsigned long)current);


