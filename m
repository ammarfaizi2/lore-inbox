Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263763AbTKFRCf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 12:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbTKFRCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 12:02:34 -0500
Received: from [198.70.193.2] ([198.70.193.2]:46917 "EHLO AVEXCH01.qlogic.org")
	by vger.kernel.org with ESMTP id S263740AbTKFRCZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 12:02:25 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b6).
Date: Thu, 6 Nov 2003 09:02:28 -0800
Message-ID: <B179AE41C1147041AA1121F44614F0B060ED69@AVEXCH02.qlogic.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b6).
Thread-Index: AcOkSccpaGyQ32I9QxaadMqrN+o6QAANeVKg
From: "Andrew Vasquez" <andrew.vasquez@qlogic.com>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: "Linux-Kernel" <linux-kernel@vger.kernel.org>,
       "Linux-SCSI" <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 06 Nov 2003 17:02:28.0626 (UTC) FILETIME=[C2716F20:01C3A487]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph,

> > 	o Slab cache allocations for driver SRBs.
> 
> this one is broken.  You kall kmem_cache_alloc and kmem_cache_free
> under a spinlock which is not wrong (at least with GFP_ATOMIC) but
> useless.  You don't have a mempool so you will deadlock under load.
> You have a kmem_cache_t per host which is unessecary, one in the
> driver is enough.
> 

Thanks, I'll take a look at this.

> > the source-type tarball format.  It's not worth the extra effort
> > of building a separate drop-in kernel tarball, given the varying
> > release periods of the driver.  Similar drop-in-kernel-tarball
> > results can be had by:
> 
> Would be nice to unpack into a directory instead of CWD, like almost
> any tarball does..
> 

Ok.

> > Failover functionality is present in this distribution, at this
> > time I do not foresee a policy change regarding its presence in
> > the 8.x series driver.  The next beta release of 8.x will be
> > failover-feature resync'd with our latest 6.x beta (6.07.xx).
> 
> So it won't get merged into 2.6.x.  Not that it would be likely
> given your complete ignorance of the other TODO items.
>

Hmm, looking through your email from July 18th, I note three main
objections that have not been addressed:

	o Build process -- (three module interface for the ISPs), I
	  personally like the idea of a shared library module used
	  between the different ISP drivers.  Many others have voiced
	  their frustrations with the single driver-binary for each
	  ISP type that the directive from management is to have a
	  single binary for all *future* products including the 
	  ISP23xx (ISP2300/ISP2310/ISP2312/ISP2322) chips.

	  That unfortunately leaves ISP2100 and ISP2200 on the
	  periphery of development efforts.

	o Failover -- DM and the fastfail infrastructure appear to be
	  in the early stages of adoption (implementation?).  There's
	  no question that QLogic will support the interfaces once
	  they mature.  Let's just agree to disagree...

	o Structure and Form -- we're slowly chipping away at much of
	  the cruft.

Thank for the feedback.

> Sometimes I really wish to get some funding to work on a mergeable
> qla2xxx driver as it seems impossible to get one from qlogic..
> 

Regards,
Andrew Vasquez
Es wird nichts so heiﬂ gegessen, wie es gekocht wird.
