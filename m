Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268000AbUJQSfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268000AbUJQSfM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 14:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268223AbUJQSfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 14:35:11 -0400
Received: from witte.sonytel.be ([80.88.33.193]:34542 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S268000AbUJQSey (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 14:34:54 -0400
Date: Sun, 17 Oct 2004 20:34:47 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Joe Perches <joe@perches.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/8] replacing/fixing printk with pr_debug/pr_info in
 arch/i386 - intro
In-Reply-To: <1098037422.20419.21.camel@localhost.localdomain>
Message-ID: <Pine.GSO.4.61.0410172033100.27743@waterleaf.sonytel.be>
References: <1098031764.3023.45.camel@pdp11.tsho.org> <20041017161953.GA24810@elte.hu>
 <Pine.GSO.4.61.0410172006060.27743@waterleaf.sonytel.be>
 <1098037422.20419.21.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Oct 2004, Joe Perches wrote:
> On Sun, 2004-10-17 at 20:10 +0200, Geert Uytterhoeven wrote:
> > Iff you ever want to replace the above, make sure to do it like this:
> >     printk_info("Start... ");
> >     ...
> >     printkc_info("Ok!\n");
> > 
> > (with `printkc_info()' being a continuation of `printk_info()'. And do the same
> > for all other KERN_* variations. This would add real value, since the next step
> > is to make the printk{,c}_*() definitions conditionally empty for embedded
> > systems and/or systems with few memory.
> > 
> > Gr{oetje,eeting}s,
> 
> I suggest this is the incorrect usage.
> Start then Continue then End.
> I suppose one could use Continue/End with an implied start
> or simply End (ie:  printk)

Why?

The only things you need to know are
  - what is the printk() level? (so you can conditionally keep it out of the
    binary)
  - which printk() call contains the first part of the line? (so it can prepend
    the correct KERN_* definition)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
