Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbVBXAnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVBXAnZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 19:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVBXAms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 19:42:48 -0500
Received: from waste.org ([216.27.176.166]:30091 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261798AbVBXAmM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 19:42:12 -0500
Date: Wed, 23 Feb 2005 16:41:59 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: 2.6.11-rc4-mm1 (VFS: Cannot open root device "301")
Message-ID: <20050224004159.GH3163@waste.org>
References: <20050223014233.6710fd73.akpm@osdl.org> <421CB161.7060900@mesatop.com> <20050223121759.5cb270ee.akpm@osdl.org> <421CFF5E.4030402@mesatop.com> <421D09AE.4090100@mesatop.com> <20050223161653.7cb966c3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050223161653.7cb966c3.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2005 at 04:16:53PM -0800, Andrew Morton wrote:
> Steven Cole <elenstev@mesatop.com> wrote:
> >
> > > Yes, that worked.  2.6.11-rc4-mm1 now boots OK, but hdb1 seems to be 
> > > missing.
> 
> Looking at the IDE update in rc4-mm1:
> 
> +void ide_init_disk(struct gendisk *disk, ide_drive_t *drive)
> +{
> +	ide_hwif_t *hwif = drive->hwif;
> +	unsigned int unit = drive->select.all & (1 << 4);
> +
> +	disk->major = hwif->major;
> +	disk->first_minor = unit << PARTN_BITS;
> +	sprintf(disk->disk_name, "hd%c", 'a' + hwif->index * MAX_DRIVES + unit);
> +	disk->queue = drive->queue;
> +}
> 
> Looks funny.
> 
> Could someone try this?
> 
> -	unsigned int unit = drive->select.all & (1 << 4);
> +	unsigned int unit = (drive->select.all >> 4) & 1;

Apparently there's already an 'hdb' sitting in drive->name, perhaps we
ought to do disk->disk_name = drive->name for the non-devfs case.

-- 
Mathematics is the supreme nostalgia of our time.
