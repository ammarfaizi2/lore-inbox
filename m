Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264571AbUEaH5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbUEaH5M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 03:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264562AbUEaH5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 03:57:12 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:47287 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264571AbUEaH5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 03:57:11 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2 mismatched preempt count in arch/i386/kernel/irq.c 
In-reply-to: Your message of "Mon, 31 May 2004 03:50:19 -0400."
             <Pine.LNX.4.58.0405310347140.1794@montezuma.fsmlabs.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 31 May 2004 17:56:51 +1000
Message-ID: <16253.1085990211@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 May 2004 03:50:19 -0400 (EDT), 
Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
>On Mon, 31 May 2004, Keith Owens wrote:
>
>> 2.6.7-rc2 (and earlier) arch/i386/kernel/irq.c::do_IRQ() calls
>> irq_exit() which expands into preempt_enable_no_resched(), amongst
>> others.  With CONFIG_PREEMPT=y, preempt_enable_no_resched() does
>> dec_preempt_count().  Where is the corresponding inc_preempt_count?
>> AFAICT the use of preempt_enable_no_resched() is unbalanced.
>
>I believe IRQ_EXIT_OFFSET takes care of that;
>
>#define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
>
>#define irq_exit()							\
>do {									\
>		preempt_count() -= IRQ_EXIT_OFFSET;			\
>		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
>			do_softirq();					\
>		preempt_enable_no_resched();				\
>} while (0)

How ugly ....

