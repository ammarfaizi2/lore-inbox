Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbVBXAxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbVBXAxf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 19:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbVBXAtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 19:49:47 -0500
Received: from waste.org ([216.27.176.166]:50315 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261796AbVBXAos (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 19:44:48 -0500
Date: Wed, 23 Feb 2005 16:44:44 -0800
From: Matt Mackall <mpm@selenic.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc4-mm1 (VFS: Cannot open root device "301")
Message-ID: <20050224004444.GI3163@waste.org>
References: <20050223014233.6710fd73.akpm@osdl.org> <421CB161.7060900@mesatop.com> <20050223121759.5cb270ee.akpm@osdl.org> <421CFF5E.4030402@mesatop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421CFF5E.4030402@mesatop.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2005 at 03:10:38PM -0700, Steven Cole wrote:
> Andrew Morton wrote:
> >Steven Cole <elenstev@mesatop.com> wrote:
> 
> >>I am having trouble getting recent -mm kernels to boot on my test box.
> >>For 2.6.11-rc3-mm2 and 2.6.11-rc4-mm1 I get the following:
> >>
> >>VFS: Cannot open root device "301" or unknown-block(3,1)
> >>Please append a correct "root=" boot option
> >>Kernel panic - not syncing: VFS: Unable to mount root fs on 
> >>unknown-block(3,1)
> >>
> [snipped]
> >
> >Please set CONFIG_BASE_FULL=y.  Check that this causes CONFIG_BASE_SMALL=0,
> >then retest.
> 
> Yes, that worked.  2.6.11-rc4-mm1 now boots OK, but hdb1 seems to be 
> missing.

Can you retry CONFIG_BASE_FULL=n with Andrew's patch?

You may need to boot back into a sane kernel for LILO to operate properly.

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




-- 
Mathematics is the supreme nostalgia of our time.
