Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964998AbVLaQbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbVLaQbf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 11:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbVLaQbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 11:31:35 -0500
Received: from 213-140-2-68.ip.fastwebnet.it ([213.140.2.68]:20695 "EHLO
	aa001msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S964998AbVLaQbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 11:31:35 -0500
Date: Sat, 31 Dec 2005 17:31:35 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
Message-ID: <20051231173135.67cee547@localhost>
In-Reply-To: <43B68B2A.7080208@bigpond.net.au>
References: <20051227190918.65c2abac@localhost>
	<20051227224846.6edcff88@localhost>
	<200512281027.00252.kernel@kolivas.org>
	<20051230145221.301faa40@localhost>
	<43B5E78C.9000509@bigpond.net.au>
	<20051231113446.3ad19dbc@localhost>
	<20051231115213.4a2e01ba@localhost>
	<43B68B2A.7080208@bigpond.net.au>
X-Mailer: Sylpheed-Claws 2.0.0-rc1 (GTK+ 2.6.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 01 Jan 2006 00:44:10 +1100
Peter Williams <pwil3058@bigpond.net.au> wrote:

> OK.  This probably means that the parameters that control the mechanism 
> need tweaking.
> 
> There should be a file /sys/cpusched/attrs/unacceptable_ia_latency which 
> contains the latency (in nanoseconds) that the scheduler considers 
> unacceptable for interactive programs.  Try changing that value and see 
> if things improve?  Making it smaller should help but if you make it too 
> small all the interactive tasks will end up with the same priority and 
> this could cause them to get in each other's way.

I've tried different values and sometimes I've got a good feeling BUT
the behaviour is too strange to say something.

Sometimes I get what I want (dd priority ~17 and CPU eaters prio
25), sometimes I get a total disaster (dd priority 17 and CPU eaters
prio 15/16) and sometimes I get something like DD prio 22 and CPU
eaters 23/24.

All this is not well related to "unacceptable_ia_latency" values.

What I think is that the priority calculation in ingosched and other
schedulers is in general too weak, while in other schedulers is rock
solid (read: nicksched).

Maybe is just that the smarter a scheduler want to be, the more fragile
it will be.

-- 
	Paolo Ornati
	Linux 2.6.15-rc7-lial on x86_64
