Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264511AbTLLI7d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 03:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264512AbTLLI7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 03:59:33 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:18100 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264511AbTLLI7c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 03:59:32 -0500
Message-ID: <3FD9836F.2050003@cyberone.com.au>
Date: Fri, 12 Dec 2003 19:59:27 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@redhat.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>
Subject: Re: [CFT][RFC] HT scheduler
References: <20031212052812.E016B2C072@lists.samba.org> <3FD9679A.1020404@cyberone.com.au>
In-Reply-To: <3FD9679A.1020404@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

>
> w26 does ALL this, while sched.o is 3K smaller than Ingo's shared 
> runqueue
> patch on NUMA and SMP, and 1K smaller on UP (although sched.c is 90 lines
> longer). kernbench system time is down nearly 10% on the NUMAQ, so it 
> isn't
> hurting performance either.


Hackbench performance on the NUMAQ is improved by nearly 50% at large
numbers of tasks due to a better scaling factor (which I think is slightly
"more" linear too). It is also improved by nearly 25% (4.08 vs 3.15) on
OSDLs 8 ways at small number of tasks, due to a better constant factor.

http://www.kerneltrap.org/~npiggin/w26/hbench.png

And yeah hackbench kills the NUMAQ after about 350 rooms. This is due to
memory shortages. All the processes are getting stuck in shrink_caches,
get_free_pages, etc.


