Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbTLIBDE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 20:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbTLIBDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 20:03:04 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:20368 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262196AbTLIBDA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 20:03:00 -0500
Message-ID: <3FD51015.7060509@cyberone.com.au>
Date: Tue, 09 Dec 2003 10:58:13 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@redhat.com>
CC: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Anton Blanchard <anton@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] make cpu_sibling_map a cpumask_t
References: <3FD3FD52.7020001@cyberone.com.au> <Pine.LNX.4.58.0312080109010.1758@montezuma.fsmlabs.com> <Pine.LNX.4.58.0312081553340.31173@devserv.devel.redhat.com> <3FD50698.6090108@cyberone.com.au> <Pine.LNX.4.58.0312081832190.23561@devserv.devel.redhat.com>
In-Reply-To: <Pine.LNX.4.58.0312081832190.23561@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ingo Molnar wrote:

>the thing that makes balancing-only driven SMT possible with current 2.6.0
>is the overbalancing we do (to have cross-CPU fairness). Previous
>iterations of the O(1) scheduler (all the 2.4 backports) didnt do this so
>all the add-on SMT schedulers tended to have a problem achieving good SMT
>distribution. Now that we more agressively balance, this isnt such a big
>issue anymore.
>

I'm glad you like my idea. I do like your shared runqueue approach,
its conceptually very elegant IMO, but implementation looks difficult.

You'll have to have a look at my patch, it is the "scheduling domains"
thing. Basically there are no ifdefs for NUMA or SMT in the scheduler,
the balancing depends on SMP and behaves according to a structure
describing desired properties.

I have to document it a little more though.

>
>so i tend to lean towards your SMT patch, it's much easier to maintain
>than my runqueue-sharing approach. The performance is equivalent as far as
>i can see (around 20%, and a stabilization of the distribution of
>runtimes) - but please also boot my patch and repeat the exact same
>measurements you did.
>

I will. I might not get time today, but I'll test various old
"favourites" like kernbench, hackbench, [dt]bench with both versions.


