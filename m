Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266304AbUG1K0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266304AbUG1K0a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 06:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266870AbUG1K03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 06:26:29 -0400
Received: from cantor.suse.de ([195.135.220.2]:55956 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266304AbUG1K02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 06:26:28 -0400
Date: Wed, 28 Jul 2004 12:25:47 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] mark swim3 floppy controller as removable device
Message-ID: <20040728102547.GA21543@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mark the mac floppy controller driver as removable media.
This prevents an entry in /proc/partitions.
Several tools will not try to access the floppy anymore with
this change.

Signed-off-by: Olaf Hering <olh@suse.de>

diff -purN linux-2.6.8-rc2-bk6.orig/drivers/block/swim3.c linux-2.6.8-rc2-bk6/drivers/block/swim3.c
--- linux-2.6.8-rc2-bk6.orig/drivers/block/swim3.c	2004-06-16 05:19:13.000000000 +0000
+++ linux-2.6.8-rc2-bk6/drivers/block/swim3.c	2004-07-28 10:11:37.236364106 +0000
@@ -1058,6 +1058,7 @@ int swim3_init(void)
 		disk->fops = &floppy_fops;
 		disk->private_data = &floppy_states[i];
 		disk->queue = swim3_queue;
+		disk->flags |= GENHD_FL_REMOVABLE;
 		sprintf(disk->disk_name, "fd%d", i);
 		sprintf(disk->devfs_name, "floppy/%d", i);
 		set_capacity(disk, 2880);

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
