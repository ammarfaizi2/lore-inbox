Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVHAUxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVHAUxr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 16:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbVHAUvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 16:51:33 -0400
Received: from mx1.elte.hu ([157.181.1.137]:10664 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261247AbVHAUth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 16:49:37 -0400
Date: Mon, 1 Aug 2005 22:50:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Luca Falavigna <dktrkranz@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Real-Time Preemption V0.7.52-07: rt_init_MUTEX_LOCKED declaration
Message-ID: <20050801205006.GA20541@elte.hu>
References: <42EE4D27.8060500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EE4D27.8060500@gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Luca Falavigna <dktrkranz@gmail.com> wrote:

> This patch fixes broken rt_init_MUTEX_LOCKED declaration using 
> rt_sema_init() macro. This way we fix a potential compile bug: 
> rt_init_MUTEX_LOCKED calls 
> there_is_no_init_MUTEX_LOCKED_for_RT_semaphores, which is not 
> referenced. (e.g. drivers/char/watchdog/cpu5wdt.c: "cpu5wdt: Unknown 
> symbol there_is_no_init_MUTEX_LOCKED_for_RT_semaphores")

the right solution would be to mark policy->lock as a compat_semaphore.  
That will revert things back to the stock semantics. (at the price of 
not having PI, which isnt a big issue in this case.)

> -+extern void there_is_no_init_MUTEX_LOCKED_for_RT_semaphores(void);

the reason for not allowing init_MUTEX_LOCKED() is that in basically 
every case that does it, the semaphore is not used as a true mutex in 
the strict sense. So the affected semaphore should be changed to 
compat_semaphore, to gain full semantics.

	Ingo
