Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266781AbUHOPLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266781AbUHOPLI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 11:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266778AbUHOPJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 11:09:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42719 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266846AbUHOPGb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 11:06:31 -0400
Date: Sun, 15 Aug 2004 11:05:38 -0400
From: Alan Cox <alan@redhat.com>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: enable the hwif->raw_taskfile hook
Message-ID: <20040815150538.GA13244@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc3/drivers/ide/ide-taskfile.c linux-2.6.8-rc3/drivers/ide/ide-taskfile.c
--- linux.vanilla-2.6.8-rc3/drivers/ide/ide-taskfile.c	2004-08-09 15:51:00.000000000 +0100
+++ linux-2.6.8-rc3/drivers/ide/ide-taskfile.c	2004-08-12 16:43:49.000000000 +0100
@@ -604,7 +604,11 @@
 
 int ide_raw_taskfile (ide_drive_t *drive, ide_task_t *args, u8 *buf)
 {
-	return ide_diag_taskfile(drive, args, 0, buf);
+	ide_hwif_t *hwif = HWIF(drive);
+	if(hwif->raw_taskfile)
+		return hwif->raw_taskfile(drive, args, buf);
+	else
+		return ide_diag_taskfile(drive, args, 0, buf);
 }
 
 EXPORT_SYMBOL(ide_raw_taskfile);

Signed-off-by: Alan Cox <alan@redhat.com>

--
Xenophobia: fear of paravirtualization
