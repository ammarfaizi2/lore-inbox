Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbULAVv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbULAVv1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 16:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbULAVv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 16:51:26 -0500
Received: from smtp-out.hotpop.com ([38.113.3.61]:36327 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S261451AbULAVvN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 16:51:13 -0500
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: linux-fbdev-devel@lists.sourceforge.net, Kronos <kronos@people.it>
Subject: Re: [PATCH 2.4.29-pre1] radeonfb: don't try to ioreamp the entire VRAM [was: Re: [Linux-fbdev-devel] why does radeonfb work fine in 2.6, but not in 2.4.29-pre1?]
Date: Thu, 2 Dec 2004 05:50:38 +0800
User-Agent: KMail/1.5.4
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <20041128184606.GA2537@middle.of.nowhere> <Pine.GSO.4.61.0412011724010.26820@waterleaf.sonytel.be> <20041201203711.GA21008@dreamland.darkstar.lan>
In-Reply-To: <20041201203711.GA21008@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412020550.38324.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 December 2004 04:37, Kronos wrote:
> Il Wed, Dec 01, 2004 at 05:25:52PM +0100, Geert Uytterhoeven ha scritto:
> > > Make fb layer aware of the difference between the ioremap()'ed VRAM and
> > > total available VRAM.
> > > smem_len in struct fb_fix_screeninfo still contains the amount of
> > > physical VRAM (reported to userspace via FBIOGET_FSCREENINFO ioctl) and
> > > the new field mapped_vram contains the amount of VRAM actually
> > > ioremap()'ed by drivers (used in read/write/mmap operations).
> > > Since there was unused padding at the end of struct fb_fix_screeninfo
> > > binary compatibility with userspace utilities is retained.
> > > If mapped_vram is not set it's assumed that the entire framebuffer is
> > > mapped, thus other drivers are unaffected by this patch.
> > >
> > > The patch has been tested by Jurriaan <thunder7@xs4all.nl>.
> > >
> > > Signed-off-by: Luca Tettamanti <kronos@people.it>
> > >
> > > --- a/include/linux/fb.h	2004-11-30 18:30:08.000000000 +0100
> > > +++ b/include/linux/fb.h	2004-11-30 18:33:00.000000000 +0100
> > > @@ -126,7 +126,8 @@
> > >  					/* (physical address) */
> > >  	__u32 mmio_len;			/* Length of Memory Mapped I/O  */
> > >  	__u32 accel;			/* Type of acceleration available */
> > > -	__u16 reserved[3];		/* Reserved for future compatibility */
> > > +	__u32 mapped_vram;		/* Amount of ioremap()'ed VRAM */
> > > +	__u16 reserved[1];		/* Reserved for future compatibility */
> > >  };
> >
> > I don't really like this patch. mapped_vram doesn't matter for user space
> > at all, so it does not belong to fb_fix_screeninfo.
>
> Hmm, it looked sensible to me since it's the max amount of data that
> userspace can read (or write) from /dev/fb%d.

Userspace already use fix.line_length * var.yres_virtual to compute the
amount it can access, which is not necessarily equal to the mapped vram.

> Putting mapped_vram in fb_info would be acceptable?

Yes, that is a more sensible solution.

Tony


