Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbUK1PE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbUK1PE0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 10:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbUK1PE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 10:04:26 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:38366 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261489AbUK1PEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 10:04:22 -0500
Message-ID: <41A9F76D.55694D6C@tv-sign.ru>
Date: Sun, 28 Nov 2004 19:06:05 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2] rcu: cosmetic, delete wrong comment, use HARDIRQ_OFFSET
References: <41A9E98C.2C1D07EF@tv-sign.ru> <20041128143128.GA2714@holomorphy.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>
> On Sun, Nov 28, 2004 at 06:06:52PM +0300, Oleg Nesterov wrote:
> >
> > Afaics, this comment is misleading. rcu_check_quiescent_state()
> > is executed in softirq context, while rcu_check_callbacks() checks
> > in_softirq() before ++qsctr.
>
> rcu_qsctr_inc() does *NOT* check in_softirq(), and yes, scheduling
> does occur directly off the timer interrupt. For instance, for
> userspace tasks whose timeslices have expired.

But schedule()->rcu_qsctr_inc() can happen only after return from
do_softirq(), so where is the race?

Oleg.
