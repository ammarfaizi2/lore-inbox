Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271371AbRHTQ2n>; Mon, 20 Aug 2001 12:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271356AbRHTQ2d>; Mon, 20 Aug 2001 12:28:33 -0400
Received: from age.cs.columbia.edu ([128.59.22.100]:6667 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S271357AbRHTQ2V>; Mon, 20 Aug 2001 12:28:21 -0400
Date: Mon, 20 Aug 2001 12:28:27 -0400 (EDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] allow hdX=scsi when ide-scsi is a module
Message-ID: <Pine.LNX.4.33.0108201225020.12354-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The current IDE code doesn't allow the user to reserve a drive to be used 
only with ide-scsi emulation, if the ide-scsi layer is compiled as a 
module. The following trivial patch fixes the problem, I've been using it 
for the last 6 months or so.

The patch removes the explicit dependency on CONFIG_SCSI because ide-scsi 
itself requires the SCSI subsystem.

Please apply...

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
-----------------------
diff -urX unpack/diff_kernel_excludes tmp/linux/drivers/ide/ide.c linux-2.4/drivers/ide/ide.c
--- tmp/linux/drivers/ide/ide.c	Mon Sep 11 08:42:57 2000
+++ linux-2.4/drivers/ide/ide.c	Wed Oct 11 14:25:14 2000
@@ -2973,7 +2973,7 @@
 				drive->remap_0_to_1 = 2;
 				goto done;
 			case -14: /* "scsi" */
-#if defined(CONFIG_BLK_DEV_IDESCSI) && defined(CONFIG_SCSI)
+#if defined(CONFIG_BLK_DEV_IDESCSI) || defined(CONFIG_BLK_DEV_IDESCSI_MODULE)
 				drive->scsi = 1;
 				goto done;
 #else

