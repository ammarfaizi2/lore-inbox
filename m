Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751772AbVJTGic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbVJTGic (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 02:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbVJTGic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 02:38:32 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:7847 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751772AbVJTGib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 02:38:31 -0400
Date: Thu, 20 Oct 2005 02:38:17 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: Ktimer / -rt9 (+custom) monotonic_clock going backwards.
In-Reply-To: <20051019151138.GA7739@elte.hu>
Message-ID: <Pine.LNX.4.58.0510200221200.27683@localhost.localdomain>
References: <Pine.LNX.4.58.0510191047270.24515@localhost.localdomain>
 <20051019151138.GA7739@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Oct 2005, Ingo Molnar wrote:

>
> should be monotone - the latest -rt kernels include a debugging check
> for the monotonicity of do_get_ktime_mono().
>

Hi Ingo,

Hmm, I think this will help in that debugging check :-)

-- Steve

Index: linux-2.6.14-rc4-rt12/kernel/ktimers.c
===================================================================
--- linux-2.6.14-rc4-rt12.orig/kernel/ktimers.c	2005-10-20 02:15:17.000000000 -0400
+++ linux-2.6.14-rc4-rt12/kernel/ktimers.c	2005-10-20 02:33:38.000000000 -0400
@@ -971,7 +971,7 @@
 		}
 		return prev;
 	}
-
+	per_cpu(prev_mono_time, cpu) = now;
 	return now;
 }

