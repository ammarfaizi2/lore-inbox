Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274824AbTGaWoh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 18:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274867AbTGaWoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 18:44:37 -0400
Received: from mailc.telia.com ([194.22.190.4]:31203 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id S274824AbTGaWoe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 18:44:34 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: Christian Vogel <vogel@skunk.physik.uni-erlangen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.0-test2: Never using pm_idle (CPU wasting power)
Date: Fri, 1 Aug 2003 00:45:08 +0200
User-Agent: KMail/1.5.9
References: <20030731150722.A5938@skunk.physik.uni-erlangen.de>
In-Reply-To: <20030731150722.A5938@skunk.physik.uni-erlangen.de>
Cc: Robert Love <rml@tech9.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200308010045.08178.roger.larsson@skelleftea.mail.telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 July 2003 15.07, Christian Vogel wrote:
> Hi,
>
> on a Thinkpad 600X I noticed the CPU getting very hot. It turned
> out that pm_idle was never called (which invokes the ACPI pm_idle
> call in this case) and default_idle was used instead.
>
> 	/* arch/i386/kernel/process.c, line 723 */
> 	void cpu_idle (void)
> 	{
> 		/* endless idle loop with no priority at all */
> 		while (1) {
> 			void (*idle)(void) = pm_idle;
> 			if (!idle)
> 				idle = default_idle; /* once on bootup */
> 			irq_stat[smp_processor_id()].idle_timestamp = jiffies;
> 			while (!need_resched())
> 				idle();
> 			schedule();  /* never reached */
> 		}
> 	}
>
> The schedule() is never reached (need_resched() is never 0) and
> so the idle-variable is not updated. pm_idle is NULL on the
> first call to cpu_idle on this thinkpad, and so I stay idling
> in the default_idle()-function.
>

This smells preemptive kernel, correct?

> By moving the "void *idle = pm_idle; if(!idle)..." in the inner
> while()-loop the notebook calls pm_idle (as it get's updated by ACPI)
> and stays cool.
>

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
