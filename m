Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129348AbRADSmw>; Thu, 4 Jan 2001 13:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129387AbRADSmm>; Thu, 4 Jan 2001 13:42:42 -0500
Received: from hybrid-024-221-152-185.az.sprintbbd.net ([24.221.152.185]:18926
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S129348AbRADSmd>; Thu, 4 Jan 2001 13:42:33 -0500
Date: Thu, 4 Jan 2001 11:01:51 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-fbdev@vuser.vu.union.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [linux-fbdev] [PATCH] clgenfb on PPC
Message-ID: <20010104110151.H26653@opus.bloom.county>
In-Reply-To: <20010102095133.B26653@opus.bloom.county> <Pine.LNX.4.05.10101031349110.611-100000@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.05.10101031349110.611-100000@callisto.of.borg>; from geert@linux-m68k.org on Wed, Jan 03, 2001 at 01:50:46PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2001 at 01:50:46PM +0100, Geert Uytterhoeven wrote:
> On Tue, 2 Jan 2001, Tom Rini wrote:
> > Hey all.  While going through the 2.4 tree and removing dead CONFIG_xxx's for
> > PPC stuff, I noticed clgenfb still had CONFIG_PREP stuff (which may have
> > partily explained why it no longer worked here).  I've attached a patch, that
> > with another patch to fix some PCI issues on certain machines, gives me a
> > working (so far, can't test heavily yet tho) framebuffer on my powerstack.
> > 
> > Comments?
> 
> To me it looks like most of them depend on `big endian', not on `PReP'.

Possibly...  I don't have or know anyone with the MacPicasso video card,
which is the only other card which may have this. :)

> BTW, doesn't the Cirrus Logic graphics chip have a big endian aperture? I 
> don't like things like green.offset = -3, since it will probably break some
> applications (did you run X?).

I finally got the machine up w/ an nfsroot, and played around a bit.  w/o the
patch (ie isPReP always 0) I don't get a console, but a few lines of pixels in
a row, and random pixels here and there.  Since the original logic was for
PReP only, I'm inclined to think that keeping it at just _machine == _MACH_prep
is the safest way to go, for the moment.

BTW, with or w/o the patch, XF4 (fbdev) wouldn't quite work right.  The logs 
didn't indicate anything wrong, but the monitor went black, like X was 
starting, but never did. (ShadowFB on / off)

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
