Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266684AbUI0Lf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266684AbUI0Lf4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 07:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266687AbUI0Lf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 07:35:56 -0400
Received: from witte.sonytel.be ([80.88.33.193]:1710 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266684AbUI0Lfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 07:35:54 -0400
Date: Mon, 27 Sep 2004 13:35:46 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Bernd Petrovitsch <bernd@firmix.at>
cc: Jochen Friedrich <jochen@scram.de>,
       "Christian T. Steigies" <cts@debian.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: sprintf -> strcpy (was: Re: gcc-3.4)
In-Reply-To: <1096284437.25427.25.camel@tara.firmix.at>
Message-ID: <Pine.GSO.4.61.0409271334240.17228@waterleaf.sonytel.be>
References: <20040925145454.GA16191@skeeve> <20040925221427.GA30105@skeeve>
 <Pine.LNX.4.58.0409262049380.1809@localhost> <Pine.GSO.4.61.0409271315230.15815@waterleaf.sonytel.be>
 <1096284437.25427.25.camel@tara.firmix.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sep 2004, Bernd Petrovitsch wrote:
> On Mon, 2004-09-27 at 13:17 +0200, Geert Uytterhoeven wrote:
> > (CC'ing lkml)
> > 
> > On Sun, 26 Sep 2004, Jochen Friedrich wrote:
> > > > Or maybe it is the binutils? After downgrading to 2.14 from a previous
> > > > toolchain source, I could build linux-2.6.8 with gcc-3.4.
> > > 
> > > I'm using binutils 2.15 and gcc 3.4.2 on Alpha to cross compile 2.6. All i
> > > noticed is that the compiler optimizes sprintf(x,"%s",y) to strcpy(x,y)
> > > which then fails to link or causes unresolved externals because strcpy is
> > > an inline function on m68k. The fix is to do the replacement in the
> > > source, like here:
> > 
> > I remember seeing a similar discussion on lkml about some other automatic
> > replacements a while ago, but I cannot remember the details...
> 
> Do you mean the strncpy() -> strlcpy() conversion which leads to
> information leaks from kernel to user-space im several cases (and Alan
> cox fixed the wrong replacements in the netword drivers IIRC).

No, that was a manual conversion.

IIRC, it was about gcc replacing strcpy() by memcpy() if the string was
constant, or something like that. And it broke the PPC boot code due to the
RELOC()s.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
