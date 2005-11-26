Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbVKZTlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbVKZTlZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 14:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbVKZTlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 14:41:25 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:36585
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1750720AbVKZTlY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 14:41:24 -0500
Subject: Re: 2.6.14-rt15: cannot build with !PREEMPT_RT
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       david singleton <dsingleton@mvista.com>
In-Reply-To: <1133031912.5904.12.camel@mindpipe>
References: <1132987928.4896.1.camel@mindpipe>
	 <20051126122332.GA3712@elte.hu>  <1133031912.5904.12.camel@mindpipe>
Content-Type: text/plain
Organization: linutronix
Date: Sat, 26 Nov 2005 20:46:46 +0100
Message-Id: <1133034406.32542.308.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-11-26 at 14:05 -0500, Lee Revell wrote:

> -rt19 seems to work except that asm/io_apic.h fails to include 
> asm/apicdef.h so MAX_IO_APICS is undefined.

The patch below fixes the Makefile x86_64 clutter and the io_apic
compile problem

	tglx


Index: linux-2.6.14-rt/Makefile
===================================================================
--- linux-2.6.14-rt.orig/Makefile
+++ linux-2.6.14-rt/Makefile
@@ -189,8 +189,8 @@ SUBARCH := $(shell uname -m | sed -e s/i
 # Default value for CROSS_COMPILE is not to prefix executables
 # Note: Some architectures assign CROSS_COMPILE in their arch/*/Makefile
 
-ARCH = x86_64
-CROSS_COMPILE = x86_64-linux-
+ARCH		?= $(SUBARCH)
+CROSS_COMPILE	?=
 
 # Architecture as present in compile.h
 UTS_MACHINE := $(ARCH)
Index: linux-2.6.14-rt/arch/i386/kernel/i8253.c
===================================================================
--- linux-2.6.14-rt.orig/arch/i386/kernel/i8253.c
+++ linux-2.6.14-rt/arch/i386/kernel/i8253.c
@@ -10,10 +10,10 @@
 #include <linux/init.h>
 #include <linux/mca.h>
 
+#include <asm/smp.h>
 #include <asm/io_apic.h>
 #include <asm/delay.h>
 #include <asm/i8253.h>
-#include <asm/smp.h>
 #include <asm/io.h>
 
 #include "io_ports.h"


