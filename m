Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964895AbWGEOnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbWGEOnJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 10:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWGEOnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 10:43:09 -0400
Received: from mail.gmx.de ([213.165.64.21]:36528 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964895AbWGEOnI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 10:43:08 -0400
X-Authenticated: #14349625
Subject: Re: [PATCH] sched: Add SCHED_BGND (background) scheduling policy
From: Mike Galbraith <efault@gmx.de>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <44ABC5B7.2090707@bigpond.net.au>
References: <20060704233521.8744.45368.sendpatchset@heathwren.pw.nest>
	 <1152099752.8684.198.camel@Homer.TheSimpsons.net>
	 <44ABC5B7.2090707@bigpond.net.au>
Content-Type: text/plain
Date: Wed, 05 Jul 2006 16:48:27 +0200
Message-Id: <1152110907.8594.19.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-05 at 23:59 +1000, Peter Williams wrote:
> Mike Galbraith wrote:
> > The task in the expired array could also be a !safe_to_background() task
> > who already had a chance to run, and who's slice expired.
> 
> If it's !safe_to_background() it's in our interest to let it run in 
> order to free up the resource that it's holding.

Only if there are waiters (or you know there will be some before the
holder gets a chance to run again).  Even then, they might be background
tasks, so it could still be ~wrong.

(yeah, comprehensive PI would be mucho tidier than tick time)

	-Mike

