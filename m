Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWDSBGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWDSBGv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 21:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWDSBGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 21:06:51 -0400
Received: from xenotime.net ([66.160.160.81]:37052 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750788AbWDSBGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 21:06:51 -0400
Date: Tue, 18 Apr 2006 18:09:15 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: bunk@stusta.de, akpm@osdl.org, adaplas@pol.net, darrenrjenkins@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] [2.6 patch] fix section mismatch in pm2fb.o
Message-Id: <20060418180915.b67a7917.rdunlap@xenotime.net>
In-Reply-To: <20060418235038.GC11582@stusta.de>
References: <20060418235038.GC11582@stusta.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2006 01:50:38 +0200 Adrian Bunk wrote:

> From: Darren Jenkins <darrenrjenkins@gmail.com>
> 
> There are a couple of Section mismatch problems in drivers/video/pm2fb.o
> 
> WARNING: drivers/video/pm2fb.o - Section mismatch: reference
> to .init.data: from .text after 'pm2fb_set_par' (at offset 0xd5d)
> WARNING: drivers/video/pm2fb.o - Section mismatch: reference
> to .init.data: from .text after 'pm2fb_set_par' (at offset 0xd82)
> 
> They are caused because pm2fb_set_par() uses lowhsync and lowvsync which
> are marked __devinitdata.
> 
> This patch simply removes the __devinitdata annotations.
> 
> Signed-off-by: Darren Jenkins <darrenrjenkins@gmail.com>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
> This patch was already sent on:
> - 9 Apr 2006
> 
> --- 2.6.16-git20/drivers/video/pm2fb.c.orig	2006-04-03 19:08:51.000000000 +1000
> +++ 2.6.16-git20/drivers/video/pm2fb.c	2006-04-03 19:09:34.000000000 +1000
> @@ -73,8 +73,8 @@ static char *mode __devinitdata = NULL;
>   * these flags allow the user to specify that requests for +ve sync
>   * should be silently turned in -ve sync.
>   */
> -static int lowhsync __devinitdata = 0;
> -static int lowvsync __devinitdata = 0;
> +static int lowhsync = 0;
> +static int lowvsync = 0;
>  
>  /*
>   * The hardware state of the graphics card that isn't part of the

I'll ack that since I've already posted it to linux-fbdev-devel
and it's been acked there.

---
~Randy
