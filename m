Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbTLLQr2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 11:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbTLLQr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 11:47:28 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:5552 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261270AbTLLQrZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 11:47:25 -0500
Date: Fri, 12 Dec 2003 17:47:23 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Catching NForce2 lockup with NMI watchdog
In-Reply-To: <brcoob$a02$1@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.55.0312121717510.21008@jurand.ds.pg.gda.pl>
References: <3FD5F9C1.5060704@nishanet.com> <Pine.LNX.4.55.0312101421540.31543@jurand.ds.pg.gda.pl>
 <brcoob$a02$1@gatekeeper.tmr.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Dec 2003, bill davidsen wrote:

> | In practice, assuming the MP IRQ routing information provided the BIOS has
> | been correct (which is not always the case), prerequisites #1 and #2 have
> | been met so far, but #3 has proved to be occasionally problematic.
> 
> In practice many system seem to take a good bit of guessing and testing.
> I have an old P-II which only works with acpi=force and nmi_watchdog=2,
> for instance.

 Well, the NMI watchdog is a side-effect feature that works by chance
rather than by design.  So you can't really complain it doesn't work
somewhere, although I wouldn't mind if new hardware was designed such that
it works.  You shouldn't have to use "acpi=force" for the watchdog to work
though and for a PII system if "nmi_watchdog=1" doesn't work, then I
suspect a BIOS bug (set APIC_DEBUG to 1 in asm-i386/apic.h and send me the
bootstrap log and a dump from `mptable' for a diagnosis, if interested).

> It would be nice if there were a program which could poke at the
> hardware and suggest options which might work, as in eliminating the
> ones which can be determined not to work. Absent that trial and error
> rule, unfortunately.

 Linux has all appropriate bits to set up hardware reasonably as long as
BIOS provides accurate information.  The only case our code fails is when
BIOS tells us lies and the there's little we can do about it.  Actually we
are doing hardware manufacturers a favor we try to handle some cases at
all -- it's the BIOS that should be fixed instead and it is software and
it is stored in Flash memories these days, so there's no excuse.  So if
there's a problem with running Linux because of BIOS bugs, then please
bugger the manufacturer in the first place (and avoid the company in the
future if they don't support Linux).

 Sometimes the NMI watchdog works in principle, but its activation leads
to system instability -- almost always this is a symptom of buggy SMM code
executed by the BIOS behind our back (NMIs are disabled by default in the
SMM, but careless code may enable them by accident).

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
