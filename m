Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263154AbUFTTlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263154AbUFTTlL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 15:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263709AbUFTTlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 15:41:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24224 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263154AbUFTTlG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 15:41:06 -0400
Date: Sun, 20 Jun 2004 16:34:04 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.27-rc1
Message-ID: <20040620193404.GA7102@logos.cnet>
References: <20040620004520.GA4599@logos.cnet> <Pine.GSO.4.58.0406201910300.23356@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0406201910300.23356@waterleaf.sonytel.be>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Geert! 


On Sun, Jun 20, 2004 at 07:16:40PM +0200, Geert Uytterhoeven wrote:
> On Sat, 19 Jun 2004, Marcelo Tosatti wrote:
> > Marcelo Tosatti:
> >   o journal_try_to_free_buffers(): Add debug print in case of bh list corruption
> 
> Which introduced 4 warnings. Here's a fix:
> 
> --- linux-2.4.27-rc1/fs/jbd/transaction.c.orig	2004-06-20 13:04:20.000000000 +0200
> +++ linux-2.4.27-rc1/fs/jbd/transaction.c	2004-06-20 19:08:07.000000000 +0200
> @@ -1700,11 +1700,11 @@ void debug_page(struct page *p)
> 
>  	bh = p->buffers;
> 
> -	printk(KERN_ERR "%s: page index:%u count:%d flags:%x\n", __FUNCTION__,
> +	printk(KERN_ERR "%s: page index:%lu count:%d flags:%lx\n", __FUNCTION__,
>  		 p->index, atomic_read(&p->count), p->flags);
> 
>  	while (bh) {
> -		printk(KERN_ERR "%s: bh b_next:%p blocknr:%u b_list:%u state:%x\n",
> +		printk(KERN_ERR "%s: bh b_next:%p blocknr:%lu b_list:%u state:%lx\n",
>  			__FUNCTION__, bh->b_next, bh->b_blocknr, bh->b_list,
>  				bh->b_state);
>  		bh = bh->b_this_page;

Right.

> And now I just looked at the original patch:
> 
> | --- linux-2.4.26/fs/jbd/transaction.c	2004-02-18 13:36:31.000000000 +0000
> | +++ linux-2.4.27-rc1/fs/jbd/transaction.c	2004-06-19 23:37:33.000000000 +0000
> | @@ -1752,6 +1769,11 @@ int journal_try_to_free_buffers(journal_
> |  	do {
> |  		struct buffer_head *p = tmp;
> |
> | +		if (!unlikely(tmp)) {
>                     ^^^^^^^^^^^^^^
> Shouldn't this be `unlikely(!tmp))'?

The original works, but thats cleaner as Willy also pointed out.

I'll fix those.

Thanks!

