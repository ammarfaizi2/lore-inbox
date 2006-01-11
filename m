Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbWAKKNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWAKKNa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 05:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWAKKN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 05:13:29 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:3687 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932380AbWAKKN3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 05:13:29 -0500
Date: Wed, 11 Jan 2006 11:15:24 +0100
From: Jens Axboe <axboe@suse.de>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Mark Lord <lkml@rtr.ca>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH ]  VMSPLIT config options (with default config fixed)
Message-ID: <20060111101524.GY3389@suse.de>
References: <20060110133728.GB3389@suse.de> <Pine.LNX.4.63.0601100840400.9511@winds.org> <20060110143931.GM3389@suse.de> <Pine.LNX.4.64.0601100804380.4939@g5.osdl.org> <43C3E9C2.1000309@rtr.ca> <20060110173217.GU3389@suse.de> <43C3F0CA.10205@rtr.ca> <43C403BA.1050106@pobox.com> <43C40803.2000106@rtr.ca> <20060111021318.7e61384c@werewolf.auna.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060111021318.7e61384c@werewolf.auna.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11 2006, J.A. Magallon wrote:
> I really like to see this in -mm, and finally in mainline.

It's in -mm now.

> My only objection is about the menu entry names and help. I think
> people building a kernel would not exactly understand what all this is
> about (even I think I don't have it realle clear).

If they don't, they should not touch the option...

> Is there any doc which states clearly somthing like:
> 
> - no highmem is the fastest
> - 4Gb introduces one indirection, so it is slower...(really ?)
> - 64Gb introduces two (PAE ?)
> 
> mixed with
> 
> - 3G/1G standard maping:
>    - nor user nor kernel can use any memory above 860 Mb
>    - user processes (my numbercruncher) can not allocate more than XGb
> - 2G/2G: idem:
>    - max memory seen by my linux system (not kernel, but kernel+userspace,
>    - how much can I allocate for a single process (how big my problem
>      can be ?)
> 
> If there is already a doc like that, it would be very interesting to
> have pointer/link to it in the help text.

I think the help text is good enough, but it would definitely be nice
with a fuller description of what exactly low and high memory is and the
implications of the various settings.

> For example, when I read this:
> 
> +	  If the address range available to the kernel is less than the
> +	  physical memory installed, the remaining memory will be available
> +	  as "high memory". Accessing high memory is a little more costly
> +	  than low memory, as it needs to be mapped into the kernel first.
> 
> Does this mean that with 3/1 standard split, I still can use the lost
> 128 Mb for something ? I though I can't.

It tells you that the remaining memory is available as high memory, so
it's not lost of course. It also tells you that accessing this high
memory is indeed possible, but it's a little more costly since it needs
to be mapped temporarily into the kernel address space.

> Don't be too hard with me, just anxious to finally understand this...

No worries, perhaps you will be the one writing the Documentation/ bit
to accompany this then :-)

Basically the option boils down to how much virtual address space you
want to assign to the kernel and user space. The kernel can always
access all of memory, but in some cases part of that memory will be
available as high memory that needs to be mapped in first (see
references to kmap() and kmap_atomic() in the kernel). So whether
changing the mapping or using highmem is the best option for you,
depends entirely on what you run on that machine. If you require a huge
user address space, then you don't want to change away from the 3/1
user/kernel default setting. However, if you don't need the full 3G of
adress space to user apps, then you are better off increasing the kernel
address space range to get rid of the high memory mapping.

For the "typical" case of 1GB machine, using the _OPT setting to just
move the offset slightly is a really good choice as it only removes a
little bit of the user address range.

-- 
Jens Axboe

