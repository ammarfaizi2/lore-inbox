Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264592AbRFTUIU>; Wed, 20 Jun 2001 16:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264593AbRFTUIJ>; Wed, 20 Jun 2001 16:08:09 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:63893 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S264592AbRFTUH6>;
	Wed, 20 Jun 2001 16:07:58 -0400
Date: Wed, 20 Jun 2001 16:07:55 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove null register_disk
In-Reply-To: <UTC200106201958.VAA343451.aeb@vlet.cwi.nl>
Message-ID: <Pine.GSO.4.21.0106201606430.26389-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 20 Jun 2001 Andries.Brouwer@cwi.nl wrote:

> In fs/partitions/check.c we read
> 
> void register_disk(struct gendisk *gdev, kdev_t dev, unsigned minors,
>         struct block_device_operations *ops, long size)
> {
>         if (!gdev)
>                 return;
>         grok_partitions(gdev, MINOR(dev)>>gdev->minor_shift, minors, size);
> }
> 
> showing that register_disk is void when its first argument is NULL.
> This allows one to remove some dead code.
> Can be applied to 2.4. No behaviour is changed.

That's simply wrong. We will need register_disk(). Reinserting it into the
right places in 2.5 is a unnecessary PITA.

