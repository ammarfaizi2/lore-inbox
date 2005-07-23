Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbVGWUXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVGWUXK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 16:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVGWUXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 16:23:10 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:37039 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261581AbVGWUXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 16:23:08 -0400
Date: Sat, 23 Jul 2005 22:22:37 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Nishanth Aravamudan <nacc@us.ibm.com>
cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
Subject: Re: [PATCH] Add schedule_timeout_{interruptible,uninterruptible}{,_msecs}()
 interfaces
In-Reply-To: <20050723190626.GA4345@us.ibm.com>
Message-ID: <Pine.LNX.4.61.0507232214580.3743@scrub.home>
References: <20050707213138.184888000@homer> <20050708160824.10d4b606.akpm@osdl.org>
 <20050723002658.GA4183@us.ibm.com> <1122078715.5734.15.camel@localhost.localdomain>
 <Pine.LNX.4.61.0507231247460.3743@scrub.home> <1122116986.3582.7.camel@localhost.localdomain>
 <Pine.LNX.4.61.0507231340070.3743@scrub.home> <20050723163753.GC4951@us.ibm.com>
 <Pine.LNX.4.61.0507231854180.3728@scrub.home> <20050723190626.GA4345@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 23 Jul 2005, Nishanth Aravamudan wrote:

> > What's wrong with just:
> > 
> > 	schedule_timeout_{,un}interruptible(msecs_to_jiffies(some_constant_msecs));
> 
> Nothing, I suppose. I just prefer directly using msecs. I understand
> your point more now, I think. You are worried about those people that
> actually use the return value of schedule_timeout().

It's only half the point:

> > The majority of users use a constant, which can already be converted at 
> > compile tile.

The kernel time unit is and will be jiffies and the kernel time functions 
should be in ticks with some optional wrappers in other time units, not 
the other way around.

> 2) Sleep in a loop, keeping track of remaining timeout each iteration:
> 
> 	while (timeout) {
> 		do_some_stuff();
> 		timeout = schedule_timeout(timeout);
> 		if (some_condition)
> 			break;
> 	}

This actually is a pre-preempt construct and should probably use 
time_before() now.

bye, Roman
