Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbWINBYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWINBYf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 21:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWINBYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 21:24:35 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:46256 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1751312AbWINBYe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 21:24:34 -0400
Date: Thu, 14 Sep 2006 11:24:35 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 5/7] Alter get_order() so that it can make use of
 ilog2() on a constant [try #3]
Message-Id: <20060914112435.4ce28290.sfr@canb.auug.org.au>
In-Reply-To: <20060913183531.22109.85723.stgit@warthog.cambridge.redhat.com>
References: <20060913183522.22109.10565.stgit@warthog.cambridge.redhat.com>
	<20060913183531.22109.85723.stgit@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Wed, 13 Sep 2006 19:35:31 +0100 David Howells <dhowells@redhat.com> wrote:
>
> diff --git a/include/asm-generic/page.h b/include/asm-generic/page.h
> index a96b5d9..a7e374e 100644
> --- a/include/asm-generic/page.h
> +++ b/include/asm-generic/page.h
> @@ -6,20 +6,6 @@ #ifndef __ASSEMBLY__
>  
>  #include <linux/compiler.h>
>  
> -/* Pure 2^n version of get_order */
> -static __inline__ __attribute_const__ int get_order(unsigned long size)
> -{
> -	int order;
> -
> -	size = (size - 1) >> (PAGE_SHIFT - 1);
> -	order = -1;
> -	do {
> -		size >>= 1;
> -		order++;
> -	} while (size);
> -	return order;
> -}
> -
>  #endif	/* __ASSEMBLY__ */
>  #endif	/* __KERNEL__ */

After this patch, you don't need to include <linux/compiler.h> any more
(and, in fact, the file ends up essentially empty).  Is there a good
reason to move this function out of asm-generic/page.h?

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
