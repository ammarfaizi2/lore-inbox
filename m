Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267515AbUJOAmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267515AbUJOAmG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 20:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267522AbUJOAmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 20:42:06 -0400
Received: from brown.brainfood.com ([146.82.138.61]:131 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S267515AbUJOAl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 20:41:57 -0400
Date: Thu, 14 Oct 2004 19:41:52 -0500 (CDT)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Ingo Molnar <mingo@elte.hu>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U2
In-Reply-To: <Pine.LNX.4.58.0410141930440.1221@gradall.private.brainfood.com>
Message-ID: <Pine.LNX.4.58.0410141941320.1221@gradall.private.brainfood.com>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
 <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu>
 <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>
 <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
 <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>
 <Pine.LNX.4.58.0410141930440.1221@gradall.private.brainfood.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2004, Adam Heath wrote:

> On Fri, 15 Oct 2004, Ingo Molnar wrote:
>
> >
> > i have released the -U2 PREEMPT_REALTIME patch:
> >
> >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U2
>
> kernel/latency.c: In function `add_preempt_count':
> kernel/latency.c:390: error: structure has no member named `preempt_trace_eip'
> kernel/latency.c:394: error: structure has no member named `preempt_trace_parent_eip'

Here's a patch:

--- kernel/latency.c.orig	2004-10-14 19:36:26.000000000 -0500
+++ kernel/latency.c	2004-10-14 19:33:30.000000000 -0500
@@ -387,11 +387,9 @@
 	if (val <= 10) {
 		unsigned int idx = preempt_count() & PREEMPT_MASK;
 		if (idx < MAX_PREEMPT_TRACE) {
-			current->preempt_trace_eip[idx] = eip;
 #ifdef CONFIG_LATENCY_TRACE
+			current->preempt_trace_eip[idx] = eip;
 			current->preempt_trace_parent_eip[idx] = parent_eip;
-#else
-			current->preempt_trace_parent_eip[idx] = 0;
 #endif
 		}
 	}
--

