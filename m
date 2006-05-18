Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbWERQ5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWERQ5m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 12:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbWERQ5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 12:57:42 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:43679 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751367AbWERQ5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 12:57:41 -0400
Date: Thu, 18 May 2006 18:57:28 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add Amstrad Delta NAND support.
Message-ID: <20060518165728.GA26113@wohnheim.fh-wedel.de>
References: <20060518160940.GS7570@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060518160940.GS7570@earth.li>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 May 2006 17:09:41 +0100, Jonathan McDowell wrote:
>
> +static struct mtd_info *ams_delta_mtd = NULL;



> +	switch(cmd){
              ^    ^
Add spaces

> +	omap_writew(0, (OMAP_MPUIO_BASE + OMAP_MPUIO_IO_CNTL));
                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Could that be done in a macro?

> +	udelay(0.04);

Floating point in the kernel?

> +	ams_delta_mtd = kmalloc (sizeof(struct mtd_info) +
                               ^
> +					sizeof (struct nand_chip), GFP_KERNEL);

Remove space

And please create a structure containing both struct mtd_info and
struct nand_chip.  Then use sizeof(that structure)...

> +	/* Get pointer to private data */
> +	this = (struct nand_chip *) (&ams_delta_mtd[1]);

...and remove this cast.

> +	/* Initialize structures */
> +	memset((char *) ams_delta_mtd, 0, sizeof(struct mtd_info));
> +	memset((char *) this, 0, sizeof(struct nand_chip));

And those as well, while you're at it.

> +	if (nand_scan (ams_delta_mtd, 1)) {
                     ^
> +	kfree (ams_delta_mtd);
             ^
> +static void __exit ams_delta_cleanup (void)
                                       ^
> +	nand_release (ams_delta_mtd);
                    ^
> +	kfree (ams_delta_mtd);
             ^
Jörn

-- 
Happiness isn't having what you want, it's wanting what you have.
-- unknown
