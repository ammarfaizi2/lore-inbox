Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269247AbUJQSLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269247AbUJQSLu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 14:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269257AbUJQSLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 14:11:49 -0400
Received: from witte.sonytel.be ([80.88.33.193]:23271 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S269247AbUJQSLm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 14:11:42 -0400
Date: Sun, 17 Oct 2004 20:10:37 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Daniele Pizzoni <auouo@tin.it>,
       kernel-janitors <kernel-janitors@lists.osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/8] replacing/fixing printk with pr_debug/pr_info in
 arch/i386 - intro
In-Reply-To: <20041017161953.GA24810@elte.hu>
Message-ID: <Pine.GSO.4.61.0410172006060.27743@waterleaf.sonytel.be>
References: <1098031764.3023.45.camel@pdp11.tsho.org> <20041017161953.GA24810@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Oct 2004, Ingo Molnar wrote:
> * Daniele Pizzoni <auouo@tin.it> wrote:
> 
> > Hello, I'm going to post a series of small janitorial patches focused on
> > 1) replacing DPRINTK-style macros with pr_debug from kernel.h
> > 2) replacing printk(KERN_INFO ...) with pr_info(...)
> > 3) fixing _obvious_ inconsistencies of printk levels as:
> > 
> > printk(KERN_INFO "Start... ");
> > ...
> > printk("Ok!\n");
> 
> 1) be careful, there is no inconsistency here. It's a printk that doesnt
> end in a "\n" in the first line.

Indeed.

Iff you ever want to replace the above, make sure to do it like this:

    printk_info("Start... ");
    ...
    printkc_info("Ok!\n");

(with `printkc_info()' being a continuation of `printk_info()'. And do the same
for all other KERN_* variations. This would add real value, since the next step
is to make the printk{,c}_*() definitions conditionally empty for embedded
systems and/or systems with few memory.

Gr{oetje,eeting}s,

						Geert

P.S. The naming conventions above are purely hypothetical. I suggest we first
     have a few Holy Wars(tm) about them before settling :-)
--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
