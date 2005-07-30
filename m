Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263187AbVG3XaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263187AbVG3XaB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 19:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263190AbVG3XaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 19:30:01 -0400
Received: from liaag2ae.mx.compuserve.com ([149.174.40.156]:3819 "EHLO
	liaag2ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S263186AbVG3X37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 19:29:59 -0400
Date: Sat, 30 Jul 2005 19:26:40 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [sched, patch] better wake-balancing, #2
To: Ingo Molnar <mingo@elte.hu>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ia64 <linux-ia64@vger.kernel.org>
Message-ID: <200507301929_MC3-1-A601-D4C2@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jul 2005 at 17:02:07 +0200, Ingo Molnar wrote:

> do wakeup-balancing only if the wakeup-CPU is idle.
>
> this prevents excessive wakeup-balancing while the system is highly
> loaded, but helps spread out the workload on partly idle systems.

I tested this with Volanomark on dual-processor PII Xeon -- the
results were very bad:

Before: 5863 messages per second

124169 schedule                                  64.1369
 64663 _spin_unlock_irqrestore                  4041.4375
  7949 tcp_clean_rtx_queue                        6.5370
  6787 net_rx_action                             24.9522
 
After: 5569 messages per second

139417 schedule                                  72.0129
 82169 _spin_unlock_irqrestore                  5135.5625
  9949 tcp_clean_rtx_queue                        8.1817
  7917 net_rx_action                             29.1066

__
Chuck
