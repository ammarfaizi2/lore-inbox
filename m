Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbWEIWfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWEIWfe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 18:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWEIWfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 18:35:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:24214 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751296AbWEIWfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 18:35:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=G/KHhCjipFMCchX1eaC2mLklT3bvvRCxU031+yW3NAglU26GrgG4LuhAMnbFhaxbWd3Bh5xQvKJk2ZeRtO/Km1OONQBqz2si31QDG96Skufkn6DoxYfZC0FvuZlPz6LGoJmor17JpHWn1D/t8Nbo7myjf1zdBHtK8vLchi6ZkC0=
Date: Wed, 10 May 2006 02:34:05 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Allen <amah@highpoint-tech.com>
Cc: linux-scsi@vger.kernel.org, "'Andrew Morton'" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hptiop: HighPoint RocketRAID 3xxx controller driver
Message-ID: <20060509223404.GE7237@mipter.zuzino.mipt.ru>
References: <200605092128.k49LSQ6R024308@mail.hypersurf.com> <20060509215936.GD7237@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509215936.GD7237@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 01:59:36AM +0400, Alexey Dobriyan wrote:
> That plethora of HPT_IOCTL_* defines, where are you using them? What
> arguments are passed in and out?

Argh, sorry for confusion, I've checked several first in the list and wrongly
concluded nothing is used. Anyway, please, remove unused HPT_IOCTL_ defines.

> #ifdef MODULE_LICENSE
> MODULE_LICENSE("GPL");
> #endif

#ifdef is totally unneeded.

Module init and exit functions should be marked with __init and __exit
resp.

Use DMA_??BIT_MASK in calls to pci_set_dma_mask(). See
include/linux/dma-mapping.h for readily available items.

hptiop_get_logical_devices can return -1 and you'll end up with

	for (j = 0; j < -1; j++)

in hptiop_show_devicelist()

u64 things are printed as

	"%llu", (unsigned long long)capacity

Is unsigned long long enough in this case?

I also suggest to use vsnprintf() in hptiop_copy_info() because you use
it with strings.

Funny, that you do

	driveid->model[20] = 0;

when ->model is in fact 40 chars long.

