Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314596AbSFJXQj>; Mon, 10 Jun 2002 19:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316512AbSFJXQi>; Mon, 10 Jun 2002 19:16:38 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:58773 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314596AbSFJXQh>;
	Mon, 10 Jun 2002 19:16:37 -0400
Date: Mon, 10 Jun 2002 16:15:59 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: Scheduler Bug (set_cpus_allowed)
Message-ID: <20020610161559.H1565@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <20020610135734.D1565@w-mikek2.des.beaverton.ibm.com> <Pine.LNX.4.44.0206102257100.369-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2002 at 12:35:38AM +0200, Ingo Molnar wrote:
> 
> agreed. I removed the _sync code mainly because there was no
> idle_resched() to migrate a task actively, and the migration bits i tried
> were incomplete. But with your above conditional it should cover all the
> practical cases we care about, in an elegant way.
> 
> i ported your sync wakeup resurrection patch to 2.5.21 (attached). I did
> some modifications:
> 
> - wake_up() needs to check (rq->curr != p) as well, not only !p->array.
> 
> - make __wake_up_sync dependent on CONFIG_SMP
> 
> - export __wake_up_sync().
> 
> (the attached patch includes both the ->frozen change plus the sync wakeup
> resurrection, it's against vanilla 2.5.21.)
> 
> appears to work for me just fine (compiles, boots and works under SMP & UP
> alike), and does the trick for bw_pipe and lat_pipe. Comments?
> 
> 	Ingo

Great!  Thanks!

You might also consider adding the optimization/fast path to
set_cpus_allowed().  Once again, I don't expect this routine
(or this code path) to be used much, but I just hate to see
us scheudle a migration task to set the cpu field when it is
safe to do it within the routine.

-- 
Mike
