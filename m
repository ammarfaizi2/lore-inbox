Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbVFEPCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVFEPCn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 11:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVFEPCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 11:02:43 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:33012 "EHLO
	godzilla.mvista.com") by vger.kernel.org with ESMTP id S261581AbVFEPCd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 11:02:33 -0400
Date: Sun, 5 Jun 2005 08:02:26 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, plist fixes
In-Reply-To: <20050605082616.GA26824@elte.hu>
Message-ID: <Pine.LNX.4.10.10506050752130.10127-100000@godzilla.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 5 Jun 2005, Ingo Molnar wrote:

> but i think the fundamental question remains even on Sunday mornings -
> is the plist overhead worth it? Compared to the simple sorted list we 
> exchange O(nr_RT_tasks_running) for O(nr_RT_levels_used) [which is in 
> the 1-100 range], is that a significant practical improvement? By 
> overhead i dont just mean cycle cost, but also architectural flexibility 
> and maintainability.

We use it for all tasks . So for instance all priority levels get sorted ,
not just RT tasks. Most systems aren't going to have many RT tasks, just
interrupts and they don't share many locks. However, there are tons of
userspace tasks that do get sorted.

I think using plist on the wait_list is worth it. Since there aren't
many RT tasks usually . It may be a waste to use it on the pi_waiters.

Daniel

