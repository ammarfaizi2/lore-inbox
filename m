Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbTLUAaY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 19:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbTLUAaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 19:30:24 -0500
Received: from dp.samba.org ([66.70.73.150]:1675 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261885AbTLUAaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 19:30:21 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [CFT][RFC] HT scheduler 
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@redhat.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>,
       John Hawkes <hawkes@sgi.com>
In-reply-to: Your message of "Fri, 19 Dec 2003 15:57:13 +1100."
             <3FE28529.1010003@cyberone.com.au> 
Date: Sat, 20 Dec 2003 13:43:38 +1100
Message-Id: <20031221003020.6F4482C0D1@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3FE28529.1010003@cyberone.com.au> you write:
> + * See comment for set_cpus_allowed. calling rules are different:
> + * the task's runqueue lock must be held, and __set_cpus_allowed
> + * will return with the runqueue unlocked.

Please, never *ever* do this.

Locking is probably the hardest thing to get right, and code like this
makes it harder.

Fortunately, there is a simple solution coming with the hotplug CPU
code: we need to hold the cpucontrol semaphore here anyway, against
cpus vanishing.

Perhaps we should just use that in both places.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
