Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263139AbTDYNg3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 09:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTDYNg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 09:36:29 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:46601 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S263139AbTDYNg2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 09:36:28 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: cciss patches for 2.4.21-rc1, 4 of 4
Date: Fri, 25 Apr 2003 08:48:33 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF1040528C8@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: cciss patches for 2.4.21-rc1, 4 of 4
Thread-Index: AcMKrq/vdIfU+okZS8+vWzl/aVqVbQAfjuFAAAEVzjA=
From: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
To: "Cameron, Steve" <Steve.Cameron@hp.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 Apr 2003 13:48:33.0393 (UTC) FILETIME=[5CC08610:01C30B31]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't seen any issues (yet) on ia64. I'm running with 5GB RAM.

mikem

-----Original Message-----
From: Cameron, Steve 
Sent: Friday, April 25, 2003 8:25 AM
Cc: linux-kernel@vger.kernel.org; Miller, Mike (OS Dev)
Subject: RE: cciss patches for 2.4.21-rc1, 4 of 4



Mike Miller wrote:

> Changes:
>	1. Sets the DMA mask to 64 bits. Removes RH's code for the DMA mask.

In order for this to work, it depends on pci_alloc_consistent always
returning memory with physical addresses that fit in 32 bits, 
regardless of the DMA mask, since the cciss device's command register 
is 32 bits, and the command buffer addresses must fit in there.  If 
that's the case, this is fine.  Otherwise, this may fail if pci_alloc_consistent
returns memory above 4GB.  (on x86, I think this is not a problem, not
sure of other archs, e.g. alpha, ia64)

Note the cciss devices *are* capable of 64 bit addressing for DMA, provided
you can find a way to tell it a 64 bit address.  For data, it's no problem.
Only for command buffers is it a problem.

-- steve
