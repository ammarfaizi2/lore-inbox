Return-Path: <linux-kernel-owner+w=401wt.eu-S1751081AbXADCJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbXADCJF (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 21:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbXADCJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 21:09:05 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:55476 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751052AbXADCJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 21:09:04 -0500
Message-ID: <459C61BB.70205@garzik.org>
Date: Wed, 03 Jan 2007 21:08:59 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Initial Promise SX4 hw docs opened
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The first open hardware docs for the Promise SX4 (sata_sx4) series are 
now available:
http://gkernel.sourceforge.net/specs/promise/pdc20621-pguide-dimm-1.6.pdf.bz2
http://gkernel.sourceforge.net/specs/promise/pdc20621-pguide-pll-ata-timing-1.2.pdf.bz2

These are only small, ancillary guides; the main hardware doc should be 
opened soon.

However, I would like to take this opportunity to point hackers looking 
for a project at this hardware.  The Promise SX4 is pretty neat, and it 
needs more attention than I can give, to reach its full potential.

Here's a braindump:

* It's an older chipset/board, probably not actively sold anymore

* ATA programming interface very close to sata_promise (PDC2037x)

* Contains on-board DIMM, to be used for any purpose the driver desires

* Contains on-board RAID5 XOR, also fully programmable

A key problem is that, under Linux, sata_sx4 cannot fully exploit the 
RAID-centric power of this hardware by driving the hardware in "dumb ATA 
mode" as it does.

A better driver would notice when a RAID1 or RAID5 array contains 
multiple components attached to the SX4, and send only a single copy of 
the data to the card (saving PCI bus bandwidth tremendously). 
Similarly, a better driver would take advantage of the RAID5 XOR offload 
capabilities, to offload the entire RAID5 read or write transaction to 
the card.

All this is difficult within either the MD or DM RAID frameworks, 
because optimizing each RAID transaction requires intimate knowledge of 
the hardware.  We have the knowledge...  but I don't have good ideas -- 
aside from an SX4-specific RAID 0/1/5/6 driver -- on how to exploit this 
knowledge.

Traditionally the vendor has distributed a SCSI driver that implements 
the necessary RAID stack pieces entirely in the hardware driver itself. 
  That sort of approach definitely works, but is traditionally rejected 
by upstream maintainers because it essentially requires a third (if h/w 
specific) RAID stack.

	Jeff


