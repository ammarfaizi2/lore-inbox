Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266354AbSLCWaw>; Tue, 3 Dec 2002 17:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266356AbSLCWav>; Tue, 3 Dec 2002 17:30:51 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:50377 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266354AbSLCWau>; Tue, 3 Dec 2002 17:30:50 -0500
Date: Tue, 3 Dec 2002 14:39:44 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: Rusty Lynch <rusty@linux.co.intel.com>
Cc: trelane@digitasaru.net, linux-kernel@vger.kernel.org
Subject: Re: [ide-scsi] "structure has no member named `tag'"
Message-ID: <20021203223944.GA1350@beaverton.ibm.com>
Mail-Followup-To: Rusty Lynch <rusty@linux.co.intel.com>,
	trelane@digitasaru.net, linux-kernel@vger.kernel.org
References: <20021203220928.GA3024@digitasaru.net> <004a01c29b19$d9800a50$62d40a0a@amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004a01c29b19$d9800a50$62d40a0a@amr.corp.intel.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Lynch [rusty@linux.co.intel.com] wrote:
> There was a discussion on this at
> http://marc.theaimsgroup.com/?t=103861087100001&r=1&w=2
> 
> To get past this you can just change the line to compare ->name instead ->tag until the real fix lands.

You can use this patch until the real one comes out.

-andmike
--
Michael Anderson
andmike@us.ibm.com

--- a/drivers/scsi/ide-scsi.c	2002-11-23 13:01:23.000000000 +1100
+++ b/drivers/scsi/ide-scsi.c	2002-12-01 00:44:26.000000000 +1100
@@ -764,7 +764,7 @@
 
 	if (disk) {
 		struct Scsi_Device_Template **p = disk->private_data;
-		if (strcmp((*p)->tag, "sg") == 0)
+		if (strcmp((*p)->scsi_driverfs_driver.name, "sg") == 0)
 			return test_bit(IDESCSI_SG_TRANSFORM, &scsi->transform);
 	}
 	return test_bit(IDESCSI_TRANSFORM, &scsi->transform);
