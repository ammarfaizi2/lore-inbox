Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbUCIAgx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 19:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbUCIAgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 19:36:51 -0500
Received: from gizmo09ps.bigpond.com ([144.140.71.19]:6820 "HELO
	gizmo09ps.bigpond.com") by vger.kernel.org with SMTP
	id S261322AbUCIAgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 19:36:43 -0500
Date: Tue, 9 Mar 2004 11:36:51 +1100
From: Jonathan Thorpe <jonthorp@bigpond.net.au>
To: linux-kernel@vger.kernel.org
Subject: sd.c - "Spinning up disk..." on usb-storage flash reader
Message-Id: <20040309113651.129e284e.jonthorp@bigpond.net.au>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I recently upgraded to 2.6.3 from 2.4.25 and whilst most things work, there is a problem that I'm having with a Scanlogic/Cypress SL11R-IDE CompactFlash/SmartMedia reader.

When I run the reader with a CompactFlash card, the SCSI disk (sd.c) is attempting to "spin up" the SmartMedia socket, which does not contain media. If I were to insert a SmartMedia card, the problem goes away.

Below are some relevant logs from the kernel:

--
scsi14 : SCSI emulation for USB Mass Storage devices
  Vendor: ScanLogi  Model: SL11R-IDE         Rev: 0074
  Type:   Direct-Access                      ANSI SCSI revision: 02
sdc: Spinning up disk..........................................................................................
.............not responding...
sdc : READ CAPACITY failed.
sdc : status=1, message=00, host=0, driver=08 
Current sd: sense = 70  2
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x00 0x00 0x00 
sdc: assuming Write Enabled
sdc: assuming drive cache: write through
sdc: Spinning up disk..........................................................................................
.............not responding...
sdc : READ CAPACITY failed.
sdc : status=1, message=00, host=0, driver=08 
Current sd: sense = 70  2
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x00 0x00 0x00 
sdc: assuming Write Enabled
sdc: assuming drive cache: write through
sdc: Spinning up disk..........................................................................................
.............not responding...
sdc : READ CAPACITY failed.
sdc : status=1, message=00, host=0, driver=08 
Current sd: sense = 70  2
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x00 0x00 0x00 
sdc: assuming Write Enabled
sdc: assuming drive cache: write through
 sdc:<3>Buffer I/O error on device sdc, logical block 0
Buffer I/O error on device sdc, logical block 0
 unable to read partition table
 sdc:<3>Buffer I/O error on device sdc, logical block 0
 unable to read partition table
Attached scsi removable disk sdc at scsi14, channel 0, id 0, lun 0
  Vendor: ScanLogi  Model: SL11R-IDE         Rev: 0074
  Type:   Direct-Access                      ANSI SCSI revision: 02
sdd: Unit Not Ready, sense:
Current : sense = 70  0
Raw sense data:0x70 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
SCSI device sdd: 500737 512-byte hdwr sectors (256 MB)
sdd: assuming Write Enabled
sdd: assuming drive cache: write through
SCSI error: host 14 id 0 lun 1 return code = 8000002
  Sense class 7, sense error 0, extended sense 0
SCSI device sdd: 500737 512-byte hdwr sectors (256 MB)
sdd: assuming Write Enabled
sdd: assuming drive cache: write through
SCSI device sdd: 500737 512-byte hdwr sectors (256 MB)
sdd: assuming Write Enabled
sdd: assuming drive cache: write through
--

I have two of these readers, one with slightly newer firmware which does not have this problem.

Are there any checks that I can incorporate into sd.c to see if the device is removable? The 2.4.2x kernel seemed a little more robust with checking whether or not the device was removable (i.e. USB flash memory readers), perhaps a little friendlier to firmware bugs.

Any assistance would be appreciated.

Please CC as I am not subscribed to the list: jthorpe at bigpond dot net dot au.

Thanks,
Jonathan
