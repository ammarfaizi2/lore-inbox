Return-Path: <linux-kernel-owner+w=401wt.eu-S965239AbXAJXm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965239AbXAJXm5 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 18:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965241AbXAJXm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 18:42:57 -0500
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:33909 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965239AbXAJXm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 18:42:56 -0500
Subject: Re: [patch] Fix bttv and friends on 64bit machines with lots of
	memory.
From: hermann pitton <hermann-pitton@arcor.de>
To: Linux and Kernel Video <video4linux-list@redhat.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <45A4AAA4.4040606@novell.com>
References: <45A4AAA4.4040606@novell.com>
Content-Type: text/plain
Date: Thu, 11 Jan 2007 00:41:46 +0100
Message-Id: <1168472507.3118.7.camel@pc08.localdom.local>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, den 10.01.2007, 09:58 +0100 schrieb Gerd Hoffmann:
>   Hi,
> 
> We have a DMA32 zone now, lets use it to make sure the card
> can reach the memory we have allocated for the video frame
> buffers.
> 
> please apply,
> 
>   Gerd

Hi,

did anybody already pick up, comment, review Gerd's patch ?

Walks in into his own home like a stranger ...

Gerd, THANKS for all you did.
It was a incredible lot!

Hermann

> einfaches Textdokument-Anlage (v4l-dma32)
> Fix bttv and friends on 64bit machines with lots of memory.
> 
> We have a DMA32 zone now, lets use it to make sure the card
> can reach the memory we have allocated for the video frame
> buffers.
> 
> Signed-off-by: Gerds Hoffmann <kraxel@suse.de>
> ---
>  drivers/media/video/video-buf.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6.18/drivers/media/video/video-buf.c
> ===================================================================
> --- linux-2.6.18.orig/drivers/media/video/video-buf.c
> +++ linux-2.6.18/drivers/media/video/video-buf.c
> @@ -1224,7 +1224,7 @@ videobuf_vm_nopage(struct vm_area_struct
>  		vaddr,vma->vm_start,vma->vm_end);
>  	if (vaddr > vma->vm_end)
>  		return NOPAGE_SIGBUS;
> -	page = alloc_page(GFP_USER);
> +	page = alloc_page(GFP_USER | __GFP_DMA32);
>  	if (!page)
>  		return NOPAGE_OOM;
>  	clear_user_page(page_address(page), vaddr, page);

