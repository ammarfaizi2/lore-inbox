Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292163AbSBOViG>; Fri, 15 Feb 2002 16:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289790AbSBOVhw>; Fri, 15 Feb 2002 16:37:52 -0500
Received: from altus.drgw.net ([209.234.73.40]:63749 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S289768AbSBOVhf>;
	Fri, 15 Feb 2002 16:37:35 -0500
Date: Fri, 15 Feb 2002 15:37:17 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
        linux-kernel@vger.kernel.org, ralf@uni-koblenz.de
Subject: Re: [patch] printk and dma_addr_t
Message-ID: <20020215153717.F1211@altus.drgw.net>
In-Reply-To: <20020213.013557.74564240.davem@redhat.com> <E16awZq-0004s4-00@the-village.bc.nu> <3C6A3F66.75D57124@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C6A3F66.75D57124@zip.com.au>; from akpm@zip.com.au on Wed, Feb 13, 2002 at 02:26:46AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2002 at 02:26:46AM -0800, Andrew Morton wrote:
> Alan Cox wrote:
> > 
> > So how do they modify the printf format rules in gcc ?
> 
> Good question.  It'd be nice for NIPQUAD and such.
> 
> Here's an alternative fix.  Less vomitous?
> 
> Sorry about sticking a prototype in types.h.  It needs to be
> somewhere where all dma_addr_t users will see it, and where
> dma_addr_t is already in scope.  Maybe there's a better place?

Personally, I like this less.. I don't think the previous #define 
DMA_ADDR_T_FMT (or whatever it was) is that bad, considering the options.

Once we set the precedent of having little 'char 
* form_some_random_type()' functions, they will show up all over the 
place.

I need something like this for the MTD patch I've got that supports 64 
bit buswidths on 32 bit machines and needs to printk the data on error.

I found that #define CFI_FMT '%lx' or whatever to be more 
straightforward, and easier to understand.

> + */
> +char *form_dma_addr_t(char *buf, dma_addr_t a)
> +{
> +	char *fmt;	/* Funny code to prevent a printf warning */
> +
> +	if (sizeof(dma_addr_t) == sizeof(long))
> +		fmt = "%lx";
> +	else
> +		fmt = "%Lx";
> +
> +	sprintf(buf, fmt, a);
> +	return buf;
> +}

-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Schulz
