Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262908AbVDAVUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262908AbVDAVUJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 16:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262890AbVDAVRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 16:17:20 -0500
Received: from kanga.kvack.org ([66.96.29.28]:28854 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S262896AbVDAUze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:55:34 -0500
Date: Fri, 1 Apr 2005 15:55:07 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-ns83820@kvack.org, jgarzik@pobox.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] drivers/net/ns83820.c: remove unused code
Message-ID: <20050401205507.GF27961@kvack.org>
References: <20050322215717.GO1948@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050322215717.GO1948@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

applied

On Tue, Mar 22, 2005 at 10:57:17PM +0100, Adrian Bunk wrote:
> The Coveity checker found that residue is always 0.
> 
> Is this patch correct or should residue have been used?
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.12-rc1-mm1-full/drivers/net/ns83820.c.old	2005-03-22 21:32:15.000000000 +0100
> +++ linux-2.6.12-rc1-mm1-full/drivers/net/ns83820.c	2005-03-22 21:33:16.000000000 +0100
> @@ -1189,7 +1189,6 @@
>  
>  	for (;;) {
>  		volatile u32 *desc = dev->tx_descs + (free_idx * DESC_SIZE);
> -		u32 residue = 0;
>  
>  		dprintk("frag[%3u]: %4u @ 0x%08Lx\n", free_idx, len,
>  			(unsigned long long)buf);
> @@ -1199,17 +1198,11 @@
>  		desc_addr_set(desc + DESC_BUFPTR, buf);
>  		desc[DESC_EXTSTS] = cpu_to_le32(extsts);
>  
> -		cmdsts = ((nr_frags|residue) ? CMDSTS_MORE : do_intr ? CMDSTS_INTR : 0);
> +		cmdsts = ((nr_frags) ? CMDSTS_MORE : do_intr ? CMDSTS_INTR : 0);
>  		cmdsts |= (desc == first_desc) ? 0 : CMDSTS_OWN;
>  		cmdsts |= len;
>  		desc[DESC_CMDSTS] = cpu_to_le32(cmdsts);
>  
> -		if (residue) {
> -			buf += len;
> -			len = residue;
> -			continue;
> -		}
> -
>  		if (!nr_frags)
>  			break;
>  
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-ns83820' in
> the body to majordomo@kvack.org.

-- 
"Time is what keeps everything from happening all at once." -- John Wheeler
