Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267359AbUJVNWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267359AbUJVNWk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 09:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269143AbUJVNWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 09:22:40 -0400
Received: from mx1.elte.hu ([157.181.1.137]:50347 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267359AbUJVNWi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 09:22:38 -0400
Date: Fri, 22 Oct 2004 15:19:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alexander Batyrshin <abatyrshin@ru.mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041022131950.GA6574@elte.hu>
References: <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <4176A50C.9050303@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4176A50C.9050303@ru.mvista.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Alexander Batyrshin <abatyrshin@ru.mvista.com> wrote:

> used i386/defconfig

> BUG: semaphore recursion deadlock detected!
> .. current task khpsbpkt/723 is already holding c04610c0.

ok, this should be fixed in -U9.2.

> 2.
> if execute
> ``for i in `seq 1 9999`; do nohup bash >/dev/null 2>&1 & done'',
> then you'll get something like:
> [...skip...]
> Warning: dev (pts0) tty->count(16) != #fd's(8) in tty_open
> Warning: dev (pts0) tty->count(16) != #fd's(11) in tty_open

> I'v tested it against linux-2.6.9-rc4-mm1 => all was ok

i have trouble reproducing this myself. Can you still trigger it under
-U9.2? If yes then could you check whether this still happens with a the
same .config but with CONFIG_SMP turned off? This smells like a locking
bug/breakage in the tty layer that we dont detect. You have all the
relevant debug options turned on, correct? (DEBUG_PREEMPT and
RWSEM_DEADLOCK_DETECT)

	Ingo
