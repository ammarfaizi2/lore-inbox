Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263771AbTKFRL0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 12:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263774AbTKFRLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 12:11:25 -0500
Received: from [198.70.193.2] ([198.70.193.2]:3166 "EHLO AVEXCH01.qlogic.org")
	by vger.kernel.org with ESMTP id S263771AbTKFRLW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 12:11:22 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b6).
Date: Thu, 6 Nov 2003 09:11:26 -0800
Message-ID: <B179AE41C1147041AA1121F44614F0B0598CE5@AVEXCH02.qlogic.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b6).
Thread-Index: AcOkTMSKR/3vU6OHTJ2y1A8pBdR8gwAOwJBw
From: "Andrew Vasquez" <andrew.vasquez@qlogic.com>
To: "Jens Axboe" <axboe@suse.de>
Cc: "Mike Anderson" <andmike@us.ibm.com>,
       "Linux-Kernel" <linux-kernel@vger.kernel.org>,
       "Linux-SCSI" <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 06 Nov 2003 17:11:27.0268 (UTC) FILETIME=[037FAE40:01C3A489]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens,

> > 	o Given the ISPs inability to handle data segments that cross
> > 	  32-bit page boundaries, and the overhead in defensive logic
> > 	  within the driver to prevent these cases (compare the 6.x
> > 	  code to the 8.x code and you will see what I mean), by
> > 	  disabling clustering we guarantee that a single SG element
> > 	  never crosses a 4GB boundary.
> 
> That is not, however. Linux will never give you a segment crossing a
> 4GB boundary, exactly because most hardware cannot handle this.
> 
> > Now, in 2.6 there are some significant changes.  For one, with the
> > block layer rewrite and the ability to limit segment boundaries of a
> > block queue request with the blk_queue_segment_boundary() call, a LLDD
> > need not concern itself with any defensive fast-path logic to handle
> > the 4GB cross.
> 
> Ditto 2.4. See BH_PHYS_4G().
> 

Yes, but if I recall, these checks did not enter until late in the 2.4
branch.  The original (engineering) intent of the 6.x series branch
was to support all 2.4 kernels, though we are slowly (formally) moving
away from the restrictions.

> > So, we're left with the benefits of the overhead of this merge
> > process done by the block layer.  I'm certainly receptive to the
> > notion of reexamining the use of clustering given some solid data
> > points showing an (significant -- this is subjective) increase in
> > performance and/or a resounding 'yeah, enable it!' from those in
> > the block-layer 'know.'
> 
> In 2.6 clustering comes for free, so it would be silly not to enable
> it.
> 

Thanks for the clarification, I'll add the parameter back into the
template for the 8.x series driver.

Regards,
Andrew Vasquez
