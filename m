Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280996AbRKLVNB>; Mon, 12 Nov 2001 16:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280995AbRKLVMw>; Mon, 12 Nov 2001 16:12:52 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:51442 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S280992AbRKLVMr>;
	Mon, 12 Nov 2001 16:12:47 -0500
Date: Mon, 12 Nov 2001 13:09:02 -0800
From: Jonathan Lahr <lahr@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: SCSI io_request_lock patch
Message-ID: <20011112130902.B26302@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a request for comments on the patch described below which 
implements a revised approach to reducing io_request_lock contention 
in 2.4.

This new version of the io_request_lock patch (siorl-v0) is available
at http://sourceforge.net/projects/lse/.  It employs the same
concurrent request queueing scheme as the iorlv0 patch but isolates 
code changes to the SCSI subsystem and engages the new locking scheme 
only for SCSI drivers which explicitly request it.  I took this more 
restricted approach after additional development based on comments from 
Jens and others indicated that iorlv0 impacted the IDE subsystem and
was unnecessarily broad in general.

The siorl-v0 patch allows drivers to enable concurrent queueing through 
the concurrent_queue field in the Scsi_Host_Template which is copied to 
the request queue.  It creates SCSI-specific versions of generic block 
i/o functions used by the SCSI subsystem and modifies them to conditionally 
engage the new locking scheme based on this field.  It allows control over 
which drivers use concurrent queueing and preserves original block i/o 
behavior by default.

I tested this patch with aic7xxx and lpfc drivers, and regression tested 
it with IDE disk and CDROM drivers.  Any feedback would be appreciated.

Thanks,
Jonathan

-- 
Jonathan Lahr
IBM Linux Technology Center
Beaverton, Oregon
lahr@us.ibm.com
503-578-3385

