Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129981AbRCAU6i>; Thu, 1 Mar 2001 15:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129987AbRCAU62>; Thu, 1 Mar 2001 15:58:28 -0500
Received: from baldur.fh-brandenburg.de ([195.37.0.5]:53914 "HELO
	baldur.fh-brandenburg.de") by vger.kernel.org with SMTP
	id <S129981AbRCAU6V>; Thu, 1 Mar 2001 15:58:21 -0500
Date: Thu, 1 Mar 2001 21:56:23 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Alexander Viro <viro@math.psu.edu>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, gator@cs.tu-berlin.de,
        linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] Re: fat problem in 2.4.2
In-Reply-To: <Pine.GSO.4.21.0103011345110.11577-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.10.10103012147490.19829-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 1 Mar 2001, Alexander Viro wrote:

> +static int generic_vm_expand(struct address_space *mapping, loff_t size)
> +{
> +	struct page *page;
> +	unsigned long index, offset;
> +	int err;
> +
> +	if (!mapping->a_ops->prepare_write || !mapping->a_ops->commit_write)
> +		return -ENOSYS;
> +
> +	offset = (size & (PAGE_CACHE_SIZE-1)); /* Within page */
> +	index = size >> PAGE_CACHE_SHIFT;

For affs I did basically the same with a small difference:

	offset = ((size-1) & (PAGE_CACHE_SIZE-1)) + 1;
	index = (size-1) >> PAGE_CACHE_SHIFT;

That works fine here and allocates a page in the cache more likely to be
used.

bye, Roman

