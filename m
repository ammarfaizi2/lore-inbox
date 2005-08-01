Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVHAV0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVHAV0J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 17:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbVHAVYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 17:24:00 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:4340 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261298AbVHAVVp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 17:21:45 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1122920564.6759.15.camel@localhost.localdomain>
References: <20050730160345.GA3584@elte.hu>
	 <1122920564.6759.15.camel@localhost.localdomain>
Content-Type: text/plain
Organization: MontaVista
Date: Mon, 01 Aug 2005 14:20:38 -0700
Message-Id: <1122931238.4623.17.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-01 at 14:22 -0400, Steven Rostedt wrote:
> Ingo,
> 
> What's with the "BUG: possible soft lockup detected on CPU..."? I'm
> getting a bunch of them from the IDE interrupt.  It's not locking up,
> but it does things that probably do take some time.  Is this really
> necessary? Here's an example dump:
> 
> -- Steve
> 
> Note: I added the curr=%s:%d,current->comm,current->pid just to see who
> was at fault. 

It means that IRQ 14 is running for a long time as an RT task .. btw,
the curr=%s:%d information duplicates some in the "show all held locks"
section .

I could base it off current_sched_time() to only trigger if the task has
actually been running for 10 seconds, instead of just assuming that it
has..

Daniel

