Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265241AbUFOTqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265241AbUFOTqZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 15:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265890AbUFOTqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 15:46:25 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19205 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265241AbUFOTqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 15:46:22 -0400
Date: Tue, 15 Jun 2004 20:46:16 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Tom Rini <trini@kernel.crashing.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 0/5] kbuild
Message-ID: <20040615204616.E7666@flint.arm.linux.org.uk>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>, Wolfgang Denk <wd@denx.de>
References: <20040614204029.GA15243@mars.ravnborg.org> <20040615154136.GD11113@smtp.west.cox.net> <20040615174929.GB2310@mars.ravnborg.org> <20040615190951.C7666@flint.arm.linux.org.uk> <20040615191418.GD2310@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040615191418.GD2310@mars.ravnborg.org>; from sam@ravnborg.org on Tue, Jun 15, 2004 at 09:14:18PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 09:14:18PM +0200, Sam Ravnborg wrote:
> On Tue, Jun 15, 2004 at 07:09:51PM +0100, Russell King wrote:
> > > 
> > > Compared to the original behaviour where the all: target picked the default
> > > target for a given architecture, this patch adds the following:
> > 
> > This isn't the case on ARM.  I've always told people 'make zImage'
> > or 'make Image'.  I've never told people to use just 'make' on its
> > own - in fact, I've never used 'make' on its own with the kernel.
> 
> Why not?

It's something we've never done - we've always traditionally told people
to use 'make zImage' or whatever, because then they know what they're
getting.

See: http://www.arm.linux.org.uk/docs/kerncomp.shtml

This works for no matter what kernel version you're building, whether
its pre or post new kbuild.

> Letting the build system select a default target is often a
> better choice than some random choice by a developer.

No.  Only the developer knows what boot loader he's going to use on
the board, he knows what modifications he's made, he knows how he's
configured it.  Therefore he knows full well what he needs from the
kernel.

> Not discussing different platforms, only discussing kernel targets.
> For arm I see the following:
> zImage, Image bootpImage uImage
> And some test targets: zImg, Img, bp, i, zi

For ARM, there are: zImage and Image.  bootpImage is an add-on extra
which requires extra parameters to be passed in order to use - and
is our fix for the day that NFS requires external programs (though
it seems to have been superseded by initramfs now, so will probably
go away soon.)

I'm considering dropping the test targets - they were useful for me
personally back in the days when I wasn't using a script-based kernel
build system.  Now that all my kernel builds are scripted, those
targets aren't used anymore and can go.

That leaves uImage which I've discussed already in a previous mail,
and various other targets which I've historically said I won't merge
(as I detailed in a previous mail - srec, gzipped vmlinux, gzipped
Image, etc.)

> Maybe Wolgang can jump in here - I do not know why mkimage is needed.
> But I do like to have it present for convinience.
> It is btw called mkuboot.sh in scripts/ to better say what it does.

I'll let you read mkuboot.sh - you'll find that it's just a wrapper
script to moan if you use mkuboot.sh and you don't have mkimage
installed.

I've no idea what mkimage actually does, but from the scant comments
in mkuboot.sh, it seems to package up into a "U-Boot image".

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
