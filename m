Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272365AbTGaFo6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 01:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272368AbTGaFo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 01:44:58 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:10877 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S272365AbTGaFo4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 01:44:56 -0400
Date: Thu, 31 Jul 2003 08:44:48 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI watchdog documentation
Message-ID: <20030731054448.GU83336@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Mikael Pettersson <mikpe@csd.uu.se>, ak@suse.de,
	linux-kernel@vger.kernel.org
References: <200307302253.h6UMr0XW024175@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307302253.h6UMr0XW024175@harpo.it.uu.se>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 12:53:00AM +0200, you [Mikael Pettersson] wrote:
> On Wed, 30 Jul 2003 22:40:52 +0300, Ville Herva wrote:
> >Ok, you got me confused (thankfully I didn't submit anything for inclusion
> >yet. :)
> ...
> >So... Should it be something like:
> >
> >+For x86-64, the needed APIC is always compiled in, and the NMI watchdog is
> >+always enabled with perctr mode. Currently, mode=2 (local APIC) does not
> 
> always enabled with I/O-APIC mode.
> 
> >+work on x86-64. IO APIC mode (mode=1) is the default. Using NMI watchdog
> 
> Using local APIC
> 
> >+(mode=1) needs the first performance register, so you can't use it for
> 
> (mode=2)
> 
> >+other purposes (such as high precision performance profiling.)
> 
> >(Is the last sentence only valid for x86-64?)
> 
> No, it's true for both x86 and x86-64. However, both oprofile
> and the perfctr driver disable the local APIC NMI watchdog, so
> the statement is only true for other drivers that don't do this.

Uuh, sorry. Is the one below ok by you for submission to Linus and Marcelo?


-- v --

v@iki.fi

--- linux/Documentation/nmi_watchdog.txt	Sun Jul 27 19:58:26 2003
+++ linux~/Documentation/nmi_watchdog.txt	Tue Jul 29 21:08:01 2003
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
@@ -20,6 +22,15 @@
 kernel debugging options, such as Kernel Stack Meter or Kernel Tracer,
 may implicitly disable the NMI watchdog.]
 
+For x86-64, the needed APIC is always compiled in, and the NMI watchdog is
+always enabled with I/O-APIC mode (nmi_watchdog=1). Currently, local APIC
+mode (nmi_watchdog=2) does not work on x86-64.
+
+Using local APIC (nmi_watchdog=2) needs the first performance register, so
+you can't use it for other purposes (such as high precision performance
+profiling.) However, at least oprofile and the perfctr driver disable the
+local APIC NMI watchdog automatically.
+
 To actually enable the NMI watchdog, use the 'nmi_watchdog=N' boot
 parameter.  Eg. the relevant lilo.conf entry:
 
