Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbVEXJ4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbVEXJ4G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 05:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbVEXJte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 05:49:34 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:32453 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262012AbVEXJVS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:21:18 -0400
Date: Tue, 24 May 2005 15:00:29 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: cotte@freenet.de
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       schwidefsky@de.ibm.com, akpm@osdl.org,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC/PATCH 2/4] fs/mm: execute in place (3rd version)
Message-ID: <20050524093029.GA4390@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1116866094.12153.12.camel@cotte.boeblingen.de.ibm.com> <1116869420.12153.32.camel@cotte.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116869420.12153.32.camel@cotte.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2005 at 07:30:20PM +0200, Carsten Otte wrote:
> [RFC/PATCH 2/4] fs/mm: execute in place (3rd version)
> 
> This part has changed alot again:
> - generic_file* file operations do no longer have a xip/non-xip split
> - filemap_xip.c implements a new set of fops that require get_xip_page 
>   aop to work proper. all new fops are exported GPL-only (don't like to 
>   see whatever code use those except GPL modules)
> - __xip_unmap now uses page_check_address, which is no longer static 
>   in rmap.c, and defined in linux/rmap.h
> - mm/filemap.h is now much more clean, plainly having just Linus' 
>   inline funcs moved here from filemap.c
> - fix includes in filemap_xip to make it build cleanly on i386
> 
> diff -ruN linux-git/mm/filemap.h linux-git-xip/mm/filemap.h
> --- linux-git/mm/filemap.h	1970-01-01 01:00:00.000000000 +0100
> +++ linux-git-xip/mm/filemap.h	2005-05-23 19:01:27.000000000 +0200
> @@ -0,0 +1,94 @@
> +/*
> + *	linux/mm/filemap.c
> + *

I guess you meant "filemap.h" not "filemap.c" ? Shouldn't this be
in include/linux instead ?

> + * Copyright (C) 1994-1999  Linus Torvalds
> + */
> +
> +#ifndef __FILEMAP_H
> +#define __FILEMAP_H
> +
> +#include <linux/types.h>
> +#include <linux/fs.h>
> +#include <linux/mm.h>
> +#include <linux/highmem.h>
> +#include <linux/uio.h>
> +#include <linux/config.h>
> +#include <asm/uaccess.h>
> +

> diff -ruN linux-git/mm/filemap_xip.c linux-git-xip/mm/filemap_xip.c
> --- linux-git/mm/filemap_xip.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-git-xip/mm/filemap_xip.c	2005-05-23 19:01:42.000000000 +0200
> @@ -0,0 +1,581 @@
> +/*
> + *	linux/mm/filemap_xip.c
> + *
> + * Copyright (C) 2005 IBM Corporation
> + * Author: Carsten Otte <cotte@de.ibm.com>
> + *
> + * derived from linux/mm/filemap.c - Copyright (C) Linus Torvalds
> + *
> + */
> +
> + */
> +static ssize_t
> +__xip_file_aio_read(struct kiocb *iocb, const struct iovec *iov,
> +		unsigned long nr_segs, loff_t *ppos)
> +{


OK, though this leaves filemap.c alone which is good, I have to admit
that this entire duplication of read/write routines really worries me.

There has to be a third way.

Regards
Suparna


-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

