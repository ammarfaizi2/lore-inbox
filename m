Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbVJPIPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbVJPIPU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 04:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbVJPIPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 04:15:19 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:14318 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751300AbVJPIPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 04:15:19 -0400
Date: Sun, 16 Oct 2005 04:14:59 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.14-rc4-rt6, depmod
In-Reply-To: <1129442512.7978.3.camel@cmn3.stanford.edu>
Message-ID: <Pine.LNX.4.58.0510160408540.2328@localhost.localdomain>
References: <1129442512.7978.3.camel@cmn3.stanford.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 15 Oct 2005, Fernando Lopez-Lezcano wrote:

> Hi Ingo, I'm getting this after building 2.6.14-rc4-rt6:
>
> WARNING: /lib/modules/2.6.13-0.13.rrt.rhfc4.ccrmasmp/kernel/drivers/char/hangcheck-timer.ko needs unknown symbol do_monotonic_clock

below is a patch to get this part to compile. (hopefully :-)

-- Steve

Index: linux-2.6.14-rc4-rt6/kernel/time.c
===================================================================
--- linux-2.6.14-rc4-rt6.orig/kernel/time.c	2005-10-15 11:29:19.000000000 -0400
+++ linux-2.6.14-rc4-rt6/kernel/time.c	2005-10-16 04:03:57.000000000 -0400
@@ -631,6 +631,7 @@

 	return ((u64)ts.tv_sec * NSEC_PER_SEC) + ts.tv_nsec;
 }
+EXPORT_SYMBOL_GPL(do_monotonic_clock);

 #endif /* !CONFIG_GENERIC_TIME */

Index: linux-2.6.14-rc4-rt6/kernel/time/timeofday.c
===================================================================
--- linux-2.6.14-rc4-rt6.orig/kernel/time/timeofday.c	2005-10-15 11:29:19.000000000 -0400
+++ linux-2.6.14-rc4-rt6/kernel/time/timeofday.c	2005-10-16 04:04:07.000000000 -0400
@@ -213,6 +213,7 @@

 	return ret;
 }
+EXPORT_SYMBOL_GPL(do_monotonic_clock);

 /**
  * getnsmonotonic - Returns the monotonic time in a timespec
