Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263688AbTJCGH6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 02:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263691AbTJCGH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 02:07:58 -0400
Received: from fmr02.intel.com ([192.55.52.25]:5802 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S263688AbTJCGH4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 02:07:56 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [ACPI] p2b-ds blacklisted?
Date: Fri, 3 Oct 2003 02:07:48 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC874E@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] p2b-ds blacklisted?
Thread-Index: AcOIgRRZQIwH4EhYRHi88XKo3bMDVAA76EZA
From: "Brown, Len" <len.brown@intel.com>
To: =?iso-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>,
       <linux-kernel@vger.kernel.org>
Cc: <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 03 Oct 2003 06:07:49.0858 (UTC) FILETIME=[AC6D9420:01C38974]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I would like to try what happens if i remove the board from the 
> > blacklist.
> 
> ... I removed the board from the blacklist, 

> The kernel started and there were some issues with the interrupt 
> routing....

> With "pci=noapci" the computer hang upon loading the kernel 
> module for the SCSI controller.
...
> At first sight ACPI (without pci=noacpi) seemed to work but 
> pressing the 
> power button didn't generate any events although the power button was 
> detected properly during boot.

Nothing registered on the acpi interrupt in /proc/interrupts?

> After all i think i know why P2B-S and -DS are blacklisted. The board 
> with on-board SCSI controller are messed up somehow.
> 
> I haven't tried to install BIOS 1014beta3 yet. BIOS 1014beta2 is 
> currently installed but i guess the update won't solve anything.

Depends on the root cause -- try it.  If it works we can replace the current blacklist entry with one keyed off the BIOS date.

If you want Linux/ACPI to work on this board, or proof that the board can't possibly support it, then then file a bug:

http://bugzilla.kernel.org/
Category: Power Management
Component: ACPI

Attach the console log and /proc/interrupts of the failure, dmidecode output, and acpidmp output.

> With acpi=ht it works for now, but doesn't acpi=ht imply pci=noacpi?

Booting with acpi=force should be the same as removing the P2B-DS from the dmi blacklist.

acpi=ht will use ACPI for enumerating processors, and then ACPI will exit.
ACPI will not be used to configure interrupts and the interpreter will not
run so you'll get no run-time events.  If this system doesn't have HT and has MPS, then ACPI with acpi=ht does nothing for you that you don't have already.

pci=noacpi is the same as above except the interpreter _will_ run in support of run-time events.

Ie. Acpi=ht will give you "ACPI: Interpreter disabled" and pci=noacpi will not.

Cheers,
-Len


