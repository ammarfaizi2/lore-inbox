Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267338AbUJRSmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267338AbUJRSmw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 14:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267304AbUJRSk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 14:40:58 -0400
Received: from mx2.elte.hu ([157.181.151.9]:60141 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267341AbUJRShk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 14:37:40 -0400
Date: Mon, 18 Oct 2004 20:38:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Robert Love <rml@novell.com>
Cc: dwalker@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] Voluntary Preempt additions
Message-ID: <20041018183825.GA4142@elte.hu>
References: <1098121769.26597.5.camel@dhcp153.mvista.com> <1098124252.1597.8.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098124252.1597.8.camel@betsy.boston.ximian.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Robert Love <rml@novell.com> wrote:

> On Mon, 2004-10-18 at 10:49 -0700, Daniel Walker wrote:
>                                                                                    
> > - Modified latency tracer to trace non-preemptable mutex locking , in
> > /proc/lock_trace
> 
> Why?
> 
> It is a bug to have preemption disabled when entering non-atomic
> (schedulable) code, and a stack trace is dumped if that happens.
> 
> Isn't that sufficient?

also, i improved that stackdump in the U4/U5 patches (PREEMPT_TRACE) to
include a trace of critical sections held at that moment:

  [<c0169dcb>] sys_unlink+0xdc/0x129
  [<c01060b5>] sysenter_past_esp+0x52/0x71
 preempt count: 00000002
 . 2-level deep critical section nesting:
 .. entry 1: free_hot_cold_page+0x82/0x149 / (__pagevec_free+0x1f/0x28)
 .. entry 2: print_traces+0x1b/0x54 / (dump_stack+0x23/0x25)

While the stackdump indeed is supposed to clearly identify the critical
section, they can be quite large and opaque, sometimes they even lose
the information of where the lock was acquired, and in practice it's
much easier to use PREEMPT_TRACE.

	Ingo
