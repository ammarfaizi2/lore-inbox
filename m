Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270256AbTGWR2h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 13:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270910AbTGWR2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 13:28:37 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:38119 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S270256AbTGWR2g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 13:28:36 -0400
Date: Wed, 23 Jul 2003 20:43:25 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, torvalds@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>, ak@suse.de
Subject: [PATCH] NMI watchdog documentation
Message-ID: <20030723174325.GL150921@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Marcelo Tosatti <marcelo@conectiva.com.br>, torvalds@osdl.org,
	lkml <linux-kernel@vger.kernel.org>, ak@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/nmi-watchdoc.txt doesn't actually tell what options need to be
enabled in kernel config in order to use NMI watchdog. I for one found it
confusing.

I vaguely recall someone posted a similar patch some time ago, but it still
doesn't seem to be present in 2.4 or 2.6-test.

Andi: what about x86-64 - does it have something similar that should be
mentioned?


-- v --

v@iki.fi

--- linux/Documentation/nmi_watchdog.txt	Tue Sep 18 09:03:09 2001
+++ linux~/Documentation/nmi_watchdog.txt	Wed Jul 23 20:25:42 2003
@@ -8,9 +8,20 @@
 which get executed even if the system is otherwise locked up hard).
 This can be used to debug hard kernel lockups.  By executing periodic
 NMI interrupts, the kernel can monitor whether any CPU has locked up,
-and print out debugging messages if so.  You must enable the NMI
-watchdog at boot time with the 'nmi_watchdog=n' boot parameter.  Eg.
-the relevant lilo.conf entry:
+and print out debugging messages if so.  
+
+In order to use the NMI watchdoc, you need to have APIC support in your
+kernel. For SMP kernels, APIC support gets compiled in automatically. For
+UP, enable either CONFIG_X86_UP_APIC (Processor type and features -> Local
+APIC support on uniprocessors) or CONFIG_X86_UP_IOAPIC (Processor type and
+features -> IO-APIC support on uniprocessors) in your kernel config.
+CONFIG_X86_UP_APIC is for uniprocessor machines without an IO-APIC.
+CONFIG_X86_UP_IOAPIC is for uniprocessor with an IO-APIC. [Note: certain
+kernel debugging options, such as Kernel Stack Meter or Kernel Tracer,
+may implicitly disable the NMI watchdog.]
+
+To actually enable the NMI watchdog, use the 'nmi_watchdog=N' boot
+parameter.  Eg. the relevant lilo.conf entry:
 
         append="nmi_watchdog=1"
 
