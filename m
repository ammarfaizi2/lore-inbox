Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751561AbVHYHkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbVHYHkN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 03:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751563AbVHYHkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 03:40:13 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:51345 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751561AbVHYHkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 03:40:12 -0400
Date: Thu, 25 Aug 2005 09:40:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Jens Axboe <axboe@suse.de>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: CFQ + 2.6.13-rc4-RT-V0.7.52-02 = BUG: scheduling with irqs disabled
Message-ID: <20050825074054.GA30650@elte.hu>
References: <20050824174702.GL28272@suse.de> <Pine.OSF.4.05.10508242321500.13279-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10508242321500.13279-100000@da410.phys.au.dk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Esben Nielsen <simlo@phys.au.dk> wrote:

> Yes, spin_lock(lock) is blocking since lock is mutex, not a spinlock 
> under preempt-rt. But isn't it easy to fix? Replace the two lines by 
> spin_lock_irqsave(flags). That would work for both preempt-rt and 
> !preempt-rt.

at this moment we do not pester upstream developers with PREEMPT_RT 
details. It is not at all clear at this moment whether and if how any 
API changes will look like. So there's nothing "to fix" at all!!

for the cases where there's a clear cleanup potential from merging flags 
and locks management we submit separate patches, which stand on their 
own. It happened already, and it will happen in the future. The rest 
Jens does not need to care about.

_often_, trouble on the PREEMPT_RT side highlights some potential 
trouble on the upstream side. Unclean locking rules, unecessary/unsafe 
disabling of interrupts, etc. But no way is there a 1:1 relationship.  
E.g. in this particular case i already fixed the warning in the current 
-RT tree.

	Ingo
