Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265875AbTFSSIU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 14:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265878AbTFSSIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 14:08:20 -0400
Received: from users.ccur.com ([208.248.32.211]:54699 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S265875AbTFSSIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 14:08:16 -0400
Date: Thu, 19 Jun 2003 14:20:57 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Robert Love <rml@tech9.net>
Cc: george anzinger <george@mvista.com>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Andrew Morton'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'mingo@elte.hu'" <mingo@elte.hu>, "Li, Adam" <adam.li@intel.com>
Subject: Re: [patch] setscheduler fix
Message-ID: <20030619182057.GA1228@rudolph.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
References: <A46BBDB345A7D5118EC90002A5072C780DD16DB0@orsmsx116.jf.intel.com> <3EF1DE35.20402@mvista.com> <20030619171950.GA936@rudolph.ccur.com> <1056044732.8770.39.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1056044732.8770.39.camel@localhost>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here is my patch. It is the same idea as Joe's. Is there a better fix?
> 
> Basically, the problem is that setscheduler() does not set need_resched
> when needed. There are two basic cases where this is needed:
> 
> 	- the task is running, but now it is no longer the highest
> 	  priority task on the rq
> 	- the task is not running, but now it is the highest
> 	  priority task on the rq
> 
> In either case, we need to set need_resched to invoke the scheduler.
> 
> Patch is against 2.5.72. Comments?

Looks good to me.

migration_thread and try_to_wake_up already have a simplier version of
your test that seems to be correct for that environment, so no change
is needed there.

wake_up_forked_process in principle might need your patch, but as it
appears to be called only from boot code it is unimportant that it
have the lowest possible latency, so no change is needed there either.

Joe
