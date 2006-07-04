Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWGDIAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWGDIAS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 04:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWGDIAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 04:00:18 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:38935 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750826AbWGDIAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 04:00:17 -0400
Date: Tue, 4 Jul 2006 10:02:16 +0200
From: Jens Axboe <axboe@suse.de>
To: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Cc: viro@zeniv.linux.org.uk, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] partitions: let partitions inherit policy from disk
Message-ID: <20060704080215.GS4038@suse.de>
References: <44A90B9A.5080805@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A90B9A.5080805@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03 2006, Peter Oberparleiter wrote:
> I'd like to suggest to change the partition code in
> fs/partitions/check.c to initialize a newly detected partition's policy
> field with that of the containing block device (see patch below).
> 
> My reasoning is that function set_disk_ro() in block/genhd.c
> modifies the policy field (read-only indicator) of a disk and all
> contained partitions. When a partition is detected after the call to
> set_disk_ro(), the policy field of this partition will currently not
> inherit the disk's policy field. This behavior poses a problem in cases
> where a block device can be 'logically de- and reactivated' like e.g.
> the s390 DASD driver because partition detection may run after the
> policy field has been modified.
> 
> From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
> 
> Initialize the policy field of partitions with that of the containing
> block device.
> 
> Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
> ---
> diff -Naurp linux-2.6.17/fs/partitions/check.c linux-2.6.17b/fs/partitions/check.c
> --- linux-2.6.17/fs/partitions/check.c	2006-06-18 03:49:35.000000000 +0200
> +++ linux-2.6.17b/fs/partitions/check.c	2006-07-03 12:49:13.000000000 +0200
> @@ -348,6 +348,7 @@ void add_partition(struct gendisk *disk,
>  	p->start_sect = start;-
>  	p->nr_sects = len;
>  	p->partno = part;
> +	p->policy = disk->policy;
> 
>  	devfs_mk_bdev(MKDEV(disk->major, disk->first_minor + part),
>  			S_IFBLK|S_IRUSR|S_IWUSR,

Makes sense to me, however I'll let Al ack this for inclusion. Al?

-- 
Jens Axboe

