Return-Path: <linux-kernel-owner+w=401wt.eu-S1161107AbXALWH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161107AbXALWH2 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 17:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161117AbXALWH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 17:07:27 -0500
Received: from mail.first.fraunhofer.de ([194.95.169.2]:56103 "EHLO
	mail.first.fraunhofer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161107AbXALWH0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 17:07:26 -0500
Subject: Re: SATA hotplug from the user side ?
From: Soeren Sonnenburg <kernel@nn7.de>
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <45A7BFB0.9090308@garzik.org>
References: <1168588629.5403.7.camel@localhost>
	 <45A7BFB0.9090308@garzik.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 12 Jan 2007 23:07:19 +0100
Message-Id: <1168639639.3707.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2007-01-12 at 12:04 -0500, Jeff Garzik wrote:
> Soeren Sonnenburg wrote:
> > Dear all,
> > 
> > I'd like to try out SATA hotplugging using a SIL3114. Though I was
> > harvesting the web, I could not find any useful information how this is
> > done in practice.
> > 
> > Well I realized that I can still use scsiadd to print and remove
> > devices, e.g.:
> 
> For SIL3114, you shouldn't have to run any commands at all.  It should 
> notice when you yank the cable, or plug in a new device.


It is true it detects a removal and newly plugged devices immediately...
However it still prints warnings and errors that it could not
synchronize SCSI cache for the disks. Then it prints regular 'rejects
I/O to dead device' warning messages and on replugging the disks puts
them to the next free sd device (e.g. sdc -> sdd).

These messages sound eval - so now the question is should I care ?
( On the other hand it did not crash the machine )

What follows is a change between to sata drives attached to port 4/5 of
the sil (ata5/ata6 here):

ata6: exception Emask 0x10 SAct 0x0 SErr 0x10000 action 0x2 frozen
ata6: hard resetting port
ata6: SATA link down (SStatus 0 SControl 310)
ata6: failed to recover some devices, retrying in 5 secs
ata5: exception Emask 0x10 SAct 0x0 SErr 0x10000 action 0x2 frozen
ata5: hard resetting port
ata5: SATA link down (SStatus 0 SControl 310)
ata5: failed to recover some devices, retrying in 5 secs
ata6: hard resetting port
ata6: SATA link down (SStatus 0 SControl 310)
ata6: failed to recover some devices, retrying in 5 secs
ata5: hard resetting port
ata5: SATA link down (SStatus 0 SControl 310)
ata5: failed to recover some devices, retrying in 5 secs
ata6: hard resetting port
ata6: SATA link down (SStatus 0 SControl 310)
ata6.00: disabled
ata6: EH complete
ata6.00: detaching (SCSI 5:0:0:0)
Synchronizing SCSI cache for disk sdd: 
FAILED
  status = 0, message = 00, host = 4, driver = 00
  <6>ata5: hard resetting port
ata5: SATA link down (SStatus 0 SControl 310)
ata5.00: disabled
ata5: EH complete
ata5.00: detaching (SCSI 4:0:0:0)
Synchronizing SCSI cache for disk sdc: 
FAILED
  status = 0, message = 00, host = 4, driver = 00
  <3>ata6: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata6: hard resetting port
ata6: port is slow to respond, please be patient (Status 0xff)
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata6.00: ATA-7, max UDMA/133, 1465149168 sectors: LBA48 NCQ (depth 0/32)
ata6.00: configured for UDMA/100
ata6: EH complete
scsi 5:0:0:0: Direct-Access     ATA      ST3750640AS      3.AA PQ: 0
ANSI: 5
SCSI device sdf: 1465149168 512-byte hdwr sectors (750156 MB)
sdf: Write Protect is off
sdf: Mode Sense: 00 3a 00 00
SCSI device sdf: drive cache: write back
SCSI device sdf: 1465149168 512-byte hdwr sectors (750156 MB)
sdf: Write Protect is off
sdf: Mode Sense: 00 3a 00 00
SCSI device sdf: drive cache: write back
 sdf: unknown partition table
sd 5:0:0:0: Attached scsi disk sdf
sd 5:0:0:0: Attached scsi generic sg2 type 0
scsi 4:0:0:0: rejecting I/O to dead device
scsi 4:0:0:0: rejecting I/O to dead device
scsi 5:0:0:0: rejecting I/O to dead device
scsi 5:0:0:0: rejecting I/O to dead device
ata5: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata5: hard resetting port
ata5: port is slow to respond, please be patient (Status 0xff)
ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata5.00: ATA-7, max UDMA/133, 1465149168 sectors: LBA48 NCQ (depth 0/32)
ata5.00: configured for UDMA/100
ata5: EH complete
scsi 4:0:0:0: Direct-Access     ATA      ST3750640AS      3.AA PQ: 0
ANSI: 5
SCSI device sdg: 1465149168 512-byte hdwr sectors (750156 MB)
sdg: Write Protect is off
sdg: Mode Sense: 00 3a 00 00
SCSI device sdg: drive cache: write back
SCSI device sdg: 1465149168 512-byte hdwr sectors (750156 MB)
sdg: Write Protect is off
sdg: Mode Sense: 00 3a 00 00
SCSI device sdg: drive cache: write back
 sdg: unknown partition table
sd 4:0:0:0: Attached scsi disk sdg
sd 4:0:0:0: Attached scsi generic sg3 type 0

Best,
Soeren
-- 
For the one fact about the future of which we can be certain is that it
will be utterly fantastic. -- Arthur C. Clarke, 1962
