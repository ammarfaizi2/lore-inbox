Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbTLHXhJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 18:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbTLHXhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 18:37:09 -0500
Received: from pix-525-pool.redhat.com ([66.187.233.200]:49553 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262072AbTLHXhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 18:37:07 -0500
Date: Mon, 8 Dec 2003 18:36:28 -0500 (EST)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Nick Piggin <piggin@cyberone.com.au>
cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Anton Blanchard <anton@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] make cpu_sibling_map a cpumask_t
In-Reply-To: <3FD50698.6090108@cyberone.com.au>
Message-ID: <Pine.LNX.4.58.0312081832190.23561@devserv.devel.redhat.com>
References: <3FD3FD52.7020001@cyberone.com.au> <Pine.LNX.4.58.0312080109010.1758@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0312081553340.31173@devserv.devel.redhat.com>
 <3FD50698.6090108@cyberone.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the thing that makes balancing-only driven SMT possible with current 2.6.0
is the overbalancing we do (to have cross-CPU fairness). Previous
iterations of the O(1) scheduler (all the 2.4 backports) didnt do this so
all the add-on SMT schedulers tended to have a problem achieving good SMT
distribution. Now that we more agressively balance, this isnt such a big
issue anymore.

so i tend to lean towards your SMT patch, it's much easier to maintain
than my runqueue-sharing approach. The performance is equivalent as far as
i can see (around 20%, and a stabilization of the distribution of
runtimes) - but please also boot my patch and repeat the exact same
measurements you did.

	Ingo
