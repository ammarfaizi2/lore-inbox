Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268142AbUJSLkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268142AbUJSLkl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 07:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268216AbUJSLh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 07:37:58 -0400
Received: from mx2.elte.hu ([157.181.151.9]:61071 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268148AbUJSLGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 07:06:47 -0400
Date: Tue, 19 Oct 2004 13:07:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U5
Message-ID: <20041019110755.GA25246@elte.hu>
References: <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <1098173546.12223.737.camel@thomas> <20041019090428.GA17204@elte.hu> <1098176615.12223.753.camel@thomas> <20041019093414.GA18086@elte.hu> <1098180746.12223.811.camel@thomas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098180746.12223.811.camel@thomas>
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


* Thomas Gleixner <tglx@linutronix.de> wrote:

> +        * Wait for the lockd process to start, but since we're holding
> +        * the lockd semaphore, we can't wait around forever ...
> +        */
> +       if (wait_event_interruptible_timeout(lockd_start,
> +                                            nlmsvc_pid != 0, HZ)) {
> +               printk(KERN_WARNING
> +                       "lockd_down: lockd failed to start\n");

yeah, this is much cleaner. I'd suggest to remove the init_sem() hack
from lib/rwsem-generic.c, it seems it is a nice facility to find
semaphore abuses.

	Ingo
