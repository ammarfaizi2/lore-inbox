Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279991AbRKIRGb>; Fri, 9 Nov 2001 12:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279985AbRKIRGV>; Fri, 9 Nov 2001 12:06:21 -0500
Received: from e24.nc.us.ibm.com ([32.97.136.230]:53150 "EHLO
	e24.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S279988AbRKIRGJ>; Fri, 9 Nov 2001 12:06:09 -0500
From: Patrick Mansfield <patmans@us.ibm.com>
Message-Id: <200111091706.fA9H66R17344@eng2.beaverton.ibm.com>
Subject: Re: [PATCH] fix 2.4.14 scanning past LUN 7
To: mbrown@emc.com (Michael F. Brown)
Date: Fri, 9 Nov 2001 09:06:06 -0800 (PST)
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20011109103435.A6848@lapi0061> from "Michael F. Brown" at Nov 09, 2001 09:34:35 AM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > The setting of lun0_sl is broken in the current scsi_scan.c - if
> > we found a LUN 0, the just allocated SDpnt with a SDpnt->scsi_level 
> > of 0 is used to set lun0_sl.
> 
> While I think your change makes this cleaner, I don't see why the
> current code is broken.  What difference does it make if 
> lun0_sl is set after scan_scsis_single() or in scan_scsis_single() 
> if in both cases it is set to SDpnt->scsi_level?
> 

The problem is that if we find a device, a new SDpnt is allocated,
*SDpnt2 (SDpnt in scan_scsis()) is set to the new SDpnt, so
after scan_scsis_single() returns, SDpnt->scsi_level is 0, not
the value of the just found device.

The fix sets lun0_sl to the newly found devices SDpnt->scsi_level,
not to the newly allocated SDpnt->scsi_level.

-- 
Patrick Mansfield
