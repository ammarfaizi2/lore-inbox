Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbVBWRSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbVBWRSQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 12:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVBWRR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 12:17:56 -0500
Received: from witte.sonytel.be ([80.88.33.193]:15775 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261504AbVBWRQS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 12:16:18 -0500
Date: Wed, 23 Feb 2005 18:15:48 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Paulo Marques <pmarques@grupopie.com>
cc: Matt Mackall <mpm@selenic.com>, Gene Heskett <gene.heskett@verizon.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: OT: Why is usb data many times the cpu hog that firewire is?
In-Reply-To: <421C8193.2050808@grupopie.com>
Message-ID: <Pine.LNX.4.62.0502231813290.4009@numbat.sonytel.be>
References: <200502211216.35194.gene.heskett@verizon.net>
 <200502211325.55013.gene.heskett@verizon.net> <20050221182952.GF6722@wiggy.net>
 <200502211708.27211.gene.heskett@verizon.net> <20050222231000.GA3163@waste.org>
 <421C8193.2050808@grupopie.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2005, Paulo Marques wrote:
> Matt Mackall wrote:
> > [...]
> > JPEG data is DCT of 8x8 pixel chunks. If you can get at that, you can
> > compare the DC terms of each chunk with minimal decoding. Various
> > thumbnailers do this for speed already.
> 
> I really doubt that this would work. It seems to me that you can have very
> different DC terms with very similar results. In other words, even a little
> noise in the picture might produce very different DC terms.

It will cause only a slight difference, noise is mainly visible in the
high-frequence parts.

> Instead of comparing the DC terms, you could compare just the luminance. You
> would have to decompress just half the data for that and you wouldn't need to
> make the YUV->RGB conversion. That would probably save a few cycles.

And since you cannot do `exact' comparisons of the luminance due to noise, but
have to do some averaging, you're back to the previous solution: Hence compare
the DC terms of the luminance. They're the average luminance of the 8x8 chunks.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
