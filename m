Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262428AbVGLVFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262428AbVGLVFZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 17:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbVGLVDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 17:03:17 -0400
Received: from usbb-lacimss2.unisys.com ([192.63.108.52]:6410 "EHLO
	usbb-lacimss2.unisys.com") by vger.kernel.org with ESMTP
	id S262428AbVGLVCq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 17:02:46 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
Date: Tue, 12 Jul 2005 16:02:43 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04C53@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
Thread-Index: AcWHIgHKSY4yS0loS72PGbdNfqOxYwAABkcQ
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Michel Bouissou" <michel@bouissou.net>,
       "Alan Stern" <stern@rowland.harvard.edu>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 Jul 2005 21:02:45.0162 (UTC) FILETIME=[0D00C0A0:01C58725]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > On the other hand, _something_ was generating an interrupt request 
> > that got mapped to IRQ 21 by the hardware.  And these 
> requests do seem 
> > to be associated with USB activity.  Maybe the EHCI 
> controller is responsible?
> > One of your postings showed both uhci_hcd:usb2 and ehci_hcd:usb4 
> > mapped to IRQ 11.  That could indicate a shared signal 
> line, which is 
> > currently being mapped incorrectly.

I suspect that some device is actually on the IRQ 21, and that's how its IO-APIC line is set up. Later on, its driver tries to assign different IRQ, due to some discrepancy, and the handler gets registered on say IRQ 11, and to a wrong pin, so the actual interrupts go unattended. If this what's happening, the trace will hopefully tell the story. I suggest to boot with "apic=debug" and also perhaps with "pci=routeirq" and collect the trace. You can attach the part up to the point when it reports usb devices set up. 

--Natalie

 
