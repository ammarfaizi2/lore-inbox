Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbUK1Obw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbUK1Obw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 09:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbUK1Obw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 09:31:52 -0500
Received: from holomorphy.com ([207.189.100.168]:33925 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261485AbUK1Obk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 09:31:40 -0500
Date: Sun, 28 Nov 2004 06:31:28 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2] rcu: cosmetic, delete wrong comment, use HARDIRQ_OFFSET
Message-ID: <20041128143128.GA2714@holomorphy.com>
References: <41A9E98C.2C1D07EF@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A9E98C.2C1D07EF@tv-sign.ru>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2004 at 06:06:52PM +0300, Oleg Nesterov wrote:
> rcu_check_quiescent_state:
> 	/*
> 	 * Races with local timer interrupt - in the worst case
> 	 * we may miss one quiescent state of that CPU. That is
> 	 * tolerable. So no need to disable interrupts.
> 	 */
> 	if (rdp->qsctr == rdp->last_qsctr)
> 		return;
> Afaics, this comment is misleading. rcu_check_quiescent_state()
> is executed in softirq context, while rcu_check_callbacks() checks
> in_softirq() before ++qsctr.
> Also, replace (1 << HARDIRQ_SHIFT) by HARDIRQ_OFFSET.
> On top of the 'rcu: eliminate rcu_ctrlblk.lock', see
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110156786721526

rcu_qsctr_inc() does *NOT* check in_softirq(), and yes, scheduling
does occur directly off the timer interrupt. For instance, for
userspace tasks whose timeslices have expired.


-- wli
