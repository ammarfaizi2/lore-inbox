Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267679AbTCFBGj>; Wed, 5 Mar 2003 20:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267686AbTCFBGj>; Wed, 5 Mar 2003 20:06:39 -0500
Received: from pine.compass.com.ph ([202.70.96.37]:63809 "HELO
	pine.compass.com.ph") by vger.kernel.org with SMTP
	id <S267679AbTCFBGi>; Wed, 5 Mar 2003 20:06:38 -0500
Subject: Re: [Linux-fbdev-devel] Re: FBdev updates.
From: Antonino Daplas <adaplas@pol.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0303052023110.27760-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0303052023110.27760-100000@phoenix.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1046913418.1206.189.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Mar 2003 09:18:29 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-06 at 04:23, James Simmons wrote:
> 
> > >   And one (or two...) generic questions: why is not pseudo_palette
> > > u32* pseudo_palette, or even directly u32 pseudo_palette[17] ?
> > 
> > Yes, all drivers should treat the pseudo_palette as u32* anyway, so why
> > not change pseudo-palette from void* to u32*?
> 
> See other email.
> 
> > > And why we do not fill this pseudo_palette with
> > > i * 0x01010101U for 8bpp pseudocolor and i * 0x11111111U for 4bpp
> > > pseudocolor? This allowed me to remove couple of switches and tests
> > > from acceleration fastpaths (and from cfb_imageblit and cfb_fillrect,
> > > but I did not changed these two in my benchmarks below).
> > 
> > I also agree for a different reason.  Cards with unconventional formats
> > (such as monochrome at 8 bpp - 0 for black , 0xff for white) will not
> > work with the current code.
> 
> Isn't that the job of setcolreg?
> 
setcolreg does that for directcolor and truecolor modes, because they're
the only ones that uses the pseudo_palette.  See all driver codes, the
pseudo_palette is never initialized if in pseudo_color.

The purpose of the pseudo_palette is to enable to write pixels to the
framebuffer without knowing the color format at all.  So, if you have
monochrome, then black is 0 and white is 1.  But for monochrome 8bpp,
black is 0 and white is 0xff. 

fbcon will send 0's and 1's, thus 0 and 1 will be written to the
framebuffer.  If the drawing functions referred to the pseudo_palette,
whatever the visual format, then 0 and 0xff will be written, as it
should be.

Tony
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
> for complex code. Debugging C/C++ programs can leave you feeling lost and 
> disoriented. TotalView can help you find your way. Available on major UNIX 
> and Linux platforms. Try it free. www.etnus.com
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel


