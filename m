Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265874AbUFOT1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265874AbUFOT1q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 15:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265886AbUFOT1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 15:27:46 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:11210 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S265874AbUFOT1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 15:27:42 -0400
Date: Tue, 15 Jun 2004 12:27:40 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/5] kbuild
Message-ID: <20040615192740.GF14528@smtp.west.cox.net>
References: <20040614204029.GA15243@mars.ravnborg.org> <20040615154136.GD11113@smtp.west.cox.net> <20040615174929.GB2310@mars.ravnborg.org> <20040615175453.GD14528@smtp.west.cox.net> <20040615190119.GC2310@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615190119.GC2310@mars.ravnborg.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 09:01:19PM +0200, Sam Ravnborg wrote:

> On Tue, Jun 15, 2004 at 10:54:53AM -0700, Tom Rini wrote:
> > > 
> > > - One has to select the default kernel image only once
> > >   when configuring the kernel.
> > 
> > in the case where 'all' wasn't correct to start with.  And i386 isn't
> > the convincing case here.
> If all was correct in first place this patch does not change behaviour.
> For the embedded space all: is often not the right choice,

That's quite debatable.  'all' does do the right thing on ppc32.

> but for i386 (as you note) all: is always OK (except some rare cases).
> 
> > > - There exist a possibility to add more than half a line of text
> > >   describing individual targets. All relevant information can be
> > >   specified in the help section in the Kconfig file
> > 
> > Honestly, I'm indifferent to this.  This problem is equally, if not
> > better solved by documenting in the board-specific help "and use 'make
> > fooImage for foo firmware"
> 
> For ppc I see nowhere documented what znetboot, vmlinux.sm neither
> zimage is used for.

True.  A patch to add that bit 'o help to the archhelp target would
happily be reviewed.

> In total 5 different kernel targets that is un-documented.
> Adding this patch gives you a good way to document
> them - and room for it.
> For the uimage target, I would at least expect a reference
> to the relevant bootloader, and maybe a few notes about
> the format as well. But there is not room for it on half a line.
> If you know what uImage is, not problem. But for newcomers
> wondering what it is - this is relevant.

What I don't see is why:
'znetboot - Build a zImage and put into /tftpboot/
 uImage - Build an image for U-Boot
 rom.img - Build an image to live on ROM
 srec - Build an SREC image'

etc, isn't sufficient, in the archhelp.  Especially with a note added to
the boards for the corner cases where all isn't correct (foo-board only
supports U-Boot, so you should use uImage to get things working
directly).

> > > - Other programs now have access to what kernel image has been built.
> > >   This is needed when creating kernel packages like rpm.
> > 
> > I suppose this can clean up some of the globbing that might otherwise be
> > done, but I know for a fact that there's been kernel rpms before this :)
>
> Did you actually take a look in the mkspec script?
> If ARCH equals i386 select bzImage, otherwise select vmlinux.
> Not scalable at all - and this type of information should be part
> of the architecture specific files, not the mkspec script.

Without stepping too much into the what belongs in the kernel debate,
you've already got lots of board-specific things to handle, so if it's
already documented.

> > > Where I see this really pay off is for architectures like MIPS with
> > > at least four different targets, depending on selected config.
> > > When one has selected to build a certain kernel, including a specific
> > > bootloader only the make command is needed.
> > > No need to remember the 'make rom.bin' or whatever target.
> > 
> > This is where I see it blowing up, quite badly.  As Russell noted,
> > you're going to have a horrible, unmaintainable list of boards and
> > firmware supported, or not, on each.  Even on PPC32 where we really only
> > have "needs vmlinux, raw", "needs vmlinux, for U-Boot" and "can use
> > arch/ppc/boot/", it'll still get ugly noting which boards can use
> > U-Boot, which can use arch/ppc/boot/ and which can use both.
> 
> What the patch does is to create a placeholder for
> existing targets. No requirements exist for doing what you propose.

Which gets back to one of Russells points.  You can document the formats
all you want, but that won't help the user pick one, unless they already
know enough to not need this information to start with.

Or, you restrict their choices to what would work, which is a horrible
mess.  And you may need to restrict the choices, otherwise we'll get
'allyesconfig' doesn't build type messages again (yes, I've already had
to re-arrange things once for allyesconfig on ppc32).

> But for a given board I would expect the defconfig to select the correct
> kernel image.

<nit>'correct' is such an odd word here.  Especially in the case where
all of them are valid targets.</nit>

-- 
Tom Rini
http://gate.crashing.org/~trini/
