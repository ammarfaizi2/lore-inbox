Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbVH3MAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbVH3MAs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 08:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbVH3MAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 08:00:47 -0400
Received: from spirit.analogic.com ([208.224.221.4]:26887 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751393AbVH3MAr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 08:00:47 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 30 Aug 2005 12:00:46.0100 (UTC) FILETIME=[745F6D40:01C5AD5A]
Content-class: urn:content-classes:message
Subject: Linux-2.6.13 __request_region buggered
Date: Tue, 30 Aug 2005 07:59:49 -0400
Message-ID: <Pine.LNX.4.61.0508300757070.7559@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux-2.6.13 __request_region buggered
Thread-Index: AcWtWnRwOYdOSo6ET2edxVXoOk3UzA==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Changes in "request_mem_region()"  ("__request_region()")
now seem to force PCI/Bus alignment upon the requested region.
It appears as though somebody thought this would only used
to reserve address-space on a PCI/Bus.

Linux-2.6.12.5 and all known previous versions back to
linux-2.4.26 worked fine.

This breaks several high-speed data-acquisition boards and
it isn't easy to fix. Since I allocate 16 megabytes of address-
space, aligned on a PAGE boundary, I would have to allocate
4096 blocks of PAGE_SIZE and keep track of them for module
unload.

This is an egregious mistake. One can't make such arbitrary
rules when interfacing to an operating system. The only reason
for the alignment issues on a PCI/Bus was to save the cost
of decode. Since, at least the ix86, can access a single
bit anywhere in memory, one should not create such constraints
out of thin air.

Maybe this is just a coding error and not a deliberate
constraint? Please fix.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
