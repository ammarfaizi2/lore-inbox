Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWIJPIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWIJPIS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 11:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWIJPIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 11:08:18 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:3236 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S932213AbWIJPIR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 11:08:17 -0400
Date: Sun, 10 Sep 2006 19:08:20 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: rcu_do_batch: rcu_data->qlen is not irq safe
Message-ID: <20060910150820.GA7433@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rcu_do_batch() decrements rdp->qlen with irqs enabled.
This is not good, it can also be modified by call_rcu()
from interrupt.

So, is it worth fixing? The problem is mostly theoretical.

If yes, is it ok to use local_t ? Iirc, the were some
problems with local_t on some arches. Sometimes it is
just atomic_t ...

Otherwise, we can update ->qlen after the main loop,

	local_irq_disable();
	rdp->qlen -= count;
	local_irq_enable();

What dou you think?

Oleg.

