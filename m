Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262483AbTEILjp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 07:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262485AbTEILjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 07:39:45 -0400
Received: from arava.co.il ([212.179.127.3]:39838 "HELO arava.co.il")
	by vger.kernel.org with SMTP id S262483AbTEILjo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 07:39:44 -0400
Date: Fri, 9 May 2003 14:52:23 +0300 (IDT)
From: Matan Ziv-Av <matan@svgalib.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.21-rc2 modular ide-scsi 
Message-ID: <Pine.LNX.4.21_heb2.09.0305091448120.805-100000@matan2.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



When scsi or ide-scsi are compiled as modules, ide subsystem
does not recognise the hdc=scsi command line.


-- 
Matan Ziv-Av.                         matan@svgalib.org

--- linux-2.4.21-rc2/drivers/ide/ide.c.original	Fri May  9 14:45:19 2003
+++ linux-2.4.21-rc2/drivers/ide/ide.c	Fri May  9 14:46:09 2003
@@ -2013,13 +2013,8 @@
 				drive->remap_0_to_1 = 2;
 				goto done;
 			case -14: /* "scsi" */
-#if defined(CONFIG_BLK_DEV_IDESCSI) && defined(CONFIG_SCSI)
 				drive->scsi = 1;
 				goto done;
-#else
-				drive->scsi = 0;
-				goto bad_option;
-#endif /* defined(CONFIG_BLK_DEV_IDESCSI) && defined(CONFIG_SCSI) */
 			case 3: /* cyl,head,sect */
 				drive->media	= ide_disk;
 				drive->cyl	= drive->bios_cyl  = vals[0];

