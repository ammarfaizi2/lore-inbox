Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264372AbTEPINX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 04:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264373AbTEPINX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 04:13:23 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:55000 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264372AbTEPINW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 04:13:22 -0400
Date: Fri, 16 May 2003 10:24:22 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@infradead.org>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: [BK FBDEV] String drawing optimizations.
In-Reply-To: <Pine.LNX.4.44.0305152104400.6330-100000@phoenix.infradead.org>
Message-ID: <Pine.GSO.4.21.0305161018320.3722-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 May 2003, James Simmons wrote:
> > What about getting rid of one-char putc, implementing it in terms of
> > putcs? I'm doing it in matroxfb patches, and nobody complained yet, and
> > with current length of {fbcon,accel}_putc{s,} I was not able to find
> > measurable speed difference between putc and putc through putcs variants.
> 
> Hm. I compressed all the image drawing functions into accel_putcs which is 
> used in many places. I then placed accel_putc() into fbcon_putc(). I could 
> have accel_putcs() called in fbcon_putc(). The advantage is smaller 
> amount of code. The offset is a big more overhead plus a function call. 
> What do people think here?

putc() is almost never called, IIRC. We did our best to combine as much data as
possible and call putcs().

A quick grep showed ->con_putc() is called only in drivers/char/vt.c for:
  - Complementing the pointer position (for gpm)
  - Inserting/deleting single characters
  - Softcursor

I guess the small overhead won't have much influence here.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

