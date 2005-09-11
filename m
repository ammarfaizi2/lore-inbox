Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964924AbVIKMDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbVIKMDe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 08:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbVIKMDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 08:03:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:33946 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964924AbVIKMDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 08:03:33 -0400
Date: Sun, 11 Sep 2005 13:03:32 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sungem driver patch testing..
Message-ID: <20050911120332.GA7627@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0509102008540.4912@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509102008540.4912@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2005 at 08:11:22PM -0700, Linus Torvalds wrote:
> 
> I've been grepping around for things that do their own PCI ROM mapping and 
> do it badly, and one thing that matches that description is the sungem 
> ethernet driver on PC's.
> 
> If anybody has such a beast, can you please try this patch and report 
> whether it works for you? 
> 
> 		Linus
> 
> ---
> diff --git a/drivers/net/sungem.c b/drivers/net/sungem.c
> --- a/drivers/net/sungem.c
> +++ b/drivers/net/sungem.c
> @@ -2817,7 +2817,7 @@ static int gem_ioctl(struct net_device *
>  
>  #if (!defined(__sparc__) && !defined(CONFIG_PPC_PMAC))
>  /* Fetch MAC address from vital product data of PCI ROM. */
> -static void find_eth_addr_in_vpd(void __iomem *rom_base, int len, unsigned char *dev_addr)
> +static int find_eth_addr_in_vpd(void __iomem *rom_base, int len, unsigned char *dev_addr)

While we're at it the cpp conditioal looks bogus.  We definitly needs this
when plugging a SUN card into a mac.  I'd suggest compiling this
unconditionally and fall back to it when whatever firmware method to get
the mac address fails.

