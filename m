Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbTIMTCx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 15:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbTIMTCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 15:02:53 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:52882 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262001AbTIMTCw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 15:02:52 -0400
Date: Sat, 13 Sep 2003 20:02:42 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Felipe W Damasio <felipewd@terra.com.br>
Cc: rusty@rustcorp.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel/futex.c: Uneeded memory barrier
Message-ID: <20030913190242.GC7404@mail.jlokier.co.uk>
References: <3F620E61.4080604@terra.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F620E61.4080604@terra.com.br>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch looks fine to me.

Felipe W Damasio wrote:
> 	Kills an unneeded set_current_state after schedule_timeout, since it 
> already guarantees that the task will be TASK_RUNNING.
> 
> 	Also, when setting the state to TASK_RUNNING, isn't that memory 
> barrier unneeded? Patch removes this memory barrier too.

If _all_ instances in the kernel of

	set_current_state(TASK_RUNNING)

can be validly turned into

	__set_current_state(TASK_RUNNING)

it would be good to make the barrier in set_current_state() itself
conditional on the state being state.

-- Jamie
