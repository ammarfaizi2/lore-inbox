Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267431AbUHDVLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267431AbUHDVLH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 17:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267428AbUHDVLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 17:11:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42215 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267431AbUHDVKz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 17:10:55 -0400
Date: Wed, 4 Aug 2004 16:17:37 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.4.27-rc5
Message-ID: <20040804191737.GA12223@logos.cnet>
References: <20040803234250.GB8083@logos.cnet> <Pine.GSO.4.58.0408041752150.15861@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0408041752150.15861@waterleaf.sonytel.be>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2004 at 05:53:39PM +0200, Geert Uytterhoeven wrote:
> On Tue, 3 Aug 2004, Marcelo Tosatti wrote:
> > Most importantly this release fixes an exploitable race in file offset handling
> > which allows unpriviledged users from potentially reading kernel memory.
> > This touches several drivers and generic proc code. This issue is covered by
> > CAN-2004-0415.
> > Marcelo Tosatti:
> >   o Al Viro and others: Fix file offset handling races in several drivers
> 
> Breaks the build with gcc 2.95. Trivial fix below:
> 
> --- linux-2.4.27-rc5/net/atm/br2684.c.orig	2004-08-04 15:33:22.000000000 +0200
> +++ linux-2.4.27-rc5/net/atm/br2684.c	2004-08-04 17:21:16.000000000 +0200
> @@ -736,8 +736,9 @@ static ssize_t br2684_proc_read(struct f
>  {
>  	unsigned long page;
>  	int len = 0, x, left;
> -	page = get_free_page(GFP_KERNEL);
>  	loff_t n = *pos;
> +
> +	page = get_free_page(GFP_KERNEL);
>  	if (!page)
>  		return -ENOMEM;
>  	left = PAGE_SIZE - 256;

Applied, thanks!
