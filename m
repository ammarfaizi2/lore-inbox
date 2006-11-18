Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754385AbWKRKjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754385AbWKRKjq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 05:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754391AbWKRKjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 05:39:46 -0500
Received: from posti5.jyu.fi ([130.234.4.34]:48262 "EHLO posti5.jyu.fi")
	by vger.kernel.org with ESMTP id S1754368AbWKRKjp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 05:39:45 -0500
Date: Sat, 18 Nov 2006 12:39:07 +0200 (EET)
From: Tero Roponen <teanropo@jyu.fi>
X-X-Sender: teanropo@jalava.cc.jyu.fi
To: Andrew Morton <akpm@osdl.org>
cc: James Simmons <jsimmons@infradead.org>,
       linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] fb: modedb uses wrong default_mode
In-Reply-To: <20061117124013.b6e4183d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0611181235490.22722@jalava.cc.jyu.fi>
References: <Pine.LNX.4.64.0611151933070.12799@jalava.cc.jyu.fi>
 <20061115152952.0e92c50d.akpm@osdl.org> <20061115234456.GB3674@cosmic.amd.com>
 <Pine.LNX.4.64.0611171919090.9851@pentafluge.infradead.org>
 <20061117124013.b6e4183d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2006, Andrew Morton wrote:
> 
> Here's the current version of this monster patch:
> 
> From: Jordan Crouse <jordan.crouse@amd.com>
> 
> If no default mode is specified, it should be grabbed from the supplied
> database, not the default one.
> 
> [teanropo@jyu.fi: fix it]
> [akpm@osdl.org: simplify it]
> [akpm@osdl.org: remove pointless DEFAULT_MODEDB_INDEX]
> Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: "Antonino A. Daplas" <adaplas@pol.net>
> Signed-off-by: Tero Roponen <teanropo@jyu.fi>
> Cc: James Simmons <jsimmons@infradead.org>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/video/modedb.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff -puN drivers/video/modedb.c~video-get-the-default-mode-from-the-right-database drivers/video/modedb.c
> --- a/drivers/video/modedb.c~video-get-the-default-mode-from-the-right-database
> +++ a/drivers/video/modedb.c
> @@ -34,8 +34,6 @@ const char *global_mode_option;
>       *  Standard video mode definitions (taken from XFree86)
>       */
>  
> -#define DEFAULT_MODEDB_INDEX	0
> -
>  static const struct fb_videomode modedb[] = {
>      {
>  	/* 640x400 @ 70 Hz, 31.5 kHz hsync */
> @@ -505,8 +503,10 @@ int fb_find_mode(struct fb_var_screeninf
>  	db = modedb;
>  	dbsize = ARRAY_SIZE(modedb);
>      }
> +
>      if (!default_mode)
> -	default_mode = &modedb[DEFAULT_MODEDB_INDEX];
> +	default_mode = &db[0];
> +
>      if (!default_bpp)
>  	default_bpp = 8;
>  
> _

I'm using neofb and this Works For Me (TM).

Thanks,
Tero Roponen
