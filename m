Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264554AbUEaHu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264554AbUEaHu7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 03:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264562AbUEaHu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 03:50:59 -0400
Received: from smtp102.mail.sc5.yahoo.com ([216.136.174.140]:46195 "HELO
	smtp102.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264554AbUEaHu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 03:50:57 -0400
Message-ID: <40BAE3DA.1010900@yahoo.com.au>
Date: Mon, 31 May 2004 17:50:50 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2 mismatched preempt count in arch/i386/kernel/irq.c
References: <15151.1085988908@kao2.melbourne.sgi.com>
In-Reply-To: <15151.1085988908@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 2.6.7-rc2 (and earlier) arch/i386/kernel/irq.c::do_IRQ() calls
> irq_exit() which expands into preempt_enable_no_resched(), amongst
> others.  With CONFIG_PREEMPT=y, preempt_enable_no_resched() does
> dec_preempt_count().  Where is the corresponding inc_preempt_count?
> AFAICT the use of preempt_enable_no_resched() is unbalanced.
> 

If preempt is enabled, IRQ_EXIT_OFFSET is HARDIRQ_OFFSET-1.

I believe that is where the preempt_enable_no_resched is balanced.
