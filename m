Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267520AbSLFDYR>; Thu, 5 Dec 2002 22:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267526AbSLFDYR>; Thu, 5 Dec 2002 22:24:17 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:7120 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267520AbSLFDYQ>;
	Thu, 5 Dec 2002 22:24:16 -0500
Date: Thu, 5 Dec 2002 19:31:56 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: Michael <soppscum@online.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-scsi compile error in 2.5.50-mm1
Message-ID: <20021206033156.GG2321@beaverton.ibm.com>
Mail-Followup-To: Michael <soppscum@online.no>,
	linux-kernel@vger.kernel.org
References: <20021206021613.06a864ab.soppscum@online.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021206021613.06a864ab.soppscum@online.no>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael [soppscum@online.no] wrote:
> make -f scripts/Makefile.build obj=drivers/scsi
>   gcc -Wp,-MD,drivers/scsi/.ide-scsi.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 -Iarch/i386/mach-generic -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=ide_scsi -DKBUILD_MODNAME=ide_scsi   -c -o drivers/scsi/ide-scsi.o drivers/scsi/ide-scsi.c
> drivers/scsi/ide-scsi.c: In function `should_transform':
> drivers/scsi/ide-scsi.c:767: structure has no member named `tag'
> make[2]: *** [drivers/scsi/ide-scsi.o] Error 1
> make[1]: *** [drivers/scsi] Error 2
> make: *** [drivers] Error 2

I do not believe we have come to a final patch for this. It was
previously discussed on this thread

http://marc.theaimsgroup.com/?l=linux-kernel&m=103861077118120&w=2

This short term patch from Douglas Gilbert should fix the compile and
restore previous behavior.

-andmike
--
Michael Anderson
andmike@us.ibm.com

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

