Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272701AbTG1HeW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 03:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272702AbTG1HeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 03:34:22 -0400
Received: from mx1.elte.hu ([157.181.1.137]:32427 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S272701AbTG1HeV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 03:34:21 -0400
Date: Mon, 28 Jul 2003 09:44:37 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Mike Galbraith <efault@gmx.de>
Cc: Con Kolivas <kernel@kolivas.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched-2.6.0-test1-G6, interactivity changes
In-Reply-To: <5.2.1.1.2.20030728093215.01be8f68@pop.gmx.net>
Message-ID: <Pine.LNX.4.44.0307280935300.4596-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 28 Jul 2003, Mike Galbraith wrote:

> >Yes I can reproduce it, but we need the Kirk approach and cheat. Some
> >workaround for tasks that have fallen onto the expired array but shouldn't be
> >there needs to be created. But first we need to think of one before we can
> >create one...
> 
> Oh good, it's not my poor little box.  My experimental tree already has
> a "Kirk" ;-)

could you give -G7 a try:

	redhat.com/~mingo/O(1)-scheduler/sched-2.6.0-test1-G7

Mr. Kirk was busy fixing the IDE code (a subsystem he loves to contribute
to) but i managed to get some code from Mr. Spock: it introduces
ON_RUNQUEUE_WEIGHT, set to 30% currently. Wakeups that come from IRQ
contexts get a 100% sleep average - most hw interrupts are of interactive
nature.

this method should result in process-context wakeups giving a limited but
load-proportional boost - which boost is enough to prevent such tasks from
getting max CPU hogs, but not enough to make them permanently interactive.

	Ingo

