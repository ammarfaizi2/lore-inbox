Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266617AbUG0U10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266617AbUG0U10 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 16:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266605AbUG0U1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 16:27:19 -0400
Received: from hqemgate00.nvidia.com ([216.228.112.144]:37905 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S266613AbUG0U07 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 16:26:59 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2.6.8-rc2] sata_nv.c
Date: Tue, 27 Jul 2004 13:26:20 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B03F95F5@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.8-rc2] sata_nv.c
Thread-Index: AcRz/MaxbSqU1JC0Q/q9Hf5cug5RxgAGpAFw
From: "Andrew Chew" <achew@nvidia.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>
X-OriginalArrivalTime: 27 Jul 2004 20:26:57.0268 (UTC) FILETIME=[102DA340:01C47418]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 7) don't use host->scr_addr as a sly way to obtain your base address. 
> Use host_set->mmio_base directly (casting from unsigned long 
> if it's PIO 
> rather than MMIO).

I noticed in libata-core.c's ata_pci_remove_one(), that the
host_set->mmio_base gets unmapped before calling
host_set->ops->host_stop(host_set).  The problem is that I want to
access the registers mapped to host_set->mmio_base in my host_stop
routine (it's in my host_stop routine that I disable hotplug event
interrupts).

It looks safe to just swap the two calls, so we call
host_set->ops->host_stop(host_set) before we iounmap
host_set->mmio_base.  That way, my host_stop routine can still access
host_set->mmio_base.

However, I don't want to break any architectural model you may have in
mind.  Can you advise me on the proper approach I should take with this?
