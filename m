Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269342AbUJFRYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269342AbUJFRYz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 13:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269324AbUJFRYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 13:24:42 -0400
Received: from chaos.analogic.com ([204.178.40.224]:4736 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S269286AbUJFRRE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 13:17:04 -0400
Date: Wed, 6 Oct 2004 13:16:19 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Michael Baumann <baumann@optivus.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problem trying to implement mmap for device on 2.4
In-Reply-To: <200410060950.39483.baumann@optivus.com>
Message-ID: <Pine.LNX.4.61.0410061312090.3138@chaos.analogic.com>
References: <200410060950.39483.baumann@optivus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Oct 2004, Michael Baumann wrote:

> Sorry if this is too much of a noob question - do point me to the right place
> if you can.
> System: PPC on VME
> Attempting driver for 3rd party NVRAM board - it's meant to be used as
> a data-store/system-state recorder. Will be used by more than one
> processor in the system - each processor is to use a "chunk" of the RAM
> as it's scratch space. Or that's the plan.
>
> Based on what I thought I understood from Rubini&Corbet 2nd Edition
> I created a simple module, that provided a mmap method - after reserving
> the region via request_mem_region.
>
> mapping was done with a simple remap_page_range()
>
> In userland, the mmap system call is made, with MAP_FIXED
> and the kernel immediately fails the call with "cannot allocate memory" -
> never even getting to my implementation of the mmap call. Apparently
> dying somewhere during "the good deal of work" Rubini talks about.
> If I don't use MAP_FIXED, things 'work', but I need that fixed location,
> I'm obviously trying to map the RAM into user space for access.
>

If you have implimented mmap() in your driver, you use MAP_FILE.
You receive a pointer to your data-space in your board.

>
> I'm assuming I'm missing something simple in the setup, somewhere.
> Any help/pointers/ even insults accepted - I'm in a tough spot here.
>
>
> -- 
> --

MAP_FIXED is for when you have some physical memory location you
need to access (like a screen buffer at 0x000b8000).

Cheers,
Dick Johnson
Penguin : Linux version 2.6.5-1.358-noreg on an i686 machine (5537.79 BogoMips).
             Note 96.31% of all statistics are fiction.

