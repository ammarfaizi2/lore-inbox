Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVCIFBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVCIFBb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 00:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVCIFBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 00:01:31 -0500
Received: from smtp-out.hotpop.com ([38.113.3.61]:47778 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S261153AbVCIFB3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 00:01:29 -0500
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: linux-fbdev-devel@lists.sourceforge.net,
       Michal Januszewski <spock@gentoo.org>, linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] [announce 0/7] fbsplash - The Framebuffer Splash
Date: Wed, 9 Mar 2005 13:01:15 +0800
User-Agent: KMail/1.5.4
Cc: linux-fbdev-devel@lists.sourceforge.net
References: <20050308015731.GA26249@spock.one.pl>
In-Reply-To: <20050308015731.GA26249@spock.one.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503091301.15832.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 March 2005 09:57, Michal Januszewski wrote:
> Fbsplash - The Framebuffer Splash - is a feature that allows displaying
> images in the background of consoles that use fbcon. The project is
> partially descended from bootsplash.
>
> Unlike bootsplash, fbsplash has no in-kernel image decoder. Picture
> decompression is handled by a userspace helper which provides raw image
> data to the kernel. There is also no support for things like the silent
> mode and progress bars, as these are best handled by userspace programs.
>

If splash support is really, really, really wanted in the kernel, it's probably better
to just add minimal Overlay support for the framebuffer.  If overlay is added, it
won't be necessary to modify fbcon and the drivers, just core fb.

We can have 3 levels of support.  In it's most basic form, we have the display
layer (what get's shown in your monitor) plus 2 buffers in system ram, the
primary layer (where the console output is written) and the overlay, the
static image in raw framebuffer format.  Then we replace the basic
framebuffer operations (imageblit, fillrect and copyarea) with ones that
will read the contents of both buffers, do basic raster ops (colorkey, alpha
blend, etc) before writing to the actual display buffer.

The next level is both buffers are in video ram. This will need basic driver 
support, at least to subdivide the framebuffer memory to display, primary,
and overlay.  We can use the drivers accelerated drawing functions to
write to the primary layer, then use software to write the processed
contents to the display layer.

Finally, we can enable full hardware video overlay. 

Tony


