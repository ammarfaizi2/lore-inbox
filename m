Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268362AbTBNLEr>; Fri, 14 Feb 2003 06:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268363AbTBNLEq>; Fri, 14 Feb 2003 06:04:46 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:17494
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S268361AbTBNLEo>; Fri, 14 Feb 2003 06:04:44 -0500
Date: Fri, 14 Feb 2003 06:13:16 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] flush_tlb_all is not preempt safe.
In-Reply-To: <Pine.LNX.4.50.0302140600050.3518-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0302140612320.3518-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0302140600050.3518-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Feb 2003, Zwane Mwaikambo wrote:

> Hi,
> 	Considering that smp_call_function isn't allowed to hold a lock 
> reference and within smp_call_function we lock and unlock call_lock thus 
> triggering a preempt point. Therefore we can't guarantee that we'll be on 
> the same processor when we hit do_flush_tlb_all_local.
> 
> void flush_tlb_all(void)
> {
> 	preempt_disable();
> 	smp_call_function (flush_tlb_all_ipi,0,1,1);
> 
> 	do_flush_tlb_all_local();
> 	preempt_enable();
> }

Of course i had to go and paste the code i was working on. The original 
isn't wrapped in preempt_disable/enable.

	Zwane (who really needs to get to bed now)
-- 
function.linuxpower.ca
