Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161184AbWHJLl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161184AbWHJLl0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 07:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161185AbWHJLl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 07:41:26 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:17302
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161184AbWHJLlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 07:41:25 -0400
Date: Thu, 10 Aug 2006 04:41:33 -0700 (PDT)
Message-Id: <20060810.044133.50597818.davem@davemloft.net>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: softirq considered harmful
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060810110627.GM11829@suse.de>
References: <20060810110627.GM11829@suse.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@suse.de>
Date: Thu, 10 Aug 2006 13:06:27 +0200

> run_timer_softirq+0x0/0x18e: took 3750
> run_timer_softirq+0x0/0x18e: took 2595
> run_timer_softirq+0x0/0x18e: took 6265
> run_timer_softirq+0x0/0x18e: took 2608
> 
> So from 2.6 to 6.2msecs just that handler, auch. During normal running,
> the 2.6 msec variant triggers quite often.

It would be interesting to know what timers ran when
the overhead got this high.

You can probably track this with a per-cpu array
of pointers, have run_timer_softirq record the
t->func pointers into the array as it runs the
current slew of timers, then if the "took" is
very large dump the array.
