Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263357AbSIPXkk>; Mon, 16 Sep 2002 19:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263359AbSIPXkk>; Mon, 16 Sep 2002 19:40:40 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24335 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263357AbSIPXkj>; Mon, 16 Sep 2002 19:40:39 -0400
Date: Mon, 16 Sep 2002 16:45:58 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Love <rml@tech9.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG(): sched.c: Line 944
In-Reply-To: <1032218110.1203.63.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0209161644210.2029-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 16 Sep 2002, Robert Love wrote:
> 
> Nope.  If PREEMPT_ACTIVE is set, schedule() assumes the task is being
> preempted and skips certain logic e.g. deactivate_task() (this is the
> same code that lets us safely preempt a TASK_ZOMBIE).

Ahhah! I know. You just make lock_depth 0 when you exit, without actually 
taking the kernel lock. Which fools the logic into accepting a 
preempt-disable, since it thinks that the preempt disable is due to 
holding the kernel lock.

Add a big comment and you're all done.

		Linus

