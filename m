Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbUDGEJI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 00:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264093AbUDGEJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 00:09:08 -0400
Received: from fmr01.intel.com ([192.55.52.18]:55275 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S262361AbUDGEJE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 00:09:04 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: 2.6.2-rc3: irq#19 - nobody cared - with an au88xx
Date: Wed, 7 Apr 2004 00:08:59 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE002F7B775@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.2-rc3: irq#19 - nobody cared - with an au88xx
Thread-Index: AcQcAWQYi50pI7tNScSvlsuDExCEhwAPRnWQ
From: "Brown, Len" <len.brown@intel.com>
To: "Daniel Jacobowitz" <dan@debian.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 07 Apr 2004 04:08:59.0528 (UTC) FILETIME=[0DAAD080:01C41C56]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I'm assuming that it is not the fault of either of these drivers, since
>both of those are quite straightforward; they appear to be actually
>being triggered when nothing is going on.

If IRQ initialization is done incorrectly, it is possible
For a driver to request_irq(X), while the hardware is actually
on IRQ Y.

Then when that device becomes active, it would kill the other
devices on Y because its handler is looking for interrupts on X.

If this happens with acpi enabled, but doesn't happen with acpi=off
or pci=noacpi, then we need to compare the /proc/interrupts between
the working and failintg configs to see if the IRQs have moved around
when perhaps they should not have.  Dmesg from the ACPI case would
also be needed.

>There was a set of APIC errors an hour before, but they're probably
>unrelated:
>Apr  6 11:31:31 nevyn kernel: APIC error on CPU1: 00(08)
>Apr  6 11:31:31 nevyn kernel: APIC error on CPU0: 00(02)

I believe this is due to transient hardware errors on your MB.
Though not fatal, it isn't a good indicator.

-Len
