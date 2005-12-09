Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbVLIQvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbVLIQvx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 11:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbVLIQvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 11:51:53 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3594 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932283AbVLIQvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 11:51:52 -0500
Date: Fri, 9 Dec 2005 17:51:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, cotte@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/17] s390: move s390_root_dev_* out of the cio layer.
Message-ID: <20051209165150.GD23349@stusta.de>
References: <20051209152345.GD6532@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051209152345.GD6532@skybase.boeblingen.de.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 04:23:45PM +0100, Martin Schwidefsky wrote:
>...
> --- linux-2.6/drivers/s390/s390_rdev.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6-patched/drivers/s390/s390_rdev.c	2005-12-09 14:24:22.000000000 +0100
>...
> +static void
> +s390_root_dev_release(struct device *dev)
> +{
> +	kfree(dev);
> +}
>...
> +void
> +s390_root_dev_unregister(struct device *dev)
> +{
> +	if (dev)
> +		device_unregister(dev);
> +}
>...
> --- linux-2.6/include/asm-s390/s390_rdev.h	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6-patched/include/asm-s390/s390_rdev.h	2005-12-09 14:24:22.000000000 +0100
>...
> +extern struct device *s390_root_dev_register(const char *);
> +extern void s390_root_dev_unregister(struct device *);
>...

If you do _really_ need these wrappers, simply make them
"static inline"'s in the header file.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

