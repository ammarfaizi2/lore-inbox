Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbVBXA0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVBXA0m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 19:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVBXA0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 19:26:35 -0500
Received: from fire.osdl.org ([65.172.181.4]:48257 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261734AbVBXAUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 19:20:34 -0500
Date: Wed, 23 Feb 2005 16:25:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: elenstev@mesatop.com, linux-kernel@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: 2.6.11-rc4-mm1 (VFS: Cannot open root device "301")
Message-Id: <20050223162539.2bd605b4.akpm@osdl.org>
In-Reply-To: <20050223161653.7cb966c3.akpm@osdl.org>
References: <20050223014233.6710fd73.akpm@osdl.org>
	<421CB161.7060900@mesatop.com>
	<20050223121759.5cb270ee.akpm@osdl.org>
	<421CFF5E.4030402@mesatop.com>
	<421D09AE.4090100@mesatop.com>
	<20050223161653.7cb966c3.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Could someone try this?

Let's turn that into a real patch.

--- 25/drivers/ide/ide-probe.c~ide_init_disk-fix	Wed Feb 23 16:24:44 2005
+++ 25-akpm/drivers/ide/ide-probe.c	Wed Feb 23 16:24:55 2005
@@ -1269,7 +1269,7 @@ EXPORT_SYMBOL_GPL(ide_unregister_region)
 void ide_init_disk(struct gendisk *disk, ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
-	unsigned int unit = drive->select.all & (1 << 4);
+	unsigned int unit = (drive->select.all >> 4) & 1;
 
 	disk->major = hwif->major;
 	disk->first_minor = unit << PARTN_BITS;
_

