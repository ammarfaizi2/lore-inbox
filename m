Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbUDYAzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbUDYAzY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 20:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbUDYAzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 20:55:24 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:34570 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262008AbUDYAzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 20:55:23 -0400
Date: Sun, 25 Apr 2004 01:55:15 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Alex Stewart <alex@foogod.com>
cc: linux-fbdev-devel@lists.sourceforge.net, <geert@linux-m68k.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] neofb patches
In-Reply-To: <60004.64.139.3.221.1082827760.squirrel@www.foogod.com>
Message-ID: <Pine.LNX.4.44.0404250138120.15965-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Umm, I would really appreciate it if you didn't silently leave out bits of
> my patches and then just say "I merged your patches".  It took me a little
> bit to figure out that the reason panning now isn't used for fbconsole
> scrolls is because you just didn't bother to put that part of my patch in.
> 
> Is there some reason you left out the following piece of my modedb patch?
> 
> +       /* Turn on panning for console scroll by default */
> +       info->var.yres_virtual = 30000;
> +       info->var.accel_flags |= FB_ACCELF_TEXT;
> +       if (neofb_check_var(&info->var, info))
> +               goto err_map_video;

   The reason is because fb_find_mode calls check_var for us. No reason to 
call it twice. The large yres_virtual being 30000 that is not needed any 
longer. The accel flag is set in neofb_check_var. The current test is

if (var->bits_per_pixel >= 24 || !par->neo2200)
	var->accel_flags &= ~FB_ACCEL_TEXT;

Should we drop the bpp >= 24 test? Do you observe this problem at all 
depths.






