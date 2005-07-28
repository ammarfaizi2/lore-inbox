Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbVG1QeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVG1QeG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 12:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVG1Qbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 12:31:55 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:12180 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261594AbVG1Q3c convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 12:29:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HvuJ4zfwECvWmOG9CdDmbTQ9x5sqOXEW2KRDd6vQyNl+JsfBnRTuJHSLBPzvbiIlRuHkxnZ55nsvcl8MUvCh/wYIq+AXn3G/8TVTMafMX8nUWK5ww8PFohrkkXzOEC55JOVH3exHEX+cRhZLc6jjWf46pX0qx4qnnzhryvoD5qM=
Message-ID: <9e473391050728092936794718@mail.gmail.com>
Date: Thu, 28 Jul 2005 12:29:21 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: colormap fixes
Cc: "Antonino A. Daplas" <adaplas@gmail.com>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0507281758080.24391@numbat.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200507280031.j6S0V3L3016861@hera.kernel.org>
	 <Pine.LNX.4.62.0507280952140.24391@numbat.sonytel.be>
	 <9e473391050728060741040424@mail.gmail.com>
	 <42E8F0CD.6070500@gmail.com>
	 <Pine.LNX.4.62.0507281758080.24391@numbat.sonytel.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, 28 Jul 2005, Antonino A. Daplas wrote:
> > Jon Smirl wrote:
> > > On 7/28/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Wed, 27 Jul 2005, Linux Kernel Mailing List wrote:
> > >
> > > There are a couple of ways to fix this.
> > > 1) Add a check to limit use of the sysfs attributes to 256 entries. If
> > > you want more you have to use /dev/fb0 and the ioctl. More is an
> > > uncommon case.
> > > 2) Switch this to a binary parameter. Now you have to use tools like
> > > hexdump instead of cat to work with the data. It was nice to be able
> > > to use cat to see the current map.
> > >
> > > Does anyone have preferences for which way to fix it?
> >
> > Or...
> >
> >  3) Add another file in sysfs which specifies at what index and how many
> > entries will be read or written from or to the cmap. With this additional
> > sysfs file, it should be able to handle any reasonable cmap length, but
> > it will take more than one reading of the color_map file. Another
> > advantage is that the entire color map need not be read or written if
> > only one field needs to be changed.
> >
> > I've attached a test patch.  Let me know what you think.
> 
> I like it! ... But, a disadvantages is that it needs to store state between two
> non-atomic operations. E.g. imagine two processes doing this at the same time.

Two attributes is a big problem with atomicity. If you want access to
the full cmap I would switch to a binary attribute or use the existing
IOCTL.

Note that you can set the entire map with the new patch, you just
can't read it. You can store 1-N entries at any base you want.

> 
> Gr{oetje,eeting}s,
> 
>                                                 Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                                             -- Linus Torvalds
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Jon Smirl
jonsmirl@gmail.com
