Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbTDLAiq (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 20:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbTDLAiq (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 20:38:46 -0400
Received: from bunyip.cc.uq.edu.au ([130.102.2.1]:45836 "EHLO
	bunyip.cc.uq.edu.au") by vger.kernel.org with ESMTP id S262219AbTDLAin (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 20:38:43 -0400
Message-ID: <3E97632F.1090104@torque.net>
Date: Sat, 12 Apr 2003 10:51:59 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: SATA on SAS [was: ATAPI cdrecord issue 2.5.67]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
 > > Alan Cox writes:
 > > On Thu, 2003-04-10 at 20:53, H. Peter Anvin wrote:
 > > > I think ide-scsi needs to be supported for some time
 > > > going forward.
 > > > After all, cdrecord, cdrdao, dvdrecord aren't going to be
 > > > the only applications.
 > >
 > > And far longer than that. People seem to be testing and demoing
 > > crazy things like SATA attached scanners, printers and
 > > even enclosure services.
 > >
 > > ATAPI tape drives will need ide-scsi too, unless ide-tape
 > > somehow got repaired lately. And some people already use
 > > ide-scsi+st in
 > > 2.4 since ide-tape doesn't always work reliably.
 > >
 > > ide-scsi isn't just for CD/DVD writers.
 >
 > How long will it be before somebody develops an ATAPI, SCSI host
 > adaptor, I.E. a SCSI host adaptor which appears as an ATAPI device?

That is precisely what is planned when a SATA cdwriter is
connected to a SAS host (read below).

 > (I know that ATAPI really is effectively just a SCSI transport, but
 > you can already get SCSI, SCSI host adaptors, I.E. where the devices
 > on the second-level adaptor appear as the logical units of the host
 > adaptor, and there is no reason this couldn't be done using ATAPI).

Spinning this discussion another way, with Serial Attached SCSI
(SAS) real SATA disk drives can be attached to SAS host bus adapters
(HBAs). For that matter cdwriters that use MMC (scsi instruction
set) over ATAPI could be SATA devices connected to a SAS HBA.

SAS HBAs will be compilicated beasts (at least in their plumbing)
because they need to speak 3 protocols:
   - SSP to "real" SAS devices. This carries the SCSI command set
   - STP to SATA devices. This carries the ATA/ATAPI command set
   - SMP, a management protocol, to talk to fanout devices, etc

So how does Linux handle a SATA disk on a SAS HBA?
Possibilities:
   - the scsi subsystem gets a new disk driver (called
     "ad"?? (or perhaps "hd"!)) that speaks ATA
   - the ide susbsystem supports SAS HBAs and can speak
     all three SAS protocols
   - after cleaning up "ide-scsi" we write another driver
     that does the logical inverse ("scsi-ide" ??):
     bridging upper layers of the IDE subsystem down into
     the nether regions of the SCSI subsystem
   - the SCSI subsystem hides SATA devices that speak ATA
     (as opposed to ATAPI) with a SCSI to ATA transformation
     layer.

This problem is a year or less away.

Apologies for all the TLAs (three letter acronyms).
More coffee anybody?

Doug Gilbert

