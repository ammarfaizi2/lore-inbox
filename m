Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbWDKQlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWDKQlL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 12:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWDKQlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 12:41:11 -0400
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:17021 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1751352AbWDKQlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 12:41:10 -0400
In-Reply-To: <20060410221455.GH2408@stusta.de>
References: <20060410221455.GH2408@stusta.de>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8C90D17C-DB88-4B60-9D88-C01627E347F3@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [2.6 patch] the scheduled unexport of insert_resource
Date: Tue, 11 Apr 2006 11:41:07 -0500
To: Adrian Bunk <bunk@stusta.de>
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm fine with this.  I'll deal with getting my bus code out in the  
future.

- k

On Apr 10, 2006, at 5:14 PM, Adrian Bunk wrote:

> This patch contains the scheduled unexport of insert_resource.
>
> Kumar Gala said that some not yet submitted code uses it [1], but  
> since
> there is after one month still no code submission, and reverting the
> exporting it again is trivial if it is both submitted and considered
> acceptable for inclusion this shouldn't be a problem.
>
> [1] http://lkml.org/lkml/2006/4/1/28
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
> ---
>
>  Documentation/feature-removal-schedule.txt |    8 --------
>  include/linux/ioport.h                     |    2 +-
>  kernel/resource.c                          |    2 --
>  3 files changed, 1 insertion(+), 11 deletions(-)
>
> --- linux-2.6.17-rc1-mm2-full/Documentation/feature-removal- 
> schedule.txt.old	2006-04-10 20:52:23.000000000 +0200
> +++ linux-2.6.17-rc1-mm2-full/Documentation/feature-removal- 
> schedule.txt	2006-04-10 20:52:36.000000000 +0200
> @@ -72,14 +72,6 @@
>
>  ---------------------------
>
> -What:	remove EXPORT_SYMBOL(insert_resource)
> -When:	April 2006
> -Files:	kernel/resource.c
> -Why:	No modular usage in the kernel.
> -Who:	Adrian Bunk <bunk@stusta.de>
> -
> ----------------------------
> -
>  What:	PCMCIA control ioctl (needed for pcmcia-cs [cardmgr, cardctl])
>  When:	November 2005
>  Files:	drivers/pcmcia/: pcmcia_ioctl.c
> --- linux-2.6.17-rc1-mm2-full/include/linux/ioport.h.old	2006-04-10  
> 20:52:46.000000000 +0200
> +++ linux-2.6.17-rc1-mm2-full/include/linux/ioport.h	2006-04-10  
> 20:52:55.000000000 +0200
> @@ -95,7 +95,7 @@
>  extern int request_resource(struct resource *root, struct resource  
> *new);
>  extern struct resource * ____request_resource(struct resource  
> *root, struct resource *new);
>  extern int release_resource(struct resource *new);
> -extern __deprecated_for_modules int insert_resource(struct  
> resource *parent, struct resource *new);
> +extern int insert_resource(struct resource *parent, struct  
> resource *new);
>  extern int allocate_resource(struct resource *root, struct  
> resource *new,
>  			     u64 size,
>  			     u64 min, u64 max,
> --- linux-2.6.17-rc1-mm2-full/kernel/resource.c.old	2006-04-10  
> 20:53:04.000000000 +0200
> +++ linux-2.6.17-rc1-mm2-full/kernel/resource.c	2006-04-10  
> 20:53:11.000000000 +0200
> @@ -381,8 +381,6 @@
>  	return result;
>  }
>
> -EXPORT_SYMBOL(insert_resource);
> -
>  /*
>   * Given an existing resource, change its start and size to match the
>   * arguments.  Returns -EBUSY if it can't fit.  Existing children of

