Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbVBXAPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbVBXAPy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 19:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbVBXANY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 19:13:24 -0500
Received: from fire.osdl.org ([65.172.181.4]:49387 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261665AbVBXALu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 19:11:50 -0500
Date: Wed, 23 Feb 2005 16:16:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Steven Cole <elenstev@mesatop.com>
Cc: elenstev@mesatop.com, linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: 2.6.11-rc4-mm1 (VFS: Cannot open root device "301")
Message-Id: <20050223161653.7cb966c3.akpm@osdl.org>
In-Reply-To: <421D09AE.4090100@mesatop.com>
References: <20050223014233.6710fd73.akpm@osdl.org>
	<421CB161.7060900@mesatop.com>
	<20050223121759.5cb270ee.akpm@osdl.org>
	<421CFF5E.4030402@mesatop.com>
	<421D09AE.4090100@mesatop.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole <elenstev@mesatop.com> wrote:
>
> > Yes, that worked.  2.6.11-rc4-mm1 now boots OK, but hdb1 seems to be 
> > missing.

Looking at the IDE update in rc4-mm1:

+void ide_init_disk(struct gendisk *disk, ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	unsigned int unit = drive->select.all & (1 << 4);
+
+	disk->major = hwif->major;
+	disk->first_minor = unit << PARTN_BITS;
+	sprintf(disk->disk_name, "hd%c", 'a' + hwif->index * MAX_DRIVES + unit);
+	disk->queue = drive->queue;
+}

Looks funny.

Could someone try this?

-	unsigned int unit = drive->select.all & (1 << 4);
+	unsigned int unit = (drive->select.all >> 4) & 1;


