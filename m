Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283358AbRK2R7e>; Thu, 29 Nov 2001 12:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283359AbRK2R7Y>; Thu, 29 Nov 2001 12:59:24 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:58122 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S283358AbRK2R7J>;
	Thu, 29 Nov 2001 12:59:09 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: James Simmons <jsimmons@transvirtual.com>
Date: Thu, 29 Nov 2001 18:58:24 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] Hooks for new fbdev api
CC: linux-fbdev-devel@lists.sourceforge.net,
        linuxconsole-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org
X-mailer: Pegasus Mail v3.40
Message-ID: <A9484F0657A@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Nov 01 at 9:35, James Simmons wrote:
> +struct fbcursor {
> +   __u16 set;      /* what to set */
> +   __u16 enable;/* cursor on/off */
> +   struct fbcurpos pos;/* cursor position */
> +   struct fbcurpos hot;/* cursor hot spot */
> +   struct fb_cmap cmap;/* color map info */

>From what you wrote I assume that cmap.start must be 0 and cmap.len
some length, and it must be always set, as otherwise it is impossible
to guess image/mask depth from it.

> +   struct fbcurpos size;/* cursor bit map size */
> +   char *image;/* cursor image bits */
> +   char *mask;/* cursor mask bits */

And maybe it is better to go with Geert idea? Remove mask, and
make image just really use cmap - if cmap entry is 100% transparent,
it is like that bit(mask) == 1, and add one more field for inverted
cmap entry. As no driver can use image/mask immediately anyway, there
is no big problem.

I hope that mask/image format is going to be specified somewhere
more exactly - like whether each image/mask line consist of 
non-fractional number of bytes, what happens if cmap has 8 entries 
and other legal, but hard to implement, features...
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
