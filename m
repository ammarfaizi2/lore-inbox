Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266436AbUFQJai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266436AbUFQJai (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 05:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266441AbUFQJai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 05:30:38 -0400
Received: from mail.dif.dk ([193.138.115.101]:16775 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S266436AbUFQJag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 05:30:36 -0400
Date: Thu, 17 Jun 2004 11:29:38 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, James Simmons <jsimmons@infradead.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix warning in fbmem.c
In-Reply-To: <Pine.GSO.4.58.0406171015270.21503@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.56.0406171128250.12749@jjulnx.backbone.dif.dk>
References: <8A43C34093B3D5119F7D0004AC56F4BC082C7F93@difpst1a.dif.dk>
 <Pine.GSO.4.58.0406171015270.21503@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2004, Geert Uytterhoeven wrote:

> On Thu, 17 Jun 2004, Jesper Juhl wrote:
> > Here are two proposed patches to fix the following warning in fbmem.c :
> > drivers/video/fbmem.c:933: warning: passing arg 1 of `copy_from_user' discards qualifiers from pointer target type
> >
> > The cause of the warning is that the .data member of struct fb_image is of
> > type 'const char *' and copy_from_user() takes a 'void *' as it's first
> > 'to' argument.
> > I see two ways to fix it;
> > a) use a simple cast to hide the warning
> > b) rewrite the code to copy into a buffer pointed to by a non-const
> > pointer, then assign the pointer to cursor.image.data
>
> Here is a variant of b, which avoids the cast and makes cursor.mask const as
> well.
>

> --- linux-2.6.7-rc1/include/linux/fb.h.orig	2004-05-24 11:14:01.000000000 +0200
> +++ linux-2.6.7-rc1/include/linux/fb.h	2004-06-07 22:38:01.000000000 +0200
> @@ -375,7 +375,7 @@ struct fb_cursor {
>  	__u16 set;		/* what to set */
>  	__u16 enable;		/* cursor on/off */
>  	__u16 rop;		/* bitop operation */
> -	char *mask;		/* cursor mask bits */
> +	const char *mask;	/* cursor mask bits */
>  	struct fbcurpos hot;	/* cursor hot spot */
>  	struct fb_image	image;	/* Cursor image */
>  };
>

Nice. I didn't know the code well enough to dare make this change as well.


--
Jesper Juhl <juhl-lkml@dif.dk>
