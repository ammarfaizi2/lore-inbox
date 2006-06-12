Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751917AbWFLMZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbWFLMZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 08:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbWFLMZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 08:25:59 -0400
Received: from witte.sonytel.be ([80.88.33.193]:12459 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1751917AbWFLMZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 08:25:58 -0400
Date: Mon, 12 Jun 2006 14:25:44 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: [Linux-fbdev-devel] [PATCH 0/7] Detaching fbcon
In-Reply-To: <448D5B4F.5080504@gmail.com>
Message-ID: <Pine.LNX.4.62.0606121424300.7668@pademelon.sonytel.be>
References: <44856223.9010606@gmail.com> <448C19D7.5010706@t-online.de>
 <448C83AD.9060200@gmail.com> <448D1C9E.7050606@t-online.de> <448D5B4F.5080504@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2006, Antonino A. Daplas wrote:
> Knut Petersen wrote:
> > I suggest to add the fb_unbinding / fb_binding fbops and to only allow
> > unbinding if we know that it will not leave the video hardware in a state
> > that is unusable for proper operation.
> > 
> > If there is nothing to be done inside those two fbops, they simply return
> > 0.
> > 
> > Other framebuffer drivers set the hardware to a state that is completely
> > unusable by a textmode console and that is incompatible with X. These
> > might need to know if X is active to decide if unbinding makes any sense at
> > that specific moment.
> 
> This is very ugly. Drivers should not care whether it's safe to load or
> unload, unbind or bind, or whether a specific application is open or not.
> This is not their job, this should be the job of the higher layer or an
> arbiter.  And yes, the state of graphics is currently ugly, witness the
> very long threads on how to to make everything work together.
> 
> Right now, the only thing I can claim is that trying to do an fbdev
> operation while inside X will result in undefined, if not fatal behavior.
> Don't do it. And no matter how many ugly hacks and workarounds we add
> for the framebuffer layer, this will always be true.

The main problem is that there are too many drivers for the same hardware:
  - vgacon
  - fbdev
  - X

All of them want to control the hardware, and all of them make assumptions
about its state...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
