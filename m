Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270234AbTG3Kd3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 06:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270327AbTG3Kd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 06:33:29 -0400
Received: from mx1.elte.hu ([157.181.1.137]:59873 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S270234AbTG3Kd2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 06:33:28 -0400
Date: Wed, 30 Jul 2003 12:31:23 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, <linas@austin.ibm.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Race in 2.6.0-test2 timer code
In-Reply-To: <20030730082848.GC23835@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0307301223450.13299-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Jul 2003, Andrea Arcangeli wrote:

> 
> 	cpu0			cpu1
> 	------------		--------------------
> 
> 	do_setitimer
> 				it_real_fn
> 	del_timer_sync		add_timer	-> crash

would you mind to elaborate the precise race? I cannot see how the above
sequence could crash on current 2.6:

del_timer_sync() takes the base pointer in timer->base and locks it, then
checks whether the timer has this base or not and repeats the sequence if
not. add_timer() locks the current CPU's base, then installs the timer and
sets timer->base. Where's the race?

	Ingo

