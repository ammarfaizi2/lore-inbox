Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbULGBDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbULGBDS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 20:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbULGBDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 20:03:18 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:61824 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S261727AbULGBDM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 20:03:12 -0500
Date: Tue, 7 Dec 2004 02:02:59 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org, mroos@ut.ee, Riina Kikas <riinak@ut.ee>
Subject: Re: [PATCH 2.6] clean-up: fixes "comparison between signed
Message-ID: <20041207010259.GA12352@vana.vc.cvut.cz>
References: <2C0CC42621D@vcnet.vc.cvut.cz> <Pine.LNX.4.61.0412062352430.3390@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0412062352430.3390@dragon.hygekrogen.localhost>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2004 at 12:09:05AM +0100, Jesper Juhl wrote:
> On Mon, 6 Dec 2004, Petr Vandrovec wrote:
> > Correct is (if any fix is needed at all) typecast regs->esp to unsigned
> > long, 
> 
> That would have been my suggestion as well.
> 
> >eventually with check that address is less than (unsigned long)-32,
> > as area at VA 0 is not going to grow "down" to 0xFFFFFxxx, even if you
> > nicely ask.
> 
> you mean something like this - right?

Yes.  Though I believe that we already take vma == NULL path when address is that big.
								Petr Vandrovec
 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> 
> diff -up linux-2.6.10-rc3-bk2-orig/arch/i386/mm/fault.c linux-2.6.10-rc3-bk2/arch/i386/mm/fault.c
> --- linux-2.6.10-rc3-bk2-orig/arch/i386/mm/fault.c	2004-12-06 22:24:16.000000000 +0100
> +++ linux-2.6.10-rc3-bk2/arch/i386/mm/fault.c	2004-12-07 00:04:33.000000000 +0100
> @@ -305,7 +305,7 @@ fastcall void do_page_fault(struct pt_re
>  		 * pusha) doing post-decrement on the stack and that
>  		 * doesn't show up until later..
>  		 */
> -		if (address + 32 < regs->esp)
> +		if (address + 32 < (unsigned long)regs->esp || address >= (~0UL - 32))
>  			goto bad_area;
>  	}
>  	if (expand_stack(vma, address))
> 
> 
> 
