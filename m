Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbULFViM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbULFViM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 16:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbULFViM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 16:38:12 -0500
Received: from mail.dif.dk ([193.138.115.101]:2246 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261663AbULFVhu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 16:37:50 -0500
Date: Mon, 6 Dec 2004 22:47:56 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Riina Kikas <riinak@ut.ee>
Cc: linux-kernel@vger.kernel.org, mroos@ut.ee
Subject: Re: [PATCH 2.6] clean-up: fixes "shadows global", "unused parameter"
 warnings
In-Reply-To: <Pine.SOC.4.61.0412062253040.21075@math.ut.ee>
Message-ID: <Pine.LNX.4.61.0412062230580.3378@dragon.hygekrogen.localhost>
References: <Pine.SOC.4.61.0412062253040.21075@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2004, Riina Kikas wrote:

> This patch fixes warnings "declaration of `prefetch' shadows a global
> declaration"
> (occuring on line 141) and "unused parameter `addr'" (occuring on line 136)
> 
> Signed-off-by: Riina Kikas <Riina.Kikas@mail.ee>
> 
> --- a/arch/i386/mm/fault.c	2004-12-02 21:30:30.000000000 +0000
> +++ b/arch/i386/mm/fault.c	2004-12-02 21:30:59.000000000 +0000
> @@ -133,12 +133,12 @@
>   * Sometimes AMD Athlon/Opteron CPUs report invalid exceptions on prefetch.
>   * Check that here and ignore it.
>   */
> -static int __is_prefetch(struct pt_regs *regs, unsigned long addr)
> +static int __is_prefetch(struct pt_regs *regs)

If you make that change, at least also change the caller of __is_prefetch
As the patch stands it will break the build of fault.c - I suspect you 
didn't compile test it.??

Also, addr gets passed in to is_prefetch() from several different 
locations before it gets passed on to __is_prefetch() - are you sure it's 
correct to just remove the function argument - can you prove that it does 
no harm? could it be that the correct fix would be to actually use it for 
something instead?  I don't know the code enough to be able to answer 
that, but I think it's a good question that needs to be answered.

What kernel source is this against? it doesn't seem to apply to my 
2.6.10-rc3-bk2 tree here.


-- 
Jesper Juhl 


