Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262865AbVEHNdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262865AbVEHNdl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 09:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbVEHNdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 09:33:41 -0400
Received: from one.firstfloor.org ([213.235.205.2]:17129 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262865AbVEHNdj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 09:33:39 -0400
To: Arjan van de Ven <arjan@infradead.org>
Cc: vatsa@in.ibm.com, schwidefsky@de.ibm.com, jdike@addtoit.com,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>, rmk+lkml@arm.linux.org.uk,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [RFC] (How to) Let idle CPUs sleep
References: <20050507182728.GA29592@in.ibm.com>
	<1115524211.17482.23.camel@localhost.localdomain>
	<1115547230.5998.10.camel@laptopd505.fenrus.org>
From: Andi Kleen <ak@muc.de>
Date: Sun, 08 May 2005 15:33:38 +0200
In-Reply-To: <1115547230.5998.10.camel@laptopd505.fenrus.org> (Arjan van de
 Ven's message of "Sun, 08 May 2005 12:13:50 +0200")
Message-ID: <m1oeblvo3x.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:

> On Sun, 2005-05-08 at 13:50 +1000, Rusty Russell wrote:
>> My preference would be the second: fix the scheduler so it doesn't rely
>> on regular polling.  However, as long as the UP case runs with no timer
>> interrupts when idle, many people will be happy (eg. most embedded).
>
> alternatively; if a CPU is idle a long time we could do a software level
> hotunplug on it (after setting it to the lowest possible frequency and
> power state), and have some sort of thing that keeps track of "spare but
> unplugged" cpus that can plug cpus back in on demand.


We need to do this anyways for RCU, because fully idle CPUs don't go
through quiescent states and could stall the whole RCU system.

But it has to be *really* lightweight because these transistion can
happen a lot (consider a CPU that very often goes to sleep for a short time)
>
> That also be nice for all the virtual environments where this could
> interact with the hypervisor etc

I am not sure how useful it is to make this heavy weight by involving
more subsystems. I would try to keep the idle state as lightweight
as possible, to keep the cost of going to sleep/waking up low.

-Andi
