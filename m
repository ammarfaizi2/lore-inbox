Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264917AbUHJMxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbUHJMxt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 08:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264973AbUHJMvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 08:51:41 -0400
Received: from ppp2-adsl-200.the.forthnet.gr ([193.92.233.200]:34346 "EHLO
	ppp1-100.the.forthnet.gr") by vger.kernel.org with ESMTP
	id S264917AbUHJMu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 08:50:26 -0400
From: V13 <v13@priest.com>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.6.8-rc3-mm2
Date: Tue, 10 Aug 2004 15:52:20 +0300
User-Agent: KMail/1.7
Cc: Ingo Molnar <mingo@elte.hu>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>
References: <200408091217.50786.jbarnes@engr.sgi.com> <20040810100234.GN11200@holomorphy.com> <20040810115307.GR11200@holomorphy.com>
In-Reply-To: <20040810115307.GR11200@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408101552.22501.v13@priest.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 August 2004 14:53, William Lee Irwin III wrote:
> On Tue, Aug 10, 2004 at 02:00:51AM -0700, William Lee Irwin III wrote:
> >>> It deadlocks with or without the fork_idle() call being via keventd;
> >>> the printk change is what makes the difference. =(
>
> On Tue, Aug 10, 2004 at 02:38:31AM -0700, William Lee Irwin III wrote:
> >> Okay, it deadlocks with both mdelay(1000) and yield() in place of the
> >> printk(). Trying manual calls to schedule() and local_irq_enable() next.
>
> On Tue, Aug 10, 2004 at 03:02:34AM -0700, William Lee Irwin III wrote:
> > Replacing the printk() with either of the following two things didn't
> > work: (a) yield();
> > (b) local_irq_enable(); set_current_state(TASK_RUNNING); schedule();
>
> Okay, these also failed as replacements for printk():
> (c) local_irq_enable();
> (d) local_irq_enable(); set_current_state(TASK_RUNNING);
> 	schedule(); mdelay(1000);
> (e) local_irq_enable(); set_current_state(TASK_RUNNING);
> 	for (i = 0; i < 1000; ++i) mdelay(1);
> 	set_current_state(TASK_RUNNING); schedule();

Why don't you create a copy of printk() and start commenting out lines in 
there?

> -- wli
<<V13>>
