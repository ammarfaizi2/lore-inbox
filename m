Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267132AbSLKMPX>; Wed, 11 Dec 2002 07:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267133AbSLKMOd>; Wed, 11 Dec 2002 07:14:33 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:57235 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S267132AbSLKMNG>;
	Wed, 11 Dec 2002 07:13:06 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: James Simmons <jsimmons@infradead.org>
Date: Wed, 11 Dec 2002 13:20:34 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [TRIVIAL PATCH] FBDEV: Small impact patch for fbdev
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       adaplas@pol.net
X-mailer: Pegasus Mail v3.50
Message-ID: <A042D564F44@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Dec 02 at 21:59, James Simmons wrote:

> Fixed. Actually I used the following code.
> 
> int fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
> {
>         int xoffset = var->xoffset;
>         int yoffset = var->yoffset;
>         int err;
> 
>         if (xoffset < 0 || yoffset < 0 || info->fbops->fb_pan_display ||

I'm probably missing something important, but do not you want
                                           !info->fbops->fb_pan_display
instead?
                                                            Petr
                                                                                                       
>             xoffset + info->var.xres > info->var.xres_virtual ||
>             yoffset + info->var.yres > info->var.yres_virtual)
>                 return -EINVAL;
>         if ((err = info->fbops->fb_pan_display(var, info)))
>                 return err;
>         info->var.xoffset = var->xoffset;
>         info->var.yoffset = var->yoffset;
>         if (var->vmode & FB_VMODE_YWRAP)
