Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266994AbTGTMJO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 08:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266997AbTGTMJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 08:09:14 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:29153
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S266994AbTGTMJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 08:09:13 -0400
Subject: Re: [PATCH] drivers/video/vesafb.c, kernel 2.6.0-test1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roberto Sanchez <rcsanchez97@yahoo.es>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jsimmons@infradead.org, geert@linux-m68k.org, torvalds@osdl.org
In-Reply-To: <20030720021133.53368.qmail@web41804.mail.yahoo.com>
References: <20030720021133.53368.qmail@web41804.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058703699.32239.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 20 Jul 2003 13:21:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-07-20 at 03:11, Roberto Sanchez wrote:
> --- linux-2.6.0-test1.orig/drivers/video/vesafb.c       2003-07-13
> 23:30:36.000000000 -0400
> +++ linux/drivers/video/vesafb.c        2003-07-19 20:30:18.000000000 -0400
> @@ -227,7 +227,7 @@
>         vesafb_defined.xres = screen_info.lfb_width;
>         vesafb_defined.yres = screen_info.lfb_height;
>         vesafb_fix.line_length = screen_info.lfb_linelength;
> -       vesafb_fix.smem_len = screen_info.lfb_size * 65536;
> +       vesafb_fix.smem_len = screen_info.lfb_width * screen_info.lfb_height *
> screen_info.lfb_depth;
>         vesafb_fix.visual   = (vesafb_defined.bits_per_pixel == 8) ?
>                 FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;

This will make some systems crash on boot.

width * height * depth is in bits. You tben need to chop that down to
bytes and maybe allow room for the scroll buffer, but only if its still
under the size of the entire frame buffer.

See the final 2.4 changes

