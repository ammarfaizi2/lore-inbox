Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWIVCOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWIVCOY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 22:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbWIVCOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 22:14:24 -0400
Received: from dpc691978010.direcpc.com ([69.19.78.10]:55469 "EHLO
	third-harmonic.com") by vger.kernel.org with ESMTP id S932206AbWIVCOX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 22:14:23 -0400
Message-ID: <45134829.9040708@third-harmonic.com>
Date: Thu, 21 Sep 2006 22:19:21 -0400
From: john cooper <john.cooper@third-harmonic.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, john cooper <john.cooper@third-harmonic.com>
Subject: Re: 2.6.18-rt1
References: <20060920141907.GA30765@elte.hu> <1158774118.29177.13.camel@c-67-180-230-165.hsd1.ca.comcast.net> <20060920182553.GC1292@us.ibm.com> <200609201436.47042.gene.heskett@verizon.net> <20060920194650.GA21037@elte.hu>
In-Reply-To: <20060920194650.GA21037@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------000505020107080806050800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000505020107080806050800
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:

> ok, i've uploaded -rt3:

Attached is a patch which fixes a build problem
for ARM pxa270, and general ARM boot issue when
LATENCY_TRACE is configured.

-john

-- 
john.cooper@third-harmonic.com

--------------000505020107080806050800
Content-Type: text/plain;
 name="patch-2.6.18-rt3-pxa270"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-2.6.18-rt3-pxa270"

 include/asm-arm/arch-pxa/timex.h |    2 ++
 kernel/latency_trace.c           |    2 ++
 2 files changed, 4 insertions(+)
=================================================================
--- ./kernel/latency_trace.c.ORG	2006-09-20 21:10:15.000000000 -0400
+++ ./kernel/latency_trace.c	2006-09-21 21:28:49.000000000 -0400
@@ -150,6 +150,8 @@ enum trace_flag_type
  */
 #if !defined(CONFIG_DEBUG_PAGEALLOC) && !defined(CONFIG_SMP) && !defined(CONFIG_ARM)
 # define MAX_TRACE (unsigned long)(8192*16-1)
+#elif defined(CONFIG_ARM)      /* 4MB kernel image size limitation */
+# define MAX_TRACE (unsigned long)(128*2-1)
 #else
 # define MAX_TRACE (unsigned long)(8192*2-1)
 #endif
=================================================================
--- ./include/asm-arm/arch-pxa/timex.h.ORG	2006-09-20 21:10:15.000000000 -0400
+++ ./include/asm-arm/arch-pxa/timex.h	2006-09-21 21:57:43.000000000 -0400
@@ -16,6 +16,8 @@
 #define CLOCK_TICK_RATE 3686400
 #elif defined(CONFIG_PXA27x)
 /* PXA27x timer base */
+#include <asm-arm/arch-pxa/hardware.h>
+#include <asm-arm/arch-pxa/pxa-regs.h>
 #ifdef CONFIG_MACH_MAINSTONE
 #define CLOCK_TICK_RATE 3249600
 #else

--------------000505020107080806050800--
