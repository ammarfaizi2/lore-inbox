Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267902AbTCFHxl>; Thu, 6 Mar 2003 02:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267906AbTCFHxl>; Thu, 6 Mar 2003 02:53:41 -0500
Received: from pine.compass.com.ph ([202.70.96.37]:12323 "HELO
	pine.compass.com.ph") by vger.kernel.org with SMTP
	id <S267902AbTCFHxk>; Thu, 6 Mar 2003 02:53:40 -0500
Subject: Re: [Linux-fbdev-devel] Re: FBdev updates.
From: Antonino Daplas <adaplas@pol.net>
To: Sven Luther <luther@dpt-info.u-strasbg.fr>
Cc: James Simmons <jsimmons@infradead.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <20030306073508.GA1734@iliana>
References: <20030303203500.GA2916@vana.vc.cvut.cz>
	<Pine.LNX.4.44.0303052015250.27760-100000@phoenix.infradead.org> 
	<20030306073508.GA1734@iliana>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1046937890.1208.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Mar 2003 16:05:32 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-06 at 15:35, Sven Luther wrote:
> >  
> > >   And one (or two...) generic questions: why is not pseudo_palette
> > > u32* pseudo_palette, or even directly u32 pseudo_palette[17] ?
> > 
> > pseudo_palette was originally designed to be a pointer to some kind of 
> > data for color register programming. For example many PPC graphics cards 
> > have a color register region. Now you could have that point to 
> 
> Does this correspond to the LUT i have in my boards ?
> 
> BTW, what is the point in having a pseudo_palette if you can store
> the colors in the onchip LUT table.
> 

The hardware clut typically stores each color channel separately.  In
software terms, this is akin to struct fb_cmap.  The pseudo_palette, on
the other hand, is a pixel LUT, the contents of which can be directly
written to the framebuffer without it ever knowing the format at all, ie
it does not matter if it's RGB or YUV.  This makes the upper layer
independent of the low-lever driver (at least in terms of colorspace
formats).

Tony

