Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbUL2TGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbUL2TGk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 14:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbUL2TGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 14:06:40 -0500
Received: from [213.146.154.40] ([213.146.154.40]:64438 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261413AbUL2TG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 14:06:29 -0500
Date: Wed, 29 Dec 2004 19:06:24 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] fix floppy build
Message-ID: <20041229190624.GA15538@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <41D2FF34.3040606@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41D2FF34.3040606@pobox.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2004 at 02:02:12PM -0500, Jeff Garzik wrote:
> So my patch removing #include kernel/version.h broke the modular floppy 
> build... doh.  I would prefer to remove the redundancy of listing the 
> kernel version each time the floppy driver is loaded.
> 
> See attached for 'bk pull' and example patch.

> Please do a
> 
> 	bk pull bk://gkernel.bkbits.net/misc-2.6
> 
> This will update the following files:
> 
>  drivers/block/floppy.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> through these ChangeSets:
> 
> <jgarzik@pobox.com> (04/12/29 1.2079)
>    block/floppy.c: fix build by removing UTS_RELEASE use
>    
>    It's redundant to the kernel message that prints out the kernel version,
>    as well as many other places where one can request the kernel version.
> 
> diff -Nru a/drivers/block/floppy.c b/drivers/block/floppy.c
> --- a/drivers/block/floppy.c	2004-12-29 14:00:55 -05:00
> +++ b/drivers/block/floppy.c	2004-12-29 14:00:55 -05:00
> @@ -4595,7 +4595,7 @@
>  
>  int init_module(void)
>  {
> -	printk(KERN_INFO "inserting floppy driver for " UTS_RELEASE "\n");
> +	printk(KERN_INFO "inserting floppy driver\n");

or just kill the printk completely..

