Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310303AbSCGMm2>; Thu, 7 Mar 2002 07:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310300AbSCGMmT>; Thu, 7 Mar 2002 07:42:19 -0500
Received: from artemis.rus.uni-stuttgart.de ([129.69.1.28]:20374 "EHLO
	artemis.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S310303AbSCGMmG>; Thu, 7 Mar 2002 07:42:06 -0500
Date: Thu, 7 Mar 2002 13:42:02 +0100 (MET)
From: Erich Focht <focht@ess.nec.de>
To: Anton Blanchard <anton@samba.org>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scheduler: migration tasks startup
In-Reply-To: <20020307092411.GB853@krispykreme>
Message-ID: <Pine.LNX.4.21.0203071332440.12898-100000@sx6.ess.nec.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Mar 2002, Anton Blanchard wrote:

> > we encountered problems with the initial distribution of the
> > migration_tasks across the CPUs. Machines with 16 and more CPUs
> > sometimes won't boot. 
> 
> We found this on a 31 way and have sent a fix to Ingo already, we needed
> to do a set_current_state(TASK_UNINTERRUPTIBLE) before schedule_timeout()
> or we just busy loop.

OK, good to know that it wasn't a tipical IA64 problem.

As far as I understand, your solution still relies on the specific
behavior of the scheduler for distributing the tasks uniformly and on
synchronizing among migration_tasks. I'd really prefer replacing this
shaky method by the usage of migration_task on CPU#0. Thich would always
work, no matter how many tasks are around. This saves some debugging work
to those who play around with the scheduler or want to start some kernel
threads earlier...

Regards,
Erich




