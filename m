Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262856AbTDNI2e (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 04:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262865AbTDNI2e (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 04:28:34 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:33454 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id S262856AbTDNI2d (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 04:28:33 -0400
Date: Mon, 14 Apr 2003 10:39:40 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Paul Mackerras <paulus@samba.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] M68k IDE updates
In-Reply-To: <16025.63003.968553.194791@nanango.paulus.ozlabs.org>
Message-ID: <Pine.GSO.4.21.0304141037410.28305-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Apr 2003, Paul Mackerras wrote:
> Alan Cox writes:
> > This looks the wrong place to fix this problem Geert. The PPC 
> > folks have the same issues with byte order on busses but you
> > won't see ifdefs in the core IDE code for it.
> > 
> > Fix your __ide_mm_insw/ide_mm_outsw macros and the rest happens
> > automatically.
> 
> As I understand it, on some platforms (including some PPC platforms,
> but not powermacs) one needs to byteswap drive ID data but not the
> normal sector data.  Or vice versa.  Whether drive ID data needs
> byte-swapping comes down to how the drive is attached to the bus.  The
> conventions used by other systems that we need to interoperate with
> (e.g. other OSes, or just older kernels) determine whether normal
> sector data needs byte-swapping or not.
> 
> Since __ide_mm_insw doesn't get told whether it is transferring normal
> sector data or drive ID data, it can't necessarily do the right thing
> in both situations.

Indeed. Ataris and Q40/Q60s have byteswapped IDE busses, but they expect
on-disk data to be that way, for compatibility with e.g. TOS.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

