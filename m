Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313493AbSDJSj3>; Wed, 10 Apr 2002 14:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313500AbSDJSj2>; Wed, 10 Apr 2002 14:39:28 -0400
Received: from out012pub.verizon.net ([206.46.170.137]:52461 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP
	id <S313493AbSDJSj2>; Wed, 10 Apr 2002 14:39:28 -0400
Date: Wed, 10 Apr 2002 14:40:42 -0400
From: Skip Ford <skip.ford@verizon.net>
To: Duncan Sands <duncan.sands@math.u-psud.fr>
Cc: Kernel List <linux-kernel@vger.kernel.org>, rml@tech9.net
Subject: Re: 2.5.8-pre2: preempt: exits with preempt_count 1
Mail-Followup-To: Duncan Sands <duncan.sands@math.u-psud.fr>,
	Kernel List <linux-kernel@vger.kernel.org>, rml@tech9.net
In-Reply-To: <E16vHbV-0000M5-00@baldrick>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Message-Id: <20020410183923.RMC1346.out012.verizon.net@pool-141-150-235-204.delv.east.verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Sands wrote:
> My system (x86 K6 UP running 2.5.8-pre2 with preemption) on powering down
> gave:
> ...
> Power down.
> error: halt[411] exited with preempt_count 1
> 
> This was after about 24 hours of up time.  What can I do to help
> track down this locking problem?

If you fixed the oopsing 2.5.8-pre1 kernel by putting 'lock_kernel()'
in exit.c, then you have to remove that line.

The correct fix was applied later, and if you leave in the call
to 'lock_kernel()' you get the exact message you're reporting.

If line 505 of kernel/exit.c is lock_kernel() in your tree then delete
it, and try again.

-- 
Skip
