Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263766AbTKFRqT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 12:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263785AbTKFRqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 12:46:16 -0500
Received: from [198.70.193.2] ([198.70.193.2]:2492 "EHLO AVEXCH01.qlogic.org")
	by vger.kernel.org with ESMTP id S263745AbTKFRpq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 12:45:46 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b6).
Date: Thu, 6 Nov 2003 09:45:50 -0800
Message-ID: <B179AE41C1147041AA1121F44614F0B0598CE6@AVEXCH02.qlogic.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b6).
Thread-Index: AcOkU/rBlDsfTazRSqOpx6FDHFZotQANRZFw
From: "Andrew Vasquez" <andrew.vasquez@qlogic.com>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: "Linux-Kernel" <linux-kernel@vger.kernel.org>,
       "Linux-SCSI" <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 06 Nov 2003 17:45:51.0334 (UTC) FILETIME=[D1C72860:01C3A48D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph,

> More comments:
> 
>  - qla_vendor.c is still unused and should be killed
>

Yes, more baggage from old failover code, we should be able to kill it.

>  - your ioctl API gets worse and worse.  You don't expect this huge
>  dungpile of ioctls all marked _BAD to be merged, do you?  
>

No.  We've had this IOWR problem since the inception of 5.x series
driver.  Software (SMS 3.0) has been built on top of the this IOCTL
interface.  We painfully discovered this problem when we began to look
at other non-x86 platforms (ppc64).

>  Also having different ioctl values for different plattforms is not
>  an option for Linux.
> 

The better (right) fix would be to push this interface change onto the
caller of the IOCTLs where they can manage the differences there, and
the driver could once and for all shed itself of this nagging problem.
That is the consensus here.  The _BAD conversion was only done so the
driver would compile.

Regards,
Andrew Vasquez
