Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262884AbVDAUst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbVDAUst (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 15:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262892AbVDAUrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 15:47:47 -0500
Received: from waste.org ([216.27.176.166]:27287 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262886AbVDAUqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:46:34 -0500
Date: Fri, 1 Apr 2005 12:46:30 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clean up kernel messages
Message-ID: <20050401204629.GJ15453@waste.org>
References: <20050401200851.GG15453@waste.org> <20050401122641.7c52eaab.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050401122641.7c52eaab.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2005 at 12:26:41PM -0800, Andrew Morton wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> >
> > This patch tidies up those annoying kernel messages. A typical kernel
> >  boot now looks like this:
> > 
> >  Loading Linux... Uncompressing kernel...
> >  #
> > 
> >  See? Much nicer. This patch saves about 375k on my laptop config and
> >  nearly 100k on minimal configs.
> > 
> 
> heh.  Please take a look at
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0004.2/0709.html, see if
> Graham did anything which you missed.

He's got a bunch of stuff that's not strictly related in there and
stuff I've already dealt with (vprintk and the like) and stuff that's
still forthcoming (panic tweaks, etc.). I also leave in all the APIs
like dmesg, they just no longer do anything.

> One problem was that
> 
> 	printk("foo");
> 
> will still cause the string "foo\0" to appear in the kernel image.  That
> was fixed in later gcc's, but it would be interesting to know which
> compilers get it right.

Haven't encountered this. I think it should be fine for any compiler
that can handle 2.6. This has been in -tiny for nearly a year and a
half and no one's complained.
 
> >  +static inline int printk(const char *s, ...) { return 0; }
> 
> Actually printk() is supposed to return the number of chars which it
> printed.  So if someone is doing:
> 
> 	while (len < 40)
> 		len += printk("something");
> 
> you've gone and made them lock up.
> 
> But I think the number of places where we examine the printk return value
> is near zero.

Well in some sense 0 is the proper return but I suppose this could be
made to return 1. Small enough not break anything, big enough so that
things like the above get unstuck.

-- 
Mathematics is the supreme nostalgia of our time.
