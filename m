Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265278AbTLLQND (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 11:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265249AbTLLQMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 11:12:41 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:44305 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S265259AbTLLQMj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 11:12:39 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Catching NForce2 lockup with NMI watchdog
Date: 12 Dec 2003 16:01:15 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <brcoob$a02$1@gatekeeper.tmr.com>
References: <3FD5F9C1.5060704@nishanet.com> <Pine.LNX.4.55.0312101421540.31543@jurand.ds.pg.gda.pl>
X-Trace: gatekeeper.tmr.com 1071244875 10242 192.168.12.62 (12 Dec 2003 16:01:15 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.55.0312101421540.31543@jurand.ds.pg.gda.pl>,
Maciej W. Rozycki <macro@ds2.pg.gda.pl> wrote:

|  The I/O APIC NMI watchdog utilizes the property of being transparent to a
| single IRQ source of a specially reconfigured 8259A PIC (the master one in
| the IA32 PC architecture).  There are more prerequisites that have to be
| met and all indeed are for a 100% compatible PC as specified by the
| Intel's Multiprocessor Specification.
| 
| 1. The INT output of the master 8259A PIC has to be connected to the LINT0
| (or LINTIN0; the name varies by implementations) inputs of all local APICs
| in the system.
| 
| 2a. The OUT0 output of the 8254 PIT (IOW the timer source) has to be 
| directly connected to the INTIN2 input of the first I/O APIC.
| 
| 2b. Alternatively the INT output of the master 8259A PIC has to be
| connected to the INTIN0 input of the first I/O APIC.
| 
| 3. There must be no glue logic that would change logical properties of the
| signal between the INT output of the master 8259A PIC and the respective
| APIC interrupt inputs.
| 
| In practice, assuming the MP IRQ routing information provided the BIOS has
| been correct (which is not always the case), prerequisites #1 and #2 have
| been met so far, but #3 has proved to be occasionally problematic.

In practice many system seem to take a good bit of guessing and testing.
I have an old P-II which only works with acpi=force and nmi_watchdog=2,
for instance.

It would be nice if there were a program which could poke at the
hardware and suggest options which might work, as in eliminating the
ones which can be determined not to work. Absent that trial and error
rule, unfortunately.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
