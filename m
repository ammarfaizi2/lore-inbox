Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263049AbVCQLtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263049AbVCQLtA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 06:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263078AbVCQLqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 06:46:48 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:52283 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263054AbVCQKqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 05:46:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=BTKnYEkmIYequmTROsCQbnALFX/l4UZLEhnJMPUVjUNIQvfpVuhfDgAvnGEVr2Kf4X5YDi2EkKh4C4U62fbOcoATws1MAfl/s4hZyCQTxGwGFiRDJ2wi6gY+nxJqfRJ8n4Wwx8YI/BWR/oT/FtNNPvsfIIQ/lpmJxuVBwlHjAxY=
Message-ID: <e2cbbd0c050317024642cbcf19@mail.gmail.com>
Date: Thu, 17 Mar 2005 11:46:04 +0100
From: =?ISO-8859-1?Q?St=E9phane_Fillod?= <fillods@gmail.com>
Reply-To: =?ISO-8859-1?Q?St=E9phane_Fillod?= <fillods@gmail.com>
To: trivial@rustcorp.com.au
Subject: [PATCH] compile out scsi_ioctl when no SCSI/IDE/etc.
Cc: linux-kernel@vger.kernel.org, linux-tiny@selenic.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch compiles out scsi_ioctl for embedded system with no
SCSI/IDE/etc, and saves couple KiB.
It was made against linuxppc 2.6.10pre3, but should apply ok against
current version.
Rem: If need be, the Kconfig part can be rewritten with "select".

Signed-off-by: Stephane Fillod <fillods@gmail.com>

--- linux/drivers/block/Kconfig	6 Dec 2004 16:15:14 -0000	1.1.1.1
+++ linux/drivers/block/Kconfig	16 Mar 2005 18:12:05 -0000
@@ -429,4 +429,9 @@
 
 source "drivers/block/Kconfig.iosched"
 
+config CDROM_SCSI_IOCTL
+	bool
+	depends on IDE || PARIDE || SCSI || CD_NO_IDESCSI 
+	default y
+
 endmenu
--- linux/drivers/block/Makefile	6 Dec 2004 16:18:35 -0000	1.1.1.1
+++ linux/drivers/block/Makefile	16 Mar 2005 18:12:05 -0000
@@ -13,8 +13,9 @@
 # kblockd threads
 #
 
-obj-y	:= elevator.o ll_rw_blk.o ioctl.o genhd.o scsi_ioctl.o
+obj-y	:= elevator.o ll_rw_blk.o ioctl.o genhd.o
 
+obj-$(CONFIG_SCSI_IOCTL)	+= scsi_ioctl.o
 obj-$(CONFIG_IOSCHED_NOOP)	+= noop-iosched.o
 obj-$(CONFIG_IOSCHED_AS)	+= as-iosched.o
 obj-$(CONFIG_IOSCHED_DEADLINE)	+= deadline-iosched.o


Best Regards,
-- 
Stephane Fillod
