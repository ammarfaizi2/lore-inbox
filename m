Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbVHWJyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbVHWJyj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 05:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbVHWJyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 05:54:39 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:15022 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932112AbVHWJyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 05:54:38 -0400
Date: Tue, 23 Aug 2005 10:54:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] fs/super.c: unexport user_get_super
Message-ID: <20050823095427.GA4425@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050822162056.GD9927@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050822162056.GD9927@stusta.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2005 at 06:20:56PM +0200, Adrian Bunk wrote:
> I didn't find any modular usage in the kernel.

And there shouldn't be one either.  This is really just for some syscalls,
everything else should use get_super based on a struct block_device. If
there's any caller using this wrongly in out of tree modules they can
be switched to bdget + get_super trivially (fixing their code would be
even better).

> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
> This patch was already sent on:
> - 30 May 2005
> - 13 May 2005
> - 1 May 2005
> - 23 Apr 2005
> 
> --- linux-2.6.12-rc2-mm3-full/fs/super.c.old	2005-04-23 02:45:59.000000000 +0200
> +++ linux-2.6.12-rc2-mm3-full/fs/super.c	2005-04-23 02:46:07.000000000 +0200
> @@ -467,8 +467,6 @@
>  	return NULL;
>  }
>  
> -EXPORT_SYMBOL(user_get_super);
> -
>  asmlinkage long sys_ustat(unsigned dev, struct ustat __user * ubuf)
>  {
>          struct super_block *s;
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
---end quoted text---
