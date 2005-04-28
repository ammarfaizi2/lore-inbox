Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262128AbVD1PGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbVD1PGI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 11:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbVD1PGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 11:06:08 -0400
Received: from ccerelbas04.cce.hp.com ([161.114.21.107]:58093 "EHLO
	ccerelbas04.cce.hp.com") by vger.kernel.org with ESMTP
	id S262113AbVD1PFw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 11:05:52 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Question] Does the kernel ignore errors writng to disk?
Date: Thu, 28 Apr 2005 10:05:15 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF107DC05BC@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Question] Does the kernel ignore errors writng to disk?
Thread-Index: AcVMAvlp8G9xSfBnR1WNKYDOPN8+rQAAJ9uQ
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>, <brace@hp.com>
X-OriginalArrivalTime: 28 Apr 2005 15:05:16.0602 (UTC) FILETIME=[AFAEF9A0:01C54C03]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
> Sent: Thursday, April 28, 2005 9:58 AM
> To: Miller, Mike (OS Dev)
> Cc: Linux Kernel Mailing List; linux-scsi@vger.kernel.org; 
> brace@hp.com
> Subject: Re: [Question] Does the kernel ignore errors writng to disk?
> 
> On Mer, 2005-04-27 at 19:40, mike.miller@hp.com wrote:
> > It looks like the OS/filesystem (ext2/3 and reiserfs) does 
> not wait for for a successful completion. Is this assumption correct?
> 
> Of course it doesn't. At 250 ops/second for a decent disk no 
> OS waits for completions, all batch and asynchronously queue 
> I/O. See man fsync and also O_DIRECT if you need specific "to 
> disk" support. If you do that be aware that you must also 
> turn write caching off on the IDE disk. I've repeatedly asked 
> the "maintainer" of the IDE layer to do this automatically 
> but gave up bothering long ago. Without that setting users 
> are playing with fire quite honestly.
> 
> The alternative with latest 2.6 stuff is to turn on Jens 
> Axboe's barrier work which seems to give better performance 
> on a drive new enough to have cache flush operations.
> 
> Alan
Thanks, Alan. I'll try Jens barrier.

> 
> 
