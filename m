Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262260AbUKBOaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbUKBOaq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 09:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbUKBO3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 09:29:46 -0500
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:24845 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S263008AbUKBO1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 09:27:24 -0500
Date: Tue, 2 Nov 2004 14:26:31 +0000 (GMT)
From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
To: adaplas@pol.net
cc: linux-fbdev-devel@lists.sourceforge.net, jsimmons@infradead.org,
       geert@linux-m68k.org, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org,
       wli@holomorphy.com
Subject: Re: [Linux-fbdev-devel] Help re Frame Buffer/Console Problems
In-Reply-To: <200411020746.27871.adaplas@hotpop.com>
Message-ID: <Pine.LNX.4.10.10411021416590.4390-100000@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have already hard wired the fg and bg colours. I have got to the point 
where I am checking the cfbimgblt code where it converts the mono bit font
image data to the 8bpp pseudo colour screen image data. It is looking
like there may be a problem with sign extension at this level as the
pixel value being used apears to be 255.

I have changed a char *pt to a u8 *pt to see if this helps.

Regards
	Mark Fortescue.

On Tue, 2 Nov 2004, Antonino A. Daplas wrote:

> On Tuesday 02 November 2004 01:32, Mark Fortescue wrote:
> > Hi all,
> >
> > Thanks for the info Antonino. I see you spotted my typing error. Yes it is
> > the 2.6.10-rc1-bk6 kernel. The oter error is the 2.2.8.1. It should be
> > 2.6.8.1.
> >
> > The cgthree driver does not currently set up the all->info.var.red,
> > all->info.var.green or all->info.var.blue structures. Putting a value of 8
> > in the length field of these structures (correct for the cgthree) does get
> > me my logo back but I am still getting black on black text. It makes it
> > very difficult to read. It is begining to look like there is something
> > werid going on with the colour pallet stuf for PSEUDO_COLOUR.
> >
> 
> I doubt that the problem is at the driver layer since you were able to
> see the logo. It's probably higher up.
> 
> Try this mod, hardwire the foreground color to 0x07.
> 
> Edit drivers/video/console/bitblit.c:bit_putcs() and change this line:
> 
> image.fg_color = fg;
> image.bg_color = bg;
> 
> to
> 
> image.fg_color = 0x07070707;
> image.bg_color = 0x0;
> 
> You can also try the reverse:
> 
> image.fg_color = 0x0;
> image.bg_color = 0x07070707
> 
> If you get visible text, the problem is either in fbcon.c or vt.c.
> 
> Tony
> 
> 

