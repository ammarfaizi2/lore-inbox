Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266684AbUAWWKK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 17:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266697AbUAWWKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 17:10:10 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:59787 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S266684AbUAWWKD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 17:10:03 -0500
Date: Fri, 23 Jan 2004 23:10:01 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Pascal Schmidt <der.eremit@email.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make ide-cd handle non-2kB sector sizes
In-Reply-To: <Pine.LNX.4.44.0401232054060.1178-100000@neptune.local>
Message-ID: <Pine.LNX.4.55.0401232256050.3223@jurand.ds.pg.gda.pl>
References: <Pine.LNX.4.44.0401232054060.1178-100000@neptune.local>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jan 2004, Pascal Schmidt wrote:

> > So that's just opposite to what ide-cd does, but I think ide-cd should be
> > limited to CD-like devices with their all properties (oddities).  
> 
> When I brought up the issue a few months back, the consensus was to
> use ide-cd, not ide-floppy.

 Interesting.  I would consider ide-floppy (despite its somewhat
inadequate name) the driver for all ATAPI disks as opposed to ATA disks
that use ide-disk.  CD-like devices are much different, supporting such
alien to disk devices entities like tracks or audio reading or playing.

 BTW, does ide-cd support partition tables yet?  You typically want them
for MO disks if you want to transport data to/from other OSes or simply
because their space is big enough to create separate filesystems for
certain applications.  Or perhaps swap space even. ;-)

> > Specifically you can do random writes to an MO disk, perhaps even format
> > it, which is usually not the case with CDs.
> 
> ide-cd also handles DVD-RAM, which can also handle random writes.

 Well, an exception rather than a rule. ;-)

> > BTW, what does ide-scsi say of the device type for the MO: is it "CD-ROM"  
> > or "Direct-Access" or anything else?  I used an MO drive (a SCSI one --
> > nobody was crazy enough to think of an ATAPI interface for that kinds of
> > devices at that time) for a short while under Linux once and it used to be
> > the latter, with sd, not sr being the appropriate driver.
> 
> On 2.4:
> 
> scsi0 : SCSI host adapter emulation for IDE ATAPI devices
>   Vendor: FUJITSU   Model: M25-MCC3064AP     Rev: 0051
>   Type:   Optical Device                     ANSI SCSI revision: 02
> 
> And yes, this uses the sd driver.

 I see -- that's reasonable.  And I can't understand the proposed
inconsistency with drivers -- why it should be a CD when being an ATAPI
device and a disk when being a SCSI one?  After all SCSI has a separate
driver for CDs as well...

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
