Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbTLPUyP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 15:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbTLPUyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 15:54:15 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:34727 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262328AbTLPUyM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 15:54:12 -0500
Date: Tue, 16 Dec 2003 21:54:09 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: George Anzinger <george@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Catching NForce2 lockup with NMI watchdog
In-Reply-To: <3FDF4060.30303@mvista.com>
Message-ID: <Pine.LNX.4.55.0312162141070.8262@jurand.ds.pg.gda.pl>
References: <3FD5F9C1.5060704@nishanet.com> <Pine.LNX.4.55.0312101421540.31543@jurand.ds.pg.gda.pl>
 <brcoob$a02$1@gatekeeper.tmr.com> <3FDA40DA.20409@mvista.com>
 <Pine.LNX.4.55.0312151412270.26565@jurand.ds.pg.gda.pl> <3FDE2AC6.30902@mvista.com>
 <Pine.LNX.4.55.0312161426060.8262@jurand.ds.pg.gda.pl> <3FDF4060.30303@mvista.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Dec 2003, George Anzinger wrote:

> This is for the VST code where we want to stop the timer interrupts for a bit IF 
> and only if we are in the idle task AND there are no timers to service, i.e. the 
> interrupt would be useless.  We don't want to mess with the PIT program as that 
> would mess up the time when we turn it on again.  So we just want to stop a few 
> interrupts from time to time.  We catch up after turning the PIT back on by 
> using the TSC or pm_timer or some other source that keeps something close to 
> reasonable time.

 I see.  Well, then disable_irq(0) may be the easiest way to do that for
the regular timer interrupt.  For the NMI watchdog from the I/O APIC you'd
use disable_8259A_irq(0) and for one from the local APIC -- just mask the
APIC_LVTPC interrupt (there's no wrapper function, but that's easy).

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
