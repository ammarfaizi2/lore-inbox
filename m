Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262543AbUJ0Q5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbUJ0Q5z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 12:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbUJ0QzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 12:55:10 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:28532 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S262501AbUJ0QxV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 12:53:21 -0400
X-Ironport-AV: i="3.86,107,1096866000"; 
   d="scan'208"; a="98410367:sNHT4006004936"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6527.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2.6.9-rc3-mm2] EDD: use EXTENDED READ command, add CONFIG_EDD_SKIP_MBR
Date: Wed, 27 Oct 2004 11:53:18 -0500
Message-ID: <A60571FBCFDF524DA9BA2A14E8808BE81202B4@ausx2kmpc108.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.9-rc3-mm2] EDD: use EXTENDED READ command, add CON FIG_EDD_SKIP_MBR
Thread-Index: AcS2yStX1XoqjNPjQNCaauTf5m5aXAFeN4XQ
From: <Matt_Domsch@Dell.com>
To: <david.balazic@hermes.si>
Cc: <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Oct 2004 16:53:18.0289 (UTC) FILETIME=[7579AC10:01C4BC45]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Balazic <david.balazic@hermes.si>
> See my edd report attached. 
> The mainboard is a 
> Gigabyte GA-7VAXP Ultra
<http://www.giga-byte.com/MotherBoard/Products/Products_GA-7VAXP%20Ultra
.htm> 
> ATAPI CD-ROM units on hda,hdc,hdd 
> PATA hard drive on the promise PDC20276 ( one on each channel ) 

Thanks!

This looks sane to me.
BIOS reports two disk devices (int13_dev80,81), corresponding to the two
disks you report having.  The boot disk is a 60GB, the second disk is a
160GB.

In Jeff's case, the BIOS reported having devices which didn't actually
exist.  So this is definitely a different problem that Jeff's.

Your BIOS has some difficulty following the EDD specification (reports
incorrect PCI bus/dev/fn values, uses 0x00 instead of 0x20 (space) bytes
to pad out some text fields), but the rest of the EDD3.0 fields look
correct.
|   |-- hde
|   |   |-- device -> ../../devices/pci0000:00/0000:00:0f.0/ide2/2.0
|   |-- hdg
|   |   |-- device -> ../../devices/pci0000:00/0000:00:0f.0/ide3/3.0

while BIOS reports:
/sys/firmware/edd/int13_dev80/host_bus
PCI 	00:06.0  channel: 0
/sys/firmware/edd/int13_dev81/host_bus
PCI 	00:06.1  channel: 0

I don't have a clue why your BIOS would induce a 30-second delay when
being asked to read the disks for their MBR, either with the newer or
older read commands, unless the second disk isn't really spun up yet
during POST, and it's got to wait for that to happen.  But once the
disks are spinning, rebooting should not show the delay, and I believe
you claim it does still delay.  Once again, I'm at a loss.

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
