Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264810AbUEYI0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264810AbUEYI0j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 04:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264808AbUEYI0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 04:26:39 -0400
Received: from proxy.ch.cybtec.net ([217.117.162.97]:34321 "EHLO
	proxy.ch.cybtec.net") by vger.kernel.org with ESMTP id S264810AbUEYI0Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 04:26:25 -0400
Subject: [PATCH] Add support for ISD-300 controller
From: =?ISO-8859-1?Q?Jo=EBl?= Bourquard <numlock@freesurf.ch>
Reply-To: numlock@freesurf.ch
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Message-Id: <1085473581.11152.0.camel@lhosts>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 25 May 2004 10:26:21 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support in unusual_devs.h for the ISD-300 USB controller
used in CD-ROM enclosures.

With it, since 2.6.0 it allowed me to move gigabytes of data and worked
without a hitch. Very helpful -- thus please consider applying :-)


*** linux/drivers/usb/storage/unusual_devs.h	2004-05-25
09:44:57.015060816 +0200
--- linux/drivers/usb/storage/unusual_devs.h.new	2004-05-25
09:49:53.589974576 +0200
***************
*** 366,371 ****
--- 366,377 ----
  		"USB Hard Disk",
  		US_SC_RBC, US_PR_CB, NULL, 0 ), 
  
+ /* Submitted by Joël Bourquard <numlock@freesurf.ch> */
+ UNUSUAL_DEV(  0x05ab, 0x0060, 0x1104, 0x1110,
+                 "In-System",
+                 "PyroGate External CD-ROM Enclosure (FCD-523)",
+                 US_SC_SCSI, US_PR_BULK, NULL, 0 ),
+ 
  #ifdef CONFIG_USB_STORAGE_ISD200
  UNUSUAL_DEV(  0x05ab, 0x0031, 0x0100, 0x0110,
  		"In-System",



*** Device insertion, without the patch ***
usb 1-3: new high speed USB device using address 3
usb-storage: probe of 1-3:2.0 failed with error -5

*** Device insertion, with patch applied ***
usb 1-3: new high speed USB device using address 3
scsi1 : SCSI emulation for USB Mass Storage devices
Vendor: MATSHITA  Model: DVD-RAM LF-D521   Rev: A106
Type:   CD-ROM                             ANSI SCSI revision: 02
sr0: scsi3-mmc drive: 32x/32x writer dvd-ram cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 5
USB Mass Storage device found at 3
scsi.agent[9818]: cdrom at
/devices/pci0000:00/0000:00:1d.7/usb1/1-3/1-3:2.0/host1/1:0:0:0


Best Regards,
Joël

