Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261613AbSKKXQN>; Mon, 11 Nov 2002 18:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262295AbSKKXQN>; Mon, 11 Nov 2002 18:16:13 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:13768 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261613AbSKKXQM>;
	Mon, 11 Nov 2002 18:16:12 -0500
Date: Mon, 11 Nov 2002 18:23:00 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Bernd Eckenfels <ecki@lina.inka.de>
cc: dm@uk.sistina.com, linux-lvm@sistina.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] make device mapper compile on 2.5.4x
In-Reply-To: <20021111225340.GA3587@lina.inka.de>
Message-ID: <Pine.GSO.4.21.0211111821210.29617-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Nov 2002, Bernd Eckenfels wrote:

> -	set_device_ro(dm_kdev(md), 0/*(param->flags & DM_READONLY_FLAG)*/);
> +	bdev = bdget(kdev_t_to_nr(dm_kdev(md)));
> +	if (!bdev)
> +		return -ENXIO;
> +	set_device_ro(bdev, (param->flags & DM_READONLY_FLAG));
> +	bdput(bdev);

That is simply wrong.  set_device_ro() works only on opened block_device.
Correct fix is to use set_disk_ro() and it's already in the tree (1.830
on bkbits).

