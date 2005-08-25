Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbVHYVfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbVHYVfb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 17:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbVHYVfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 17:35:31 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:56058 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S964790AbVHYVfb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 17:35:31 -0400
Subject: Re: 2.6.13-rc7-rt1
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "K.R. Foley" <kr@cybsft.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20050825174515.GA31215@elte.hu>
References: <20050825062651.GA26781@elte.hu>
	 <1124984208.25139.0.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <20050825174515.GA31215@elte.hu>
Content-Type: text/plain
Organization: MontaVista
Date: Thu, 25 Aug 2005 14:35:24 -0700
Message-Id: <1125005724.10901.5.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-25 at 19:45 +0200, Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > Does anyone have x86_64 working in PREEMPT_RT ?
> 
> builds fine, but doesnt seem to boot at the moment. Havent investigated 
> yet.

I tested an em64t , and it hung during boot .. But this patched fixed
it, does it do anything for you?

Daniel

Index: linux-2.6.12/arch/x86_64/kernel/smpboot.c
===================================================================
--- linux-2.6.12.orig/arch/x86_64/kernel/smpboot.c	2005-08-25 19:39:04.000000000 +0000
+++ linux-2.6.12/arch/x86_64/kernel/smpboot.c	2005-08-25 20:42:38.000000000 +0000
@@ -750,7 +750,6 @@ static int __cpuinit do_boot_cpu(int cpu
 
 do_rest:
 
-	cpu_pda[cpu].pcurrent = c_idle.idle;
 
 	start_rip = setup_trampoline();
 
@@ -789,6 +788,8 @@ do_rest:
 		apic_read(APIC_ESR);
 	}
 
+	cpu_pda[cpu].pcurrent = c_idle.idle;
+
 	/*
 	 * Status is now clean
 	 */


