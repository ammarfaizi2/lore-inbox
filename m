Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263918AbTLTKlO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 05:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263922AbTLTKlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 05:41:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:42457 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263918AbTLTKlL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 05:41:11 -0500
Date: Sat, 20 Dec 2003 02:41:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: John Hawkes <hawkes@babylon.engr.sgi.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu,
       johnstul@us.ibm.com
Subject: Re: [RFC][PATCH] 2.6.0-test11 sched_clock() broken for "drifty ITC"
Message-Id: <20031220024159.49145807.akpm@osdl.org>
In-Reply-To: <200312182044.hBIKiCLY5477429@babylon.engr.sgi.com>
References: <200312182044.hBIKiCLY5477429@babylon.engr.sgi.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Hawkes <hawkes@babylon.engr.sgi.com> wrote:
>
> David Mosberger suggests raising this issue on LKML to encourage a search
>  for a more general solution to my ia64 problem.
> 
>  My specific problem is that the generic ia64 sched_clock() is broken for
>  "drifty ITC" (the per-CPU cycle counter clock) platforms, such as the SGI
>  sn.  sched_clock() currently uses its local CPU's ITC and therefore on
>  drifty platforms its values are not synchronized across the CPUs.  This
>  results (in part) in an invalid load_balance() is-the-cache-hot-or-not
>  calculation.

Requiring that sched_clock() be synchronised is difficult for some
platforms.  Clearly, it is better if we can relax that.

> However, David Mosberger rejected this patch, and he seeks instead some
> hypothetical more generic approach to "drifty timebase platforms".  One
> possible generic change would be to relax the semantics of sched_clock() to
> no longer expect that the values be synchronized across all CPUs.

Your patch to kernel/sched.c looks good: low overhead, simple, Ingo likes
it.

Could you please finalise it, cook up the ia64 and numaq implementations
and send it over?


