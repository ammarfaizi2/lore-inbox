Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267303AbUJGITU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267303AbUJGITU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 04:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269750AbUJGITU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 04:19:20 -0400
Received: from witte.sonytel.be ([80.88.33.193]:10750 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S267303AbUJGITC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 04:19:02 -0400
Date: Thu, 7 Oct 2004 10:18:51 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Thayne Harbaugh <tharbaugh@lnxi.com>
cc: =?ISO-8859-15?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is
 availlable
In-Reply-To: <1097097771.3845.28.camel@tubarao>
Message-ID: <Pine.GSO.4.61.0410071017020.9319@waterleaf.sonytel.be>
References: <20041005185214.GA3691@wohnheim.fh-wedel.de> <20041006173823.GA26740@kroah.com>
 <20041006180421.GD10153@wohnheim.fh-wedel.de> <20041006181958.GB27300@kroah.com>
 <20041006192335.GH10153@wohnheim.fh-wedel.de> <1097097771.3845.28.camel@tubarao>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1804928587-1097137131=:9319"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-1804928587-1097137131=:9319
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 6 Oct 2004, Thayne Harbaugh wrote:
> On Wed, 2004-10-06 at 21:23 +0200, Jörn Engel wrote:
> > On Wed, 6 October 2004 11:19:58 -0700, Greg KH wrote:
> > > On Wed, Oct 06, 2004 at 08:04:21PM +0200, J?rn Engel wrote:
> > > > On Wed, 6 October 2004 10:38:23 -0700, Greg KH wrote:
> > > > > 
> > > > > Your printk() calls need the proper KERN_* level.
> > > > 
> > > > As does the original one.  Which one would you like for both?
> > > 
> > > KERN_WARNING perhaps?
> > 
> > As in the patch below?
> > 
> > > > > usually do not have a /dev/null this early in the boot process).  Does
> > > > > this mean we should add a /dev/null to the initramfs image, like the
> > > > > /dev/console node we currently have there?
> > > > 
> > > > Yes, that would fix the case.  Is this a problem?
> > > 
> > > I don't have a problem with doing that.
> > 
> > Then please do so. :)
> 
> Take your pick:
> 
> This depends on the initramfs from file patch that is in the mm tree:

[ patch deleted ]

This fixes the standard initamfs. But it still allows you to have a root file
system without /dev/console or /dev/null.

What about letting the kernel open the console without going through
/dev/console? Since the kernel knows /dev/console is the device with major 5
minor 1, why can't it just open (5, 1)? Then we don't need a /dev/console node,
and things will never break.

Same for /dev/null as a fallback.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
---559023410-1804928587-1097137131=:9319--
