Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261191AbSI2TsG>; Sun, 29 Sep 2002 15:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261761AbSI2TsF>; Sun, 29 Sep 2002 15:48:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:266 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261760AbSI2Trk>;
	Sun, 29 Sep 2002 15:47:40 -0400
Message-ID: <3D9759FF.2050802@pobox.com>
Date: Sun, 29 Sep 2002 15:52:31 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jaroslav Kysela <perex@suse.cz>
CC: Arjan van de Ven <arjanv@fenrus.demon.nl>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA update [6/10] - 2002/07/20
References: <Pine.LNX.4.33.0209292120171.591-100000@pnote.perex-int.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaroslav Kysela wrote:
> On 29 Sep 2002, Arjan van de Ven wrote:
>>what is wrong with the PCI DMA API that makes ALSA wants a private
>>interface/implementation ?
> 
> 
> These lines (i386 arch):
> 
>         if (hwdev == NULL || ((u32)hwdev->dma_mask != 0xffffffff))
>                 gfp |= GFP_DMA;
>         ret = (void *)__get_free_pages(gfp, get_order(size));
> 
> Note that some of soundcards have various PCI DMA transfer limits 
> (dma_mask is not set to use full 32-bits). In this case, restricting this 
> hardware to allocate these buffers in first 16MB is not a very good idea.
> Thus, we have own hacks to allocate memory in whole hardware area.

It sounds like it would be reasonable to fix the ia32 arch code, would 
it not?


> Debugging. We enumerate all allocations, so we can check for memory leaks.
> I'm happy to say, that our code is very well debugged in this regard.

So are the net drivers, but without wrappers :)

