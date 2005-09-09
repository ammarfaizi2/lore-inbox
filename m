Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030213AbVIIKHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbVIIKHN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 06:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030214AbVIIKHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 06:07:13 -0400
Received: from zorg.st.net.au ([203.16.233.9]:12992 "EHLO borg.st.net.au")
	by vger.kernel.org with ESMTP id S1030213AbVIIKHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 06:07:11 -0400
Message-ID: <43215EE4.6050003@torque.net>
Date: Fri, 09 Sep 2005 20:07:32 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org, axboe@suse.de, ballen@gravity.phys.uwm.edu
Subject: [PATCH] permit READ DEFECT DATA in block/scsi_ioctl
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/mixed;
 boundary="------------070106010203090209060500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070106010203090209060500
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

The soon to be released smartmontools 5.34 uses the
READ DEFECT DATA command on SCSI disks. A disk that
has defect list entries (or worse, an increasing number
of them) is at risk.

Currently the first invocation of smartctl causes this:
   scsi: unknown opcode 0x37
message to appear the console and in the log.

The READ DEFECT DATA SCSI command does not change
the state of a disk. Its opcode (0x37) is valid for
SBC devices (e.g. disks) and SMC-2 devices (media
changers) where it is called INITIALIZE STATUS ELEMENT
WITH RANGE and again doesn't change the external state
of the device.

The patch is against lk 2.6.13 .

Changelog:
  - mark SCSI opcode 0x37 (READ DEFECT DATA) as
    safe_for_read

Signed-off-by: Douglas Gilbert <dougg@torque.net>

Doug Gilbert


--------------070106010203090209060500
Content-Type: text/x-patch;
 name="scsi_ioctl2613rdd.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="scsi_ioctl2613rdd.diff"

--- linux/drivers/block/scsi_ioctl.c	2005-06-19 07:54:59.000000000 +1000
+++ linux/drivers/block/scsi_ioctl.c2613rdd	2005-09-09 17:21:52.000000000 +1000
@@ -123,6 +123,7 @@
 		safe_for_read(READ_12),
 		safe_for_read(READ_16),
 		safe_for_read(READ_BUFFER),
+		safe_for_read(READ_DEFECT_DATA),
 		safe_for_read(READ_LONG),
 		safe_for_read(INQUIRY),
 		safe_for_read(MODE_SENSE),

--------------070106010203090209060500--
