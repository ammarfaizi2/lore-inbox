Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131450AbRCNOzF>; Wed, 14 Mar 2001 09:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131444AbRCNOyz>; Wed, 14 Mar 2001 09:54:55 -0500
Received: from aeon.tvd.be ([195.162.196.20]:22752 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S131450AbRCNOyq>;
	Wed, 14 Mar 2001 09:54:46 -0500
Date: Wed, 14 Mar 2001 15:51:36 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] [RFC] fbdev & power management
In-Reply-To: <20010314140550.30460@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.05.10103141550350.25760-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Mar 2001, Benjamin Herrenschmidt wrote:
> >> Either that, or the fbdev would register with PCI (or whatever), _and_
> >> fbcon would too independently. In that scenario, fbcon would only handle
> >> things like disabling the cursor timer, while fbdev's would handle HW
> >> issues. THe only problem is for fbcon to know that a given fbdev is
> >> asleep, this could be an exported per-fbdev flag, an error code, or
> >> whatever. In this case, fbcon can either buffer text input, or fallback
> >> to the cfb working on the backed up fb image (that last thing can be
> >> handled entirely within the fbdev I guess).
> >
> >I'd go for a fallback to dummycon. It's of no use to waste power on creating
> >graphical images of the text console when asleep. And the fallback to
> dummycon
> >is needed anyway while a fbdev is opened (in 2.5.x).
> 
> We do already have the backup image since we need to backup & restore the
> framebuffer content.

Fine. Keep it. But there's no reason to keep on updating it when the screen
contents change. Fbcon can do that when the fbdev goes out of sleep mode.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

