Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131354AbRCNNnb>; Wed, 14 Mar 2001 08:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131365AbRCNNnV>; Wed, 14 Mar 2001 08:43:21 -0500
Received: from aeon.tvd.be ([195.162.196.20]:27328 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S131354AbRCNNnH>;
	Wed, 14 Mar 2001 08:43:07 -0500
Date: Wed, 14 Mar 2001 14:39:57 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Brad Douglas <brad@neruo.com>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] [RFC] fbdev & power management
In-Reply-To: <20010314131756.18036@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.05.10103141429440.24115-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Mar 2001, Benjamin Herrenschmidt wrote:
> >I think registering fbcon as a PM client and doing the above when the
> >fbdev suspend/resume hooks are called should work.  A memory backup is
> >worked on until the resume is run and the backup is restored to the
> >display.
> >
> >So the fbdev drivers would register PM with fbcon, not PCI, correct?
> 
> Either that, or the fbdev would register with PCI (or whatever), _and_
> fbcon would too independently. In that scenario, fbcon would only handle
> things like disabling the cursor timer, while fbdev's would handle HW
> issues. THe only problem is for fbcon to know that a given fbdev is
> asleep, this could be an exported per-fbdev flag, an error code, or
> whatever. In this case, fbcon can either buffer text input, or fallback
> to the cfb working on the backed up fb image (that last thing can be
> handled entirely within the fbdev I guess).

I'd go for a fallback to dummycon. It's of no use to waste power on creating
graphical images of the text console when asleep. And the fallback to dummycon
is needed anyway while a fbdev is opened (in 2.5.x).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

