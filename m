Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965277AbWJCHEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965277AbWJCHEw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 03:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965350AbWJCHEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 03:04:52 -0400
Received: from witte.sonytel.be ([80.88.33.193]:16089 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S965277AbWJCHEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 03:04:51 -0400
Date: Tue, 3 Oct 2006 09:04:38 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>, devel@laptop.org
Subject: Re: [Linux-fbdev-devel] [PATCH] video: Get the default mode from
 the right database
In-Reply-To: <20061002225738.GD7716@cosmic.amd.com>
Message-ID: <Pine.LNX.4.62.0610030901070.28197@pademelon.sonytel.be>
References: <20061002225738.GD7716@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Oct 2006, Jordan Crouse wrote:
> fb_find_mode() is behaving in an non-intuitive way.  When I specify my
> own video mode database, and no default mode, I would have expected it
> to assume the first mode in my database as the default mode.  Instead, it
> uses the built in database:
> 
> > if (!db) {
> >     db = modedb;
> >     dbsize = ARRAY_SIZE(modedb);
> > }
> > if (!default_mode)
> >     default_mode = &modedb[DEFAULT_MODEDB_INDEX];
> 
> Personally, I think this is incorrect - if an alternate database is
> specified, it should be always using that.  Patch is attached.

> --- a/drivers/video/modedb.c
> +++ b/drivers/video/modedb.c
> @@ -506,7 +506,7 @@ int fb_find_mode(struct fb_var_screeninf
>  	dbsize = ARRAY_SIZE(modedb);
>      }
>      if (!default_mode)
> -	default_mode = &modedb[DEFAULT_MODEDB_INDEX];
> +	default_mode = &db[DEFAULT_MODEDB_INDEX];
>      if (!default_bpp)
>  	default_bpp = 8;

Although currently DEFAULT_MODEDB_INDEX is defined to be 0, perhaps we need a
more rigorous check now it may apply to the custom video mode database?
Probably you always want the first mode of your custom video mode database to
be the default?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
