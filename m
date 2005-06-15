Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVFORgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVFORgB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 13:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbVFORgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 13:36:00 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:53416 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261231AbVFORfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 13:35:46 -0400
Subject: Re: [BUG] Race condition with it_real_fn in kernel/itimer.c
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1118852632.4508.48.camel@localhost.localdomain>
References: <1118852632.4508.48.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 15 Jun 2005 13:35:23 -0400
Message-Id: <1118856923.4508.50.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-15 at 12:23 -0400, Steven Rostedt wrote:

> 
> 	for_each_online_cpu(i) {
> 		base = &per_cpu(tvec_bases, i);
> 		if (base->running_timer == timer) {
> 			while (base->running_timer == timer) {
> 				cpu_relax();
> 				preempt_check_resched();
> 			}
> 			break;
> 		}
> 	}
> 
> If the timer hasn't gone off yet on another cpu, it will spin until it
> is finished. Now here's the problem:

This was suppose to say...

If the timer is currently going off on another cpu.


-- Steve


