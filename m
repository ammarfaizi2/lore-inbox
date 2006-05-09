Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWEITm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWEITm3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 15:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWEITm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 15:42:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33993 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750825AbWEITm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 15:42:28 -0400
Date: Tue, 9 May 2006 12:41:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, aeb@cwi.nl
Subject: Re: [PATCH] make kernel ignore bogus partitions
Message-Id: <20060509124138.43e4bac0.akpm@osdl.org>
In-Reply-To: <20060503210055.GB31048@beardog.cca.cpqcorp.net>
References: <20060503210055.GB31048@beardog.cca.cpqcorp.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net> wrote:
>
> Patch 1/1
> Sometimes partitions claim to be larger than the reported capacity of a
> disk device. This patch makes the kernel ignore those partitions.
> 
> Signed-off-by: Mike Miller <mike.miller@hp.com>
> Signed-off-by: Stephen Cameron <steve.cameron@hp.com>
> 
> Please consider this for inclusion.
> 
> 
>  fs/partitions/check.c |    5 +++++
>  1 files changed, 5 insertions(+)
> 
> --- linux-2.6.14/fs/partitions/check.c~partition_vs_capacity	2006-01-06 09:32:14.000000000 -0600
> +++ linux-2.6.14-root/fs/partitions/check.c	2006-01-06 11:24:50.000000000 -0600
> @@ -382,6 +382,11 @@ int rescan_partitions(struct gendisk *di
>  		sector_t from = state->parts[p].from;
>  		if (!size)
>  			continue;
> +		if (from+size-1 > get_capacity(disk)) {
> +			printk(" %s: p%d exceeds device capacity, ignoring.\n", 
> +				disk->disk_name, p);
> +			continue;
> +		}
>  		add_partition(disk, p, from, size);
>  #ifdef CONFIG_BLK_DEV_MD
>  		if (state->parts[p].flags)

Shouldn't that be

	if (from+size > get_capacity(disk)) {

?

