Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262152AbVBJP7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbVBJP7u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 10:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbVBJP7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 10:59:50 -0500
Received: from mx1.elte.hu ([157.181.1.137]:36548 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262152AbVBJP7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 10:59:48 -0500
Date: Thu, 10 Feb 2005 16:59:28 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Kevin Hilman <kevin@hilman.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and GFP_ATOMIC
Message-ID: <20050210155928.GA8263@elte.hu>
References: <83r7jyiyqx.fsf@www2.muking.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83r7jyiyqx.fsf@www2.muking.org>
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


* Kevin Hilman <kevin@hilman.org> wrote:

> To produce the following trace, I wrote a simple moudle which just has
> this as its init_module routine:
> 
>         local_irq_disable();
>         p = __get_free_page(GFP_ATOMIC);
>         local_irq_enable();

in the PREEMPT_RT kernel almost everything might sleep, so the general
rule is to not call anything 'complex' from an IRQs-off section. 
Depending on which is easier in your code, if you want to fix it up for
PREEMPT_RT then either move the GFP_ATOMIC allocation from under the
irqs-off section, or introduce a spinlock for the irqs-off section and
use spin_lock_irqsave(). (that is almost always needed anyway if you
really needed the irqs-off section.)

	Ingo
