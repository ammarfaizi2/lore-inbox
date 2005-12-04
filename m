Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbVLDAjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbVLDAjj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 19:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbVLDAjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 19:39:39 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:59086 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932191AbVLDAji
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 19:39:38 -0500
Date: Sun, 4 Dec 2005 01:43:02 +0100
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Helge Hafting <helge.hafting@aitel.hist.no>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Tejun Heo <htejun@gmail.com>
Subject: Re: Linux 2.6.15-rc3 problem found - scsi order changed
Message-ID: <20051204004302.GA2188@aitel.hist.no>
References: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org> <20051129213656.GA8706@aitel.hist.no> <Pine.LNX.4.64.0511291340340.3029@g5.osdl.org> <438D69FF.2090002@aitel.hist.no> <438EB150.2090502@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438EB150.2090502@pobox.com>
User-Agent: Mutt/1.5.9i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 03:16:16AM -0500, Jeff Garzik wrote:
> Helge Hafting wrote:
> >I tried compiling and booting rc1.  The machine is remote, and did not
> >come up.  So I don't know why it didn't come up, but it is likely
> >that it is the same problem.
> 
> Any chance at all to get netconsole or serial console output, after 
> turning on ATA_DEBUG and ATA_VERBOSE_DEBUG in include/linux/libata.h ?

There is nothing wrong with the SATA driver - I am posting from 
2.6.15-rc1 now.

The problem is that the scsi order changed.  
With 2.6.14 and earlier, I got:
sda, sdb, sdc : harddisks connected to sym2 pci host adapter
sdd, sde      : harddisks connected to mainboard SATA
sdf,sdg,sdh,sdi : the slots in my USB card reader


With 2.6.15-rc1 and later, I get:
sda,sdb,sdc,sdd: the slots in my USB card reader
sde, sdf, sdg: harddisks connected to the sym2 pci host adapter
sdh, sdi     : harddisks connected to mainboard SATA

This kernel have all drivers compiled in - no modules.

So I have to ask - is this change (USB devices before 
any other scsi disks) _intentional_ ?

I can of course change my fstab, but I can imagine this causing all
sorts of trouble for people who plug in the occational USB pendrive.
Now it will shift all other scsi devices.  That didn't happen before.

Therefore, I hope this change of scsi order will be reverted.  USB should
be last, because USB drives are the most likely to be transient.  
While SATA and SCSI host adapters are the ones most likely to contain
root file systems.  I will happily test any patches attempting to restore
the old behaviour.

I guess mounting by UUID is another way of fixing this?  Please tell if
this change is intentional - it will making mounting scsi disks by device sort
of useless for anyone with USB though :-/

Helge Hafting

