Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266615AbSLCXWO>; Tue, 3 Dec 2002 18:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266623AbSLCXWO>; Tue, 3 Dec 2002 18:22:14 -0500
Received: from ns1.triode.net.au ([202.147.124.1]:56768 "EHLO
	iggy.triode.net.au") by vger.kernel.org with ESMTP
	id <S266615AbSLCXWN>; Tue, 3 Dec 2002 18:22:13 -0500
Message-ID: <3DED3E88.3020609@torque.net>
Date: Wed, 04 Dec 2002 10:30:16 +1100
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [ide-scsi] "structure has no member named `tag'"
Content-Type: multipart/mixed;
 boundary="------------040006010407010800070302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040006010407010800070302
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

"Rusty Lynch" <rusty@linux.co.intel.com> wrote
 >
 > There was a discussion on this at
 > http://marc.theaimsgroup.com/?t=103861087100001&r=1&w=2
 >
 > To get past this you can just change the line to compare
 > ->name instead ->tag until the real fix lands.

For lk 2.5.50-bk3 that attached patch should work.

Doug Gilbert



--------------040006010407010800070302
Content-Type: text/plain;
 name="ide-scsi_2550mike.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-scsi_2550mike.diff"

--- linux/drivers/scsi/ide-scsi.c	2002-11-23 13:01:23.000000000 +1100
+++ linux/drivers/scsi/ide-scsi.c2550mike	2002-12-01 00:44:26.000000000 +1100
@@ -764,7 +764,7 @@
 
 	if (disk) {
 		struct Scsi_Device_Template **p = disk->private_data;
-		if (strcmp((*p)->tag, "sg") == 0)
+		if (strcmp((*p)->scsi_driverfs_driver.name, "sg") == 0)
 			return test_bit(IDESCSI_SG_TRANSFORM, &scsi->transform);
 	}
 	return test_bit(IDESCSI_TRANSFORM, &scsi->transform);

--------------040006010407010800070302--

