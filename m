Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270435AbTG1TVz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 15:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270448AbTG1TVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 15:21:55 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:48942 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S270435AbTG1TVx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 15:21:53 -0400
Date: Mon, 28 Jul 2003 22:21:42 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI watchdog documentation
Message-ID: <20030728192142.GR83336@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <20030723174325.GL150921@niksula.cs.hut.fi> <20030728195342.02913727.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030728195342.02913727.ak@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28, 2003 at 07:53:42PM +0200, you [Andi Kleen] wrote:
> 
> x86-64 is the same, except APIC is always compiled in and the nmi watchdog is
> always enabled with perfctr mode. mode=2 seems to also not work correctly currently.
> 
> However one caveat (even for i386): when you use perfctr mode 1 you lose the first
> performance register which you may need for other things.

Thanks.

So, is something like the following ok by you (patch is relative to -test2
nmi-watchdog.txt)? If it is, I'll send it to Linus and Marcelo.


-- v --

v@iki.fi

--- /usr/src/linux/Documentation/nmi_watchdog.txt	Mon Jul 28 22:10:18 2003
+++ /usr/src/linux~/Documentation/nmi_watchdog.txt	Mon Jul 28 22:18:10 2003
@@ -1,9 +1,11 @@
 
-Is your ix86 system locking up unpredictably? No keyboard activity, just
+[NMI watchdog is available for x86 and x86-64 architectures]
+
+Is your system locking up unpredictably? No keyboard activity, just
 a frustrating complete hard lockup? Do you want to help us debugging
 such lockups? If all yes then this document is definitely for you.
 
-On Intel and similar ix86 type hardware there is a feature that enables
+On many x86/x86-64 type hardware there is a feature that enables
 us to generate 'watchdog NMI interrupts'.  (NMI: Non Maskable Interrupt
 which get executed even if the system is otherwise locked up hard).
 This can be used to debug hard kernel lockups.  By executing periodic
@@ -20,6 +22,13 @@
 kernel debugging options such as Kernel Stack Meter or Kernel Tracer
 may implicitly disable NMI watchdog.]
 
+For x86-64, the needed APIC is always compiled in, and the NMI watchdog is
+always enabled with perfctr mode. Currently, mode=2 does not work on x86-64.
+
+Using NMI watchdog (in mode=1) needs the first performance register, so you
+can't use it for other purposes (such as high precision performance
+profiling.)
+
 To actually enable the NMI watchdog, use the 'nmi_watchdog=N' boot
 parameter.  Eg. the relevant lilo.conf entry:
 
