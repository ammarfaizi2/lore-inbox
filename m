Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271839AbTG2R6g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 13:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271845AbTG2Rzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 13:55:37 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:50863 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S271839AbTG2Rxd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 13:53:33 -0400
Date: Tue, 29 Jul 2003 20:53:19 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Andi Kleen <ak@suse.de>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI watchdog documentation
Message-ID: <20030729175318.GI83336@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Andi Kleen <ak@suse.de>, Mikael Pettersson <mikpe@csd.uu.se>,
	linux-kernel@vger.kernel.org
References: <200307291037.h6TAbX9G026932@harpo.it.uu.se> <20030729160630.GA2133@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030729160630.GA2133@wotan.suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 29, 2003 at 06:06:30PM +0200, you [Andi Kleen] wrote:
> > Andi, you have the numbers mixed up. mode 1 is I/O-APIC, mode 2 is local APIC,
> > and x86-64 defaults nmi_watchdog to I/O-APIC mode.
> > Now, is it the I/O-APIC or local APIC watchdog that doesn't work in x86-64?
> 
> Right, 1 and 2 need to be exchanged. Anyways local apic mode does not seem
> to work, the kernel always reportss "NMI stuck" at bootup.
> IO APIC mode for is default.
> 
> I have not tested if it works with a 32bit kernel on an Opteron box.

Ok, I'll send the following to Linus and Marcelo unless you object.


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
+always enabled with perfctr mode. Currently, mode=1 does not work on x86-64.
+
+Using NMI watchdog (in mode=2) needs the first performance register, so you
+can't use it for other purposes (such as high precision performance
+profiling.)
+
 To actually enable the NMI watchdog, use the 'nmi_watchdog=N' boot
 parameter.  Eg. the relevant lilo.conf entry:
 
