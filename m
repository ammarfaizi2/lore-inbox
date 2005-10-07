Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030458AbVJGPsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030458AbVJGPsz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 11:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030462AbVJGPsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 11:48:55 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:60606 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030458AbVJGPsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 11:48:54 -0400
Date: Fri, 7 Oct 2005 11:48:42 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: John Rigg <lk@sound-man.co.uk>
cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.14-rc3-rt10 crashes on boot
In-Reply-To: <E1ENtsV-00018l-5z@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0510071146370.7222@localhost.localdomain>
References: <E1ENtsV-00018l-5z@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Oct 2005, John Rigg wrote:

> On Friday 7 October 2005 Ingo Molnar wrote:
> >i got overflows in initramfs's gunzip with certain debug options. I have
> >improved the stack footprint of the worst offenders in -rt11 (see the
> >standalone patch below) - John, does it boot any better?
>
> Ah. I'm using initrd. With CONFIG_LATENCY_TRACE=y my initrd.img is
> large, > 3.6MB. Maybe it's time to try initramfs.
>
> BTW I'm having trouble enabling DEBUG_STACKOVERFLOW. I can see
> it in arch/i386/Kconfig.debug (and not in arch/x86_64/Kconfig.debug),
> but it doesn't appear in menuconfig no matter what other kernel hacking
> options I enable. If I add it manually to .config it just gets removed
> by `make oldconfig'. Is this an x86_64 issue?
>
> For now I'll assume that there is a stack overflow and try initramfs.
>

Here John,

Add this patch and it will add the option for you in x86_64 (I forgot that
you were using that).  I even set it to be default on. I didn't add a test
in do_IRQ, but I believe that the tests in latency.c should be good
enough.

-- Steve

Index: linux-rt-quilt/arch/x86_64/Kconfig.debug
===================================================================
--- linux-rt-quilt.orig/arch/x86_64/Kconfig.debug	2005-08-28 19:41:01.000000000 -0400
+++ linux-rt-quilt/arch/x86_64/Kconfig.debug	2005-10-07 11:43:45.000000000 -0400
@@ -33,6 +33,14 @@
 	 options. See Documentation/x86_64/boot-options.txt for more
 	 details.

+config DEBUG_STACKOVERFLOW
+        bool "Check for stack overflows"
+        depends on DEBUG_KERNEL
+        default y
+        help
+          This option will cause messages to be printed if free stack space
+          drops below a certain limit.
+
 config KPROBES
 	bool "Kprobes"
 	depends on DEBUG_KERNEL
