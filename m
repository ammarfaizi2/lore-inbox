Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131610AbRCOIWW>; Thu, 15 Mar 2001 03:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131611AbRCOIWM>; Thu, 15 Mar 2001 03:22:12 -0500
Received: from aeon.tvd.be ([195.162.196.20]:38194 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S131610AbRCOIV7>;
	Thu, 15 Mar 2001 03:21:59 -0500
Date: Thu, 15 Mar 2001 09:21:06 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@linux-fbdev.org>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Brad Douglas <brad@neruo.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] [RFC] fbdev & power management
In-Reply-To: <Pine.LNX.4.31.0103141239070.779-100000@linux.local>
Message-ID: <Pine.LNX.4.05.10103150918580.23611-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Mar 2001, James Simmons wrote:
> >>So the fbdev drivers would register PM with fbcon, not PCI, correct?
> >
> >Either that, or the fbdev would register with PCI (or whatever), _and_
> >fbcon would too independently. In that scenario, fbcon would only handle
> >things like disabling the cursor timer, while fbdev's would handle HW
> >issues. THe only problem is for fbcon to know that a given fbdev is
> >asleep, this could be an exported per-fbdev flag, an error code, or
> >whatever. In this case, fbcon can either buffer text input, or fallback
> >to the cfb working on the backed up fb image (that last thing can be
> >handled entirely within the fbdev I guess).

    [...]

>   As for fbcon knowing when it is asleep. Hum. We could have a flags to
> tell it to have text data updates to be placed in the shadow buffer
> (struct vc_datas->vc_screenbuffer) only;

Very simple to implement in the fbdev itself: just replace the drawing ops by
dummy drawing ops.

This can already be done now, by providing a dummy struct display_switch, and
in the future by providing dummy accels.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

