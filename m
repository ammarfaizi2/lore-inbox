Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265346AbSJRRaB>; Fri, 18 Oct 2002 13:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265345AbSJRR3E>; Fri, 18 Oct 2002 13:29:04 -0400
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:55429 "EHLO
	snipe.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S265307AbSJRR2n>; Fri, 18 Oct 2002 13:28:43 -0400
Date: Fri, 18 Oct 2002 10:27:59 -0700 (PDT)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Russell King <rmk@arm.linux.org.uk>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHS] fbdev updates.
In-Reply-To: <20021015103833.C9771@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0210181018470.10832-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That's fine for me, but I'd expect other people to find problems with it.
>
> Would it not be better to allow drivers to decide which type of blanking
> they want to use depending on the current parameters set via the set_par
> callback?  Only the drivers themselves know what their fb_blank method is
> capable of performing.

Yes the drivers should always have priority. The other stuff is there
only if the drivers have no power management of any kind. I leave it up to
the driver write to implement a fb_blank function that handles different
cases.

> I think with the above you'll inadvertently encourage drivers to mundge
> the fb_blank function pointer in their set_par method.

Why would you have to mess around with the function pointer. Couldn't you
just set a flag or fill in a hardware dependent struct that defines what
states are possible for hardware power management. Then when fb_blank is
called it uses the information to decide which action to take. I think
this approach is much more powerful than using a single can_soft_blank
flag. I like to get ride of can_soft_blank and allow the driver to decide
on this stuff itself.

> There is also the argument about wanting soft blanking, but hardware power
> saving.

Hm. True unfortunely the fbdev layer lacks handling details like that. The
console system is even worse. This is why a single flag like
can_soft_blank can actually be a limitation.

