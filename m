Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267248AbUHDCh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267248AbUHDCh6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 22:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267249AbUHDCh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 22:37:58 -0400
Received: from fmr05.intel.com ([134.134.136.6]:39563 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S267248AbUHDChz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 22:37:55 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
Date: Wed, 4 Aug 2004 10:36:23 +0800
Message-ID: <B44D37711ED29844BEA67908EAF36F037BB9C6@pdsmsx401.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
Thread-Index: AcR5xKwdebSw3tKWSTqJu24EITV+iAABW7Bw
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Nathan Bryant" <nbryant@optonline.net>,
       "Brown, Len" <len.brown@intel.com>
Cc: <acpi-devel@lists.sourceforge.net>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Stefan D?singer" <stefandoesinger@gmx.at>
X-OriginalArrivalTime: 04 Aug 2004 02:36:59.0450 (UTC) FILETIME=[EA9A01A0:01C479CB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan,
I agree your patch should be ok for the special case, but it's not
sufficient. Please note a Link device is just an abstraction of PCI
router, which possibly is in ICH. If we use pci=noacpi or acpi=noirq, we
don't use link device but still use the router and may also change the
sets of the router (look at i386/pci/irq.c) and so still fail after S3.
Your patch can't handle this situation. This indicates adding
suspend/resume code in pci_link.c is not a good idea. Generic solution
should be to provide LPC driver.

Thanks,
Shaohua

>-----Original Message-----
>From: Nathan Bryant [mailto:nbryant@optonline.net]
>Sent: Wednesday, August 04, 2004 9:43 AM
>To: Brown, Len
>Cc: acpi-devel@lists.sourceforge.net; Linux Kernel list; Li, Shaohua;
>Stefan D?singer
>Subject: [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
>
>
>This patch should fix multiple user-visible problems with the ACPI IRQ
>routing after S3 resume:
>
>"irq x: nobody cared"
>"my interrupts are gone"
>
>It probably applies to multiple bugzilla entries and mailing list
posts.
>
>Tested on my machine, which is experiencing similar problems. Seems to
>work - although I get some non-fatal "nobody cared" messages that might
>be caused by the i8042 driver.
>
>Comments?
>Stefan, can you test this?
