Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262089AbSJNSoh>; Mon, 14 Oct 2002 14:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262093AbSJNSog>; Mon, 14 Oct 2002 14:44:36 -0400
Received: from [203.167.79.9] ([203.167.79.9]:22542 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S262089AbSJNSof>; Mon, 14 Oct 2002 14:44:35 -0400
Subject: Re: [Linux-fbdev-devel] fbdev changes.
From: Antonino Daplas <adaplas@pol.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0210131318420.5997-100000@maxwell.earthlink.net>
References: <Pine.LNX.4.33.0210131318420.5997-100000@maxwell.earthlink.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1034621143.571.53.camel@daplas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 
Date: 15 Oct 2002 02:47:02 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-14 at 04:27, James Simmons wrote:
[...]
> 
> Second change!! We need a uiversal cursor api. I purposed some time ago a
> api but nothing happend.I like to resolve this final part to remove th
> last bit of console crude from the fbdev layer.
> 
> The api I suggested was :
> 
> 
> /*
>  * hardware cursor control
>  */
> 
> #define FB_CUR_SETCUR   0x01
> #define FB_CUR_SETPOS   0x02
> #define FB_CUR_SETHOT   0x04
> #define FB_CUR_SETCMAP  0x08
> #define FB_CUR_SETSHAPE 0x10
> #define FB_CUR_SETALL   0x1F
> 
> struct fbcurpos {
>         __u16 x, y;
> };
> 
> struct fbcursor {
>         __u16 set;              /* what to set */
>         __u16 enable;           /* cursor on/off */
>         struct fbcurpos pos;    /* cursor position */
>         struct fbcurpos hot;    /* cursor hot spot */
>         struct fb_cmap cmap;    /* color map info */
>         struct fbcurpos size;   /* cursor bit map size */
>         char *image;            /* cursor image bits */
>         char *mask;             /* cursor mask bits */
> };
> 
> If you have any suggestion please post you purpose struct. Thank you.

Can you clarify the usage of the above?  Assuming the console cursor is
monochrome, half-height, and fontsize is 8x16, how would the structure
be filled up?

We will also need a field for the bit operation (xor, solid, trans, etc)
as suggested by Petr, at least for monochrome.

Finally, another field for the font bitmap that is overlying the cursor
may be needed.  Only for the console and a monochrome cursor.  This way,
the driver can manually do the bit operation if the hardware is
incapable of doing so.

If I'm to guess at the structure usage (in console):

set - which of the fbcursor fields have changed
enable - make cursor visible/invisible
hot - how will this be used?  
size - is this fontsize or the actual cursor size?
image - bitmap where all bits are set to 1?
mask - does this correlate with the shape of the cursor or with the
underlying font bitmap?

image and mask has the same dimensions (fbcursor.size)?

Tony




