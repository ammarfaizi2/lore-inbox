Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWHFLGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWHFLGG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 07:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWHFLGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 07:06:06 -0400
Received: from witte.sonytel.be ([80.88.33.193]:27121 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1750744AbWHFLGD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 07:06:03 -0400
Date: Sun, 6 Aug 2006 13:05:20 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Dave Jones <davej@redhat.com>, Andreas Schwab <schwab@suse.de>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: single bit flip detector.
In-Reply-To: <Pine.LNX.4.61.0608020908180.7593@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.62.0608061302470.21620@pademelon.sonytel.be>
References: <20060801184451.GP22240@redhat.com> <1154470467.15540.88.camel@localhost.localdomain>
 <20060801223011.GF22240@redhat.com> <20060801223622.GG22240@redhat.com>
 <20060801230003.GB14863@martell.zuzino.mipt.ru> <20060801231603.GA5738@redhat.com>
 <jebqr4f32m.fsf@sykes.suse.de> <20060801235109.GB12102@redhat.com>
 <20060802001626.GA14689@redhat.com> <Pine.LNX.4.61.0608020908180.7593@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2006, Jan Engelhardt wrote:
> > 		printk(" %02x", (unsigned char)data[offset + i]);
> 
> Remove cast. (Or does it spew a warning message for you?)

No warning, but you still want the cast...

On PPC and ARM that will work fine, since char is unsigned.

But on most other platforms char is signed, and contrary to popular belief,
`%02x' doesn't mean `limit this field to 2 characters', so it would print e.g.
ffffffff instead of ff for -1.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
