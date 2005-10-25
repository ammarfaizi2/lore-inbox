Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbVJYWgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbVJYWgg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 18:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbVJYWgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 18:36:36 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:11664 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932448AbVJYWgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 18:36:35 -0400
Subject: Re: ktimers in RT causing bad bogomips and more.
From: Steven Rostedt <rostedt@goodmis.org>
To: tglx@linutronix.de
Cc: john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1130279207.8167.46.camel@tglx.tec.linutronix.de>
References: <1130278541.21118.49.camel@localhost.localdomain>
	 <1130279207.8167.46.camel@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 25 Oct 2005 18:36:22 -0400
Message-Id: <1130279782.21118.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-26 at 00:26 +0200, Thomas Gleixner wrote:
> On Tue, 2005-10-25 at 18:15 -0400, Steven Rostedt wrote:
> > 	if (!hres->active)
> > 		return CLOCK_EVT_RUN_CYCLIC;
> 
> I'm searching for the brown paperbag. 
> 
> Thats the startup code before switching over to high resolution, so it
> should return 1, nothing else.
> 
> CLOCK_EVT_RUN_CYCLIC is a leftover of the initial implementation, which
> did not take tick overruns into account. 

Here, I'll make it easy for you. ;-)

-- Steve

Index: rt_linux_ernie/kernel/ktimers.c
===================================================================
--- rt_linux_ernie.orig/kernel/ktimers.c	2005-10-25 18:31:51.000000000 -0400
+++ rt_linux_ernie/kernel/ktimers.c	2005-10-25 18:32:38.000000000 -0400
@@ -338,10 +338,9 @@
 	 * we expect, that the event source is running in periodic
 	 * mode when it is a source serving other (tick based)
 	 * functionality than next event
-	 *
 	 */
 	if (!hres->active)
-		return CLOCK_EVT_RUN_CYCLIC;
+		return 1;
 
 	now = do_ktime_get();
 


