Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWEHHeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWEHHeg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 03:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWEHHeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 03:34:36 -0400
Received: from hera.cwi.nl ([192.16.191.8]:58333 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S1750757AbWEHHeg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 03:34:36 -0400
Date: Mon, 8 May 2006 09:27:01 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       Andries.Brouwer@cwi.nl
Subject: Re: [PATCH] make kernel ignore bogus partitions
Message-ID: <20060508072701.GB15941@apps.cwi.nl>
References: <20060503210055.GB31048@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060503210055.GB31048@beardog.cca.cpqcorp.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2006 at 04:00:55PM -0500, Mike Miller (OS Dev) wrote:
> Patch 1/1
> Sometimes partitions claim to be larger than the reported capacity of a
> disk device. This patch makes the kernel ignore those partitions.
> 
> Signed-off-by: Mike Miller <mike.miller@hp.com>
> Signed-off-by: Stephen Cameron <steve.cameron@hp.com>

> +		if (from+size-1 > get_capacity(disk)) {
> +			printk(" %s: p%d exceeds device capacity, ignoring.\n", 
> +				disk->disk_name, p);
> +			continue;
> +		}

I debated for a while with myself whether I should like or dislike
such a patch. On the one hand, this partition stuff is rather messy,
and if you invent strict rules that partitions should satisfy then
during the transition lots of people will be unhappy, but afterwards
the stuff may be less messy.

On the other hand, such changes do indeed make people unhappy.
Indeed, with this change one of my systems does not boot anymore.

There can be reasons, or there can have been reasons, for partitions
larger than the disk. Maybe the disk has a jumper clipping the capacity
while in other machines such a jumper is unnecessary, or while soon
after booting the setmax utility is called to set the disk to full
capacity again.
Or, while doing forensics on a disk one copies the start to some
other disk, and that other disk may be smaller.
Etc.

So, it seems that Linux loses a little bit of its power when such things
are made impossible.

Andries

