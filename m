Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262307AbTIOFnC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 01:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbTIOFnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 01:43:02 -0400
Received: from dp.samba.org ([66.70.73.150]:41919 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262307AbTIOFnA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 01:43:00 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jamie Lokier <jamie@shareable.org>
Cc: Felipe W Damasio <felipewd@terra.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel/futex.c: Uneeded memory barrier 
In-reply-to: Your message of "Sat, 13 Sep 2003 20:02:42 +0100."
             <20030913190242.GC7404@mail.jlokier.co.uk> 
Date: Mon, 15 Sep 2003 11:36:36 +1000
Message-Id: <20030915054300.74AF72C061@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030913190242.GC7404@mail.jlokier.co.uk> you write:
> If _all_ instances in the kernel of
> 
> 	set_current_state(TASK_RUNNING)
> 
> can be validly turned into
> 
> 	__set_current_state(TASK_RUNNING)
> 
> it would be good to make the barrier in set_current_state() itself
> conditional on the state being state.

Or eliminate the macro altogether, and create set_current_interruptible()
and set_current_uninterruptible() which have the barrier, and let the normal
users do the assignment the way God intended 8)

In practice, those who care are using __, the rest aren't critical.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
