Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbVCIGCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVCIGCb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 01:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVCIGCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 01:02:30 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:17751 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261548AbVCIGCZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 01:02:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=pMgOMK1I+iNoZ9AUZMMmdBs0Zym3ur7HGkllMTmTICe8nrZ7cepNs2EPss/Yw+ZeJm4Ddt6/JQtNxNw6+5FOvnTVzNzCs3ZTRROrNrOUd4IU1FJwGfI6J9taa8XL88KVVBXnf/ALYL8FC1VaFyIjLYxVesaxxOXdISj35Fijqvs=
Message-ID: <9e473391050308220218cc26a3@mail.gmail.com>
Date: Wed, 9 Mar 2005 01:02:25 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] [announce 0/7] fbsplash - The Framebuffer Splash
Cc: Michal Januszewski <spock@gentoo.org>, linux-kernel@vger.kernel.org,
       "Antonino A. Daplas" <adaplas@hotpop.com>
In-Reply-To: <200503091301.15832.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050308015731.GA26249@spock.one.pl>
	 <200503091301.15832.adaplas@hotpop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2005 13:01:15 +0800, Antonino A. Daplas
<adaplas@hotpop.com> wrote:
> On Tuesday 08 March 2005 09:57, Michal Januszewski wrote:
> > Fbsplash - The Framebuffer Splash - is a feature that allows displaying
> > images in the background of consoles that use fbcon. The project is
> > partially descended from bootsplash.
> >
> > Unlike bootsplash, fbsplash has no in-kernel image decoder. Picture
> > decompression is handled by a userspace helper which provides raw image
> > data to the kernel. There is also no support for things like the silent
> > mode and progress bars, as these are best handled by userspace programs.
> >
> 
> If splash support is really, really, really wanted in the kernel, it's probably better
> to just add minimal Overlay support for the framebuffer.  If overlay is added, it
> won't be necessary to modify fbcon and the drivers, just core fb.
> 
> We can have 3 levels of support.  In it's most basic form, we have the display
> layer (what get's shown in your monitor) plus 2 buffers in system ram, the
> primary layer (where the console output is written) and the overlay, the
> static image in raw framebuffer format.  Then we replace the basic
> framebuffer operations (imageblit, fillrect and copyarea) with ones that
> will read the contents of both buffers, do basic raster ops (colorkey, alpha
> blend, etc) before writing to the actual display buffer.
> 
> The next level is both buffers are in video ram. This will need basic driver
> support, at least to subdivide the framebuffer memory to display, primary,
> and overlay.  We can use the drivers accelerated drawing functions to
> write to the primary layer, then use software to write the processed
> contents to the display layer.
> 
> Finally, we can enable full hardware video overlay.

Another idea would be to build a console is user space. Think of it as
a full screen xterm. A user space console has access to full hardware
acceleration using the DRM interface.

-- 
Jon Smirl
jonsmirl@gmail.com
