Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267298AbUJRSVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267298AbUJRSVX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 14:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267164AbUJRSPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 14:15:08 -0400
Received: from mx1.elte.hu ([157.181.1.137]:21399 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267285AbUJRSNt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 14:13:49 -0400
Date: Mon, 18 Oct 2004 20:13:31 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Voluntary Preempt additions
Message-ID: <20041018181331.GB2899@elte.hu>
References: <1098121769.26597.5.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098121769.26597.5.camel@dhcp153.mvista.com>
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


* Daniel Walker <dwalker@mvista.com> wrote:

> This is in addition to voluntary preempt U5 . So, first apply up to
> Voluntary Preempt U4 , then apply this patch. I'll release for U5 as
> soon as it's formally released. 

i've released U5 an hour ago.

> We are releasing the following new features,
>                                                                                       
> - Architecture independent mutex with priority inheritance. Note, we
> have only tested this in x86.

there's new generic mutex code in -U5 which covers all the locking
primitives: semaphores, rw-semaphores, spinlock-mutexes and
rwlock-mutexes. PI should be done by improving the existing
rwsem-generic.c code.

> - Modified latency tracer to trace non-preemptable mutex locking , in
> /proc/lock_trace

hm, what is this good for? It is illegal to enter a schedulable section 
with preemption disabled and there we currently dump a trace of all 
critical sections held - this should be enough to pinpoint the bug.

> - Added two new locking functions _mutex_lock_cpu and
> _mutex_unlock_cpu.

hm, they are unused right now - what will they be used for?

	Ingo
